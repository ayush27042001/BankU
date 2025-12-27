<%@ Page Title="" Language="C#" MasterPageFile="~/Neox.Master" AutoEventWireup="true" CodeBehind="AEPSNew.aspx.cs" Inherits="NeoXPayout.AEPSNew" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
<style>

.operator-card {
    transition: background-color 0.2s, border-color 0.2s;
}

.operator-card:hover {
    background-color: #f1f5ff; 
    border-color: #bcd0f7;     
    cursor: pointer;
}

.operator-card.active {
    background-color: #eaf3ff; 
    border-color: #6e9dfc;
}

.view-plans-btn {
    font-weight: 500;
    text-decoration: none;
}

.view-plans-btn:hover {
    text-decoration: underline;
}

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
        background-color:red;
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
#payoutTable {
    border: 1px solid #dee2e6;
    border-collapse: separate !important;
    border-spacing: 0;
}

#payoutTable td,
#payoutTable th {
    border: none !important;
}

#payoutTable tbody tr {
    border-bottom: 1px solid #e9ecef;
}

#payoutTable thead.table-light th {
    background-color: #f6f7fb !important;
    color: #000;
    font-weight: 600;
}

#payoutTable tbody tr:hover {
    background-color: #f9fafc;
    cursor: pointer;
}

.status-success { color: green; font-weight: bold; }
.status-failed { color: red; font-weight: bold; }
.details-row { display: none; }

.device-select {
    display: flex;
    gap: 12px;
    flex-wrap: wrap;
    margin-bottom: 12px;
}

.device-btn {
    background: #f1f1f1;
    border: 1px solid #ddd;
    padding: 9px 18px;
    border-radius: 8px;
    cursor: pointer;
    font-size: 14px;
    font-weight: 600;
    color: #333;
    transition: all 0.25s ease;
}

.device-btn:hover {
    background: #e6e6e6;
}

.device-btn.active {
    background: #0066cc;
    color: #fff;
    border-color: #0066cc;
    box-shadow: 0 4px 10px rgba(0, 102, 204, 0.25);
}

.btn1 {
    background: #6e007c;
    color: #fff;
    border: none;
    padding: 11px 26px;
    border-radius: 8px;
    font-size: 15px;
    font-weight: 700;
    cursor: pointer;
    transition: all 0.3s ease;
}

.btn1:hover {
    background: #5a0066;
}

.btn1:disabled {
    background: #bfbfbf;
    cursor: not-allowed;
    box-shadow: none;
}

@media (max-width: 576px) {
    .device-btn {
        width: 100%;
        text-align: center;
    }

    .device-select {
        gap: 8px;
    }
}
.offcanvas {
    box-shadow: -5px 0 20px rgba(0,0,0,0.15);
}

</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<hr /> 
<asp:Panel runat="server" ID="pnlMain">
    <button  type="button" class="btn btn-receipt btn-primary"> Test</button>
    <button  type="button" class="btn btnTxn btn-primary"> Testtxn</button>
    <button class="btn btn-primary" type="button" data-bs-toggle="offcanvas" data-bs-target="#aepsLoginSidebar">
    Open AEPS Login
</button>

