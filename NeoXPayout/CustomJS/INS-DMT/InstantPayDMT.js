var profilereferenceKey = '';
var senderregistrationreferenceKey = '';
var WadhValue = 'E0jzJ/P8UopUHAieZn8CKqS4WPMi5ZSYXgfnlfkWjrc=';
let selectedDevice = '';
let finalUrl = '', MethodCapture = '', MethodInfo = '', rdServiceInfo = '';
var otpReferenceID = '';
var referenceKey = '';
var posh = '';
var outletId = '';
var hash = '';
var beneficiaryReferenceKey = "";
var beneficiaryId = "";
var deleteBeneReferenceKey = "";
var deleteBeneId = "";
var txnReferenceKey = "";
var txnAmount = "";
var payeeBeneId = "";


function selectDeviceBtn(id, btn) {
    selectedDevice = id;
    document.querySelectorAll('.device-box').forEach(b => b.classList.remove('active'));
    btn.classList.add('active');
}

$(document).ready(function () {
    getLocation();
});
function openSenderSidebar() {

    let mobileno = $("#mobile").val().trim();
    if (mobileno == "") {
        showFailed("Please Enter Mobile Number!");
        return;
    }
    $(".loader-overlay").css("display", "flex");
    var selectedProvider = $(".header-tab.active").data("item");
    selectedProvider = selectedProvider == "INP" ? "instantpay" : selectedProvider;
    const url = "https://api.banku.co.in/api/DMT/remitter-profile";
    const headers = {
        "userid": $("#ContentPlaceHolder1_hdnUserId").val(),
        "username": "banku",
        "Content-Type": "application/json",
        "Accept": "*/*"
    };

    const requestPayload = {
        userId: $("#ContentPlaceHolder1_hdnUserId").val(),
        mobileNumber: $("#mobile").val().trim(),
        txnMode: "",
        iftEnable: "",
        source: "web",
        endpointIp: "",
        provider: selectedProvider
    };

    $.ajax({
        url: url,
        type: "POST",
        contentType: "application/json",
        dataType: "json",
        headers: headers,
        data: JSON.stringify(requestPayload),
        success: function (response) {
            if (response.statusCode == "RNF") {
                $("#txtSenderMobileNumber").val(mobileno);
                $("#txtSenderMobileNumber").addClass("disablecss");
                $("#btnVerifySender").hide();
                document.getElementById("senderSidebar").style.display = "flex";
                document.body.style.overflow = "hidden";
                profilereferenceKey = response.data.referenceKey;
            }
            if (response.statusCode == "TXN") {
                fetchBankList();
                LoadBeneficiaryDetails(response.data.beneficiaries);
                const el = document.getElementById('rightSidebar');
                const offcanvas = new bootstrap.Offcanvas(el);
                profilereferenceKey = response.data.referenceKey;
                offcanvas.show();
            }
            else {
                showFailed(response.status);
                $(".loader-overlay").css("display", "none");
                return;
            }
            $(".loader-overlay").css("display", "none");
        },
        error: function (xhr) {
            showFailed(JSON.stringify({
                status: xhr.status,
                statusText: xhr.statusText,
                response: xhr.responseText
            }, null, 2)); 
            $(".loader-overlay").css("display", "none");
        }
    });
}

function fetchBankList() {

    const headers = {
        "userid": $("#ContentPlaceHolder1_hdnUserId").val(),
        "username": "banku",
        "Content-Type": "application/json",
        "Accept": "*/*"
    };

    $.ajax({
        url: "https://api.banku.co.in/api/DMT/FetchBankList",
        type: "POST",
        contentType: "application/json",
        dataType: "json",
        headers: headers,
        success: function (response) {
            let ddl = $("#ddlBank");
            ddl.empty();
            ddl.append('<option value="">Select Bank</option>');

            $.each(response, function (index, bank) {
                ddl.append(
                    `<option value="${bank.bankId}"
                        data-ifsc="${bank.ifscGlobal}"
                        data-alias="${bank.ifscAlias}">
                        ${bank.name}
                    </option>`
                );
            });

        },
        error: function (xhr) {
            console.error("Bank list fetch failed", xhr);
            alert("Unable to load bank list");
        }
    });
}

