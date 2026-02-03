$(document).ready(function () {
    callAgentStatus();
    $("#aadhaar").val($("#ContentPlaceHolder1_hdnAadharNO").val());
    $("#aadharNoKYC").val($("#ContentPlaceHolder1_hdnAadharNO").val());
    $("#mobileNo").val($("#ContentPlaceHolder1_hdnUserMobile").val());

    $("#aadharNoReg").val($("#ContentPlaceHolder1_hdnAadharNO").val());
    $("#regMobile").val($("#ContentPlaceHolder1_hdnUserMobile").val());
    $("#pan").val($("#ContentPlaceHolder1_hdnUserPAN").val());
    $("#email").val($("#ContentPlaceHolder1_hdnUserEmail").val());
    $("#bankAccountNumber").val($("#ContentPlaceHolder1_hdnUserBankAccount").val());
    $("#BankIFSCCode").val($("#ContentPlaceHolder1_hdnUserBankIFSC").val());
    getLocation();
    ResetControl();
});





function getLocation() {
    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(
            function (position) {
                var Latitude = position.coords.latitude;
                var Longitude = position.coords.longitude;

                // Example: store in hidden fields
                document.getElementById("ContentPlaceHolder1_hdLatitude").value = Latitude;
                document.getElementById("ContentPlaceHolder1_hdLongitude").value = Longitude;

                console.log(Latitude, Longitude);
            },
            function (error) {
                alert("Location access denied");
            }
        );
    } else {
        alert("Geolocation not supported");
    }
}

function validateRegister() {

    let isValid = true;

    const panRegex = /^[A-Z]{5}[0-9]{4}[A-Z]{1}$/;
    const mobileRegex = /^[6-9][0-9]{9}$/;
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    const pincodeRegex = /^[1-9][0-9]{5}$/;

    function showError2(id, show) {
        document.getElementById(id).classList.toggle("d-none", !show);
        if (show) isValid = false;
    }

    showError2("erraadharNoReg", document.getElementById("aadharNoReg").value.trim() === "");
    showError2("errPan", !panRegex.test(document.getElementById("pan").value));
    showError2("errMobileNo", !mobileRegex.test(document.getElementById("regMobile").value));
    showError2("errEmail", !emailRegex.test(document.getElementById("email").value));
    showError2("errbankAccountNumber", document.getElementById("bankAccountNumber").value.trim() === "");
    showError2("errBankIFSCCode", document.getElementById("BankIFSCCode").value.trim() === "");

    if (!isValid) return;
    callAgentSignIn();
}

function validateSigninOTP() {
    let isValid = true;
    function showError2(id, show) {
        document.getElementById(id).classList.toggle("d-none", !show);
        if (show) isValid = false;
    }
    showError2("errsigninOTP", document.getElementById("signinOTP").value.trim() === "");
    if (!isValid) return;

    callAgentSignInValidate();
}


let selectedOperator = '';
let selectedDevice = '';
let finalUrl = '', MethodCapture = '', MethodInfo = '', rdServiceInfo = '';
var otpReferenceID = '';
var referenceKey = '';
var posh = '';
var outletId = '';
var hash = '';
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
        const amountValidator = document.getElementById("ContentPlaceHolder1_RequiredFieldValidator2");
        if (selectedOperator == "Balance" || selectedOperator == "Statement") {
            $("#ContentPlaceHolder1_txtamount").css("display", "none");
            $("#ContentPlaceHolder1_RequiredFieldValidator2").css("display", "none");
            ValidatorEnable(amountValidator, false);
        }
        else {
            $("#ContentPlaceHolder1_txtamount").css("display", "block");
            ValidatorEnable(amountValidator, true);

        }

        let mobileBox = document.getElementById("ContentPlaceHolder1_txtMobile");
        let amountBox = document.getElementById("ContentPlaceHolder1_txtAadhar");
        if (mobileBox) mobileBox.value = "";
        if (amountBox) {
            amountBox.value = "";
            amountBox.readOnly = false;
        }
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