<div class="container py-4">
     

      <!-- Tabs -->
    <div class="d-flex align-items-center overflow-hidden mb-3" style="gap:8px;">
        <div class="tab-scroll flex-grow-1">
            <ul class="nav nav-tabs mb-0" id="rechargeTabs" role="tablist">
                <li class="nav-item" role="presentation">
                    <button class="nav-link active" id="mobile-tab" data-bs-toggle="tab"
                            data-bs-target="#mobile" type="button" role="tab"
                            aria-controls="mobile" aria-selected="true" style="color:#6e007c;">
                        AEPS Transaction
                    </button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link" id="dth-tab" data-bs-toggle="tab"
                            data-bs-target="#dth" type="button" role="tab"
                            aria-controls="dth" aria-selected="false" style="color:#6e007c;">
                        AEPS Authentication
                    </button>
                </li>
            </ul>
        </div>
    </div>

    <!-- Tab content (renders in same place) -->
    <div class="tab-content">

        <!-- Mobile Recharge Tab -->
        <div class="tab-pane fade show active" id="mobile" role="tabpanel" aria-labelledby="mobile-tab">
            <div class="row mb-4 align-items-center summary-row">
                <div class="col-md-auto summary-item">
                    <small class="text-muted">TRANSACTION TODAY</small>
                    <h5 class="mb-0">0</h5>
                </div>
                <div class="col-md-auto summary-item">
                    <small class="text-muted">TOTAL VALUE</small>
                    <h5 class="mb-0">₹0</h5>
                </div>
                <div class="col-md-auto summary-item">
                    <small class="text-muted">AVG VALUE</small>
                    <h5 class="mb-0">₹0</h5>
                </div>
                <label runat="server" id="lblMessage" class="col text-end text-success"></label>
                <label runat="server" id="lblerror" class="col text-end text-danger"></label>
                <div class="col text-end">
                    <button type="button" class="btn btn-primary" 
                            data-bs-toggle="offcanvas" data-bs-target="#TransactionSidebar"
                            style="background-color:#6e007c">Scan</button>
                </div>
            </div>
        </div>

        <!-- DTH Recharge Tab -->
        <div class="tab-pane fade" id="dth" role="tabpanel" aria-labelledby="dth-tab">
            <div class="row mb-4 align-items-center summary-row">
                <div class="col-md-auto summary-item">
                    <small class="text-muted">TRANSACTION TODAY</small>
                    <h5 class="mb-0">0</h5>
                </div>
                <div class="col-md-auto summary-item">
                    <small class="text-muted">TOTAL VALUE</small>
                    <h5 class="mb-0">₹0</h5>
                </div>
                <div class="col text-end">
                    <button type="button" class="btn btn-primary"
                            data-bs-toggle="offcanvas" data-bs-target="#AuthenticationSidebar"
                            style="background-color:#6e007c">Scan</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Filter Row -->
        <div class="row mb-3">
            <div class="col-md-6 d-flex gap-2">
                <select id="dateFilter" class="form-select form-select-sm" style="max-width:150px;">
                    <option value="">All Dates</option>
                    <option value="today">Today</option>
                    <option value="yesterday">Yesterday</option>
                </select>
                <select id="statusFilter" class="form-select form-select-sm" style="max-width:150px;">
                    <option value="">All Status</option>
                    <option value="success">Success</option>
                    <option value="failed">Failed</option>
                </select>
            </div>

            <div class="col-md-6 d-flex justify-content-end gap-2">
                <!-- Select Filter Dropdown -->
                <select id="columnFilter" class="form-select form-select-sm" style="max-width:150px;">
                    <option value="">Select Filter</option>
                    <option value="orderid">Order ID</option>
                    <option value="beneficiary">Beneficiary</option>
                    <option value="amount">Amount</option>
                    <option value="status">Status</option>
                </select>

                <!-- Search Box -->
                <input id="searchBox" type="text" class="form-control form-control-sm" placeholder="Search" style="max-width:200px;" />

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
                        <th>Beneficiary</th>
                        <th>Bank Name</th>
                        <th>Date</th>
                        <th>Mode</th>
                        <th>Amount (₹)</th>
                        <%--<th>Action</th>--%>
                    </tr>
                </thead>
              <tbody>
                  <asp:Repeater runat="server" ID="gvRequests">
                      <ItemTemplate>
                    <tr>
                        <td class="toggle-btn" style="cursor:pointer;">+</td>
                        <td class="status-cell"><span class="status-success"><%# Eval("Status") %></span></td>
                        <td class="orderid"><%# Eval("OrderId") %></td>
                        <td>🏦</td>
                        <td class="beneficiary">A/C: <%# Eval("AccountNumber") %><br>IFSC: <%# Eval("IFSC") %></td>
                        <td><%# Eval("BankName") %></td>
                        <td class="date-cell"><%# Eval("CreatedAt") %></td>
                        <td><%# Eval("Mode") %></td>
                        <td class="amount"><%# Eval("Amount") %></td>                
                    </tr>
                    <tr class="details-row">
                        <td colspan="10"><%# Eval("BeneficiaryName") %></td>
                    </tr>
                          </ItemTemplate>
                  </asp:Repeater>
            
                </tbody>

            </table>
        </div>

    </div>