function AddBeneficiary() {

    var bankid = $("#ddlBank").val();
    var txtbeneAccountNo = $("#txtbeneAccountNo").val().trim();
    var txtbeneName = $("#txtbeneName").val().trim();
    var txtbeneIfscCode = $("#txtbeneIfscCode").val().trim();
    var txtbeneMobNo = $("#txtbeneMobNo").val().trim();

    if (bankid === "") {
        showFailed('Please Select Bank Name!');
        return;
    }
    if (txtbeneMobNo === "") {
        showFailed('Please Enter Beneficiary Mobile Number!');
        return;
    }
    if (txtbeneAccountNo === "") {
        showFailed('Please Enter Bank Account Number!');
        return;
    }
    if (txtbeneName === "") {
        showFailed('Please Enter Beneficiary Name!');
        return;
    }
    if (txtbeneIfscCode === "") {
        showFailed('Please Enter IFSC Code!');
        return;
    }

    $(".loader-overlay").css("display", "flex");

    const url = "https://api.banku.co.in/api/DMT/remitter-beneficiary-registration";

    const headers = {
        "userid": $("#ContentPlaceHolder1_hdnUserId").val(),
        "username": "banku",
        "Content-Type": "application/json",
        "Accept": "*/*"
    };

    const requestPayload = {
        beneficiaryMobileNumber: txtbeneMobNo,
        remitterMobileNumber: $("#mobile").val().trim(),
        accountNumber: txtbeneAccountNo,
        ifsc: txtbeneIfscCode,
        bankId: bankid,
        name: txtbeneName,
        userId: $("#ContentPlaceHolder1_hdnUserId").val(),
        endpointIp: ""
    };

    console.log("Add Beneficiary Request:", requestPayload);

    $.ajax({
        url: url,
        type: "POST",
        contentType: "application/json",
        dataType: "json",
        headers: headers,
        data: JSON.stringify(requestPayload),

        success: function (response) {

            console.log("Add Beneficiary Response:", response);

            if (response.statusCode === "OTP") {

                beneficiaryId = response.data.beneficiaryId;
                beneficiaryReferenceKey = response.data.referenceKey;

                showSuccess(response.status || "OTP sent successfully");

                // 🔓 Show OTP UI
                $("#txtbeneOTP").show().val("").focus();
                $(".primary-btn:contains('Add Account')").hide();
                $(".primary-btn:contains('Verify Account')").show();

                // 🔐 Lock fields
                $("#ddlBank, #txtbeneMobNo, #txtbeneAccountNo, #txtbeneName, #txtbeneIfscCode")
                    .addClass("disablecss")
                    .prop("disabled", true);
            }
            else {
                showFailed(response.status || "Failed to add beneficiary");
            }

            $(".loader-overlay").css("display", "none");
        },

        error: function (xhr) {
            showFailed(JSON.stringify({
                status: xhr.status,
                statusText: xhr.statusText,
                response: xhr.responseText
            }, null, 2));
            $(".loader-overlay").css("display", "none");
        }
    });
}

function VerifyBeneficiary() {

    var otp = $("#txtbeneOTP").val().trim();

    if (otp === "") {
        showFailed("Please enter OTP");
        return;
    }

    if (!beneficiaryReferenceKey || !beneficiaryId) {
        showFailed("Beneficiary reference missing. Please retry.");
        return;
    }

    $(".loader-overlay").css("display", "flex");

    const url = "https://api.banku.co.in/api/DMT/remitter-beneficiary-registration-validate";

    const headers = {
        "userid": $("#ContentPlaceHolder1_hdnUserId").val(),
        "username": "banku",
        "Content-Type": "application/json",
        "Accept": "*/*"
    };

    const requestPayload = {
        remitterMobileNumber: $("#mobile").val().trim(),
        referenceKey: beneficiaryReferenceKey,
        otp: otp,
        beneficiaryId: beneficiaryId,
        userId: $("#ContentPlaceHolder1_hdnUserId").val(),
        endpointIp: ""
    };

    console.log("Verify Beneficiary Request:", requestPayload);

    $.ajax({
        url: url,
        type: "POST",
        contentType: "application/json",
        dataType: "json",
        headers: headers,
        data: JSON.stringify(requestPayload),

        success: function (response) {

            console.log("Verify Beneficiary Response:", response);

            if (response.statusCode === "SUCCESS" || response.statusCode === "TXN") {

                showSuccess("Beneficiary added successfully");
                $("#txtbeneOTP").hide().val("");
                $(".primary-btn:contains('Verify Account')").hide();
                $(".primary-btn:contains('Add Account')").show();
                $("#ddlBank, #txtbeneMobNo, #txtbeneAccountNo, #txtbeneName, #txtbeneIfscCode")
                    .removeClass("disablecss")
                    .prop("disabled", false)
                    .val("");
                openSenderSidebar();
                $("#closeBeneficiarySidebar").click();
            }
            else {
                showFailed(response.status || "OTP verification failed");
            }

            $(".loader-overlay").css("display", "none");
        },

        error: function (xhr) {
            showFailed(JSON.stringify({
                status: xhr.status,
                statusText: xhr.statusText,
                response: xhr.responseText
            }, null, 2));
            $(".loader-overlay").css("display", "none");
        }
    });
}

