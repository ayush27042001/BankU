<%@ Page Title="" Language="C#" MasterPageFile="~/Neox.Master" AutoEventWireup="true" CodeBehind="AEPS.aspx.cs" Inherits="NeoXPayout.AEPS" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
   <%--ValidateRequest="false"--%>
<style>
    .form-icon-group {
        position: relative;
    }

    .form-icon-group .form-control {
        padding-left: 2.2rem !important; 
    }

    .form-icon {
        position: absolute;
        top: 50%;
        left: 10px;
        transform: translateY(-50%);
        color: #6c757d;
        font-size: 1rem;
        pointer-events: none;
    }

    .pop_up, .pop_up1 {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0,0,0,0.6);
    z-index: 9999;
    display: flex;
    align-items: center;
    justify-content: center;
}

.subscribe_box, .subscribe_box1 {
    background-color: #fff;
    padding: 30px;
    border-radius: 12px;
    text-align: center;
    box-shadow: 0 0 10px rgba(0,0,0,0.2);
}

.close {
    float: right;
    font-size: 16px;
    color: #555;
}
.close:hover {
    color: red;
}

</style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<hr />

<div class="px-xl-6 px-lg-6  px-3 py-3 page-body">
                    <div class="row">
                         <div class="col-md-6 col-lg-12 col-xl-6">
                              <div class="card ">
                                 <div class="card-header border-bottom pb-0">
                                    <div class="d-flex align-items-center mb-2 flex-wrap w-100">
                                        <!-- Left side: Tabs -->
                                        <ul class="nav nav-pills nav-pills-underline mb-2 mb-md-0">
                                             <li class="nav-item">
                                                <asp:LinkButton runat="server" ID="btnTran" CssClass="nav-link" OnClick="BillType_Click" CommandArgument="Transaction">AEPS Transaction</asp:LinkButton>
                                            </li>
                                            <li class="nav-item">
                                                <asp:LinkButton runat="server" ID="btnAEPS" CssClass="nav-link" OnClick="BillType_Click" CommandArgument="Authentication">AEPS Authentication</asp:LinkButton>
                                            </li>                                         
                                        </ul>
                                    </div>
                                </div>

                                <div class="card-body">
                                    <!-- AEPS Authentication Form -->
                                    <asp:Panel ID="pnlAuthentication" runat="server">
                                        <div class="mb-2">
                                            <label class="col-form-label">Retailer Aadhaar Number</label>
                                            <fieldset class="form-icon-group left-icon position-relative">
                                                <asp:TextBox ID="txtAadhaar" CssClass="form-control" runat="server"></asp:TextBox>
                                                <div class="form-icon"><i class="bi bi-phone"></i></div>
                                            </fieldset>
                                        </div>
                                        <div class="mt-2">
                                            <asp:LinkButton ID="LinkButton1" runat="server" CssClass="btn btn-primary" OnClick="LinkButton1_Click">Scan</asp:LinkButton>        
                                            <asp:Label ID="Label2" runat="server" Font-Bold="True" ForeColor="Red"></asp:Label>
                                            <asp:Label ID="Label1" runat="server" Font-Bold="True" ForeColor="Red"></asp:Label>
                                        </div>
                                    </asp:Panel>

                                    <!-- AEPS Transaction Form -->
                                    <asp:Panel ID="pnlTransaction" runat="server" Visible="false">
                                      
                                        <div class="mb-3 row">
                                            <div class="col-sm-12 d-flex gap-4 align-items-center">
                                                <div class="form-check">
                                                    <asp:RadioButton ID="rdoMiniStatement" runat="server" Attributes="value=SAP" GroupName="TransactionType" CssClass="form-check-input" />
                                                    <label class="form-check-label ms-1" for="rdoMiniStatement">Mini Statement</label>
                                                </div>
                                                <div class="form-check">
                                                    <asp:RadioButton ID="rdoBalanceEnquiry" runat="server" Attributes="value=BAP" GroupName="TransactionType" CssClass="form-check-input" />
                                                    <label class="form-check-label ms-1" for="rdoBalanceEnquiry">Balance Enquiry</label>
                                                </div>
                                                <div class="form-check">
                                                    <asp:RadioButton ID="rdoCashWithdrawal" runat="server" Attributes="value=WAP" GroupName="TransactionType" CssClass="form-check-input" />
                                                    <label class="form-check-label ms-1" for="rdoCashWithdrawal">Cash Withdrawal</label>
                                                </div>
                                                <div class="form-check">
                                                    <asp:RadioButton ID="rdoCashDeposit" runat="server" Attributes="value=CashDeposit" GroupName="TransactionType" CssClass="form-check-input" />
                                                    <label class="form-check-label ms-1" for="rdoCashDeposit">Cash Deposit</label>
                                                </div>
                                            </div>

                                            <div class="col-sm-12 mt-2">
                                                <asp:CustomValidator ID="cvTransactionType" runat="server"
                                                     ValidationGroup="TxnGroup"
                                                    ErrorMessage="Please select a transaction type"
                                                    Display="Dynamic"
                                                    CssClass="text-danger"
                                                    ClientValidationFunction="validateTransactionType"
                                                    EnableClientScript="true" />
                                            </div>
                                        </div>
                                       <div class="mb-3 row">
                                            <label for="ddlbankname" class="col-sm-4 col-form-label fw-semibold">Bank Name</label>
                                            <div class="col-sm-8">
                                                 <asp:DropDownList ID="ddlbankname" runat="server" CssClass="form-control" MaxLength="50" ></asp:DropDownList>
                                                <asp:RequiredFieldValidator ID="rfvBankName" runat="server"
                                                    ValidationGroup="TxnGroup"
                                                    ControlToValidate="ddlbankname"
                                                    InitialValue=""
                                                    Display="Dynamic"
                                                    ErrorMessage="Please select a bank"
                                                    CssClass="text-danger" />
                                            </div>
                                        </div>

                                        <div class="mb-3 row">
                                            <label for="txtMobileNumber" class="col-sm-4 col-form-label fw-semibold">Mobile Number</label>
                                            <div class="col-sm-8">
                                                <asp:TextBox ID="txtMobileNumber" runat="server" CssClass="form-control" MaxLength="10" placeholder="Enter Mobile Number"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="rfvMobile" runat="server"
                                                     ValidationGroup="TxnGroup"
                                                    ControlToValidate="txtMobileNumber"
                                                    Display="Dynamic"
                                                    ErrorMessage="Mobile number is required"
                                                    CssClass="text-danger" />
                                            </div>
                                        </div>

                                        <div class="mb-3 row">
                                            <label for="txtAadhaarNumber" class="col-sm-4 col-form-label fw-semibold">Aadhaar Number</label>
                                            <div class="col-sm-8">
                                                <asp:TextBox ID="txtAadhaarNumber" runat="server" CssClass="form-control" MaxLength="12" placeholder="Enter Aadhaar Number"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="rfvAadhaar" runat="server"
                                                     ValidationGroup="TxnGroup"
                                                    ControlToValidate="txtAadhaarNumber"
                                                    Display="Dynamic"
                                                    ErrorMessage="Aadhaar number is required"
                                                    CssClass="text-danger" />
                                            </div>
                                        </div>

                                        <!-- Amount field shown conditionally -->
                                        <asp:Panel ID="amount" runat="server" CssClass="mb-3 row" Style="display: none;">
                                            <label for="txtAmount" class="col-sm-4 col-form-label fw-semibold">Amount</label>
                                            <div class="col-sm-8">
                                                <asp:TextBox ID="txtAmount" runat="server" CssClass="form-control" MaxLength="6" placeholder="Enter Amount"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="rfvAmount" runat="server"
                                                     ValidationGroup="TxnGroup"
                                                    ControlToValidate="txtAmount"
                                                    Display="Dynamic"
                                                    ErrorMessage="Amount is required"
                                                    CssClass="text-danger" />
                                            </div>
                                        </asp:Panel>

                                        <div class="mb-3 row">
                                            <div class="text-center">
                                                <asp:Label ID="Label6" runat="server" CssClass="fw-bold fs-6 text-danger"></asp:Label>
                                            </div>
                                        </div>

                                        <div class="text-center mt-4">
                                            <asp:Button ID="btnSubmit" runat="server" Text="Scan"
                                            CssClass="btn btn-primary me-2"
                                            data-bs-toggle="modal" data-bs-target="#changeDeviceModal"
                                            ValidationGroup="TxnGroup" />
                                        </div>
                                    </asp:Panel>
                                </div>
                              </div>
                         </div>

                         <div class="col-md-6 col-lg-12 col-xl-6">
                            <div class="card">
                                <div class="card-header">
                                    <h6 class="card-title mb-0">Transaction History</h6>
                                    <div class="card-action">
                                        <div>
                                            <a href="#" class="card-fullscreen" data-bs-toggle="tooltip" title="Card Full Screen">
                                                <svg class="svg-stroke" xmlns="http://www.w3.org/2000/svg"
                                                     width="20" height="20" viewBox="0 0 24 24" fill="none"
                                                     stroke="currentColor" stroke-linecap="round"
                                                     stroke-linejoin="round">
                                                    <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>
                                                    <path d="M21 12v3a1 1 0 0 1 -1 1h-16a1 1 0 0 1 -1 -1v-10a1 1 0 0 1 1 -1h9"></path>
                                                    <path d="M7 20l10 0"></path>
                                                    <path d="M9 16l0 4"></path>
                                                    <path d="M15 16l0 4"></path>
                                                    <path d="M17 4h4v4"></path>
                                                    <path d="M16 9l5 -5"></path>
                                                </svg>
                                            </a>
                                            
                                        </div>
                                    </div>
                                </div>
                             
                                <div class="card-body">
                                    <!-- Row Template -->
                                    <asp:Literal ID="litRechargeHistory" runat="server"></asp:Literal>
                                    <a href="ReportBanku.aspx" class="mt-3 btn btn-grey-outline w-100 fw-medium">Show All</a>
                                </div>
                            </div>
                        </div>
                    </div>
               </div>