<!-- Offcanvas Sidebar -->
<div class="offcanvas offcanvas-end" tabindex="-1" id="TransactionSidebar" data-bs-backdrop="static" data-bs-keyboard="false">
        <asp:HiddenField ID="hfOperator" runat="server" />
    <div class="offcanvas-header" style="background-color:whitesmoke">
        <h5 class="offcanvas-title">AEPS Transaction</h5>
        <button type="button" class="btn-close" data-bs-dismiss="offcanvas"></button>
    </div>
    <div class="offcanvas-body">

        <!-- STEP 1: Select Operator -->
        <div id="step1">
            <h6>Select Operator</h6>
            <div class="row g-2">
                <div class="col-12">
                    <button type="button" class="operator-card w-100 p-3 border rounded" data-operator="Statement">
                      Mini Statement
                    </button>
                </div>
                <div class="col-12">
                    <button type="button" class="operator-card w-100 p-3 border rounded" data-operator="Balance">
                       Balance Enquiry
                    </button>
                </div>
                <div class="col-12">
                    <button type="button" class="operator-card w-100 p-3 border rounded" data-operator="Withdraw">
                        Cash Withdrawal
                    </button>
                </div>
                <div class="col-12">
                    <button type="button" class="operator-card w-100 p-3 border rounded" data-operator="AadharPay">
                        Aadhar Pay
                    </button>
                </div>
            </div>

        </div>

        <!-- STEP 2: Fill Details -->
        <div id="step2" class="d-none">
            <h6 id="selectedOperator"></h6>
           <asp:Label runat="server" Id="lblError1" CssClass=" text-danger"></asp:Label>
            <div class="mb-3">
                <asp:DropDownList ID="ddlCircle" runat="server" CssClass="form-control">
                      
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="rfvCircle" runat="server" ControlToValidate="ddlCircle"
                    InitialValue="" ErrorMessage="Please select a Bank" CssClass="text-danger" Display="Dynamic" ValidationGroup="BankPayoutGroup"/>
            </div>

            <div class="mb-3">
                <asp:TextBox ID="txtAadhar" runat="server" CssClass="form-control" placeholder="Aadhar Number" TextMode="Number"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvAmount" runat="server" ControlToValidate="txtAadhar"
                    ErrorMessage="Aadhar is required" CssClass="text-danger" Display="Dynamic" ValidationGroup="BankPayoutGroup"/>
            </div>
              <div class="mb-3">
                <asp:TextBox ID="txtamount" runat="server" CssClass="form-control" placeholder="Amount" TextMode="Number"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtamount"
                    ErrorMessage="Amount is required" CssClass="text-danger" Display="Dynamic" ValidationGroup="BankPayoutGroup"/>
            </div>

             <div class="mb-3">
                <asp:TextBox ID="txtMobile" runat="server" CssClass="form-control" placeholder="Mobile Number"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvMobile" runat="server" ControlToValidate="txtMobile"
                    ErrorMessage="Mobile number is required" CssClass="text-danger" Display="Dynamic" ValidationGroup="BankPayoutGroup"/>
            </div>
          
            <div class="d-flex justify-content-between mt-2">
                <button type="button" class="btn btn-outline-secondary" id="backStep">⬅ Back</button>
                <asp:LinkButton runat="server" CssClass="btn btn-primary" Style="background-color:#6e007c"
                    ID="btnTransaction"  ValidationGroup="BankPayoutGroup"   OnClientClick="return validateAndOpenPlansSidebarTransaction();">
                    Scan
                </asp:LinkButton>
            </div>
        </div>

    </div>
</div>
  
<asp:HiddenField ID="hfLastSidebar" runat="server" />
<asp:HiddenField ID="hfTxnType" runat="server" />

<div class="offcanvas offcanvas-end" tabindex="-1" id="AuthenticationSidebar"  data-bs-backdrop="static" data-bs-keyboard="false">
        <asp:HiddenField ID="HiddenField2" runat="server" />
        <div class="offcanvas-header" style="background-color:whitesmoke">
            <h5 class="offcanvas-title">AEPS Authentication</h5>
            <button type="button" class="btn-close" data-bs-dismiss="offcanvas"></button>
        </div>
        <div class="offcanvas-body">

            <div class="mb-3">
                <asp:TextBox ID="TextBox1" runat="server" CssClass="form-control" placeholder="Aadhar Number"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TextBox1"
                    ErrorMessage="Aadhar number is required" CssClass="text-danger" Display="Dynamic" ValidationGroup="BankPayoutGroup1"/>
            </div>

            <div class="d-flex justify-content-between mt-2">
               
                <asp:LinkButton runat="server" CssClass="btn btn-primary" Style="background-color:#6e007c"
                    ID="LinkButton1"  ValidationGroup="BankPayoutGroup1"  OnClientClick="return validateAndOpenPlansSidebar();">
                    Scan
                </asp:LinkButton>
            </div>

       </div> 
   </div>

<div class="offcanvas offcanvas-end" tabindex="-1" id="plansSidebar" data-bs-backdrop="static" data-bs-keyboard="false">
      <div class="offcanvas-header" style="background-color:whitesmoke">
          <h5 class="offcanvas-title">Select Biometric Device</h5>
          <button type="button" class="btn-close" data-bs-dismiss="offcanvas"></button>
      </div>

      <div class="offcanvas-body">

          <!-- Device Options -->
          <div class="mb-3">
            <div class="device-select">
                <button type="button" class="device-btn"
                        onclick="selectDeviceBtn('Mantra', this)">
                    Mantra L1
                </button>

                <button type="button" class="device-btn"
                        onclick="selectDeviceBtn('Morpho', this)">
                    Morpho L1
                </button>

                <button type="button" class="device-btn"
                        onclick="selectDeviceBtn('Startek', this)">
                    Startek L1
                </button>

                <asp:HiddenField ID="hdnPidData"
                    ValidateRequestMode="Disabled"
                    runat="server" />

                <asp:LinkButton
                    ID="lnkSaveFingerprint"
                    runat="server"
                    OnClick="lnkSaveFingerprint_Click"
                    Style="display:none;">
                </asp:LinkButton>
            </div>
        </div>

     
          <!-- Scan Button -->
          <div class="d-flex justify-content-end mt-3">
            <button type="button" CssClass="btn1 btn-primary" Style="background-color:#6e007c; color:white; border-radius:5px; border-color:none" onclick="return captureFingerprint();">
                Scan
            </button>
          </div>

      </div>
    </div>