async function captureRdData(deviceType, retry = false, kyctype = "") {
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

    const wadhValue = kyctype === "EKYC" ? "E0jzJ/P8UopUHAieZn8CKqS4WPMi5ZSYXgfnlfkWjrc=" : "";
    debugger
    const pidXml = (deviceType === 'Mantra')
        ? `<PidOptions ver="1.0"><Opts fCount="1" fType="2" iCount="0" pCount="0" format="0" pidVer="2.0" timeout="30000" wadh="${wadhValue}" env="P"/></PidOptions>`
        : `<PidOptions ver="1.0"> <Opts env="P" fCount="1" fType="2" iCount="0" pCount="0" format="0" pidVer="2.0" timeout="30000" wadh="${wadhValue}" /></PidOptions>`;

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

function validateAEPS() {
    let isValid = true;

    const aadhaar = document.getElementById("aadhaar");
    const mobile = document.getElementById("mobileNo");

    const aadhaarRegex = /^[0-9]{12}$/;
    const mobileRegex = /^[6-9][0-9]{9}$/;

    if (!aadhaarRegex.test(aadhaar.value)) {
        errAadhaar.classList.remove("d-none");
        isValid = false;
    }

    if (!mobileRegex.test(mobile.value)) {
        errMobile.classList.remove("d-none");
        isValid = false;
    }

    if (!isValid) return;

    captureFingerprint("Login")
}


async function captureFingerprint(deviceType = "") {

    if (deviceType == "") {
        if (!selectedOperator) {
            alert('Please select an operator.');
            return false;
        }
    }
    if (!selectedDevice) {
        alert('Please select a device first.');
        return false;
    }

    try {
        const pidXml = await captureRdData(selectedDevice, false, deviceType);
        if (selectedOperator === 'Balance') {
            callBalanceEnquiry(pidXml);
        }
        else if (selectedOperator === 'Statement') {
            callMinistatement(pidXml);
        }
        else if (selectedOperator === 'Withdraw') {
            callCashWidhrawal(pidXml);
        }
        else if (selectedOperator === 'AadharPay') {
            callAadharPay(pidXml);
        }
        else if (deviceType === "Login") {
            callDailyLogin(pidXml);
        }
        else if (deviceType === "EKYC") {
            callAgentEKYC(pidXml);
        }
        else {
            alert("Operator not implemented yet");
        }
    } catch (err) {
        alert("Capture failed: " + err.message);
    }
    return false;
}


//document.addEventListener("DOMContentLoaded", function () {
//    let lastRechargeSidebar = null;
//    ["TransactionSidebar"].forEach(id => {
//        let el = document.getElementById(id);
//        if (el) {
//            el.addEventListener("show.bs.offcanvas", function () {
//                lastRechargeSidebar = id;
//                document.getElementById("ContentPlaceHolder1_hfLastSidebar").value = id;

//                if (id === "TransactionSidebar") {

//                    callAgentStatus();
//                }

//            });
//        }
//    });

//    document.addEventListener("click", function (e) {
//        if (e.target && e.target.id === "backToRecharge") {
//            const plansEl = document.getElementById("plansSidebar");
//            bootstrap.Offcanvas.getInstance(plansEl)?.hide();

//            const returnSidebar = lastRechargeSidebar || document.getElementById("<%= hfLastSidebar.ClientID %>").value;
//            if (returnSidebar) {
//                const targetEl = document.getElementById(returnSidebar);
//                if (targetEl) {
//                    new bootstrap.Offcanvas(targetEl).show();

//                    if (returnSidebar === "TransactionSidebars") {
//                        document.getElementById("step1").classList.add("d-none");
//                        document.getElementById("step2").classList.remove("d-none");

//                        let op = document.getElementById('<%= hfOperator.ClientID %>').value;
//                        if (op) document.getElementById("selectedOperator").innerText = "Operator: " + op;
//                        callAgentStatus();
//                    }
//                }
//            }
//        }
//    });
//});

document.addEventListener("DOMContentLoaded", function () {
    let lastRechargeSidebar = null;

    // --- Operator Selection ---
    document.querySelectorAll(".operator-card").forEach(btn => {
        btn.addEventListener("click", function () {
            let operator = this.dataset.operator;
            document.getElementById('ContentPlaceHolder1_hfOperator').value = operator;

            if (this.closest("#TransactionSidebar")) {
                document.getElementById("step1").classList.add("d-none");
                document.getElementById("step2").classList.remove("d-none");
                document.getElementById("selectedOperator").innerText = "Operator: " + operator;
                document.getElementById('ContentPlaceHolder1_hfOperator').value = operator;
                const amountValidator = document.getElementById("ContentPlaceHolder1_RequiredFieldValidator2");
                if (operator == "Balance" || operator == "Statement") {
                    $("#ContentPlaceHolder1_txtamount").css("display", "none");
                    $("#ContentPlaceHolder1_RequiredFieldValidator2").css("display", "none");
                    ValidatorEnable(amountValidator, false);
                }
                else {
                    $("#ContentPlaceHolder1_txtamount").css("display", "block");
                    ValidatorEnable(amountValidator, true);

                }

                let mobileBox = document.getElementById("ContentPlaceHolder1_txtMobile");
                let amountBox = document.getElementById("ContentPlaceHolder1_txtAadhar");
                if (mobileBox) mobileBox.value = "";
                if (amountBox) {
                    amountBox.value = "";
                    amountBox.readOnly = false;
                }
            }
        });
    });

    // --- Plan Selection ---
    document.addEventListener("click", function (e) {
        const btn = e.target.closest(".plan-btn");
        if (!btn) return;

        const amount = btn.getAttribute("data-amount") || "";
        let returnSidebar = lastRechargeSidebar || document.getElementById("ContentPlaceHolder1_hfLastSidebar").value;

        if (returnSidebar === "TransactionSidebar") {
            let amountBox = document.getElementById("ContentPlaceHolder1_txtAadhar");
            if (amountBox) {
                amountBox.value = amount;
                amountBox.readOnly = true;
            }
            document.getElementById("step1").classList.add("d-none");
            document.getElementById("step2").classList.remove("d-none");

            let op = document.getElementById('ContentPlaceHolder1_hfOperator').value;
            if (op) document.getElementById("selectedOperator").innerText = "Operator: " + op;
        }

        // Close plans and reopen sidebar
        const plansEl = document.getElementById("plansSidebar");
        bootstrap.Offcanvas.getInstance(plansEl)?.hide();

        if (returnSidebar) {
            const targetEl = document.getElementById(returnSidebar);
            if (targetEl) {
                bootstrap.Offcanvas.getOrCreateInstance(targetEl).show();
            }
        }
    });

    // --- Back Step Button ---
    document.getElementById("backStep").addEventListener("click", function () {
        document.getElementById("step2").classList.add("d-none");
        document.getElementById("step1").classList.remove("d-none");
    });

    // --- Initiate Button Validation ---
    document.getElementById("btnInitiateTransaction").addEventListener("click", function () {
        callAgentStatusV2(function (isSuccess) {
            if (isSuccess) {
                const targetEl = document.getElementById("TransactionSidebar");
                bootstrap.Offcanvas.getOrCreateInstance(targetEl).show();
            }
        });
    });
});


document.addEventListener("DOMContentLoaded", function () {
    let lastRechargeSidebar = null;

    // --- Operator Selection ---
    document.querySelectorAll(".operator-card").forEach(btn => {
        btn.addEventListener("click", function () {
            let operator = this.dataset.operator;
            document.getElementById('ContentPlaceHolder1_hfOperator').value = operator;

            if (this.closest("#TransactionSidebar")) {
                document.getElementById("step1").classList.add("d-none");
                document.getElementById("step2").classList.remove("d-none");
                document.getElementById("selectedOperator").innerText = "Operator: " + operator;
                document.getElementById('ContentPlaceHolder1_hfOperator').value = operator;
                const amountValidator = document.getElementById("ContentPlaceHolder1_RequiredFieldValidator2");
                if (operator == "Balance" || operator == "Statement") {
                    $("#ContentPlaceHolder1_txtamount").css("display", "none");
                    $("#ContentPlaceHolder1_RequiredFieldValidator2").css("display", "none");
                    ValidatorEnable(amountValidator, false);
                }
                else {
                    $("#ContentPlaceHolder1_txtamount").css("display", "block");
                    ValidatorEnable(amountValidator, true);

                }

                let mobileBox = document.getElementById("ContentPlaceHolder1_txtMobile");
                let amountBox = document.getElementById("ContentPlaceHolder1_txtAadhar");
                if (mobileBox) mobileBox.value = "";
                if (amountBox) {
                    amountBox.value = "";
                    amountBox.readOnly = false;
                }
            }
        });
    });

    // --- Plan Selection ---
    document.addEventListener("click", function (e) {
        const btn = e.target.closest(".plan-btn");
        if (!btn) return;

        const amount = btn.getAttribute("data-amount") || "";
        let returnSidebar = lastRechargeSidebar || document.getElementById("ContentPlaceHolder1_hfLastSidebar").value;

        if (returnSidebar === "TransactionSidebar") {
            let amountBox = document.getElementById("ContentPlaceHolder1_txtAadhar");
            if (amountBox) {
                amountBox.value = amount;
                amountBox.readOnly = true;
            }
            document.getElementById("step1").classList.add("d-none");
            document.getElementById("step2").classList.remove("d-none");

            let op = document.getElementById('ContentPlaceHolder1_hfOperator').value;
            if (op) document.getElementById("selectedOperator").innerText = "Operator: " + op;
        }

        // Close plans and reopen sidebar
        const plansEl = document.getElementById("plansSidebar");
        bootstrap.Offcanvas.getInstance(plansEl)?.hide();

        if (returnSidebar) {
            const targetEl = document.getElementById(returnSidebar);
            if (targetEl) {
                bootstrap.Offcanvas.getOrCreateInstance(targetEl).show();
            }
        }
    });

    // --- Back Step Button ---
    document.getElementById("backStep").addEventListener("click", function () {
        document.getElementById("step2").classList.add("d-none");
        document.getElementById("step1").classList.remove("d-none");
    });

    // --- Initiate Button Validation ---
    document.getElementById("btnInitiateTransaction").addEventListener("click", function () {
        callAgentStatusV2(function (isSuccess) {
            if (isSuccess) {
                const targetEl = document.getElementById("TransactionSidebar");
                bootstrap.Offcanvas.getOrCreateInstance(targetEl).show();
            }
        });
    });
});

// --- Validation Function ---
function callAgentStatusV2(callback) {
    const payload = buildAgentStatusPayload();
    if (!payload) return;

    $(".loader-overlay").css("display", "flex");
    $.ajax({
        url: "https://partner.banku.co.in/api/AEPSTXN",
        type: "POST",
        contentType: "application/json",
        dataType: "json",
        timeout: 30000,
        data: JSON.stringify(payload),
        success: function (res) {
            console.log("AEPS Response:", res);
            $(".loader-overlay").css("display", "none");

            if (res.Status === "SUCCESS") {
                callback(true);
            } else {
                showFailed(res?.Data[0]?.status || res?.Message);
                openLoginPopup();
                callback(false);  
            }
        },
        error: function (xhr) {
            console.error(xhr.responseText);
            showFailed("Network / CORS Error");
            $(".loader-overlay").css("display", "none");
            callback(false);
        }
    });
}

function callAgentStatus() {

    const payload = buildAgentStatusPayload();
    if (!payload) return;
    $(".loader-overlay").css("display", "flex");
    $.ajax({
        url: "https://partner.banku.co.in/api/AEPSTXN",
        //url: "http://localhost:54956/api/AEPSTXN",
        type: "POST",
        contentType: "application/json",
        dataType: "json",
        timeout: 30000,
        data: JSON.stringify(payload),
        success: function (res) {
            console.log("AEPS Response:", res);
            if (res.Status === "SUCCESS") {

                $(".loader-overlay").css("display", "none");
            } else {
                showFailed(res?.Data[0]?.status || res?.Message);
                openLoginPopup();
                $(".loader-overlay").css("display", "none");
            }
        },
        error: function (xhr) {
            console.error(xhr.responseText);
            showFailed("Network / CORS Error");
            $(".loader-overlay").css("display", "none");
        }
    });
}

function callAgentSignIn() {
    const payload = buildSignUpPayload();
    if (!payload) return;
    $(".loader-overlay").css("display", "flex");
    $.ajax({
        url: "https://partner.banku.co.in/api/AEPSTXN",
        type: "POST",
        contentType: "application/json",
        dataType: "json",
        timeout: 30000,
        data: JSON.stringify(payload),
        success: function (res) {
            debugger
            console.log("AEPS Response:", res);
            if (res.Status === "SUCCESS") {
                $("#signinpostvalidate").show();
                $("#Signinprevalidate").hide();
                $("#btnCreateAgent").hide();
                $("#btnValidateAgent").show();

                showSuccess(res.Message);
                otpReferenceID = res.Data[0].xmllist.otpReferenceID;
                hash = res.Data[0].xmllist.hash;
                $(".loader-overlay").css("display", "none");

            } else {
                showError(res.Message);
                $(".loader-overlay").css("display", "none");
                return;
            }
        },
        error: function (xhr) {
            console.error(xhr.responseText);
            showFailed("Network / CORS Error");
            $(".loader-overlay").css("display", "none");
        }
    });
}

function callAgentSignInValidate() {
    const payload = buildSignUpValidatePayload();
    if (!payload) return;
    $(".loader-overlay").css("display", "flex");
    $.ajax({
        url: "https://partner.banku.co.in/api/AEPSTXN",
        type: "POST",
        contentType: "application/json",
        dataType: "json",
        timeout: 30000,
        data: JSON.stringify(payload),
        success: function (res) {
            debugger
            console.log("AEPS Response:", res);
            if (res.Status === "SUCCESS") {
                $("#signinpostvalidate").hide();
                $("#Signinprevalidate").show();
                $("#btnCreateAgent").show();
                $("#btnValidateAgent").hide();
                showSuccess(res.Message);
                outletId = res.Data[0].xmllist.outletId;

                let profilePic = res.Data[0].xmllist.profilePic;

                if (profilePic) {
                    if (!profilePic.startsWith("data:image")) {
                        profilePic = "data:image/jpeg;base64," + profilePic;
                    }

                    $("#SenderProfile").attr("src", profilePic);
                    $("#SenderName").text(res.Data[0].xmllist.name);
                    $(".sender-profile").fadeIn(); // show nicely
                }
                $("#signinOTP").val("");
                $(".loader-overlay").css("display", "none");

            } else {
                showFailed(res?.Data[0]?.status || res?.Message);
                $(".loader-overlay").css("display", "none");
                return;
            }
        },
        error: function (xhr) {
            console.error(xhr.responseText);
            showFailed("Network / CORS Error");
            $(".loader-overlay").css("display", "none");
        }
    });
}

function ResetControl() {
    $("#signinpostvalidate").hide();
    $("#Signinprevalidate").show();
    $("#btnCreateAgent").show();
    $("#btnValidateAgent").hide();
}

$(".checkEKYCStatus").click(function () {
    const payload = buildAgentEKYCStatusPayload();
    if (!payload) return;
    $(".loader-overlay").css("display", "flex");
    $.ajax({
        url: "https://partner.banku.co.in/api/AEPSTXN",
        type: "POST",
        contentType: "application/json",
        dataType: "json",
        timeout: 30000,
        data: JSON.stringify(payload),
        success: function (res) {
            console.log("AEPS Response:", res);
            if (res.Status === "SUCCESS") {
                showSuccess(res.Message);
                referenceKey = res.Data[0].xmllist.referenceKey;
                $(".loader-overlay").css("display", "none");
            }
            else {
                showFailed(res?.Data[0]?.status || res?.Message);
                if (res.Message == "You are Not Authorised, Please Register!") {
                    var myOffcanvas = new bootstrap.Offcanvas($('#aepsRegisterModal')[0]);
                    myOffcanvas.show();
                }
                else if (res.Message == "Biometric authentication already completed") {
                    var myOffcanvas = new bootstrap.Offcanvas($('#aepsLoginSidebar')[0]);
                    myOffcanvas.show();
                }
                $(".loader-overlay").css("display", "none");
            }
        },
        error: function (xhr) {
            console.error(xhr.responseText);
            showFailed("Network / CORS Error");
            $(".loader-overlay").css("display", "none");
        }
    });

});

$(document).on("click", ".btnLogin", function () {
    const registerEl = document.getElementById('aepsRegisterModal');

    registerEl.addEventListener('hidden.bs.offcanvas', function () {
        new bootstrap.Offcanvas('#aepsLoginSidebar').show();
    }, { once: true });

    bootstrap.Offcanvas.getInstance(registerEl)?.hide();
});

function openLoginPopup() {

    const targetEl = document.getElementById("aepsLoginSidebar");
    const offcanvas = bootstrap.Offcanvas.getOrCreateInstance(targetEl);
    offcanvas.show();
}

function openTranSactionpopup() {
    const targetEl = document.getElementById("TransactionSidebar");
    const offcanvas = bootstrap.Offcanvas.getOrCreateInstance(targetEl);
    offcanvas.show();
}

function CompleteAgentEKYC() {

    captureFingerprint("EKYC")
}

function callDailyLogin(pidXml) {
    const payload = buildAgentLoginPayload(pidXml);
    if (!payload) return;
    $(".loader-overlay").css("display", "flex");
    $.ajax({
        url: "https://partner.banku.co.in/api/AEPSTXN",
        type: "POST",
        contentType: "application/json",
        dataType: "json",
        timeout: 30000,
        data: JSON.stringify(payload),
        success: function (res) {
            console.log("AEPS Response:", res);
            if (res.Status === "SUCCESS") {
                showSuccess(res.Data[0].status);
                openTranSactionpopup();
                $(".loader-overlay").css("display", "none");
            } else {
                showFailed(res?.Data[0]?.status || res?.Message);
                $(".loader-overlay").css("display", "none");
            }
        },
        error: function (xhr) {
            console.error(xhr.responseText);
            showFailed("Network / CORS Error");
            $(".loader-overlay").css("display", "none");
        }
    });
}

function callAgentEKYC(pidXml) {
    const payload = buildAgentEKYCPayload(pidXml);
    if (!payload) return;
    $(".loader-overlay").css("display", "flex");
    $.ajax({
        url: "https://partner.banku.co.in/api/AEPSTXN",
        type: "POST",
        contentType: "application/json",
        dataType: "json",
        timeout: 30000,
        data: JSON.stringify(payload),
        success: function (res) {
            console.log("AEPS Response:", res);
            if (res.Status === "SUCCESS") {
                showSuccess(res.Message);
                $(".loader-overlay").css("display", "none");
            } else {
                showFailed(res?.Data[0]?.status || res.Message);
                $(".loader-overlay").css("display", "none");
            }
        },
        error: function (xhr) {
            console.error(xhr.responseText);
            showFailed("Network / CORS Error");
            $(".loader-overlay").css("display", "none");
        }
    });
}

function callBalanceEnquiry(pidXml) {
    const payload = buildBalanceEnquiryPayload(pidXml);
    if (!payload) return;
    $(".loader-overlay").css("display", "flex");
    $.ajax({
        url: "https://partner.banku.co.in/api/AEPSTXN",
        //url: "http://localhost:54956/api/AEPSTXN",
        type: "POST",
        contentType: "application/json",
        dataType: "json",
        timeout: 30000,
        data: JSON.stringify(payload),
        success: function (res) {
            console.log("AEPS Response:", res);
            if (res.Status === "SUCCESS") {
                ManageInvoicePay("BALANCE", res);
                $(".loader-overlay").css("display", "none");
            } else {
                showFailed(res?.Data[0]?.status || res.Message);
                $(".loader-overlay").css("display", "none");
            }
        },
        error: function (xhr) {
            console.error(xhr.responseText);
            showFailed("Network / CORS Error");
            $(".loader-overlay").css("display", "none");
        }
    });
}
function callMinistatement(pidXml) {
    const payload = buildBalanceEnquiryPayload(pidXml);
    if (!payload) return;
    $(".loader-overlay").css("display", "flex");
    $.ajax({
        url: "https://partner.banku.co.in/api/AEPSTXN",
        //url: "http://localhost:54956/api/AEPSTXN",
        type: "POST",
        contentType: "application/json",
        dataType: "json",
        timeout: 30000,
        data: JSON.stringify(payload),
        success: function (res) {
            console.log("AEPS Response:", res);
            if (res.Status === "SUCCESS") {
                ManageInvoicePay("MINISTATEMENT", res);
                $(".loader-overlay").css("display", "none");
            } else {
                showFailed(res?.Data[0]?.status || res.Message);
                $(".loader-overlay").css("display", "none");
            }
        },
        error: function (xhr) {
            console.error(xhr.responseText);
            showFailed("Network / CORS Error");
            $(".loader-overlay").css("display", "none");
        }
    });
}
function callCashWidhrawal(pidXml) {
    const payload = buildBalanceEnquiryPayload(pidXml);
    if (!payload) return;
    $(".loader-overlay").css("display", "flex");
    $.ajax({
        url: "https://partner.banku.co.in/api/AEPSTXN",
        type: "POST",
        contentType: "application/json",
        dataType: "json",
        timeout: 30000,
        data: JSON.stringify(payload),
        success: function (res) {
            console.log("AEPS Response:", res);
            if (res.Status === "SUCCESS") {
                ManageInvoicePay("WITHDRAWAL", res);
                $(".loader-overlay").css("display", "none");
            } else {
                showFailed(res?.Data[0]?.status || res.Message);
                $(".loader-overlay").css("display", "none");
            }
        },
        error: function (xhr) {
            console.error(xhr.responseText);
            showFailed("Network / CORS Error");
            $(".loader-overlay").css("display", "none");
        }
    });
}
function callAadharPay(pidXml) {
    const payload = buildBalanceEnquiryPayload(pidXml);
    if (!payload) return;
    $(".loader-overlay").css("display", "flex");
    $.ajax({
        url: "https://partner.banku.co.in/api/AEPSTXN",
        //url: "http://localhost:54956/api/AEPSTXN",
        type: "POST",
        contentType: "application/json",
        dataType: "json",
        timeout: 30000,
        data: JSON.stringify(payload),
        success: function (res) {
            console.log("AEPS Response:", res);
            if (res.Status === "SUCCESS") {
                ManageInvoicePay("AADHARPAY", res);
                $(".loader-overlay").css("display", "none");
            } else {
                showFailed(res?.Data[0]?.status || res.Message);
                $(".loader-overlay").css("display", "none");
            }
        },
        error: function (xhr) {
            console.error(xhr.responseText);
            showFailed("Network / CORS Error");
            $(".loader-overlay").css("display", "none");
        }
    });
}

function buildAgentLoginPayload(pidXml) {

    if (!pidXml) {
        alert("Fingerprint not captured");
        return null;
    }
    const pid = parsePidXml(pidXml);
    return {
        email: "",
        pan: "",
        bankAccountNo: "",
        bankIfsc: "",
        otpReferenceID: "",
        otp: "",
        hash: "",
        referenceKey: "",
        mobileNo: $("#mobileNo").val(),
        userid: $("#ContentPlaceHolder1_hdnUserId").val(),
        user_agent: navigator.userAgent,
        newmobileappversion: "1.0.1",
        request: {
            aadhaar_uid: $("#aadhaar").val(),
            agent_id: navigator.userAgent,
            amount: "0",
            bankiin: "",
            latitude: $("#ContentPlaceHolder1_hdLatitude").val(),
            longitude: $("#ContentPlaceHolder1_hdLongitude").val(),
            mobile: $("#mobileNo").val(),
            sp_key: "login",
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

function buildAgentEKYCPayload(pidXml) {

    if (!pidXml) {
        alert("Fingerprint not captured");
        return null;
    }
    const pid = parsePidXml(pidXml);
    return {
        email: "",
        pan: "",
        bankAccountNo: "",
        bankIfsc: "",
        otpReferenceID: "",
        otp: "",
        hash: "",
        referenceKey: referenceKey,
        mobileNo: "",
        userid: $("#ContentPlaceHolder1_hdnUserId").val(),
        user_agent: navigator.userAgent,
        newmobileappversion: "1.0.1",
        request: {
            aadhaar_uid: $("#aadharNoKYC").val(),
            agent_id: navigator.userAgent,
            amount: "0",
            bankiin: "",
            latitude: $("#ContentPlaceHolder1_hdLatitude").val(),
            longitude: $("#ContentPlaceHolder1_hdLongitude").val(),
            mobile: $("#mobileNo").val(),
            sp_key: "biometrickyc",
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
            srno: "2526I031118",
            tType: "null"
        }
    };
}

function buildBalanceEnquiryPayload(pidXml) {


    if (!pidXml) {
        alert("Fingerprint not captured");
        return null;
    }
    const pid = parsePidXml(pidXml);

    var Amount = $("#ContentPlaceHolder1_txtamount").val();

    return {
        email: "",
        pan: "",
        bankAccountNo: "",
        bankIfsc: "",
        otpReferenceID: "",
        otp: "",
        hash: "",
        referenceKey: "",
        mobileNo: $("#ContentPlaceHolder1_txtMobile").val(),
        userid: $("#ContentPlaceHolder1_hdnUserId").val(),
        user_agent: navigator.userAgent,
        newmobileappversion: "1.0.1",
        request: {
            aadhaar_uid: $("#ContentPlaceHolder1_txtAadhar").val(),
            agent_id: navigator.userAgent,
            amount: selectedOperator === "Balance" ? "0" : selectedOperator === "Statement" ? "0" : selectedOperator == "Withdraw" ? Amount : selectedOperator === "AadharPay" ? Amount : "0",
            bankiin: $("#ContentPlaceHolder1_ddlCircle").val(),
            latitude: $("#ContentPlaceHolder1_hdLatitude").val(), //Need to pick dynamic i added for now just for testing
            longitude: $("#ContentPlaceHolder1_hdLongitude").val(),//Need to pick dynamic i added for now just for testing
            mobile: $("#ContentPlaceHolder1_txtMobile").val(),
            sp_key: selectedOperator === "Balance" ? "BAP" : selectedOperator === "Statement" ? "SAP" : selectedOperator == "Withdraw" ? "WAP" : selectedOperator === "AadharPay" ? "MZZ" : "",
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


function buildAgentStatusPayload() {

    return {
        email: "",
        pan: "",
        bankAccountNo: "",
        bankIfsc: "",
        otpReferenceID: "",
        otp: "",
        hash: "",
        referenceKey: "",
        mobileNo: $("#ContentPlaceHolder1_txtMobile").val(),
        userid: $("#ContentPlaceHolder1_hdnUserId").val(),
        user_agent: navigator.userAgent,
        newmobileappversion: "1.0.1",
        request: {
            aadhaar_uid: $("#ContentPlaceHolder1_txtAadhar").val(),
            agent_id: navigator.userAgent,
            amount: "0",
            bankiin: "",
            latitude: $("#ContentPlaceHolder1_hdLatitude").val(), //Need to pick dynamic i added for now just for testing
            longitude: $("#ContentPlaceHolder1_hdLongitude").val(),//Need to pick dynamic i added for now just for testing
            mobile: $("#ContentPlaceHolder1_txtMobile").val(),
            sp_key: "checkStatus",
            pidDataType: "X",
            pidData: "",
            ci: "",
            dc: "",
            dpId: "",
            errCode: "",
            errInfo: "",
            fCount: "",
            hmac: "",
            iCount: "",
            mc: "",
            mi: "",
            nmPoints: "",
            pCount: "",
            pType: "",
            qScore: "",
            rdsId: "",
            rdsVer: "",
            sessionKey: "",
            srno: "",
            tType: "null"
        }
    };
}

function buildAgentEKYCStatusPayload() {

    return {
        email: "",
        pan: "",
        bankAccountNo: "",
        bankIfsc: "",
        otpReferenceID: "",
        otp: "",
        hash: "",
        referenceKey: "",
        mobileNo: "",
        userid: $("#ContentPlaceHolder1_hdnUserId").val(),
        user_agent: navigator.userAgent,
        newmobileappversion: "1.0.1",
        request: {
            aadhaar_uid: "",
            agent_id: navigator.userAgent,
            amount: "0",
            bankiin: "",
            latitude: $("#ContentPlaceHolder1_hdLatitude").val(), //Need to pick dynamic i added for now just for testing
            longitude: $("#ContentPlaceHolder1_hdLongitude").val(),//Need to pick dynamic i added for now just for testing
            mobile: "",
            sp_key: "biometrickycstatus",
            pidDataType: "X",
            pidData: "",
            ci: "",
            dc: "",
            dpId: "",
            errCode: "",
            errInfo: "",
            fCount: "",
            hmac: "",
            iCount: "",
            mc: "",
            mi: "",
            nmPoints: "",
            pCount: "",
            pType: "",
            qScore: "",
            rdsId: "",
            rdsVer: "",
            sessionKey: "",
            srno: "",
            tType: "null"
        }
    };
}

function buildSignUpPayload() {

    return {
        email: $("#email").val(),
        pan: $("#pan").val(),
        bankAccountNo: $("#bankAccountNumber").val(),
        bankIfsc: $("#BankIFSCCode").val(),
        otpReferenceID: "",
        otp: "",
        hash: "",
        referenceKey: "",
        mobileNo: $("#regMobile").val(),
        userid: $("#ContentPlaceHolder1_hdnUserId").val(),
        user_agent: navigator.userAgent,
        newmobileappversion: "1.0.1",
        request: {
            aadhaar_uid: $("#aadharNoReg").val(),
            agent_id: navigator.userAgent,
            amount: "0",
            bankiin: "",
            latitude: $("#ContentPlaceHolder1_hdLatitude").val(), //Need to pick dynamic i added for now just for testing
            longitude: $("#ContentPlaceHolder1_hdLongitude").val(),//Need to pick dynamic i added for now just for testing
            mobile: $("#regMobile").val(),
            sp_key: "signup",
            pidDataType: "X",
            pidData: "",
            ci: "",
            dc: "",
            dpId: "",
            errCode: "",
            errInfo: "",
            fCount: "",
            hmac: "",
            iCount: "",
            mc: "",
            mi: "",
            nmPoints: "",
            pCount: "",
            pType: "",
            qScore: "",
            rdsId: "",
            rdsVer: "",
            sessionKey: "",
            srno: "",
            tType: "null"
        }
    };
}

function buildSignUpValidatePayload() {

    return {
        email: $("#email").val(),
        pan: $("#pan").val(),
        bankAccountNo: $("#bankAccountNumber").val(),
        bankIfsc: $("#BankIFSCCode").val(),
        otpReferenceID: otpReferenceID,
        otp: $("#signinOTP").val(),
        hash: hash,
        referenceKey: referenceKey,
        mobileNo: $("#regMobile").val(),
        userid: $("#ContentPlaceHolder1_hdnUserId").val(),
        user_agent: navigator.userAgent,
        newmobileappversion: "1.0.1",
        request: {
            aadhaar_uid: $("#aadharNoReg").val(),
            agent_id: navigator.userAgent,
            amount: "0",
            bankiin: "",
            latitude: $("#ContentPlaceHolder1_hdLatitude").val(), //Need to pick dynamic i added for now just for testing
            longitude: $("#ContentPlaceHolder1_hdLongitude").val(),//Need to pick dynamic i added for now just for testing
            mobile: $("#regMobile").val(),
            sp_key: "signupvalidate",
            pidDataType: "X",
            pidData: "",
            ci: "",
            dc: "",
            dpId: "",
            errCode: "",
            errInfo: "",
            fCount: "",
            hmac: "",
            iCount: "",
            mc: "",
            mi: "",
            nmPoints: "",
            pCount: "",
            pType: "",
            qScore: "",
            rdsId: "",
            rdsVer: "",
            sessionKey: "",
            srno: "",
            tType: "null"
        }
    };
}

function ManageInvoicePay(Mode, response) {
    if (Mode == "BALANCE" || Mode == "AADHARPAY" || Mode == "WITHDRAWAL") {

        var TxnType = Mode == "BALANCE" ? "Balance Inquiry Invoice" : Mode == "WITHDRAWAL" ? "CASH Withdrawal Invoice" : "Aadhar Pay Invoice";


        if (Mode == "AADHARPAY" || Mode == "WITHDRAWAL") {

            $(".withdrawamount").text($("#ContentPlaceHolder1_txtamount").val());
            $(".withdrawrow").css("display", "contents");
            $(".availablebalancerow").css("display", "none");

        }
        else {

            $(".withdrawamount").text("");
            $(".withdrawrow").css("display", "none");
            $(".availablebalancerow").css("display", "contents");
        }

        $(".balancerrn").text(response.Data[0].agentid);
        $(".balanceTxnType").text(TxnType);
        $(".balanceac").text(response.Data[0].acamount);
        $(".balanceBankName").text($("#ContentPlaceHolder1_ddlCircle option:selected").text());
        $(".balanceAadhar").text($("#ContentPlaceHolder1_txtAadhar").val());

        var now = new Date();
        var formattedDateTime =
            String(now.getDate()).padStart(2, '0') + "-" +
            String(now.getMonth() + 1).padStart(2, '0') + "-" +
            now.getFullYear() + " " +
            String(now.getHours()).padStart(2, '0') + ":" +
            String(now.getMinutes()).padStart(2, '0') + ":" +
            String(now.getSeconds()).padStart(2, '0');

        console.log(formattedDateTime);
        $(".lblTxnDate").text(formattedDateTime);
        var modal = new bootstrap.Modal(document.getElementById('InvoiceTrnx'));
        modal.show();
    }

    if (Mode == "MINISTATEMENT") {

        $(".balancerrn").text(response.Data[0].agentid);
        $(".balanceac").text(response.Data[0].acamount);

        var now = new Date();
        var formattedDateTime =
            String(now.getDate()).padStart(2, '0') + "-" +
            String(now.getMonth() + 1).padStart(2, '0') + "-" +
            now.getFullYear() + " " +
            String(now.getHours()).padStart(2, '0') + ":" +
            String(now.getMinutes()).padStart(2, '0') + ":" +
            String(now.getSeconds()).padStart(2, '0');

        console.log(formattedDateTime);
        $(".lblTxnDate").text(formattedDateTime);
        var invoiceData = '';
        for (var i = 0; i < response.Data[0].xmllist.length; i++) {

            invoiceData = invoiceData + "<tr><td>" + response.Data[0].xmllist[i].txnType + "</td> <td>" + response.Data[0].xmllist[i].date + "</td> <td>" + response.Data[0].xmllist[i].amount + "</td> <td>" + response.Data[0].xmllist[i].narration + "</td></tr>";
        }
        $("#miniStatementData").html(invoiceData);
        var modal = new bootstrap.Modal(document.getElementById('InvoiceMiniState'));
        modal.show();
    }
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