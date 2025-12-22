let selectedOperator = '';
let selectedDevice = '';
let finalUrl = '', MethodCapture = '', MethodInfo = '', rdServiceInfo = '';
function selectDeviceBtn(id, btn) {
    selectedDevice = id;
    document.querySelectorAll('.device-btn').forEach(b => b.classList.remove('active'));
    btn.classList.add('active');
}

document.querySelectorAll('.operator-card').forEach(btn => {
    btn.addEventListener('click', function () {
        document.querySelectorAll('.operator-card').forEach(b => b.classList.remove('active'));
        this.classList.add('active');
        selectedOperator = this.getAttribute('data-operator');
        document.getElementById('ContentPlaceHolder1_hfOperator').value = selectedOperator;
        document.getElementById('step1').classList.add('d-none');
        document.getElementById('step2').classList.remove('d-none');
        document.getElementById('selectedOperator').innerText = this.innerText;
    });
});


function buildFullUrl(path, isHttps) {
    if (!path) return '';
    if (/^https?:\/\//i.test(path)) return path;
    const ipPortPattern = /^\/(\d{1,3}\.){3}\d{1,3}:\d+/;
    if (ipPortPattern.test(path)) {
        const proto = isHttps ? 'https://' : 'http://';
        return proto + path.replace(/^\//, '');
    }
    return finalUrl + (path.startsWith('/') ? path : '/' + path);
}

async function discoverRdService(deviceType) {
    return new Promise((resolve, reject) => {
        const isHttps = window.location.href.startsWith('https');
        const baseUrl = isHttps ? 'https://127.0.0.1:' : 'http://127.0.0.1:';
        const ports = Array.from({ length: 21 }, (_, i) => 11100 + i);
        let found = false;
        function tryNext(index) {
            if (index >= ports.length) return reject("Device not found");
            const url = baseUrl + ports[index];
            $.ajax({
                url: url,
                type: 'RDSERVICE',
                dataType: 'text',
                success: function (data) {
                    const parser = new DOMParser();
                    const xmlDoc = parser.parseFromString(data, 'text/xml');
                    const rdService = xmlDoc.querySelector('RDService');
                    if (!rdService) return tryNext(index + 1);
                    rdServiceInfo = rdService.getAttribute('info') || '';
                    finalUrl = baseUrl + ports[index];
                    xmlDoc.querySelectorAll('Interface').forEach(node => {
                        const id = node.getAttribute('id');
                        const path = node.getAttribute('path') || '';
                        if (id === 'CAPTURE' || path === '/rd/capture') MethodCapture = path;
                        if (id === 'DEVICEINFO' || path === '/rd/info') MethodInfo = path;
                    });
                    found = true;
                    resolve(true);
                },
                error: () => tryNext(index + 1)
            });
        }
        tryNext(0);
    });
}

async function captureRdData(deviceType, retry = false) {
    await discoverRdService(deviceType);
    const isHttps = window.location.href.startsWith('https');
    try {
        await $.ajax({
            url: buildFullUrl(MethodInfo, isHttps),
            type: 'DEVICEINFO',
            dataType: 'text'
        });
    } catch {
    }

    const pidXml = (deviceType === 'Mantra')
        ? `<PidOptions ver="1.0"><Opts fCount="1" fType="2" iCount="0" pCount="0" format="0" pidVer="2.0" timeout="30000" wadh="" env="P"/></PidOptions>`
        : `<PidOptions ver="1.0"> <Opts env="P" fCount="1" fType="2" iCount="0" pCount="0" format="0" pidVer="2.0" timeout="30000" wadh=""/></PidOptions>`;

    const captureUrl = buildFullUrl(MethodCapture, isHttps);

    let response;
    try {
        response = await $.ajax({
            url: captureUrl,
            type: 'CAPTURE',
            dataType: 'text',
            data: pidXml,
            contentType: 'text/xml; charset=utf-8'
        });
    } catch (err) {
        throw new Error("Capture request failed: " + err.statusText);
    }

    const parser = new DOMParser();
    const xmlDoc = parser.parseFromString(response, 'text/xml');
    const errCode = xmlDoc.querySelector('Resp')?.getAttribute('errCode') || '';
    const errInfo = xmlDoc.querySelector('Resp')?.getAttribute('errInfo') || '';

    if (errCode && errCode !== '0') {
        if (errCode === '740' && !retry) {
            await new Promise(r => setTimeout(r, 2000)); 
            return await captureRdData(deviceType, true);
        }
        throw new Error(`${errInfo} (Code: ${errCode})`);
    }
    return response;
}

async function captureFingerprint() {
    if (!selectedDevice) {
        alert('Please select a device first.');
        return false;
    }
    if (!selectedOperator) {
        alert('Please select an operator.');
        return false;
    }
    try {
        const pidXml = await captureRdData(selectedDevice);
        if (selectedOperator === 'Balance') {
            callBalanceEnquiry(pidXml);
        } else {
            alert("Operator not implemented yet");
            //call here for Cash Withdrawal or Mini Statement or Aadhar Pay //Todo
        }
    } catch (err) {
        alert("Capture failed: " + err.message);
    }
    return false;
}

function callBalanceEnquiry(pidXml) {
    const payload = buildBalanceEnquiryPayload(pidXml);
    if (!payload) return;
    $.ajax({
        //url: "https://partner.banku.co.in/api/AEPSTXN",
        url: "http://localhost:54956/api/AEPSTXN",
        type: "POST",
        contentType: "application/json",
        dataType: "json",
        timeout: 30000,
        data: JSON.stringify(payload),
        success: function (res) {
            console.log("AEPS Response:", res);
            if (res.Status === "SUCCESS") {
                showSuccess("Balance: " + res.Data[0].acamount);
            } else {
                showFailed(res.Message || "Transaction Failed");
            }
        },
        error: function (xhr) {
            console.error(xhr.responseText);
            showFailed("Network / CORS Error");
        }
    });
}

function buildBalanceEnquiryPayload(pidXml) {

    
    if (!pidXml) {
        alert("Fingerprint not captured");
        return null;
    }
    const pid = parsePidXml(pidXml);
    return {
        mobileNo: $("#ContentPlaceHolder1_txtMobile").val(),
        userid: $("#ContentPlaceHolder1_hdnUserId").val(),
        user_agent: navigator.userAgent,
        newmobileappversion: "1.0.1",
        request: {
            aadhaar_uid: $("#ContentPlaceHolder1_txtAadhar").val(),
            agent_id: navigator.userAgent,
            amount: "0",
            bankiin: $("#ContentPlaceHolder1_ddlCircle").val(),
            latitude: "28.600883", //Need to pick dynamic i added for now just for testing
            longitude: "76.9709669",////Need to pick dynamic i added for now just for testing
            mobile: $("#ContentPlaceHolder1_txtMobile").val(),
            sp_key: "BAP",
            pidDataType: "X",
            pidData: pid.pidData,
            ci: pid.ci,
            dc: pid.dc,
            dpId: pid.dpId,
            errCode: pid.errCode,
            errInfo: pid.errInfo,
            fCount: pid.fCount,
            hmac: pid.hmac,
            iCount: pid.iCount,
            mc: pid.mc,
            mi: pid.mi,
            nmPoints: pid.nmPoints,
            pCount: pid.pCount,
            pType: "",
            qScore: pid.qScore,
            rdsId: pid.rdsId,
            rdsVer: pid.rdsVer,
            sessionKey: pid.sessionKey,
            srno: pid.srno,
            tType: "null"
        }
    };
}

function parsePidXml(pidXml) {
    const xml = new DOMParser().parseFromString(pidXml, "text/xml");
    const resp = xml.querySelector("Resp");
    const deviceInfo = xml.querySelector("DeviceInfo");
    const skey = xml.querySelector("Skey");
    const hmac = xml.querySelector("Hmac");
    const data = xml.querySelector("Data");
    return {
        errCode: resp?.getAttribute("errCode") || "",
        errInfo: resp?.getAttribute("errInfo") || "",
        fCount: resp?.getAttribute("fCount") || "1",
        iCount: resp?.getAttribute("iCount") || "0",
        pCount: resp?.getAttribute("pCount") || "0",
        qScore: resp?.getAttribute("qScore") || "60",
        nmPoints: resp?.getAttribute("nmPoints") || "0",
        dc: deviceInfo?.getAttribute("dc") || "",
        dpId: deviceInfo?.getAttribute("dpId") || "",
        mc: deviceInfo?.getAttribute("mc") || "",
        mi: deviceInfo?.getAttribute("mi") || "",
        rdsId: deviceInfo?.getAttribute("rdsId") || "",
        rdsVer: deviceInfo?.getAttribute("rdsVer") || "",
        srno: deviceInfo?.getAttribute("srno") || "",
        ci: skey?.getAttribute("ci") || "",
        sessionKey: skey?.textContent || "",
        hmac: hmac?.textContent || "",
        pidData: data?.textContent || ""
    };
}