<div class="modal fade" id="changeDeviceModal" tabindex="-1" aria-labelledby="changeDeviceModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
        
            <div class="modal-header">
                <h5 class="modal-title" id="changeDeviceModalLabel">Select a Device</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            
            <div class="modal-body">
                <div class="mb-3 row">
                    <label class="col-sm-4 col-form-label fw-semibold">Transaction Type</label>
                    <div class="col-sm-8 d-flex flex-column gap-2">
                        <div class="form-check">
                            <asp:RadioButton ID="RadioButton1" runat="server" GroupName="TransactionType" CssClass="form-check-input" />
                            <label class="form-check-label" for="rdoMantraL1">Mantra L1</label>
                        </div>                     
                    </div>
                </div>

            </div>
            
            <div class="modal-footer">
             
               
              <asp:HiddenField ID="hdnPidData" runat="server" />
            <%--<asp:Button ID="btnCapture" class="btn btn-primary" runat="server" Text="Scan" OnClientClick="captureFingerprint(); return false;" />--%>
             <button type="button" id="btnCapture" class="btn btn-primary">Scan</button>
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
            <asp:Button ID="btnHiddenSubmit" runat="server" Text="Submit" Style="display:none;" OnClick="btnSubmit_Click" />
            <br /><br />
            <asp:Label ID="lblOutput" runat="server" Text="" Font-Names="Courier New" Font-Size="Small" />
            </div>

        </div>
    </div>
