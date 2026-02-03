<%@ Page Title="" Language="C#" MasterPageFile="~/Neox.Master" AutoEventWireup="true" CodeBehind="Payout.aspx.cs" Inherits="NeoXPayout.Payout" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        .nav-tabs .nav-link.active {
            border-color: transparent transparent #0d6efd;
            border-width: 0 0 3px;
            color: #0d6efd;
            font-weight: 500;
        }

        .status-success {
            background-color: #d1fae5;
            color: #065f46;
            padding: 3px 8px;
            border-radius: 4px;
            font-weight: 500;
            font-size: 0.85rem;
        }

        table td,
        table th {
            vertical-align: middle;
        }

        .tab-scroll {
            overflow-x: auto;
            -webkit-overflow-scrolling: touch;
            white-space: nowrap;
        }

            .tab-scroll::-webkit-scrollbar {
                display: none;
            }

            .tab-scroll .nav-tabs {
                flex-wrap: nowrap;
                border-bottom: 1px solid #dee2e6;
            }

            .tab-scroll .nav-item {
                flex: 0 0 auto;
            }

        .details-row {
            display: none;
            background-color: red;
        }

        .nav-tabs .nav-link.active {
            border-color: transparent transparent #0d6efd;
            border-width: 0 0 3px;
            color: #0d6efd;
            font-weight: 500;
        }

        .method-btn {
            border: 1px solid #ddd;
            background: #fff;
            padding: 6px 14px;
            border-radius: 8px;
            font-size: 14px;
            display: flex;
            align-items: center;
            gap: 6px;
            color: #333;
            transition: all 0.2s;
        }

            .method-btn:hover {
                background: #f8f9fa;
                border-color: #ccc;
            }

            .method-btn.active {
                background: #e6f0ff;
                border-color: #0d6efd;
                color: #0d6efd;
                font-weight: 500;
            }

        .summary-row > .summary-item {
            margin-right: 32px;
        }


        .mode-btn {
            border: 1px solid #ddd;
            background: #fff;
            padding: 4px 12px;
            border-radius: 8px;
            font-size: 13px;
            color: #333;
            transition: all 0.2s;
        }

            .mode-btn:hover {
                background: #f8f9fa;
                border-color: #ccc;
            }

            .mode-btn.active {
                background: #e6f0ff;
                border-color: #0d6efd;
                color: #0d6efd;
                font-weight: 500;
            }

        .form-control,
        .form-select {
            height: 48px !important;
            font-size: 15px;
            padding: 10px 14px;
        }


        @media (max-width: 768px) {

            .row.mb-4.align-items-center {
                flex-direction: column;
                align-items: flex-start !important;
                gap: 10px;
            }

                .row.mb-4.align-items-center .btn {
                    width: 100%;
                }

            .row.mb-3 {
                flex-direction: column;
                gap: 10px;
            }

                .row.mb-3 .col-md-6 {
                    width: 100%;
                }

                .row.mb-3 select,
                .row.mb-3 input {
                    width: 100% !important;
                    max-width: 100% !important;
                }

            .table-responsive {
                overflow-x: auto;
            }

            .btn-primary.w-100,
            .btn.btn-primary {
                position: fixed;
                bottom: 10px;
                left: 10px;
                right: 10px;
                z-index: 999;
                width: calc(100% - 20px) !important;
            }

            .nav-tabs {
                display: flex;
                overflow-x: auto;
                white-space: nowrap;
                border-bottom: none;
                scrollbar-width: none;
                -ms-overflow-style: none;
            }

                .nav-tabs::-webkit-scrollbar {
                    display: none;
                }

                .nav-tabs .nav-item {
                    flex: 0 0 auto;
                }

                .nav-tabs .nav-link {
                    border: none;
                    background: transparent;
                    padding: 8px 16px;
                    font-size: 14px;
                    color: #9ca3af;
                }

                    .nav-tabs .nav-link.active {
                        color: #0d6efd;
                        font-weight: 600;
                        border-bottom: 2px solid #0d6efd;
                        background: transparent;
                    }

            .stats-boxes {
                gap: 16px !important;
            }

                .stats-boxes > div {
                    min-width: 90px;
                }

            .summary-row {
                flex-direction: column;
                gap: 8px;
            }

            .summary-item {
                display: flex;
                justify-content: space-between;
                width: 100%;
                margin-right: 0;
                border-bottom: 1px solid #eee;
                padding-bottom: 4px;
            }

                .summary-item small {
                    font-size: 14px;
                }

                .summary-item h5 {
                    font-size: 15px;
                    margin: 0;
                }
        }
        /* Remove inner borders, keep outer border */
        #payoutTable {
            border: 1px solid #dee2e6;
            border-collapse: separate !important;
            border-spacing: 0;
        }

            #payoutTable td,
            #payoutTable th {
                border: none !important;
            }

            /* Add border only around rows (light grey) */
            #payoutTable tbody tr {
                border-bottom: 1px solid #e9ecef;
            }

            /* Header background color like screenshot */
            #payoutTable thead.table-light th {
                background-color: #f6f7fb !important;
                color: #000;
                font-weight: 600;
            }

            /* Optional: hover effect for rows */
            #payoutTable tbody tr:hover {
                background-color: #f9fafc;
                cursor: pointer;
            }

        .disablecss {
            pointer-events: none;
            opacity: 0.45;
            cursor: not-allowed;
            background-color: #e0e0e0 !important;
            color: #888 !important;
            border-color: #ccc !important;
        }
    </style>
    <style>
        .status-success {
            color: green;
            font-weight: bold;
        }

        .status-failed {
            color: red;
            font-weight: bold;
        }

        .details-row {
            display: none;
        }

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
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <hr />
    <div class="loader-overlay">
        <div class="spinner-border text-purple" role="status">
            <span class="visually-hidden">Loading...</span>
        </div>
    </div>
    <asp:Panel runat="server" ID="pnlMain">
        <div class="container py-4">
            <div class="d-flex align-items-center overflow-hidden mb-3" style="gap: 8px;">
                <div class="tab-scroll flex-grow-1">
                    <ul class="nav nav-tabs mb-0">
                        <li class="nav-item">
                            <a class="nav-link active" href="#" style="color: #6e007c;">Single Payouts</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="BulkPayoutActivation.aspx" style="color: #6e007c;">Bulk Payouts</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="SchedulePayout.aspx" style="color: #6e007c;">Scheduled Payouts</a>
                        </li>
                    </ul>
                </div>
            </div>
            <div class="row mb-4 align-items-center summary-row">
                <div class="col-md-auto summary-item">
                    <small class="text-muted">PAYOUTS TODAY</small>
                    <h5 class="mb-0">
                        <asp:Label ID="lblTxnToday" runat="server" Text="0" /></h5>
                </div>
                <div class="col-md-auto summary-item">
                    <small class="text-muted">TOTAL VALUE</small>
                    <h5 class="mb-0">
                        <asp:Label ID="lblTotalValue" runat="server" Text="₹0.00" /></h5>
                </div>
                <div class="col-md-auto summary-item">
                    <small class="text-muted">AVG VALUE</small>
                    <h5 class="mb-0">
                        <asp:Label ID="lblAvgValue" runat="server" Text="₹0.00" /></h5>
                </div>
                <label runat="server" id="lblMessage" class="col text-end text-success" text=""></label>
                <label runat="server" id="lblerror" class="col text-end text-danger" text=""></label>
                <div class="col text-end">
                    <button type="button" class="btn btn-primary" data-bs-toggle="offcanvas" data-bs-target="#singlePayoutSidebar" style="background-color: #6e007c">+ Single Payout</button>
                </div>
            </div>

            <!-- Filter Row -->
            <div class="row mb-3">
                <div class="col-md-6 d-flex gap-2">
                    <select id="dateFilter" class="form-select form-select-sm" style="max-width: 150px;">
                        <option value="">All Dates</option>
                        <option value="today">Today</option>
                        <option value="yesterday">Yesterday</option>
                    </select>
                    <select id="statusFilter" class="form-select form-select-sm" style="max-width: 150px;">
                        <option value="">All Status</option>
                        <option value="success">Success</option>
                        <option value="pending">Pending</option>
                        <option value="failed">Failed</option>
                    </select>
                </div>

                <div class="col-md-6 d-flex justify-content-end gap-2">
                    <!-- Select Filter Dropdown -->
                    <select id="columnFilter" class="form-select form-select-sm" style="max-width: 150px;">
                        <option value="">Select Filter</option>
                        <option value="orderid">Order ID</option>
                        <option value="beneficiary">Beneficiary</option>
                        <option value="amount">Amount</option>
                        <option value="status">Status</option>
                    </select>

                    <!-- Search Box -->
                    <input id="searchBox" type="text" class="form-control form-control-sm" placeholder="Search" style="max-width: 200px;" />

                    <!-- Download Button -->
                    <button class="btn btn-outline-secondary btn-sm" onclick="downloadTable()">Download</button>
                </div>
            </div>
            <asp:Label runat="server" ID="lblMessage1"></asp:Label>
            <!-- Table -->
            <div class="table-responsive">
                <table id="payoutTable" class="table table-bordered align-middle">
                    <thead class="table-light">
                        <tr>
                            <th>#</th>
                            <th>Status</th>
                            <th>Order ID</th>
                            <th>From</th>
                            <th>Beneficiary Name</th>
                            <th>Beneficiary Account</th>
                            <th>IFSC</th>
                            <th>Old Balance (₹)</th>
                            <th>Amount (₹)</th>
                            <th>Sur Charge (₹)</th>
                            <th>New Balance (₹)</th>
                            <th>Date</th>
                            <th>Transaction ID</th>
                            <th>RRN</th>
                        </tr>
                    </thead>
                    <tbody>
                        <asp:Repeater runat="server" ID="gvRequests">
                            <ItemTemplate>
                                <tr>
                                    <td class="toggle-btn" style="cursor: pointer;">+</td>
                                    <td class="status-cell"><span class="status-success"><%# Eval("Status") %></span></td>
                                    <td class="orderid"><%# Eval("TransID") %></td>
                                    <td>🏦</td>
                                    <td class="beneficiary"><%# Eval("BeneName") %></td>
                                    <td><%# Eval("AccountNo") %></td>
                                    <td> IFSC: <%# Eval("IfscCode") %></td>
                                    <td class="amount"><%# Eval("OldBal") %></td>
                                    <td class="amount"><%# Eval("Amount") %></td>
                                    <td class="amount"><%# Eval("Surcharge") %></td>
                                    <td class="amount"><%# Eval("NewBal") %></td>
                                    <td class="date-cell"><%# Eval("TxnDate") %></td>
                                    <td><%# Eval("TransactionId") %></td>
                                    <td><%# Eval("ApiMsg") %></td>
                                   

                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>

                    </tbody>

                </table>
            </div>

        </div>


        <div class="offcanvas offcanvas-end" tabindex="-1" id="singlePayoutSidebar" data-bs-backdrop="static" data-bs-keyboard="false">
            <div class="offcanvas-header">
                <h5 class="offcanvas-title">Single Payout</h5>
                <button type="button" class="btn-close" data-bs-dismiss="offcanvas"></button>
            </div>
            <div class="offcanvas-body">
                <!-- Select Debit Account -->
                <div class="mb-3">
                    <asp:TextBox ID="DebitAcc" runat="server" CssClass="form-control" Placeholder="Select Debit Account" ReadOnly="true"></asp:TextBox>

                    <div class="d-inline-flex align-items-center mt-2">
                        <button type="button" id="btnCheckBalance" class="btn btn-link small" style="color: #6e007c">
                            Check Balance
                        </button>
                        <span id="lblBalance" class="ms-2 text-success"></span>
                    </div>


                </div>
                <div class="mb-3 d-flex gap-2">
                    <button type="button" class="method-btn active" data-method="bank">
                        <i class="bi bi-bank"></i>Bank
                    </button>
                    <button type="button" class="method-btn" data-method="upi" style="display: none">
                        <i class="bi bi-upc-scan"></i>UPI
                    </button>
                </div>

                <!-- Bank Form -->
                <div class="method-content" id="bank">


                    <div class="mb-3">
                        <asp:TextBox ID="txtAccount" runat="server" CssClass="form-control" placeholder="Account Number"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvAccount" runat="server" ControlToValidate="txtAccount"
                            ErrorMessage="Account Number is required" CssClass="text-danger" Display="Dynamic" ValidationGroup="BankPayoutGroup" />
                    </div>



                    <div class="row mb-3">
                        <div class="col-md-9">
                            <asp:TextBox ID="txtIFSC" runat="server" CssClass="form-control" placeholder="IFSC Code"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvIFSC" runat="server" ControlToValidate="txtIFSC"
                                ErrorMessage="IFSC Code is required" CssClass="text-danger" Display="Dynamic" ValidationGroup="BankPayoutGroup" />
                        </div>
                        <div class="col-md-3">
                            <button type="button" style="background-color: #6e007c; padding: 10px" id="btnValidateBene" class="btn-sm btn btn-success">Validate</button>
                        </div>
                    </div>

                    <div class="mb-3">
                        <asp:TextBox ID="txtBene" runat="server" CssClass="form-control disablecss" placeholder="Beneficiary Name"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvBene" runat="server" ControlToValidate="txtBene"
                            ErrorMessage="Beneficiary Name is required" CssClass="text-danger" Display="Dynamic" ValidationGroup="BankPayoutGroup" />
                    </div>

                    <div class="mb-3">
                        <asp:TextBox ID="txtAmount" runat="server" CssClass="form-control" placeholder="Amount (₹)" TextMode="Number"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvAmount" runat="server" ControlToValidate="txtAmount"
                            ErrorMessage="Amount is required" CssClass="text-danger" Display="Dynamic" ValidationGroup="BankPayoutGroup" />
                    </div>

                    <div class="mb-2 d-flex gap-2">
                        <button type="button" class="mode-btn active" id="btnIMPS" data-mode="IMPS">IMPS</button>
                        <button type="button" class="mode-btn" id="btnNEFT" data-mode="NEFT">NEFT</button>
                        <asp:HiddenField ID="hfPaymentMode" runat="server" />
                        <%--<asp:RequiredFieldValidator 
                            ID="rfvPaymentMode" 
                            runat="server" 
                            ControlToValidate="hfPaymentMode" 
                            ErrorMessage="Please select a payment mode" 
                            Display="Dynamic" 
                            ForeColor="Red">
                        </asp:RequiredFieldValidator>--%>
                    </div>
                    <asp:HiddenField runat="server" ID="hdnUserId" />
                    <asp:HiddenField runat="server" ID="hdnUserName" />
                    <asp:HiddenField runat="server" ID="hdnUserMob" />
                    <div class="mb-3" style="margin-top: 10px">
                        <asp:TextBox ID="txtMobile" runat="server" CssClass="form-control" placeholder="Mobile Number"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvMobile" runat="server" ControlToValidate="txtMobile"
                            ErrorMessage="Mobile Number is required" CssClass="text-danger" Display="Dynamic" ValidationGroup="BankPayoutGroup" />
                    </div>
                    <asp:Button runat="server" disabled CssClass="btn btn-primary w-100" Style="background-color: #6e007c"
                        ID="BankPayout2" ValidationGroup="BankPayoutGroup" Text="Proceed" />
                </div>



                <!-- UPI Form -->
                <div class="method-content" id="upi" style="display: none;">
                    <label class="text-danger"></label>
                    <div class="mb-3">
                        <asp:TextBox ID="txtUPIID" runat="server" CssClass="form-control" placeholder="UPI ID (e.g. example@upi)"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvUPIID" runat="server"
                            ControlToValidate="txtUPIID" ErrorMessage="UPI ID is required"
                            CssClass="text-danger" Display="Dynamic" ValidationGroup="OtpPayoutGroup"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="revUPIID" runat="server"
                            ControlToValidate="txtUPIID"
                            ValidationExpression="^[\w.\-]{2,}@[a-zA-Z]{3,}$"
                            ErrorMessage="Invalid UPI ID format" CssClass="text-danger"
                            Display="Dynamic" EnableClientScript="true" ValidationGroup="OtpPayoutGroup"></asp:RegularExpressionValidator>
                    </div>

                    <div class="mb-3">
                        <asp:TextBox ID="txtUPIAmount" runat="server" CssClass="form-control" placeholder="Amount (₹)" TextMode="Number"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvUPIAmount" runat="server"
                            ControlToValidate="txtUPIAmount" ErrorMessage="Amount is required"
                            CssClass="text-danger" Display="Dynamic" ValidationGroup="OtpPayoutGroup"></asp:RequiredFieldValidator>
                        <asp:RangeValidator ID="rvUPIAmount" runat="server"
                            ControlToValidate="txtUPIAmount" MinimumValue="1" MaximumValue="1000000"
                            Type="Double" ErrorMessage="Enter a valid amount" CssClass="text-danger"
                            Display="Dynamic" ValidationGroup="OtpPayoutGroup"></asp:RangeValidator>
                    </div>

                    <div class="mb-3">
                        <asp:TextBox ID="txtUPIRemarks" runat="server" CssClass="form-control" placeholder="Remarks (optional)"></asp:TextBox>
                    </div>

                    <div class="mb-4">
                        <asp:TextBox ID="txtUPIBeneficiaryEmail" runat="server" CssClass="form-control" placeholder="Beneficiary Email (optional)" TextMode="Email"></asp:TextBox>
                        <asp:RegularExpressionValidator ID="revUPIBeneficiaryEmail" runat="server"
                            ControlToValidate="txtUPIBeneficiaryEmail"
                            ValidationExpression="^[^@\s]+@[^@\s]+\.[^@\s]+$"
                            ErrorMessage="Invalid email format" CssClass="text-danger"
                            Display="Dynamic" EnableClientScript="true" ValidationGroup="OtpPayoutGroup"></asp:RegularExpressionValidator>
                    </div>
                    <asp:LinkButton ID="btnProceedUPI" runat="server" Text="Proceed via UPI" ValidationGroup="OtpPayoutGroup" CssClass="btn btn-primary w-100" Style="background-color: #6e007c" OnClick="btnProceedUPI_Click"></asp:LinkButton>

                </div>
            </div>
        </div>

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
                                <div><strong>Date:</strong> <span class="lblTxnDate"></span></div>
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
                                        <td>Account No</td>
                                        <td class="txnAccountNo"></td>
                                    </tr>
                                    <tr>
                                        <td>Ifsc Code</td>
                                        <td class="txnifsccode"></td>
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
                    The Payout Service is currently down for maintenance or technical issues.  
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
    </script>
    <script src="CustomJS/Payout/Payout.js"></script>


    <script>
        document.getElementById("btnCheckBalance").addEventListener("click", function () {
            fetch("Payout.aspx/GetBalance", {
                method: "POST",
                headers: {
                    "Content-Type": "application/json; charset=utf-8"
                },
                body: JSON.stringify({})
            })
                .then(response => response.json())
                .then(data => {
                    document.getElementById("lblBalance").innerText = data.d;
                })
                .catch(err => console.error(err));
        });
    </script>


    <script>
        document.querySelectorAll(".toggle-btn").forEach(btn => {
            btn.addEventListener("click", function () {
                let detailsRow = this.parentElement.nextElementSibling;
                if (detailsRow.style.display === "table-row") {
                    detailsRow.style.display = "none";
                    this.textContent = "+";
                } else {
                    detailsRow.style.display = "table-row";
                    this.textContent = "-";
                }
            });
        });
    </script>

    <script>
        document.querySelectorAll(".method-btn").forEach(btn => {
            btn.addEventListener("click", function () {
                // Remove active class from all buttons
                document.querySelectorAll(".method-btn").forEach(b => b.classList.remove("active"));
                this.classList.add("active");

                // Hide all method contents
                document.querySelectorAll(".method-content").forEach(content => {
                    content.style.display = "none";
                });

                // Show selected content
                let methodId = this.getAttribute("data-method");
                document.getElementById(methodId).style.display = "block";
            });
        });
    </script>

    <script>


        document.addEventListener("DOMContentLoaded", function () {
            document.querySelectorAll(".mode-btn").forEach(btn => {
                btn.addEventListener("click", function () {
                    document.querySelectorAll(".mode-btn").forEach(b => b.classList.remove("active"));
                    this.classList.add("active");

                    // Store selected mode
                    document.getElementById('<%= hfPaymentMode.ClientID %>').value = this.dataset.mode;
                });
            });
        });

    </script>


    <!-- Clear data on close -->
    <script>
        document.getElementById('singlePayoutSidebar').addEventListener('hidden.bs.offcanvas', function () {
            
            // Remove readonly from all inputs inside the sidebar
            this.querySelectorAll('input:not([type="hidden"])').forEach(input => {
                input.removeAttribute("readonly");
                input.value = "";
            });


            // Reset dropdowns (Wallet select)
            this.querySelectorAll('select').forEach(select => {
                select.selectedIndex = 0;
            });

            // Remove stored dataset values
            this.querySelectorAll('.method-content').forEach(content => {
                delete content.dataset.orderId;
                delete content.dataset.date;
            });
            $("#ContentPlaceHolder1_BankPayout2").prop("disabled", true).val("Proceed");
            $("#ContentPlaceHolder1_DebitAcc").val($("#ContentPlaceHolder1_hdnUserMob").val());
        });

    </script>

    <script>
        // ✅ Safely check if date matches today/yesterday
        function checkDate(dateString, type) {
            let rowDate = new Date(dateString);
            if (isNaN(rowDate)) return false; // invalid date safeguard

            let today = new Date();
            today.setHours(0, 0, 0, 0);

            let yesterday = new Date(today);
            yesterday.setDate(today.getDate() - 1);

            rowDate.setHours(0, 0, 0, 0);

            if (type === "today") return rowDate.getTime() === today.getTime();
            if (type === "yesterday") return rowDate.getTime() === yesterday.getTime();
            return true; // no filter applied
        }

        // ✅ Main filter function
        function applyFilters() {
            let dateFilter = document.getElementById("dateFilter").value;
            let statusFilter = document.getElementById("statusFilter").value.toLowerCase();
            let colFilter = document.getElementById("columnFilter").value;
            let searchValue = document.getElementById("searchBox").value.toLowerCase();

            let rows = document.querySelectorAll("#payoutTable tbody tr:not(.details-row)");

            rows.forEach(row => {
                let statusCell = row.querySelector(".status-cell")?.innerText.toLowerCase().trim() || "";
                let dateCell = row.querySelector(".date-cell")?.innerText.trim() || "";

                // ✅ Choose column text for searching
                let searchCellText = "";
                if (colFilter === "orderid") searchCellText = row.querySelector(".orderid")?.innerText.toLowerCase() || "";
                else if (colFilter === "beneficiary") searchCellText = row.querySelector(".beneficiary")?.innerText.toLowerCase() || "";
                else if (colFilter === "amount") searchCellText = row.querySelector(".amount")?.innerText.toLowerCase() || "";
                else if (colFilter === "status") searchCellText = statusCell;
                else searchCellText = row.innerText.toLowerCase();

                let matchesDate = dateFilter ? checkDate(dateCell, dateFilter) : true;
                let matchesStatus = statusFilter ? (statusCell === statusFilter) : true; // ✅ exact match
                let matchesSearch = searchValue ? searchCellText.includes(searchValue) : true;

                let isMatch = matchesDate && matchesStatus && matchesSearch;

                // ✅ Show/hide main row
                row.style.display = isMatch ? "" : "none";

                // ✅ Show/hide details row accordingly
                let detailsRow = row.nextElementSibling;
                if (detailsRow && detailsRow.classList.contains("details-row")) {
                    detailsRow.style.display = isMatch ? "" : "none";
                }
            });
        }

        // ✅ Bind events
        ["dateFilter", "statusFilter", "columnFilter"].forEach(id => {
            document.getElementById(id).addEventListener("change", applyFilters);
        });
        document.getElementById("searchBox").addEventListener("input", applyFilters);

        // Download CSV
        function downloadTable() {
            let table = document.getElementById("payoutTable");
            if (!table) {
                alert("Table not found!");
                return;
            }

            let rows = table.querySelectorAll("tr");
            let csv = [];

            rows.forEach(row => {
                // Skip hidden detail rows if needed
                if (row.classList.contains("details-row")) return;

                let cols = row.querySelectorAll("th, td");
                let rowData = [];
                cols.forEach(col => {
                    let text = col.innerText.replace(/\n/g, " ").trim();
                    // Wrap in quotes if it contains commas
                    if (text.includes(",") || text.includes('"')) {
                        text = '"' + text.replace(/"/g, '""') + '"';
                    }
                    rowData.push(text);
                });
                csv.push(rowData.join(","));
            });

            let csvContent = "data:text/csv;charset=utf-8," + encodeURIComponent(csv.join("\n"));
            let a = document.createElement("a");
            a.href = csvContent;
            a.download = "payouts.csv";
            document.body.appendChild(a);
            a.click();
            document.body.removeChild(a);
        }

    </script>
</asp:Content>