function FetchIfscCode() {
    var selectedOption = $('#ddlBank option:selected');
    var ifsc = selectedOption.data('ifsc') || '';

    $('#txtbeneIfscCode').val(ifsc);
}



function LoadBeneficiaryDetails(beneficiaryData) {

    const $list = $("#beneficiaryList");
    $list.empty();

    if (!beneficiaryData || beneficiaryData.length === 0) {
        $list.append(`
            <div class="text-muted" style="padding:10px;">
                No beneficiaries found
            </div>
        `);
        return;
    }

    $.each(beneficiaryData, function (i, ben) {

        const html = `
        <div class="beneficiary-item" data-benid="${ben.id}"
     data-name="${ben.name.toLowerCase()}"
     data-account="${ben.account}"
     data-bank="${ben.bank.toLowerCase()}"
     data-ifsc="${ben.ifsc.toLowerCase()}">
            
            <div class="bank-icon">
                🏦
            </div>

            <div class="beneficiary-details">
                <div class="account">
                    <strong>${ben.account}</strong> || ${ben.name}
                </div>
                <div class="bank">
                    ${ben.bank} || ${ben.ifsc}
                </div>
            </div>

            <div class="actions">
                <button class="pay-btn" type="button"
                        onclick="payNow('${ben.id}')">
                    Pay Now
                </button>

                <span class="delete-btn"
                      onclick="deleteBeneficiary('${ben.id}')">
                    🗑️
                </span>
            </div>
        </div>
        `;

        $list.append(html);
    });
}

$('#txtSearchBene').on('keyup', function () {

    let search = $(this).val().toLowerCase().trim();

    $('.beneficiary-item').each(function () {

        let $item = $(this);

        let name = ($item.data('name') || '').toString();
        let account = ($item.data('account') || '').toString();
        let bank = ($item.data('bank') || '').toString();
        let ifsc = ($item.data('ifsc') || '').toString();

        let match =
            name.includes(search) ||
            account.includes(search) ||
            bank.includes(search) ||
            ifsc.includes(search);

        $item.toggle(match);
    });
});



function payNow(beneficiaryId) {
    console.log("Pay to beneficiary:", beneficiaryId);
    $("#hdnBeneficiaryId").val(deleteBeneId);
    payeeBeneId = beneficiaryId;
    let $bene = $('.beneficiary-item[data-benid="' + payeeBeneId + '"]');

    if ($bene.length === 0) {
        showFailed("Beneficiary not found");
        return;
    }
    $('.tdBankName').text($bene.data('bank'));
    $('.tdAcountNo').text($bene.data('account'));
    $('.tdBeneficiaryName').text($bene.data('name'));
    $('.tdBeneIfscCode').text($bene.data('ifsc'));
    $("#TxnAmount").val("");
    $("#TxnOTP").val("");
}

