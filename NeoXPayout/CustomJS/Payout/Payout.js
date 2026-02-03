$(document).ready(function () {
    const validateUrl = "https://api.banku.co.in/api/IDFCPayout/idfc/bene-validation";
    const payoutUrl = "https://api.banku.co.in/api/IDFCPayout/idfc/fund-transfer";
    const headers = {
        "userid": $("#ContentPlaceHolder1_hdnUserId").val(),
        "username": $("#ContentPlaceHolder1_hdnUserName").val(),
        "Content-Type": "application/json",
        "Accept": "*/*"
    };
    $("#btnValidateBene").on("click", function () {
        $(".loader-overlay").css("display", "flex");
        const accountNo = $("#ContentPlaceHolder1_txtAccount").val().trim();
        const ifsc = $("#ContentPlaceHolder1_txtIFSC").val().trim();
        if (accountNo === "" || ifsc === "") {
            showFailed("Account Number and IFSC Code are mandatory.");
            $(".loader-overlay").css("display", "none");
            return;
        }
        const payload = {
            beneValidationReq: {
                remitterName: $("#ContentPlaceHolder1_hdnUserName").val(),
                companyCode: "BANKU",
                remitterMobileNumber: "+91-"+$("#ContentPlaceHolder1_DebitAcc").val() || "+91-9999999999",
                accountType: "10",
                creditorAccountId: accountNo,
                ifscCode: ifsc,
                paymentDescription: "Bene Validation",
                transactionReferenceNumber: "",
                merchantCode: "",
                identifier: "Auto"
            }
        };

        $("#btnValidateBene").prop("disabled", true).text("Validating...");

        $.ajax({
            url: validateUrl,
            type: "POST",
            contentType: "application/json",
            data: JSON.stringify(payload),
            headers: headers,
            success: function (res) {
                const meta = res?.beneValidationResp?.metaData;
                const data = res?.beneValidationResp?.resourceData;
                if (meta?.status === "SUCCESS") {
                    $("#ContentPlaceHolder1_txtBene").val(data.creditorName);
                    $("#ContentPlaceHolder1_BankPayout2").prop("disabled", false);
                    showSuccess("Beneficiary validated successfully.");
                } else {
                    resetAfterFailure(meta?.message || "Beneficiary validation failed.");
                }
                $(".loader-overlay").css("display", "none");
            },
            error: function (xhr) {
                resetAfterFailure("Server error while validating beneficiary.");
            },
            complete: function () {
                $("#btnValidateBene").prop("disabled", false).text("Validate");
                $(".loader-overlay").css("display", "none");
            }
        });
    });

    function resetAfterFailure(message) {
        $("#ContentPlaceHolder1_txtBene").val("");
        $("#ContentPlaceHolder1_BankPayout2").prop("disabled", true);
        showFailed(message);
    }

    $(".mode-btn").on("click", function () {
        $(".mode-btn").removeClass("active");
        $(this).addClass("active");
        $("#ContentPlaceHolder1_hfPaymentMode").val($(this).data("mode"));
    });

    $("#ContentPlaceHolder1_hfPaymentMode").val("IMPS");

    $("#ContentPlaceHolder1_BankPayout2").on("click", function (e) {
        $(".loader-overlay").css("display", "flex");
        e.preventDefault();
        if (!Page_ClientValidate("BankPayoutGroup")) {
            $(".loader-overlay").css("display", "none");
            return;
        }
        const payload = {
            initiateAuthGenericFundTransferAPIReq: {
                tellerBranch: "41101",
                tellerID: "9903",
                debitAccountNumber: "",
                creditAccountNumber: $("#ContentPlaceHolder1_txtAccount").val(),
                remitterName: $("#ContentPlaceHolder1_hdnUserName").val(),
                amount: $("#ContentPlaceHolder1_txtAmount").val(),
                currency: "INR",
                transactionType: $("#ContentPlaceHolder1_hfPaymentMode").val(),
                paymentDescription: "Payout Payment",
                beneficiaryIFSC: $("#ContentPlaceHolder1_txtIFSC").val(),
                beneficiaryName: $("#ContentPlaceHolder1_txtBene").val(),
                beneficiaryAddress: "NA",
                emailID: "support@banku.co.in",
                mobileNo: "+91-"+$("#ContentPlaceHolder1_txtMobile").val(),
                companyCode: "BANKU",
                userId: $("#ContentPlaceHolder1_hdnUserId").val()
            }
        };

        $("#ContentPlaceHolder1_BankPayout2").prop("disabled", true).val("Processing...");

        $.ajax({
            url: payoutUrl,
            type: "POST",
            contentType: "application/json",
            data: JSON.stringify(payload),
            headers: headers,
            success: function (res) {
                const apiResp = res?.data?.initiateAuthGenericFundTransferAPIResp;
                const meta = apiResp?.metaData;
                const data = apiResp?.resourceData;
                if (meta?.status === "SUCCESS") {
                    showInvoice(data, meta, $("#ContentPlaceHolder1_txtAccount").val(), $("#ContentPlaceHolder1_txtAmount").val(), $("#ContentPlaceHolder1_txtIFSC").val());
                    var modal = new bootstrap.Modal(document.getElementById('InvoiceTrnx'));
                    modal.show();
                } else {
                    showFailed(meta?.message || "Transaction failed.");
                }
                $(".loader-overlay").css("display", "none");
            },
            error: function () {
                showFailed("Fund transfer failed due to server error.");
            },
            complete: function () {
                $("#ContentPlaceHolder1_BankPayout2").prop("disabled", true).val("Proceed");
                $("#ContentPlaceHolder1_txtAccount").val("");
                $("#ContentPlaceHolder1_txtIFSC").val("");
                $("#ContentPlaceHolder1_txtBene").val("");
                $("#ContentPlaceHolder1_txtAmount").val("");
                $("#ContentPlaceHolder1_txtMobile").val("");
                $(".loader-overlay").css("display", "none");
            }
        });
    });


    function showInvoice(data, meta, AcountNo, Amount, IFSC) {
        $(".balanceTxnType").text("Payout Invoice");
        $(".balancerrn").text(data.transactionReferenceNo);
        $(".lblTxnDate").text(meta.time);
        $(".balanceTxnType").text("Payout Invoice");
        $(".txnifsccode").text(IFSC);
        $(".txnAccountNo").text(AcountNo);
        $(".txnBeneName").text(data.beneficiaryName);
        $(".txnAmount").text("₹ " + Amount);
        $("#Label6").text(meta.message);
    }
});