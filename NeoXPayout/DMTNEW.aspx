<%@ Page Title="" Language="C#" MasterPageFile="~/Neox.Master" AutoEventWireup="true" CodeBehind="DMTNEW.aspx.cs" Inherits="NeoXPayout.DMTNEW" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

    <link rel="stylesheet" href="CustomCSS/Dmt.css" />
    <style>
        .loader-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: 99999999;
            background-color: rgba(255, 255, 255, 0.6);
            display: none;
            align-items: center;
            justify-content: center;
        }

        .disablecss {
            pointer-events: none;
            opacity: 0.45;
            cursor: not-allowed;
            background-color: #e0e0e0 !important;
            color: #888 !important;
            border-color: #ccc !important;
        }

        .device-box.active {
            background: #e2c8ef;
            color: black;
            border-color: #81007f;
            box-shadow: 0 4px 10px rgba(0, 102, 204, 0.25);
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <asp:ScriptManager
        ID="ScriptManager1"
        runat="server"
        EnableCdn="true"
        EnableScriptGlobalization="false"
        EnableScriptLocalization="false">
    </asp:ScriptManager>

    <div class="loader-overlay">
        <div class="spinner-border text-purple" role="status">
            <span class="visually-hidden">Loading...</span>
        </div>
    </div>
    <asp:Panel runat="server" ID="pnlMain">
        <!-- NEW HEADER BAR -->
        <div class="transfer-header">
            <asp:HiddenField runat="server" ID="hdnUserId" />
            <asp:HiddenField ID="hdLatitude" runat="server" />
            <asp:HiddenField ID="hdLongitude" runat="server" />
            <div class="header-left">
                <div class="title-badge">
                    <i class="fa-solid fa-building-columns"></i>
                    <span id="transferTitle">BankU – Money Transfer</span>
                </div>
            </div>

            <div class="header-tabs">
                <asp:Label ID="lblMessage1" runat="server"></asp:Label>
                <asp:Repeater ID="rptTransferTabs" runat="server">
                    <ItemTemplate>
                        <button
                            type="button"
                            class='header-tab <%# Container.ItemIndex == 0 ? "active" : "" %>'
                            onclick="changeTransfer(this,'<%# Eval("FeatureName") %>')">
                            <%# Eval("FeatureName") %>
                        </button>
                    </ItemTemplate>
                </asp:Repeater>
            </div>

            <div class="header-right">
                <button class="history-btn" type="button">
                    <i class="fa-solid fa-clock-rotate-left"></i>
                    History
                </button>
            </div>
        </div>



        <!-- NEW MAIN PANEL -->
        <div class="transfer-panel">
            <div class="panel-accent"></div>

            <div class="panel-content">
                <h3 class="panel-title">Verify Sender
      <span>Enter mobile number to continue</span>
                </h3>

                <div class="input-row">
                    <div class="input-box">
                        <i class="fa-solid fa-mobile-screen-button"></i>
                        <input type="text" id="mobile" maxlength="10" placeholder="Mobile Number">
                    </div>

                    <div class="action-group">
                        <button class="action primary" type="button" onclick="openSenderSidebar()">
                            Verify
                        </button>
                        <button class="action ghost" type="button" onclick="clearInput()">
                            Cancel
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Right Sidebar Overlay -->
        <div class="sidebar-overlay" id="senderSidebar">

            <div class="sidebar-card">

                <div class="sidebar-header">
                    Add New Sender
      <span class="close-btn" onclick="closeSenderSidebar()">×</span>
                </div>

                <div class="sidebar-body">

                    <div class="input-group">
                        <label><i class="fa-solid fa-mobile-screen-button"></i>Mobile Number </label>
                        <input type="text" id="txtSenderMobileNumber" placeholder="Enter Mobile Number">
                    </div>

                    <div class="input-group">
                        <label><i class="fa-solid fa-id-card"></i>Aadhaar Number</label>
                        <input type="text" id="txtSenderAadharNumber" placeholder="Enter Aadhaar Number">
                    </div>
                    <div class="input-group" id="senderOTPInput" style="display: none">
                        <label><i class="fa-solid fa-id-card"></i>OTP</label>
                        <input type="text" id="txtSenderOTP" placeholder="Enter OTP">
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <button class="action ghost" type="button" onclick="cancelSenderCreation()" style="width: 100%">
                                Cancel
                            </button>
                        </div>
                        <div class="col-md-6">
                            <button class="action primary" id="btnSenderCreation" type="button" onclick="senderCreationImit()" style="width: 100%">
                                Create Sender
                            </button>
                            <button class="action primary" id="btnVerifySender" type="button" onclick="verifySender()" style="width: 100%; display: none">
                                Verify Sender
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>


        <%--  sender preview --%>
        <div id="senderPopup" class="popup-overlay">

            <div class="popup-card">

                <div class="popup-header">
                    Add-Sender Preview - BankU
      <span class="close-btn" onclick="closePopup()">✕</span>
                </div>

                <div class="popup-body">
                    <h6 class="section-title">Select Fingerprint Device</h6>

                    <div class="device-row">

                        <div class="device-box" onclick="selectDeviceBtn('Mantra', this)">
                            <img src="assets/images/mantra.png" class="device-img">
                            Mantra L1
                        </div>

                        <div class="device-box" onclick="selectDeviceBtn('Morpho', this)">
                            <img src="assets/images/morpho.png" class="device-img">
                            Morpho L1
                        </div>

                        <div class="device-box" onclick="selectDeviceBtn('Startek', this)">
                            <img src="assets/images/secugen.png" class="device-img">
                            Startek L1
                        </div>

                    </div>

                </div>

                <div class="footer-buttons">
                    <button onclick="closePopup()" type="button">Cancel</button>
                    <button type="button" onclick="ProceedEKYC()">✔ Scan & Proceed</button>
                </div>

            </div>
        </div>

        <%-- Avail user--%>
        <!-- Recent Beneficiary List -->
        <div class="offcanvas offcanvas-end" tabindex="-1" id="rightSidebar" data-bs-backdrop="static" data-bs-keyboard="false">
            <div class="offcanvas-header d-flex align-items-center justify-content-between"
                style="background-color: purple; color: white">

                <h5 class="mb-0">Recent Beneficiary</h5>

                <div class="d-flex align-items-center gap-2">
                    <!-- Add New Beneficiary Button (Small) -->
                    <button id="openBeneficiaryPopupBtn"
                        type="button"
                        class="btn btn-sm text-black"
                        style="background: White; border-radius: 6px;">
                        + Add
                    </button>

                    <!-- Close -->
                    <span onclick="closeSenderAvail()"
                        style="cursor: pointer; font-size: 20px; line-height: 1;">✖
                    </span>
                </div>
            </div>


            <div class="offcanvas-body">

                <div class="mb-3">




                    <div>
                        <label>Search Beneficiary</label>
                        <input type="text" id="txtSearchBene" placeholder="Search here…" style="width: 100%; padding: 10px; border-radius: 8px; border: 1px solid #ccc; margin-top: 5px; margin-bottom: 15px;">

                        <div class="recent-beneficiary-list" id="beneficiaryList">
                            <!-- Beneficiaries will be injected here -->
                        </div>

                    </div>

                </div>
            </div>
        </div>

        <%--  end--%>

        <div class="offcanvas offcanvas-end" tabindex="-1" id="rightBeneficiaryPopup" data-bs-backdrop="static" data-bs-keyboard="false">
            <div class="offcanvas-header" style="background-color: purple; color: white">
                <h5>Add New Beneficiary  </h5>
            </div>

            <div class="offcanvas-body">

                <div class="mb-3">

                    <select class="form-control field" onchange="FetchIfscCode()" id="ddlBank">
                        <option value="">Select</option>
                    </select>
                    <input type="text" id="txtbeneMobNo" placeholder="Beneficiary Mobile" style="margin-top: 4%" class="field">
                    <input type="text" id="txtbeneAccountNo" placeholder="Account Number" class="field">
                    <input type="text" id="txtbeneName" placeholder="Beneficiary Name" class="field">
                    <input type="text" id="txtbeneIfscCode" placeholder="IFSC Code" class="field">
                    <input type="text" id="txtbeneOTP" placeholder="OTP" class="field" style="display: none">
                    <div class="btn-row">
                        <button class="primary-btn" onclick="AddBeneficiary()" type="button">Add Account</button>
                        <button class="primary-btn" style="display: none" onclick="VerifyBeneficiary()" type="button">Verify Account</button>
                        <button id="closeBeneficiarySidebar" type="button" class="cancel-btn">Cancel</button>
                    </div>

                </div>
            </div>
        </div>
        <input type="hidden" id="hdnBeneficiaryId" />
        <div id="DeleteBenePreviewSidebar" class="preview-sidebar">

            <div class="sidebar-header">
                Delete Beneficiary Preview – BankU
            </div>

            <div class="sidebar-body">

                <table class="info-table">
                    <tr>
                        <th>Bank</th>
                        <th>Account Number</th>
                        <th>Beneficiary Name</th>
                        <th>IFSC Code</th>
                    </tr>

                    <tr>
                        <td class="tdBankName"></td>
                        <td class="tdAcountNo"></td>
                        <td class="tdBeneficiaryName"></td>
                        <td class="tdBeneIfscCode"></td>
                    </tr>
                </table>

                <div class="field-row">
                    <input class="input" placeholder="Enter OTP" id="txtBeneDelOTP">
                    <button class="otp-btn" type="button" id="btnRsendOTPForDeleteBene" onclick="ResendBeneficiaryOTP()">Resend OTP</button>
                </div>

                <div class="btn-row">
                    <button id="closeDeleteBeneSidebar" type="button" class="cancel-btn">Cancel</button>
                    <button class="confirm-btn deletebene-btn" onclick="verifyDeleteBeneficiary()" type="button">Confirm & Proceed</button>
                </div>

            </div>
        </div>

        <%--  money transfer page --%>
        <div id="moneyPreviewSidebar" class="preview-sidebar">

            <div class="sidebar-header">
                Money-Transfer Preview – BankU
            </div>

            <div class="sidebar-body">

                <table class="info-table">
                    <tr>
                        <th>Bank</th>
                        <th>Account Number</th>
                        <th>Beneficiary Name</th>
                        <th>IFSC Code</th>
                    </tr>

                    <tr>
                        <td class="tdBankName"></td>
                        <td class="tdAcountNo"></td>
                        <td class="tdBeneficiaryName"></td>
                        <td class="tdBeneIfscCode"></td>
                    </tr>
                </table>

                <div class="field-row">

                    <select id="ddlTxnType" class="form-control">
                        <option value="IMPS">IMPS</option>
                        <option value="NEFT">NEFT</option>
                    </select>
                    <input class="input" id="TxnAmount" placeholder="Amount">
                    <div class="row">
                        <div class="col-md-6">
                            <input class="input" id="TxnOTP" placeholder="Enter OTP">
                        </div>
                        <div class="col-md-6">
                            <button class="otp-btn" type="button" style="width:100%" onclick="SendTxnOTP()">Send OTP</button>
                        </div>
                    </div>
                </div>

                <div class="btn-row">
                    <button id="closeMoneySidebar" type="button" class="cancel-btn">Cancel</button>
                    <button class="confirm-btn" type="button" onclick="ProceedTransaction()">Confirm & Proceed</button>
                </div>

            </div>
        </div>

        <%-- end here --%>

        <div class="modal fade" id="InvoiceTrnx" tabindex="-1" aria-labelledby="InvoiceTrnxModel" aria-hidden="true" data-bs-backdrop="static" data-bs-keyboard="false">
            <div class="modal-dialog modal-lg modal-dialog-centered">
                <div class="modal-content mt-2 mb-2 p-4" id="printAreaTxn">

                    <!-- Modal Header -->
                    <div class="modal-header border-bottom-0">
                        <button type="button" class="btn-close no-print" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>

                    <!-- Top Logo and Title -->
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <div class="d-flex align-items-center">
                            <img src="BankULogo1.png" alt="Company Logo" style="height: 30px; margin-right: 10px;" />
                        </div>
                        <asp:Label ID="Label2" runat="server" CssClass="modal-title fw-bold fs-4 text-uppercase text-dark">Transaction Invoice</asp:Label>
                    </div>

                    <!-- Modal Body -->
                    <div class="modal-body">

                        <!-- Bill To & Transaction Info -->
                        <div class="d-flex justify-content-between mb-4 border-bottom pb-3">
                            <div>
                                <h6 class="fw-bold mb-1 balanceTxnType"></h6>

                            </div>
                            <div class="text-end">
                                <div>
                                    <strong>Transaction ID:</strong>
                                    <asp:Label ID="Label5" CssClass="balancerrn" runat="server"></asp:Label>
                                </div>
                                <div><strong>Date:</strong> <span id="lblTxnDate" class="lblTxnDate"></span></div>
                            </div>
                        </div>

                        <!-- Summary Table -->
                        <div class="table-responsive mb-4">
                            <table class="table table-bordered w-100">

                                <tbody>
                                    <tr>
                                        <td>Transaction Type</td>
                                        <td class="balanceTxnType"></td>
                                    </tr>
                                    <tr>
                                        <td>Bank Name</td>
                                        <td class="balanceBankName"></td>
                                    </tr>
                                    <tr>
                                        <td>Ifsc Code</td>
                                        <td class="txnifsccode"></td>
                                    </tr>
                                    <tr>
                                        <td>Account No</td>
                                        <td class="txnAccountNo"></td>
                                    </tr>
                                    <tr>
                                        <td>Beneficiary Name</td>
                                        <td class="txnBeneName"></td>
                                    </tr>
                                    <tr>
                                        <td>Txn Amount</td>
                                        <td class="txnAmount"></td>
                                    </tr>
                                    
                                    <tr>
                                        <td>RRN</td>
                                        <td class="balancerrn"></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>



                        <!-- Signature -->
                        <div class="mt-5 d-flex justify-content-end">
                            <div class="text-end">
                                <div class="border-top pt-2">Authorized Sign</div>
                            </div>
                        </div>

                        <!-- Final Note -->
                        <div class="text-center mt-4">
                            <asp:Label ID="Label6" runat="server" CssClass="fw-bold fs-6 text-success"></asp:Label>
                        </div>
                    </div>

                    <!-- Modal Footer -->
                    <div class="modal-footer no-print">
                        <asp:LinkButton ID="LinkButton3" runat="server" CssClass="btn btn-success" OnClientClick="printReceipt(); return false;">Print</asp:LinkButton>
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    </div>

                </div>
            </div>
        </div>
    </asp:Panel>

    <asp:Panel ID="pnlError" runat="server" Visible="false" CssClass="text-center mt-5">
        <div class="d-flex justify-content-center mt-5">
            <div class="alert alert-danger rounded-4 shadow-lg p-4" role="alert" style="max-width: 700px">
                <h2 class="fw-bold text-danger mb-3">
                    <i class="fa fa-exclamation-triangle"></i>Service Unavailable
                </h2>
                <p class="fs-5">
                    The DMT Service is currently down for maintenance or technical issues.  
      Please try again later.
                </p>
                <a href="Dashboard.aspx" class="btn btn-secondary mt-3">Back to Dashboard</a>
            </div>
        </div>
    </asp:Panel>
    <div class="modal fade" id="failedModal" tabindex="-1" data-bs-backdrop="static"
        data-bs-keyboard="false" style="z-index: 9999999 !important;">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header bg-danger text-white">
                    <h5 class="modal-title">Failed</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body" id="failedMessage">
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="successModal" tabindex="-1" data-bs-backdrop="static"
        data-bs-keyboard="false" style="z-index: 9999999 !important;">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header bg-success text-white">
                    <h5 class="modal-title">Success</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body" id="successMessage">
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        function showFailed(msg) {
            document.getElementById("failedMessage").innerText = msg;
            new bootstrap.Modal(document.getElementById("failedModal")).show();
        }
        function showSuccess(msg) {
            document.getElementById("successMessage").innerText = msg;
            new bootstrap.Modal(document.getElementById("successModal")).show();
        }
    </script>

    <script src="CustomJS/DMT.js"></script>
    <script src="CustomJS/INS-DMT/InstantPayDMT.js"></script>

    <script>
        $(document).ready(function () {
            callServiceStatus();
        });

        // ✅ Print function
        function printReceipt() {
            var printContent = document.getElementById('printAreaTxn').innerHTML;
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

    </script>

</asp:Content>