</asp:Panel>

    <!--hidden Fields-->
<asp:HiddenField ID="hdLatitude" runat="server" />
<asp:HiddenField ID="hdLongitude" runat="server" />
<asp:HiddenField ID="hdnUserId" runat="server" />
    <!--END-->

<asp:Panel ID="pnlError" runat="server" Visible="false" CssClass="text-center mt-5">
<div class="d-flex justify-content-center mt-5">
  <div class="alert alert-danger rounded-4 shadow-lg p-4" role="alert" style="max-width:700px">
    <h2 class="fw-bold text-danger mb-3">
      <i class="fa fa-exclamation-triangle"></i> Service Unavailable
    </h2>
    <p class="fs-5">
      The AEPS Service is currently down for maintenance or technical issues.  
      Please try again later.
    </p>
    <a href="Dashboard.aspx" class="btn btn-secondary mt-3">Back to Dashboard</a>
  </div>
</div>
</asp:Panel>


<!-- Success Modal -->
<div class="modal fade" id="successModal" tabindex="-1"  data-bs-backdrop="static"
     data-bs-keyboard="false">
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

<!-- Failed Modal --> 
<div class="modal fade" id="failedModal" tabindex="-1"  data-bs-backdrop="static"
     data-bs-keyboard="false">
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

<!-- Mini statement Invoice Model -->

<div class="modal fade" id="InvoiceMiniState" tabindex="-1" aria-labelledby="InvoiceModel" aria-hidden="true" data-bs-backdrop="static" data-bs-keyboard="false">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content mt-2 mb-2 p-4" id="printArea">

            <!-- Modal Header -->
            <div class="modal-header border-bottom-0">
                <button type="button" class="btn-close no-print" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>

            <!-- Top Logo and Title -->
            <div class="d-flex justify-content-between align-items-center mb-3">
                <div class="d-flex align-items-center">
                    <img src="BankULogo1.png" alt="Company Logo" style="height:30px; margin-right: 10px;" />
                </div>
                <asp:Label ID="editModalLabel" runat="server" CssClass="modal-title fw-bold fs-4 text-uppercase text-dark">Mini Statement Invoice</asp:Label>
            </div>

            <!-- Modal Body -->
            <div class="modal-body">

                <!-- Bill To & Transaction Info -->
                <div class="d-flex justify-content-between mb-4 border-bottom pb-3">
                    <div>
                        <h6 class="fw-bold mb-1">Mini Statement Invoice</h6>
                         <div><strong>Current Balance:</strong>&nbsp ₹<asp:Label ID="Label1" runat="server"></asp:Label></div>
                   
                    </div>
                    <div class="text-end">
                        <div><strong>Transaction ID:</strong> <asp:Label ID="lblTranID" runat="server"></asp:Label></div>
                        <div><strong>Date:</strong> <span id="lblTranDate"></span></div>
                    </div>
                </div>

                <!-- Summary Table -->
                <div class="table-responsive mb-4">
                    <table class="table table-bordered w-100">
                        <thead class="table-light">
                            <tr>
                                <th>Type</th>
                                <th>Time</th>
                                <th>Amount(₹)</th>
                                 <th>Details</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>D</td>
                                <td>25/12</td>
                               <td>₹ 0.00</td>
                                <td>FIGD/test</td>
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
                    <asp:Label ID="Label3" runat="server" CssClass="fw-bold fs-6 text-success"></asp:Label>
                </div>
            </div>

            <!-- Modal Footer -->
            <div class="modal-footer no-print">
                <asp:LinkButton ID="LinkButton2" runat="server" CssClass="btn btn-success" OnClientClick="printReceipt(); return false;">Print</asp:LinkButton>
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
            </div>

        </div>
    </div>
</div>

<!-- Transaction Invoice for balance enquiry and txn and aadhar pay Model -->
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
                    <img src="BankULogo1.png" alt="Company Logo" style="height:30px; margin-right: 10px;" />
                </div>
                <asp:Label ID="Label2" runat="server" CssClass="modal-title fw-bold fs-4 text-uppercase text-dark">Transaction Invoice</asp:Label>
            </div>

            <!-- Modal Body -->
            <div class="modal-body">

                <!-- Bill To & Transaction Info -->
                <div class="d-flex justify-content-between mb-4 border-bottom pb-3">
                    <div>
                        <h6 class="fw-bold mb-1">Transaction Invoice</h6>
                         <div><strong>Current Balance:</strong>&nbsp ₹<asp:Label ID="Label4" runat="server"></asp:Label></div>
                       <%-- <div><asp:Label ID="lblNumber" runat="server" CssClass="text-dark fw-semibold"></asp:Label></div>
                        <div><asp:Label ID="lblOpe" runat="server" CssClass="text-muted"></asp:Label></div>--%>
                    </div>
                    <div class="text-end">
                        <div><strong>Transaction ID:</strong> <asp:Label ID="Label5" runat="server"></asp:Label></div>
                        <div><strong>Date:</strong> <span id="lblTxnDate"></span></div>
                    </div>
                </div>

                <!-- Summary Table -->
                <div class="table-responsive mb-4">
                    <table class="table table-bordered w-100">
                       
                        <tbody>
                            <tr>
                                <td>Transaction Type</td>
                                <td>Balance Enquiry </td>                           
                            </tr>
                            <tr>
                                <td>Aadhar</td>
                                <td>223423424</td>                           
                            </tr>
                            <tr>
                                <td>Bank Name</td>
                                <td>25/12</td>                           
                            </tr>
                            <tr>
                                <td>Available Balance</td>
                                <td>₹0.0</td>                           
                            </tr>
                            <tr>
                                <td>RRN</td>
                                <td>1111111</td>                           
                            </tr>
                            <tr>
                                <td>Transaction Time</td>
                                <td>1111111</td>                           
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