</div>

<!-- Capture Biometrics Modal -->
<div class="container">
    <div class="pop_up1" style="display: none;">
        <div class="subscribe_box1 text-center">
            <h2>Capture Biometrics</h2>
            <img src="assets\images\payment\ICN_scan_fp.gif" id="fingerloader" style="height: 106px;" />
            <img src="assets\images\payment\loading-1.gif" id="loader1" style="height: 106px; display: none;" />
            <p class="mt-3">Place your thumb/finger on biometric device</p>
        </div>
    </div>
</div>

<!-- Device Error Modal -->
<div class="container">
    <div class="pop_up" style="display: none;">
        <div class="subscribe_box text-center border rounded p-4 shadow">
            <div class="head mb-2">
                <span class="close" style="cursor: pointer;">Close</span>
                <div class="title fw-bold fs-4">Device Information</div>
            </div>
            <div class="body my-3">
                <img src="assets\images\payment\devicenotready.png" alt="Device Not Ready" style="height: 100px;" />
            </div>
            <div class="foot">
                <div class="subscribe">
                    <h5 class="text-danger" id="deviceerr_msg"></h5>
                </div>
            </div>
        </div>
    </div>
</div>


<input type="hidden" id="hdnlatitude" />
<input type="hidden" id="hdnlongitude" />
<input type="hidden" id="hdnscandetails" />
<asp:HiddenField ID="hdnUserKey" runat="server" />