function deleteBeneficiary(beneficiaryId) {

    if(!confirm("Are you sure you want to delete this beneficiary?"))
        return;

    let $bene = $('.beneficiary-item[data-benid="' + beneficiaryId + '"]');

    if ($bene.length === 0) {
        showFailed("Beneficiary not found");
        return;
    }

    $(".loader-overlay").css("display", "flex");

    const url = "https://api.banku.co.in/api/DMT/beneficiary-delete";

    const headers = {
        "userid": $("#ContentPlaceHolder1_hdnUserId").val(),
        "username": "banku",
        "Content-Type": "application/json",
        "Accept": "*/*"
    };

    const requestPayload = {
        remitterMobileNumber: $("#mobile").val().trim(),
        beneficiaryId: beneficiaryId,
        endpointIp: "",
        userId: $("#ContentPlaceHolder1_hdnUserId").val()
    };

    console.log("Delete Beneficiary Request:", requestPayload);

    $.ajax({
        url: url,
        type: "POST",
        contentType: "application/json",
        dataType: "json",
        headers: headers,
        data: JSON.stringify(requestPayload),
        success: function (response) {
            console.log("Delete Beneficiary Response:", response);
            if (response.statusCode === "OTP") {

                deleteBeneReferenceKey = response.data.referenceKey;
                deleteBeneId = response.data.beneficiaryId;

                $("#hdnBeneficiaryId").val(deleteBeneId);
                $('.tdBankName').text($bene.data('bank'));
                $('.tdAcountNo').text($bene.data('account'));
                $('.tdBeneficiaryName').text($bene.data('name'));
                $('.tdBeneIfscCode').text($bene.data('ifsc'));
                $('#txtBeneDelOTP').val('');

                document.getElementById("DeleteBenePreviewSidebar").style.right = "0px";
            }
            else {
                showFailed(response.status || "Unable to send OTP");
            }

            $(".loader-overlay").css("display", "none");
        },

        error: function (xhr) {
            showFailed(JSON.stringify({
                status: xhr.status,
                statusText: xhr.statusText,
                response: xhr.responseText
            }, null, 2));
            $(".loader-overlay").css("display", "none");
        }
    });
}

function verifyDeleteBeneficiary() {

    var otp = $("#txtBeneDelOTP").val().trim();

    if (otp === "") {
        showFailed("Please enter OTP");
        return;
    }

    if (!deleteBeneReferenceKey || !deleteBeneId) {
        showFailed("Delete reference missing");
        return;
    }

    $(".loader-overlay").css("display", "flex");

    const url = "https://api.banku.co.in/api/DMT/beneficiary-delete-verify";

    const headers = {
        "userid": $("#ContentPlaceHolder1_hdnUserId").val(),
        "username": "banku",
        "Content-Type": "application/json",
        "Accept": "*/*"
    };

    const requestPayload = {
        remitterMobileNumber: $("#mobile").val().trim(),
        referenceKey: deleteBeneReferenceKey,
        otp: otp,
        beneficiaryId: deleteBeneId,
        userId: $("#ContentPlaceHolder1_hdnUserId").val(),
        endpointIp: ""
    };

    console.log("Verify Delete Beneficiary Request:", requestPayload);

    $.ajax({
        url: url,
        type: "POST",
        contentType: "application/json",
        dataType: "json",
        headers: headers,
        data: JSON.stringify(requestPayload),

        success: function (response) {

            console.log("Verify Delete Beneficiary Response:", response);

            if (response.statusCode === "TXN") {
                showSuccess("Beneficiary deleted successfully");
                $('.beneficiary-item[data-benid="' + deleteBeneId + '"]').remove();
                $('#DeleteBenePreviewSidebar').css("right","-500px");
                $('#txtBeneDelOTP').val('');
                openSenderSidebar();
            }
            else {
                showFailed(response.status || "OTP verification failed");
            }

            $(".loader-overlay").css("display", "none");
        },

        error: function (xhr) {
            showFailed(JSON.stringify({
                status: xhr.status,
                statusText: xhr.statusText,
                response: xhr.responseText
            }, null, 2));
            $(".loader-overlay").css("display", "none");
        }
    });
}