<!-- AEPS Login Sidebar -->
<div class="offcanvas offcanvas-end" tabindex="-1" id="aepsLoginSidebar"
     data-bs-backdrop="static" data-bs-keyboard="false">

    <div class="offcanvas-header text-white"
         style="background-color:purple;">
        <div>
            <h5 class="mb-0 fw-bold">BankU</h5>
            <small>AEPS Daily Login</small>
        </div>

         <div class="ms-auto">
        <button type="button"
                class="btn btn-light btn-sm fw-semibold"
                data-bs-toggle="offcanvas"
                data-bs-target="#aepsRegisterModal">
            Register
        </button>
    </div>
    </div>

    <div class="offcanvas-body p-4">

     <div class="mb-3">
            <label class="form-label fw-semibold">Agent Ref No</label>
            <input type="text" id="agentRef" class="form-control">
            <small class="text-danger d-none" id="errAgent">Agent Ref is required</small>
        </div>

        <div class="mb-3">
            <label class="form-label fw-semibold">Aadhar Number</label>
            <input type="text" id="aadhaar" class="form-control" maxlength="12">
            <small class="text-danger d-none" id="errAadhaar">Enter valid 12-digit Aadhaar</small>
        </div>

        <div class="mb-3">
            <label class="form-label fw-semibold">Mobile Number</label>
            <input type="text" id="mobileNo" class="form-control" maxlength="10">
            <small class="text-danger d-none" id="errMobile">Enter valid 10-digit mobile number</small>
        </div>

        <div class="d-flex justify-content-between mt-4">
            <button class="btn text-white px-4" type="button" style="background:purple;" onclick="validateAEPS()">
                ✔ Proceed
            </button>

          <button class="btn btn-outline-secondary px-4"
        type="button"
        data-bs-dismiss="offcanvas">
    Cancel
</button>

        </div>

    </div>
</div>


<!-- AEPS Registration Modal -->
<div class="offcanvas offcanvas-end" tabindex="-1" id="aepsRegisterModal"
     data-bs-backdrop="static" data-bs-keyboard="false">

    <div class="offcanvas-header text-white" style="background:purple;">
        <div>
            <h5 class="mb-0 fw-bold">BankU</h5>
            <small>AEPS Registration</small>
        </div>

        <div class="ms-auto">
            <button type="button"
                    class="btn btn-light btn-sm fw-semibold"
                    data-bs-toggle="offcanvas"
                    data-bs-target="#aepsLoginSidebar">
                Login
            </button>
        </div>
    </div>

    <div class="offcanvas-body p-4">

        <div class="mb-3">
            <label class="form-label fw-semibold">External Ref No</label>
            <input type="text" id="extRef" class="form-control">
            <small class="text-danger d-none" id="errExtRef">Required field</small>
        </div>

        <div class="mb-3">
            <label class="form-label fw-semibold">PAN Number</label>
            <input type="text" id="pan" class="form-control">
            <small class="text-danger d-none" id="errPan">Invalid PAN format</small>
        </div>

        <div class="mb-3">
            <label class="form-label fw-semibold">Mobile Number</label>
            <input type="text" id="regMobile" class="form-control">
            <small class="text-danger d-none" id="errMobileNo">Invalid mobile number</small>
        </div>

        <div class="mb-3">
            <label class="form-label fw-semibold">Email ID</label>
            <input type="email" id="email" class="form-control">
            <small class="text-danger d-none" id="errEmail">Invalid email address</small>
        </div>

        <div class="mb-3">
            <label class="form-label fw-semibold">Address</label>
            <input type="text" id="address" class="form-control">
            <small class="text-danger d-none" id="errAddress">Required field</small>
        </div>

        <div class="mb-3">
            <label class="form-label fw-semibold">City</label>
            <input type="text" id="city" class="form-control">
            <small class="text-danger d-none" id="errCity">Required field</small>
        </div>

        <div class="mb-3">
            <label class="form-label fw-semibold">State</label>
            <select id="state" class="form-select">
                <option value="">Select State</option>
                <option>Delhi</option>
                <option>Maharashtra</option>
                <option>UP</option>
            </select>
            <small class="text-danger d-none" id="errState">Select a state</small>
        </div>

        <div class="mb-3">
            <label class="form-label fw-semibold">Pincode</label>
            <input type="text" id="pincode" class="form-control">
            <small class="text-danger d-none" id="errPincode">Invalid pincode</small>
        </div>

        <div class="d-flex justify-content-between mt-4">
            <button class="btn text-white px-4"
                    style="background:purple;"
                    type="button"
                    onclick="validateRegister()">
                ✔ Create Agent
            </button>

            <button class="btn btn-outline-secondary px-4"
                    data-bs-dismiss="offcanvas"
                    type="button">
                Cancel
            </button>
        </div>

    </div>