<script type="text/javascript">
    document.addEventListener("DOMContentLoaded", function () {
        const rdoCashWithdrawal = document.getElementById("<%= rdoCashWithdrawal.ClientID %>");
        const rdoCashDeposit = document.getElementById("<%= rdoCashDeposit.ClientID %>");
        const rdoMiniStatement = document.getElementById("<%= rdoMiniStatement.ClientID %>");
        const rdoBalanceEnquiry = document.getElementById("<%= rdoBalanceEnquiry.ClientID %>");
        const amountRow = document.getElementById("<%= amount.ClientID %>");

        if (!amountRow) return;

        function toggleAmountField() {
            if (rdoCashWithdrawal.checked || rdoCashDeposit.checked) {
                amountRow.style.display = "flex";
            } else {
                amountRow.style.display = "none";
            }
        }

        [rdoCashWithdrawal, rdoCashDeposit, rdoMiniStatement, rdoBalanceEnquiry].forEach(rb => {
            if (rb) rb.addEventListener("change", toggleAmountField);
        });

        toggleAmountField(); // Run on load
    });
</script>

<script>
    function printReceipt() {
        var printContent = document.getElementById('printArea').innerHTML;
        var win = window.open('', '_blank');
        win.document.write(`
            <html>
                <head>
                    <title>Print Receipt</title>
                    <style>
                        body { font-family: Arial, sans-serif; padding: 20px; }
                        .fw-bold { font-weight: bold; }
                        .text-dark { color: #000; }
                        .text-success { color: green; }
                        .text-danger { color: red; }
                        .text-center { text-align: center; }
                        .border-bottom { border-bottom: 1px solid #ccc; padding-bottom: 4px; margin-bottom: 6px; }
                        .mb-2 { margin-bottom: 0.5rem; }
                        .pb-1 { padding-bottom: 0.25rem; }
                        .card-title { font-size: 1.25rem; margin-bottom: 1rem; }
                    </style>
                </head>
                <body onload="window.print(); window.close();">
                    ${printContent}
                </body>
            </html>
        `);
        win.document.close();
    }
</script>

<script type="text/javascript">
    function validateTransactionType(sender, args) {
        var isChecked =
            document.getElementById('<%= rdoMiniStatement.ClientID %>').checked ||
            document.getElementById('<%= rdoBalanceEnquiry.ClientID %>').checked ||
            document.getElementById('<%= rdoCashWithdrawal.ClientID %>').checked ||
            document.getElementById('<%= rdoCashDeposit.ClientID %>').checked;

        args.IsValid = isChecked;
    }
</script>