function SendTxnOTP() {

    
    var amount = $("#TxnAmount").val().trim();

    if (amount === "" || isNaN(amount) || Number(amount) <= 0) {
        showFailed("please enter valid amount");
        return;
    }

    txnAmount = amount;
    let $bene = $('.beneficiary-item[data-benid="' + payeeBeneId + '"]');

    if ($bene.length === 0) {
        showFailed("Beneficiary not found");
        return;
    }

    $(".loader-overlay").css("display", "flex");

    const url = "https://api.banku.co.in/api/DMT/DMTTransactionOTP";

    const headers = {
        "userid": $("#ContentPlaceHolder1_hdnUserId").val(),
        "username": "banku",
        "Content-Type": "application/json",
        "Accept": "*/*"
    };

    const requestPayload = {
        remitterMobileNumber: $("#mobile").val().trim(),
        amount: amount || "500",
        referenceKey: profilereferenceKey,
        ip: "",
        userId: $("#ContentPlaceHolder1_hdnUserId").val()
    };

    console.log("Txn OTP Request:", requestPayload);

    $.ajax({
        url: url,
        type: "POST",
        contentType: "application/json",
        dataType: "json",
        headers: headers,
        data: JSON.stringify(requestPayload),

        success: function (response) {

            console.log("Txn OTP Response:", response);

            if (response.statusCode === "OTP") {

                txnReferenceKey = response.data.referenceKey;
                $('.tdBankName').text($bene.data('bank'));
                $('.tdAcountNo').text($bene.data('account'));
                $('.tdBeneficiaryName').text($bene.data('name'));
                $('.tdBeneIfscCode').text($bene.data('ifsc'));
                showSuccess("OTP sent successfully");
                $("#TxnOTP").val("").show();
            }
            else {
                showFailed(response.status || "Failed to send OTP");
            }

            $(".loader-overlay").css("display", "none");
        },

        error: function (xhr) {
            showFailed(JSON.stringify({
                status: xhr.status,
                statusText: xhr.statusText,
                response: xhr.responseText
            }, null, 2));
            $(".loader-overlay").css("display", "none");
        }
    });
}

function ProceedTransaction() {

    let $bene = $('.beneficiary-item[data-benid="' + payeeBeneId + '"]');

    if ($bene.length === 0) {
        showFailed("Beneficiary not found");
        return;
    }

    var otp = $("#TxnOTP").val().trim();
    var amount = $("#TxnAmount").val().trim();
    var txnType = $("#ddlTxnType").val();

    if (amount === "" || Number(amount) <= 0) {
        showFailed("Enter valid amount");
        return;
    }

    if (otp === "") {
        showFailed("Please enter OTP");
        return;
    }

    $(".loader-overlay").css("display", "flex");

    const url = "https://api.banku.co.in/api/DMT/DMTTransaction";

    const headers = {
        "userid": $("#ContentPlaceHolder1_hdnUserId").val(),
        "username": "banku",
        "Content-Type": "application/json",
        "Accept": "*/*"
    };

    const requestPayload = {
        remitterMobileNumber: $("#mobile").val().trim(),
        accountNumber: $bene.data('account').toString(),
        ifsc: $bene.data('ifsc').toUpperCase(),
        transferMode: txnType,
        transferAmount: amount,
        latitude: $("#ContentPlaceHolder1_hdLatitude").val(),
        longitude: $("#ContentPlaceHolder1_hdLongitude").val(),
        referenceKey: txnReferenceKey,
        otp: otp,
        externalRef: Date.now().toString(),
        ip: "",
        userId: $("#ContentPlaceHolder1_hdnUserId").val()
    };

    console.log("Transaction Request:", requestPayload);

    $.ajax({
        url: url,
        type: "POST",
        contentType: "application/json",
        dataType: "json",
        headers: headers,
        data: JSON.stringify(requestPayload),

        success: function (response) {

            console.log("Transaction Response:", response);

            if (response.statuscode === "TXN" || response.statuscode === "TUP") {
                bindTxnInvoice(response, $bene.data('bank'));
                $("#moneyPreviewSidebar").css("right","-500px");
                var modal = new bootstrap.Modal(document.getElementById('InvoiceTrnx'));
                modal.show();
            }
            else {
                showFailed(response.status || "Transaction failed");
            }

            $(".loader-overlay").css("display", "none");
        },

        error: function (xhr) {
            showFailed(JSON.stringify({
                status: xhr.status,
                statusText: xhr.statusText,
                response: xhr.responseText
            }, null, 2));
            $(".loader-overlay").css("display", "none");
        }
    });
}

function bindTxnInvoice(response, bankName) {
    var data = response.data;
    $(".balanceTxnType").text("Money Transfer");
    $(".balancerrn").text(response.orderid);
    $(".lblTxnDate").text(response.timestamp);
    $(".balanceTxnType").text("Money Transfer");
    $(".balanceBankName").text(bankName);
    $(".txnifsccode").text(data.beneficiaryIfsc);
    $(".txnAccountNo").text(data.beneficiaryAccount);
    $(".txnBeneName").text(data.beneficiaryName);
    $(".txnAmount").text("₹ " + data.txnValue);
    $("#Label6").text(response.status);
}