</div>




<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script>
    function showSuccess(msg) {
        document.getElementById("successMessage").innerText = msg;
        new bootstrap.Modal(document.getElementById("successModal")).show();
    }

    function showFailed(msg) {
        document.getElementById("failedMessage").innerText = msg;
        new bootstrap.Modal(document.getElementById("failedModal")).show();
    }
</script>

<script src="CustomJS/AEPSBalanceEnquiry.js"></script>

<script>
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
            await new Promise(r => setTimeout(r, 2000)); 
            return await captureRdData(deviceType, true); 
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

       /* setPidAndSubmit(pidXml);*/
   
       callAepsTxn(pidXml);
       /*testAepsTxn(pidXml);*/

        alert("Fingerprint captured successfully!");
    } catch (err) {
        alert("Capture failed: " + err.message);
    }
    return false;
}
</script>

<script>
    function validateAEPS() {
        let isValid = true;

        const agent = document.getElementById("agentRef");
        const aadhaar = document.getElementById("aadhaar");
        const mobile = document.getElementById("mobileNo");

        const errAgent = document.getElementById("errAgent");
        const errAadhaar = document.getElementById("errAadhaar");
        const errMobile = document.getElementById("errMobile");

        const aadhaarRegex = /^[0-9]{12}$/;
        const mobileRegex = /^[6-9][0-9]{9}$/;

        errAgent.classList.add("d-none");
        errAadhaar.classList.add("d-none");
        errMobile.classList.add("d-none");

        if (agent.value.trim() === "") {
            errAgent.classList.remove("d-none");
            isValid = false;
        }

        if (!aadhaarRegex.test(aadhaar.value)) {
            errAadhaar.classList.remove("d-none");
            isValid = false;
        }

        if (!mobileRegex.test(mobile.value)) {
            errMobile.classList.remove("d-none");
            isValid = false;
        }

        if (!isValid) return;

        alert("Validation Successful! Proceeding...");

        //  call API / submit form
    }

    function validateRegister() {

        let isValid = true;

        const panRegex = /^[A-Z]{5}[0-9]{4}[A-Z]{1}$/;
        const mobileRegex = /^[6-9][0-9]{9}$/;
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        const pincodeRegex = /^[1-9][0-9]{5}$/;

        function showError(id, show) {
            document.getElementById(id).classList.toggle("d-none", !show);
            if (show) isValid = false;
        }

        showError("errExtRef", document.getElementById("extRef").value.trim() === "");
        showError("errPan", !panRegex.test(document.getElementById("pan").value));
        showError("errMobileNo", !mobileRegex.test(document.getElementById("regMobile").value));
        showError("errEmail", !emailRegex.test(document.getElementById("email").value));
        showError("errAddress", document.getElementById("address").value.trim() === "");
        showError("errCity", document.getElementById("city").value.trim() === "");
        showError("errState", document.getElementById("state").value === "");
        showError("errPincode", !pincodeRegex.test(document.getElementById("pincode").value));

        if (!isValid) return;

       
        alert("Registration Successful!");
        //API call
    }
</script>

