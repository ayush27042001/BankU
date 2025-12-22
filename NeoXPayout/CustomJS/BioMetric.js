let selectedDevice = '';
let finalUrl = '', MethodCapture = '', MethodInfo = '', rdServiceInfo = '';

function selectDeviceBtn(id, btn) {
    selectedDevice = id;
    document.querySelectorAll('.device-btn').forEach(b => b.classList.remove('active'));
    btn.classList.add('active');
    console.log("✅ Selected device:", id);
}

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
                    console.log(`✅ RDService found (${rdServiceInfo}) at ${ports[index]}`);
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

    // Optional handshake: some devices require DEVICEINFO first
    try {
        await $.ajax({
            url: buildFullUrl(MethodInfo, isHttps),
            type: 'DEVICEINFO',
            dataType: 'text'
        });
        console.log("🔄 DEVICEINFO successful — device awake");
    } catch {
        console.warn("⚠️ DEVICEINFO failed — continuing anyway");
    }

    const pidXml = (deviceType === 'Mantra')
        ? `<PidOptions ver="1.0"><Opts fCount="1" fType="2" iCount="0" pCount="0" format="0" pidVer="2.0" timeout="30000" wadh="E0jzJ/P8UopUHAieZn8CKqS4WPMi5ZSYXgfnlfkWjrc=" env="P"/></PidOptions>`
        : `<PidOptions ver="1.0"> <Opts env="P" fCount="1" fType="2" iCount="0" pCount="0" format="0" pidVer="2.0" timeout="30000" wadh="E0jzJ/P8UopUHAieZn8CKqS4WPMi5ZSYXgfnlfkWjrc="/></PidOptions>`;

    const captureUrl = buildFullUrl(MethodCapture, isHttps);
    console.log("📡 CAPTURE →", captureUrl);

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
        console.warn(`⚠️ Capture failed (${errCode}): ${errInfo}`);
        if (errCode === '740' && !retry) {
            console.log("♻️ Reinitializing device after error 740...");
            await new Promise(r => setTimeout(r, 2000)); // wait 2 sec
            return await captureRdData(deviceType, true); // retry once
        }
        throw new Error(`${errInfo} (Code: ${errCode})`);
    }

    console.log("✅ Capture Successful:", response);
    return response;
}
function setPidAndSubmit(pidXml) {

    var hdnPid = document.getElementById('<%= hdnPidData.ClientID %>');
    var btnSave = document.getElementById('<%= lnkSaveFingerprint.ClientID %>');

    if (!hdnPid || !btnSave) {
        alert("Hidden field or save button not found.");
        return;
    }

    hdnPid.value = pidXml;

    console.log("✅ PID data stored in hidden field");

    btnSave.click();
}
async function captureFingerprint() {
    if (!selectedDevice) {
        alert('Please select a device first.');
        return false;
    }
    try {
        const pidXml = await captureRdData(selectedDevice);

        setPidAndSubmit(pidXml);

        alert("Fingerprint captured successfully!");
    } catch (err) {
        alert("Capture failed: " + err.message);
    }
    return false;
}