function printReceipt() {
    var printContent = document.getElementById('printArea').innerHTML;
    var win = window.open('', '_blank');
    win.document.write(`
            <html>
                <head>
                    <title>Print Receipt</title>
                    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
                    <style>
                        body { font-family: Arial, sans-serif; padding: 20px; }
                        .fw-bold { font-weight: bold; }
                        .text-dark { color: #000; }
                        .text-success { color: green; }
                        .text-danger { color: red; }
                        .text-center { text-align: center; }
                        .border-bottom { border-bottom: 1px solid #ccc; padding-bottom: 4px; margin-bottom: 6px; }
                        .no-print { display: none; }
                    </style>
                </head>
                <body onload="window.print(); window.close();">
                    ${printContent}
                </body>
            </html>
        `);
    win.document.close();
}


document.addEventListener(
    'focusin',
    function (e) {
        if (
            e.target.tagName === 'INPUT' ||
            e.target.tagName === 'TEXTAREA' ||
            e.target.classList.contains('select2-search__field')
        ) {
            e.stopImmediatePropagation();
        }
    },
    true
);


function ResendBeneficiaryOTP() {

    let beneficiaryId = $("#hdnBeneficiaryId").val().trim();

    let $bene = $('.beneficiary-item[data-benid="' + beneficiaryId + '"]');

    if ($bene.length === 0) {
        showFailed("Beneficiary not found");
        return;
    }

    $(".loader-overlay").css("display", "flex");

    const url = "https://api.banku.co.in/api/DMT/beneficiary-delete";

    const headers = {
        "userid": $("#ContentPlaceHolder1_hdnUserId").val(),
        "username": "banku",
        "Content-Type": "application/json",
        "Accept": "*/*"
    };

    const requestPayload = {
        remitterMobileNumber: $("#mobile").val().trim(),
        beneficiaryId: beneficiaryId,
        endpointIp: "",
        userId: $("#ContentPlaceHolder1_hdnUserId").val()
    };

    console.log("Delete Beneficiary Request:", requestPayload);

    $.ajax({
        url: url,
        type: "POST",
        contentType: "application/json",
        dataType: "json",
        headers: headers,
        data: JSON.stringify(requestPayload),
        success: function (response) {
            console.log("Delete Beneficiary Response:", response);
            if (response.statusCode === "OTP") {

                deleteBeneReferenceKey = response.data.referenceKey;
                deleteBeneId = response.data.beneficiaryId;

                $("#hdnBeneficiaryId").val(deleteBeneId);
                $('.tdBankName').text($bene.data('bank'));
                $('.tdAcountNo').text($bene.data('account'));
                $('.tdBeneficiaryName').text($bene.data('name'));
                $('.tdBeneIfscCode').text($bene.data('ifsc'));
                $('#txtBeneDelOTP').val('');

                document.getElementById("DeleteBenePreviewSidebar").style.right = "0px";
            }
            else {
                showFailed(response.status || "Unable to send OTP");
            }

            $(".loader-overlay").css("display", "none");
        },

        error: function (xhr) {
            showFailed(JSON.stringify({
                status: xhr.status,
                statusText: xhr.statusText,
                response: xhr.responseText
            }, null, 2));
            $(".loader-overlay").css("display", "none");
        }
    });
}