<script>
    function callAepsTxn(pidXml) {

        var data = {
        pidXml: pidXml,
        mobile: $("#<%= txtMobile.ClientID %>").val(),
        amount: $("#<%= txtamount.ClientID %>").val(),
        bankIin: $("#<%= ddlCircle.ClientID %>").val(),
        aadhaar: $("#<%= txtAadhar.ClientID %>").val(),
        latitude: $("#<%= hdLatitude.ClientID %>").val(),
        longitude: $("#<%= hdLongitude.ClientID %>").val(),
        operatorType: $("#<%= hfOperator.ClientID %>").val()
    };

    $.ajax({
        type: "POST",
        url: "<%= ResolveUrl("AEPSNew.aspx/AepsTxnAjax") %>",
        data: JSON.stringify({ model: data }),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (res) {

            if (!res.d.success) {
                showFailed(res.d.message || "Server error");
                return;
            }

            var api = JSON.parse(res.d.response);

            // Safety checks
            if (!api || !api.Data) {
                showFailed("Invalid response from server");
                return;
            }

            var status = api.Status;                 // SUCCESS / FAILED
            var message = api.Message;               // Message text
            var dataObj = api.Data;                  // Inner Data object
            var orderStatus = dataObj.orderstatus;   // SUCCESS / FAILED
            var txnType = dataObj.txntype;

            // Build table HTML
            var tableHtml = `
        <table class="table table-bordered table-sm">
            <tr><th>Transaction Type</th><td>${txnType}</td></tr>
            <tr><th>Order Status</th><td>${orderStatus}</td></tr>
            <tr><th>Agent ID</th><td>${dataObj.agentid}</td></tr>
            <tr><th>Bank Ref No</th><td>${dataObj.bankrefno}</td></tr>
            <tr><th>Order Amount</th><td>${dataObj.orderamount || "-"}</td></tr>
            <tr><th>Account Amount</th><td>${dataObj.acamount || "-"}</td></tr>
            <tr><th>Old Balance</th><td>${dataObj.OldBalance}</td></tr>
            <tr><th>New Balance</th><td>${dataObj.NewBalance}</td></tr>
            <tr><th>Commission</th><td>${dataObj.Commission}</td></tr>
        </table>`;

         
            if (status === "SUCCESS" && orderStatus === "SUCCESS") {

                $("#successMessage").html(`<p class="fw-bold text-success">${message}</p>${tableHtml}`);

                new bootstrap.Modal(document.getElementById("successModal")).show();
            }
            else {
              
                $("#failedMessage").html(`<p class="fw-bold text-danger">${message}</p>${tableHtml}`);

                new bootstrap.Modal(document.getElementById("failedModal")).show();
            }
        },

        error: function () {
            showFailed("Server error occurred");
        }
    });
    }

</script>