<script type="text/javascript">
    var finalUrl = "";
    var MethodCapture = "";

    function getLocation() {
        if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(showPosition);
        } else {
            alert("Geolocation is not supported by this browser.");
        }
    }

    function showPosition(position) {
        $("#hdnlatitude").val(position.coords.latitude);
        $("#hdnlongitude").val(position.coords.longitude);
    }

    function DeviceInfo() {
        var url = "http://127.0.0.1:11100/getDeviceInfo";
        var xhr = new XMLHttpRequest();
        xhr.open('DEVICEINFO', url, true);
        xhr.onreadystatechange = function () {
            if (xhr.readyState == 4 && xhr.status != 200) {
                $("#deviceerr_msg").text("Device or RD Service not active");
                $(".pop_up1").hide();
                $(".pop_up").show();
            }
        };
        xhr.send();
    }

    function RDService() {
        var url = "http://127.0.0.1:11100";
        var xhr = new XMLHttpRequest();
        xhr.open('RDSERVICE', url, true);
        xhr.send();
    }

    function discoverAvdm() {
        var SuccessFlag = 0;
        var primaryUrl = window.location.href.includes("https") ? "https://127.0.0.1:" : "http://127.0.0.1:";

        for (var i = 11100; i <= 11120; i++) {
            $.ajax({
                type: "RDSERVICE",
                async: false,
                url: primaryUrl + i.toString(),
                contentType: "text/xml; charset=utf-8",
                success: function (data) {
                    var $doc = $.parseXML(data);
                    var CmbData2 = $($doc).find('RDService').attr('info');
                    if (CmbData2.includes("Mantra")) {
                        finalUrl = primaryUrl + i.toString();
                        $($doc).find('Interface').each(function () {
                            if ($(this).attr('path') == "/rd/capture") MethodCapture = $(this).attr('path');
                        });
                        SuccessFlag = 1;
                        return;
                    }
                }
            });
            if (SuccessFlag == 1) break;
        }

        if (SuccessFlag == 0) {
            alert("RD Service not found. Please ensure RD service is running.");
        }
    }

    function CaptureAvdm(type, aadharno, bankiinno, mobileno, spkey, amount) {
        discoverAvdm();
        try {
            var XML = '<PidOptions ver="1.0"> <Opts fCount="1" fType="2" iCount="0" pCount="0" format="0" pidVer="2.0" timeout="10000" posh="UNKNOWN" env="P" /> <CustOpts><Param name="mantrakey" value="undefined" /></CustOpts> </PidOptions>';

            $(".pop_up1").addClass("open");
            $("#fingerloader").show();
            $("#loader1").hide();

            $.ajax({
                type: "CAPTURE",
                async: false,
                crossDomain: true,
                url: finalUrl + MethodCapture,
                data: XML,
                contentType: "text/xml; charset=utf-8",
                processData: false,
                success: function (data) {
                    var $doc = $.parseXML(data);
                    var errCode = $($doc).find('Resp').attr('errCode');

                    if (["700", "720", "1001", "2100", "740", "214", "10", "28", "4001", "207", "6", "216", "571", "4003", "215", "52"].includes(errCode)) {
                        $(".pop_up1").show();
                        $("#fingerloader").show();
                        $("#loader1").hide();
                        return false;
                    } else {
                        $("#fingerloader").hide();
                        $("#loader1").show();
                        var fingerdata = new XMLSerializer().serializeToString($doc);
                        sendToBackend(type, aadharno, bankiinno, mobileno, spkey, amount, fingerdata);
                    }
                },
                error: function (xhr, status, err) {
                    alert("Error: " + err);
                }
            });
        } catch (err) {
            alert(err.message);
        }
    }

    function sendToBackend(type, aadharno, bankiinno, mobileno, spkey, amount, fingerdata) {
        var latitude = $("#hdnlatitude").val();
        var longitude = $("#hdnlongitude").val();
        var userid = $("#<%= hdnUserKey.ClientID %>").val();

        $.ajax({
            type: "POST",
            url: "AEPS.aspx/SaveFingerprintData", // Adjust this path as needed
            contentType: "application/json; charset=utf-8",
            data: JSON.stringify({
                type: type,
                aadharno: aadharno,
                bankiinno: bankiinno,
                mobileno: mobileno,
                spkey: spkey,
                amount: amount,
                fingerdata: fingerdata,
                latitude: latitude,
                longitude: longitude,
                userid: userid
            }),
            success: function (response) {
                alert("Fingerprint captured and stored successfully.");
                $('#myModal').modal('show');
            },
            error: function (xhr, status, error) {
                alert("Failed to store fingerprint data. Error: " + error);
            }
        });
    }

    $("#btnCapture").on("click", function () {
        $('#myModalConfirmation').modal('hide');
        RDService();
        DeviceInfo();

        var bankiinno = $("#<%= ddlbankname.ClientID%>").val();
        var aadharno = $("#txtAadhaarNumber").val();
        var mobileno = $("#txtMobileNumber").val();
        var amount = $("#txtAmount").val();
        var spkey = $("input[name='TransactionType']:checked").val();

        if (!bankiinno || bankiinno == "0") {
            $("#errorbank").text("Please Select Bank");
            return;
        }
        if (!aadharno || aadharno.length != 12) {
            $("#errorbank").text('');
            $("#errorAadhar").text("Please Enter Aadhar No");
            return;
        }
        if (!mobileno || mobileno.length != 10) {
            $("#errorAadhar").text('');
            $("#errormobile").text("Please Enter Mobile Number");
            return;
        }
        if (!spkey || spkey == "0") {
            $("#errormobile").text('');
            $("#errortxntype").text("Please Check Transaction type");
            return;
        }

        $("#errorbank, #errorAadhar, #errormobile, #errortxntype, #erroramount").text('');

        var txntype = $("#ddltxn").val();
        if ((spkey == 'WAP' || spkey == 'MZZ') && (!amount || amount == "0")) {
            $("#erroramount").text("Please Enter Transaction Amount");
        } else {
            switch (txntype.toLowerCase()) {
                case 'wap': CaptureAvdm('cashwithdrawal', aadharno, bankiinno, mobileno, txntype, amount); break;
                case 'mzz': CaptureAvdm('aadharpay', aadharno, bankiinno, mobileno, txntype, amount); break;
                case 'bap': CaptureAvdm('balanceenquiry', aadharno, bankiinno, mobileno, txntype, 0); break;
                case 'sap': CaptureAvdm('ministatement', aadharno, bankiinno, mobileno, txntype, 0); break;
            }
        }
    });
</script>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>


</asp:Content>