function cancelSenderCreation() {
    $("#txtSenderMobileNumber").val("");
    $("#txtSenderAadharNumber").val("");
    $("#senderOTPInput").hide();
    $("#btnVerifySender").hide();
    $("#btnSenderCreation").show();
    document.getElementById("senderSidebar").style.display = "none";
    document.body.style.overflow = "hidden";
}
function senderCreationImit() {

    let mobileno = $("#txtSenderMobileNumber").val().trim();
    let senderAadhar = $("#txtSenderAadharNumber").val().trim();
    if (mobileno == "") {
        showFailed("Please Enter Mobile Number!");
        return;
    }
    if (senderAadhar == "") {
        showFailed("Please Enter Aadhar Number!");
        return;
    }

    if (!profilereferenceKey) {
        showFailed("Reference key missing. Please retry.");
        return;
    }

    $(".loader-overlay").css("display", "flex");

    var selectedProvider = $(".header-tab.active").data("item");
    selectedProvider = selectedProvider === "INP" ? "instantpay" : selectedProvider;

    const url = "https://api.banku.co.in/api/DMT/remitter-registration";

    const headers = {
        "userid": $("#ContentPlaceHolder1_hdnUserId").val(),
        "username": "banku",
        "Content-Type": "application/json",
        "Accept": "*/*"
    };

    const requestPayload = {
        userId: $("#ContentPlaceHolder1_hdnUserId").val(),
        referenceKey: profilereferenceKey,
        txnMode: "",
        aadhar: senderAadhar,
        mobileNumber: mobileno,
        otp: "",
        source: "web",
        provider: selectedProvider,
        endpointIp: ""
    };

    console.log("Sender Registration Request:", requestPayload);

    $.ajax({
        url: url,
        type: "POST",
        contentType: "application/json",
        dataType: "json",
        headers: headers,
        data: JSON.stringify(requestPayload),

        success: function (response) {

            console.log("Sender Registration Response:", response);

            if (response.statusCode === "OTP") {
                showSuccess(response.status || "OTP sent successfully");
                
                $("#senderOTPInput").show();
                $("#btnVerifySender").show();
                $("#btnSenderCreation").hide();
            }
            else {
                showFailed(response.status || "Sender registration failed");
                $("#senderOTPInput").hide();
            }

            $(".loader-overlay").css("display", "none");
        },

        error: function (xhr) {
            showFailed(JSON.stringify({
                status: xhr.status,
                statusText: xhr.statusText,
                response: xhr.responseText
            }, null, 2));

            $(".loader-overlay").css("display", "none");
        }
    });
}
function verifySender() {

    let mobileno = $("#txtSenderMobileNumber").val().trim();
    let senderAadhar = $("#txtSenderAadharNumber").val().trim();
    let senderOTP = $("#txtSenderOTP").val().trim();
    if (mobileno == "") {
        showFailed("Please Enter Mobile Number!");
        return;
    }
    if (senderAadhar == "") {
        showFailed("Please Enter Aadhar Number!");
        return;
    }

    if (senderOTP == "") {
        showFailed("Please Enter OTP!");
        return;
    }

    if (!profilereferenceKey) {
        showFailed("Reference key missing. Please retry.");
        return;
    }

    $(".loader-overlay").css("display", "flex");

    var selectedProvider = $(".header-tab.active").data("item");
    selectedProvider = selectedProvider === "INP" ? "instantpay" : selectedProvider;

    const url = "https://api.banku.co.in/api/DMT/remitter-registration-validate";

    const headers = {
        "userid": $("#ContentPlaceHolder1_hdnUserId").val(),
        "username": "banku",
        "Content-Type": "application/json",
        "Accept": "*/*"
    };

    const requestPayload = {
        userId: $("#ContentPlaceHolder1_hdnUserId").val(),
        referenceKey: profilereferenceKey,
        txnMode: "",
        aadhar: senderAadhar,
        mobileNumber: mobileno,
        otp: senderOTP,
        source: "web",
        provider: selectedProvider,
        endpointIp: ""
    };

    console.log("Sender OTP Verify Request:", requestPayload);

    $.ajax({
        url: url,
        type: "POST",
        contentType: "application/json",
        dataType: "json",
        headers: headers,
        data: JSON.stringify(requestPayload),

        success: function (response) {

            console.log("Sender Registration Response:", response);

            if (response.statusCode === "KYC") {
                showSuccess(response.status || "Mobile validated successfully please proceed for kyc");
                senderregistrationreferenceKey = response.data.referenceKey;
                $("#txtSenderMobileNumber").val("");
                $("#txtSenderAadharNumber").val("");
                $("#txtSenderOTP").val("")
                $("#senderOTPInput").hide();
                $("#btnVerifySenderOtp").hide();
                $("#btnSenderCreation").show();
                document.getElementById("senderPopup").style.display = "flex";
                document.getElementById("senderSidebar").style.display = "none";
            }
            else {
                showFailed(response.status || "Sender registration failed");
                
            }

            $(".loader-overlay").css("display", "none");
        },

        error: function (xhr) {
            showFailed(JSON.stringify({
                status: xhr.status,
                statusText: xhr.statusText,
                response: xhr.responseText
            }, null, 2));

            $(".loader-overlay").css("display", "none");
        }
    });
}