<script>
    function getLocation() {
        if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(
                function (position) {
                    var Latitude = position.coords.latitude;
                    var Longitude = position.coords.longitude;

                    // Example: store in hidden fields
                    document.getElementById("hdLatitude").value = Latitude;
                    document.getElementById("hdLongitude").value = Longitude;

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
</script>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        let lastRechargeSidebar = null;

        document.querySelectorAll(".operator-card").forEach(btn => {
            btn.addEventListener("click", function () {
                let operator = this.dataset.operator;
                document.getElementById('<%= hfOperator.ClientID %>').value = operator;

                if (this.closest("#TransactionSidebar")) {
                    document.getElementById("step1").classList.add("d-none");
                    document.getElementById("step2").classList.remove("d-none");
                    document.getElementById("selectedOperator").innerText = "Operator: " + operator;
                    document.getElementById('<%= hfOperator.ClientID %>').value = operator;

                let mobileBox = document.getElementById("<%= txtMobile.ClientID %>");
                let amountBox = document.getElementById("<%= txtAadhar.ClientID %>");
                if (mobileBox) mobileBox.value = "";
                if (amountBox) {
                    amountBox.value = "";
                    amountBox.readOnly = false; 
                }
            }
        });
    });

   
        ["TransactionSidebar", "AuthenticationSidebar"].forEach(id => {
            let el = document.getElementById(id);
            if (el) {
                el.addEventListener("show.bs.offcanvas", function () {
                    lastRechargeSidebar = id;
                    document.getElementById("<%= hfLastSidebar.ClientID %>").value = id;

            if (id === "TransactionSidebar") {
                document.getElementById("<%= hfTxnType.ClientID %>").value = "Transaction";
               
            } 
            else if (id === "AuthenticationSidebar") {
                document.getElementById("<%= hfTxnType.ClientID %>").value = "Authentication";

             
                document.getElementById("<%= hfOperator.ClientID %>").value = "login";
            }
        });
            }
        });


    // --- Plan Selection ---
    document.addEventListener("click", function (e) {
        const btn = e.target.closest(".plan-btn");
        if (!btn) return;

        const amount = btn.getAttribute("data-amount") || "";
        let returnSidebar = lastRechargeSidebar || document.getElementById("<%= hfLastSidebar.ClientID %>").value;

        if (returnSidebar === "TransactionSidebar") {
            let amountBox = document.getElementById("<%= txtAadhar.ClientID %>");
            if (amountBox) {
                amountBox.value = amount;
                amountBox.readOnly = true;
            }
            document.getElementById("step1").classList.add("d-none");
            document.getElementById("step2").classList.remove("d-none");

            let op = document.getElementById('<%= hfOperator.ClientID %>').value;
            if (op) document.getElementById("selectedOperator").innerText = "Operator: " + op;
        }

        // Close plans and reopen sidebar
        const plansEl = document.getElementById("plansSidebar");
        bootstrap.Offcanvas.getInstance(plansEl)?.hide();

        if (returnSidebar) {
            const targetEl = document.getElementById(returnSidebar);
            if (targetEl) {
                new bootstrap.Offcanvas(targetEl).show();
            }
        }
    });

    // --- Back Button in Plans Sidebar ---
    document.addEventListener("click", function (e) {
        if (e.target && e.target.id === "backToRecharge") {
            const plansEl = document.getElementById("plansSidebar");
            bootstrap.Offcanvas.getInstance(plansEl)?.hide();

            const returnSidebar = lastRechargeSidebar || document.getElementById("<%= hfLastSidebar.ClientID %>").value;
            if (returnSidebar) {
                const targetEl = document.getElementById(returnSidebar);
                if (targetEl) {
                    new bootstrap.Offcanvas(targetEl).show();

                    if (returnSidebar === "TransactionSidebars") {
                        document.getElementById("step1").classList.add("d-none");
                        document.getElementById("step2").classList.remove("d-none");

                        let op = document.getElementById('<%= hfOperator.ClientID %>').value;
                        if (op) document.getElementById("selectedOperator").innerText = "Operator: " + op;
                    }
                }
            }
        }
    });

    // --- Back Step Buttons ---
    document.getElementById("backStep").addEventListener("click", function () {
        document.getElementById("step2").classList.add("d-none");
        document.getElementById("step1").classList.remove("d-none");
    });
    });

   
</script>

<script>
    function validateAndOpenPlansSidebar() {
       
        if (typeof (Page_ClientValidate) == 'function') {
            if (!Page_ClientValidate('BankPayoutGroup1')) {
                return false; 
            }
        }

       
        var mySidebar = new bootstrap.Offcanvas(document.getElementById('plansSidebar'));
        mySidebar.show();

        return false; 
    }

    function validateAndOpenPlansSidebarTransaction() {
      
        if (typeof (Page_ClientValidate) == 'function') {
            if (!Page_ClientValidate('BankPayoutGroup')) {
                return false; 
            }
        }

        
        var mySidebar = new bootstrap.Offcanvas(document.getElementById('plansSidebar'));
        mySidebar.show();

        return false; 
    }

</script>

<script>
    // --- Expand/Collapse Table Rows ---
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

    // --- Filters ---
    function checkDate(dateString, type) {
        let rowDate = new Date(dateString);
        let today = new Date();
        today.setHours(0, 0, 0, 0);
        let yesterday = new Date(today);
        yesterday.setDate(today.getDate() - 1);
        rowDate.setHours(0, 0, 0, 0);

        if (type === "today") return rowDate.getTime() === today.getTime();
        if (type === "yesterday") return rowDate.getTime() === yesterday.getTime();
        return true;
    }

    function applyFilters() {
        let dateFilter = document.getElementById("dateFilter").value;
        let statusFilter = document.getElementById("statusFilter").value.toLowerCase();
        let colFilter = document.getElementById("columnFilter").value;
        let searchValue = document.getElementById("searchBox").value.toLowerCase();

        let rows = document.querySelectorAll("#payoutTable tbody tr:not(.details-row)");

        rows.forEach(row => {
            let statusCell = row.querySelector(".status-cell")?.innerText.toLowerCase() || "";
            let dateCell = row.querySelector(".date-cell")?.innerText || "";
            let searchCellText = colFilter ? (row.querySelector("." + colFilter)?.innerText.toLowerCase() || "") : row.innerText.toLowerCase();

            let matchesDate = dateFilter ? checkDate(dateCell, dateFilter) : true;
            let matchesStatus = statusFilter ? statusCell.includes(statusFilter) : true;
            let matchesSearch = searchValue ? searchCellText.includes(searchValue) : true;

            row.style.display = (matchesDate && matchesStatus && matchesSearch) ? "" : "none";
        });
    }

    document.getElementById("dateFilter").addEventListener("change", applyFilters);
    document.getElementById("statusFilter").addEventListener("change", applyFilters);
    document.getElementById("columnFilter").addEventListener("change", applyFilters);
    document.getElementById("searchBox").addEventListener("input", applyFilters);

    // --- Download CSV ---
    function downloadTable() {
        let table = document.getElementById("payoutTable");
        let rows = table.querySelectorAll("tr");
        let csv = [];

        rows.forEach(row => {
            if (row.classList.contains("details-row")) return;
            let cols = row.querySelectorAll("th, td");
            let rowData = [];
            cols.forEach(col => {
                let text = col.innerText.replace(/\n/g, " ").trim();
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
        a.download = "Recharge.csv";
        document.body.appendChild(a);
        a.click();
        document.body.removeChild(a);
    }
</script>

<script>
        $(document).ready(function () {
          
            document.getElementById("lblTranDate").innerText =
                new Date().toLocaleDateString("en-GB");

            $(document).on("click", ".btn-receipt", function () {
                
            // Show modal
                var receiptModal = new bootstrap.Modal(document.getElementById('InvoiceMiniState'));
            receiptModal.show();
        });
    });

        // ✅ Print function
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

<script>
        $(document).ready(function () {

            document.getElementById("lblTxnDate").innerText =
                new Date().toLocaleDateString("en-GB");

            $(document).on("click", ".btnTxn", function () {

                // Show modal
                var receiptModal = new bootstrap.Modal(document.getElementById('InvoiceTrnx'));
                receiptModal.show();
            });
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