function ProceedEKYC() {

    captureFingerprint();
}

function buildKYCPayload(pidXml) {

    let mobileno = $("#mobile").val().trim();
    if (!mobileno) {
        showFailed("Mobile number missing");
        return;
    }

    if (!senderregistrationreferenceKey) {
        showFailed("Reference key missing");
        return;
    }


    if (!pidXml) {
        showFailed("Biometric data not captured");
        return;
    }

    const pid = parsePidXml(pidXml);

    return {
        userId: $("#ContentPlaceHolder1_hdnUserId").val(),
        mobileNumber: mobileno,
        referenceKey: senderregistrationreferenceKey,
        endpointIp: "",
        latitude: $("#ContentPlaceHolder1_hdLatitude").val(),
        longitude: $("#ContentPlaceHolder1_hdLongitude").val(),
        externalRef: "",
        consentTaken: "Y",
        captureType: "FINGER",
        biometricData: {
            ci: pid.ci,
            hmac: pid.hmac,
            pidData: pid.pidData,
            ts: pid.ts || "",
            dc: pid.dc,
            mi: pid.mi,
            dpId: pid.dpId,
            mc: pid.mc,
            rdsId: pid.rdsId,
            rdsVer: pid.rdsVer,
            skey: pid.skey || "",
            srno: pid.srno || "2526I031118"
        }
    };
}

function CompleteSenderEKYC(pidXml) {

    let mobileno = $("#mobile").val().trim();
    if (!mobileno) {
        showFailed("Mobile number missing");
        return;
    }

    if (!senderregistrationreferenceKey) {
        showFailed("Reference key missing");
        return;
    }

    $(".loader-overlay").css("display", "flex");
    const url = "https://api.banku.co.in/api/DMT/remitter-EKYC";
    const headers = {
        "userid": $("#ContentPlaceHolder1_hdnUserId").val(),
        "username": "banku",
        "Content-Type": "application/json",
        "Accept": "*/*"
    };

    const request = buildKYCPayload(pidXml);
    console.log("EKYC Request:", request);
    $.ajax({
        url: url,
        type: "POST",
        contentType: "application/json",
        dataType: "json",
        headers: headers,
        data: JSON.stringify(request),

        success: function (response) {

            console.log("EKYC Response:", response);

            if (response.success === true || response.statusCode === "TXN") {
                showSuccess(response.status || "eKYC completed successfully");

                
            }
            else {
                showFailed(response.status || "eKYC failed");
            }

            $(".loader-overlay").css("display", "none");
        },

        error: function (xhr) {
            showFailed(JSON.stringify({
                status: xhr.status,
                statusText: xhr.statusText,
                response: xhr.responseText
            }, null, 2));

            $(".loader-overlay").css("display", "none");
        }
    });
}

async function captureFingerprint(deviceType = "") {
    if (!selectedDevice) {
        showFailed('Please select a device first.');
        return false;
    }
    try {
        const pidXml = await captureRdData(selectedDevice, false, "EKYC");
        CompleteSenderEKYC(pidXml);
    } catch (err) {
        alert("Capture failed: " + err.message);
    }
    return false;
}
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
                showFailed(res.Message);
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
                showFailed(res.Message);
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

$("#checkEKYCStatus").click(function () {
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
            } else {
                showFailed(res.Message);
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

function openLoginPopup() {
    var myOffcanvas = new bootstrap.Offcanvas($('#aepsLoginSidebar')[0]);
    myOffcanvas.show();
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
                $(".loader-overlay").css("display", "none");
            } else {
                showFailed(res.Data[0].status);
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
                showFailed(res.Message || "Transaction Failed");
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
                showFailed(res.Data[0].status || "Transaction Failed");
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
                showFailed(res.Data[0].status || "Transaction Failed");
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
                showFailed(res.Data[0].status || "Transaction Failed");
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
                showFailed(res.Data[0].status || "Transaction Failed");
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
        pidData: data?.textContent || "",
        skey: skey?.textContent || ""
    };
}