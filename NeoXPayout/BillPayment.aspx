<%@ Page Title="" Language="C#" MasterPageFile="~/Neox.Master" AutoEventWireup="true" EnableEventValidation="false" CodeBehind="BillPayment.aspx.cs" Inherits="NeoXPayout.BillPayment" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Segoe+UI&display=swap" rel="stylesheet">
<style>
.form-icon-group 
{
    position: relative;
}

.form-icon-group .form-control 
{
    padding-left: 2.2rem !important;
}

.form-icon
{
    position: absolute;
    top: 50%;
    left: 10px;
    transform: translateY(-50%);
    color: #6c757d;
    font-size: 1rem;
    pointer-events: none;
}

@media print {
    .no-print {
        display: none !important;
    }
}

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

.bill-card {
    border-radius: 16px;
    border: 1px solid #eee;
    transition: all 0.3s ease;
    cursor: pointer;
    background: #fff;
    box-shadow: 0 2px 6px rgba(0,0,0,0.05);
}

.bill-card img {
    height: 50px;
    filter: grayscale(20%);
    transition: transform 0.3s ease, filter 0.3s ease;
}

.bill-card h6 {
    margin-top: 10px;
    font-weight: 600;
    font-size: 15px;
    color: #333;
}

.bill-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 6px 14px rgba(0,0,0,0.1);
    border-color: #6e007c;
}

.bill-card:hover img {
    filter: grayscale(0%);
    transform: scale(1.1);
}

.bill-card:hover h6 {
    color: #6e007c;
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

/* Add border only around rows (light grey) */
#payoutTable tbody tr {
    border-bottom: 1px solid #e9ecef;
}
.disabled-card {
    opacity: 0.5;
    filter: grayscale(100%);
    pointer-events: none;
    cursor: not-allowed;
    background-color: #f5f5f5;
    position: relative;
}

/* Coming Soon badge */
.coming-soon-text {
    position: absolute;
    top: 8px;
    right: 8px;
    background: #6c757d;
    color: #fff;
    font-size: 10px;
    padding: 2px 6px;
    border-radius: 12px;
    font-weight: 600;
    letter-spacing: 0.4px;
}


.status-success { color: green; font-weight: bold; }
.status-failed { color: red; font-weight: bold; }
.details-row { display: none; }
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true" />
<hr /> 

<asp:Panel runat="server" ID="pnlMain">

<div class="container py-4">

  <!-- Header -->
  <div class="d-flex align-items-center justify-content-between mb-3">
      <h4 style="color:#6e007c;">Bill Payments</h4>
        <label runat="server" id="lblMessage" class="col text-end text-success"></label>
  </div>

  <!-- Bill Type Cards -->
  <div class="row g-3">

    <!-- Water Bill -->
    <div class="col-6 col-md-2">
        <div class="card bill-card p-3 text-center" data-billtype="WATERBILL" data-bs-toggle="offcanvas" data-bs-target="#billSidebar">
            <img src="assets/images/payment/maintenance.png" alt="Water Bill" 
             style="height:60px; width:60px;" 
             class="mx-auto d-block" />
            <h6  style="font-size: 12px;">Water Bill</h6>
        </div>
    </div>

    <!-- Electricity Bill -->
    <div class="col-6 col-md-2">
        <div class="card bill-card p-3 text-center" data-billtype="ELECTRICITY" data-bs-toggle="offcanvas" data-bs-target="#billSidebar">
            <img src="assets/images/payment/electricity1.png" alt="Electricity"  style="height:60px; width:60px;" 
             class="mx-auto d-block" />
            <h6  style="font-size: 12px;">Electricity</h6>
        </div>
    </div>

    <!-- Gas Bill -->
    <div class="col-6 col-md-2">
        <div class="card bill-card p-3 text-center" data-billtype="GAS" data-bs-toggle="offcanvas" data-bs-target="#billSidebar">
            <img src="assets/images/payment/Gas.png" alt="Gas Bill"  style="height:60px; width:60px;" 
             class="mx-auto d-block"/>
            <h6  style="font-size: 12px;">Gas Bill</h6>
        </div>
    </div>

    <!-- Fastag -->
    <div class="col-6 col-md-2">
        <div class="card bill-card p-3 text-center" data-billtype="FASTAG" data-bs-toggle="offcanvas" data-bs-target="#billSidebar">
            <img src="assets/images/payment/checkpoint.png" alt="Fastag"  style="height:60px; width:60px;" 
             class="mx-auto d-block"/>
            <h6  style="font-size: 12px;">Fastag</h6>
        </div>
    </div>

    <!-- Loan -->
    <div class="col-6 col-md-2">
        <div class="card bill-card p-3 text-center" data-billtype="LOANREPAYMENT" data-bs-toggle="offcanvas" data-bs-target="#billSidebar">
            <img src="assets/images/payment/takeover.png" alt="Loan Payment"  style="height:60px; width:60px;" 
             class="mx-auto d-block"/>
            <h6  style="font-size: 12px;">Loan Payment</h6>
        </div>
    </div>

    <!-- Postpaid -->
    <div class="col-6 col-md-2">
        <div class="card bill-card p-3 text-center" data-billtype="POSTPAID" data-bs-toggle="offcanvas" data-bs-target="#billSidebar">
            <img src="assets/images/payment/Recharge.png" alt="Postpaid"  style="height:60px; width:60px;" 
             class="mx-auto d-block"/>
            <h6  style="font-size: 12px;">Postpaid</h6>
        </div>
    </div>

    <div class="col-6 col-md-2">
        <div class="card bill-card p-3 text-center" data-billtype="BROADBAND" data-bs-toggle="offcanvas" data-bs-target="#billSidebar">
            <img src="assets/images/payment/wifi-router.png" alt="Broadband"  style="height:60px; width:60px;" 
             class="mx-auto d-block"/>
            <h6  style="font-size: 12px;">Broadband</h6>
        </div>
    </div>

   <div class="col-6 col-md-2">
    <div class="card bill-card p-3 text-center disabled-card coming-soon-wrapper">
        
        <span class="coming-soon-text">Coming Soon</span>

        <img src="assets/images/payment/love.png"
             alt="Donation"
             style="height:60px; width:60px;"
             class="mx-auto d-block"/>

        <h6 style="font-size: 12px;">Donation</h6>
    </div>
</div>


    <div class="col-6 col-md-2">
         <div class="card bill-card p-3 text-center disabled-card coming-soon-wrapper">
        
        <span class="coming-soon-text">Coming Soon</span>
            <img src="assets/images/payment/academic.png" alt="EducationFee"  style="height:60px; width:60px;" 
             class="mx-auto d-block"/>
            <h6  style="font-size: 12px;">Education Fee</h6>
        </div>
    </div>

   <div class="col-6 col-md-2">
        <div class="card bill-card p-3 text-center" data-billtype="PREPAIDELECTRICITY" data-bs-toggle="offcanvas" data-bs-target="#billSidebar">
            <img src="assets/images/payment/power.png" alt="ElectricityPrepaid"  style="height:60px; width:60px;" 
             class="mx-auto d-block"/>
            <h6  style="font-size: 12px;">Electricity Prepaid</h6>
        </div>
    </div>

    <div class="col-6 col-md-2">
       <div class="card bill-card p-3 text-center disabled-card coming-soon-wrapper">
        
        <span class="coming-soon-text">Coming Soon</span>
            <img src="assets/images/payment/heart.png" alt="Hospital"  style="height:60px; width:60px;" 
             class="mx-auto d-block"/>
            <h6 style="font-size: 12px;">Hospital & Pathology</h6>
        </div>
    </div>

      <div class="col-6 col-md-2">
         <div class="card bill-card p-3 text-center disabled-card coming-soon-wrapper">
        
        <span class="coming-soon-text">Coming Soon</span>
            <img src="assets/images/payment/home.png" alt="Housing"  style="height:60px; width:60px;" 
             class="mx-auto d-block"/>
            <h6  style="font-size: 12px;">Housing & Society</h6>
        </div>
    </div>

      <div class="col-6 col-md-2">
        <div class="card bill-card p-3 text-center disabled-card coming-soon-wrapper">
        
        <span class="coming-soon-text">Coming Soon</span>
            <img src="assets/images/payment/shield.png" alt="Insurance"  style="height:60px; width:60px;" 
             class="mx-auto d-block"/>
            <h6  style="font-size: 12px;">Insurance</h6>
        </div>
    </div>

    <div class="col-6 col-md-2">
         <div class="card bill-card p-3 text-center disabled-card coming-soon-wrapper">
        
        <span class="coming-soon-text">Coming Soon</span>
            <img src="assets/images/payment/telephone.png" alt="Landline"  style="height:60px; width:60px;" 
             class="mx-auto d-block"/>
            <h6 style="font-size: 12px;">Landline</h6>
        </div>
    </div>

    <%--<div class="col-6 col-md-2">
        <div class="card bill-card p-3 text-center" data-billtype="EMI" data-bs-toggle="offcanvas" data-bs-target="#billSidebar">
            <img src="assets/images/payment/takeover.png" alt="EMI"  style="height:60px; width:60px;" 
             class="mx-auto d-block"/>
            <h6>Loan EMI</h6>
        </div>
    </div>--%>

      <div class="col-6 col-md-2">
         <div class="card bill-card p-3 text-center disabled-card coming-soon-wrapper">
        
        <span class="coming-soon-text">Coming Soon</span>
            <img src="assets/images/payment/tax.png" alt="Taxes"  style="height:60px; width:60px;" 
             class="mx-auto d-block"/>
            <h6  style="font-size: 12px;">Municipal Taxes & Services</h6>
        </div>
    </div>

     <div class="col-6 col-md-2">
        <div class="card bill-card p-3 text-center disabled-card coming-soon-wrapper">
        
        <span class="coming-soon-text">Coming Soon</span>
            <img src="assets/images/payment/rocking-chair.png" alt="NPS"  style="height:60px; width:60px;" 
             class="mx-auto d-block"/>
            <h6 style="font-size: 12px;">National Pension Scheme(NPS)</h6>
        </div>
    </div>

    <div class="col-6 col-md-2">
        <div class="card bill-card p-3 text-center disabled-card coming-soon-wrapper">
        
        <span class="coming-soon-text">Coming Soon</span>
            <img src="assets/images/payment/train.png" alt="NCMC"  style="height:60px; width:60px;" 
             class="mx-auto d-block"/>
            <h6 style="font-size: 12px;">NCMC Recharge</h6>
        </div>
    </div>

    <div class="col-6 col-md-2">
         <div class="card bill-card p-3 text-center disabled-card coming-soon-wrapper">
        
        <span class="coming-soon-text">Coming Soon</span>
            <img src="assets/images/payment/calendar.png" alt="RecurringDeposit"  style="height:60px; width:60px;" 
             class="mx-auto d-block"/>
            <h6 style="font-size: 12px;">Recurring Deposit</h6>
        </div>
    </div>

    <div class="col-6 col-md-2">
          <div class="card bill-card p-3 text-center disabled-card coming-soon-wrapper">
        
        <span class="coming-soon-text">Coming Soon</span>
            <img src="assets/images/payment/rental-service.png" alt="Rental"  style="height:60px; width:60px;" 
             class="mx-auto d-block"/>
            <h6 style="font-size: 12px;">Rental</h6>
        </div>
    </div>

      <div class="col-6 col-md-2">
         <div class="card bill-card p-3 text-center disabled-card coming-soon-wrapper">
        
        <span class="coming-soon-text">Coming Soon</span>
            <img src="assets/images/payment/subscription.png" alt="Subscription"  style="height:60px; width:60px;" 
             class="mx-auto d-block"/>
            <h6 style="font-size: 12px;">Subscription</h6>
        </div>
    </div>



</div>
</div>

<!-- Offcanvas Sidebar (Common for all bill types) -->
<div class="offcanvas offcanvas-end" tabindex="-1" id="billSidebar" data-bs-backdrop="static" data-bs-keyboard="false">
    <asp:HiddenField ID="hfBillType" runat="server" />

    <div class="offcanvas-header" style="background-color:whitesmoke">
        <h5 class="offcanvas-title" id="billSidebarTitle">Bill Payment</h5>
        <button type="button" class="btn-close" data-bs-dismiss="offcanvas"></button>
    </div>
    <div class="offcanvas-body">

        <!-- Bill Form -->
        <div class="mb-3">
            <asp:TextBox ID="txtAccountNo" runat="server" CssClass="form-control" placeholder="Account Number"></asp:TextBox>
            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtAccountNo" ErrorMessage="Account number required" CssClass="text-danger" Display="Dynamic" ValidationGroup="BillPay" />
        </div>

        <div class="mb-3">
            <asp:TextBox ID="txtMobileBill" runat="server" CssClass="form-control" placeholder="Mobile Number"></asp:TextBox>
            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtMobileBill" ErrorMessage="Mobile required" CssClass="text-danger" Display="Dynamic" ValidationGroup="BillPay" />
        </div>

        <div class="mb-3">
            <asp:DropDownList ID="ddlOperatorBill" runat="server" CssClass="form-control">
                <asp:ListItem Value="">-- Select Operator --</asp:ListItem>
            </asp:DropDownList>
            <asp:HiddenField ID="hfOperatorText" runat="server" />
            <asp:RequiredFieldValidator runat="server" ControlToValidate="ddlOperatorBill" InitialValue="" ErrorMessage="Select operator" CssClass="text-danger" Display="Dynamic" ValidationGroup="BillPay" />
        </div>

      <%--  <div class="mb-3">
            <asp:TextBox ID="txtBillAmount" runat="server" CssClass="form-control" TextMode="Number" placeholder="Amount (₹)"></asp:TextBox>
            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtBillAmount" ErrorMessage="Amount required" CssClass="text-danger" Display="Dynamic" ValidationGroup="BillPay" />
        </div>--%>

        <div class="text-end">
            <asp:LinkButton runat="server" CssClass="btn btn-primary" Style="background-color:#6e007c" 
                ID="btnPayBill" ValidationGroup="BillPay" OnClick="btnPayBill_Click" >
                Pay Bill
            </asp:LinkButton>
        </div>
    </div>
</div>

<hr />

<div class="container py-4">
    <h4 style="color:#6e007c;">Bill Payment History</h4>

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
                <option value="Pending">Pending</option>
                <option value="failed">Failed</option>
            </select>
        </div>

        <div class="col-md-6 d-flex justify-content-end gap-2">
            <!-- Select Filter Dropdown -->
            <select id="columnFilter" class="form-select form-select-sm" style="max-width:150px;">
                <option value="">Select Filter</option>
                <option value="orderid">Order ID</option>
                <option value="beneficiary">Mobile No</option>
                <option value="amount">Amount</option>
                <option value="status">Status</option>
            </select>

            <!-- Search Box -->
            <input id="searchBox" type="text" class="form-control form-control-sm" placeholder="Search" style="max-width:200px;" />

            <!-- Download Button -->
            <button class="btn btn-outline-secondary btn-sm" onclick="downloadTable()">Download</button>
        </div>
    </div>
    <asp:HiddenField ID="hfOrderId" runat="server" />
    <asp:Label runat="server" ID="lblMessage1"></asp:Label>
       <label runat="server" id="lblerror" class="col text-end text-danger"></label>

    <asp:Repeater ID="rptBillPayments" runat="server">
        <HeaderTemplate>
            <div class="table-responsive">
                <table id="payoutTable"  class="table table-striped table-bordered align-middle">
                    <thead class="table-light">
                        <tr>
                            <th>Date</th>
                            <th>Bill Type</th>
                            <th>Operator</th>
                            <th>Account No</th>
                            <th>Mobile</th>
                            <th>Amount (₹)</th>
                            <th>Status</th>
                            <th>Txn ID</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
        </HeaderTemplate>

        <ItemTemplate>
            <tr>
                <td><%# Eval("CreatedDate", "{0:dd-MM-yyyy HH:mm}") %></td>
                <td><%# Eval("BillType") %></td>
                <td><%# Eval("OperatorName") %></td>
                <td><%# Eval("AccountNo") %></td>
                <td class="beneficiary"><%# Eval("Mobile") %></td>
                <td class="amount"><%# Eval("Amount") %></td>
                <td class="status-cell">
                    <span class="badge
                        <%# Eval("Status").ToString() == "Success" ? "bg-success" : 
                            Eval("Status").ToString() == "Pending" ? "bg-warning text-dark" : "bg-danger" %>">
                        <%# Eval("Status") %>
                    </span>
                </td>
                <td class="orderid"><%# Eval("OrderId") %></td>
               <td>
                    <button type="button" class="btn btn-success btn-sm btn-receipt"
                        data-orderid='<%# Eval("OrderId") %>'
                        data-operator='<%# Eval("OperatorName") %>'
                        data-mobile='<%# Eval("Mobile") %>'
                        data-date='<%# string.Format("{0:yyyy-MM-dd HH:mm:ss}", Eval("CreatedDate")) %>'
                       data-type='<%# Eval("BillType") %>'
                        data-amount='<%# Eval("Amount") %>'
                        data-status='<%# Eval("Status") %>'>
                        Receipt
                    </button>
                </td>
            </tr>
        </ItemTemplate>

        <FooterTemplate>
                    </tbody>
                </table>
             <nav class="mt-3">
                    <ul class="pagination justify-content-end" id="payoutPagination"></ul>
                </nav>

            </div>
        </FooterTemplate>
    </asp:Repeater>
</div>

     <!-- Electricity Bill Modal -->
<div class="modal fade" id="editModal" tabindex="-1" aria-labelledby="editModalLabel" aria-hidden="true"
   data-bs-backdrop="static" data-bs-keyboard="false"    >

<div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content mt-4 mb-4 p-4">

<!-- Modal Body -->
            <div class="modal-body">
                  <!-- Modal Header -->
            <div class="modal-header">
              
                <asp:Label ID="editModalLabel" class="modal-title" runat="server" ></asp:Label> 
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
               <div class="card shadow-sm border rounded p-4 mb-4">
                    <h5 class="card-title text-center mb-4 fw-bold text-uppercase">Bill Summary</h5>

                   <div class="mb-2 d-flex justify-content-between border-bottom pb-1">
                        <span class="fw-semibold">Customer Name :</span>
                        <asp:Label ID="lblName" runat="server" CssClass="fw-bold text-dark"></asp:Label>
                    </div>

                    <div class="mb-2 d-flex justify-content-between border-bottom pb-1">
                        <span class="fw-semibold">Mobile Number :</span>
                        <asp:Label ID="lblNumber" runat="server" CssClass="fw-bold text-dark"></asp:Label>
                    </div>

                    <div class="mb-2 d-flex justify-content-between border-bottom pb-1">
                        <span class="fw-semibold">Bill Amount :</span>
                        <asp:Label ID="lblBillAmount" runat="server" CssClass="fw-bold text-danger"></asp:Label>
                    </div>

                    <div class="mb-2 d-flex justify-content-between border-bottom pb-1">
                        <span class="fw-semibold">Bill Number :</span>
                        <asp:Label ID="lblBillNo" runat="server" CssClass="fw-bold text-success"></asp:Label>
                    </div>

                    <div class="mb-2 d-flex justify-content-between border-bottom pb-1">
                        <span class="fw-semibold">Req ID :</span>
                        <asp:Label ID="lblReqID" runat="server" CssClass="fw-bold text-dark"></asp:Label>
                    </div>           
                  
                   <div class="mb-2 d-flex justify-content-between border-bottom pb-1">
                        <span class="fw-semibold">Biller Response :</span>
                        <asp:Label ID="lblbillerResponse" runat="server" CssClass="fw-bold text-dark"></asp:Label>
                    </div>
                   
                    <div class="mb-2 d-flex justify-content-between border-bottom pb-1">
                        <span class="fw-semibold">Due Date :</span>
                        <asp:Label ID="lblDueDate" runat="server" CssClass="fw-bold text-dark"></asp:Label>
                    </div>

                    <div class="text-center">
                        <asp:Label ID="Label3" runat="server" CssClass="fw-bold fs-6 text-success"></asp:Label>
                    </div>
                     <!-- Modal Footer with Pay Now Button -->
            <div class="modal-footer">
                
                 <asp:LinkButton ID="btnPayNow" runat="server" CssClass="btn btn-success" OnClick="btnPayNow_Click">
                    Pay Now
                </asp:LinkButton>

                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
            </div>
                </div>

            </div>   

        </div>
    </div>
</div>
                <asp:HiddenField ID="HiddenField1" runat="server" />
                <asp:HiddenField ID="HiddenField2" runat="server" />
                <asp:HiddenField ID="HiddenField3" runat="server" />
                <asp:HiddenField ID="HiddenField4" runat="server" />
                <asp:HiddenField ID="HiddenField5" runat="server" />
                <asp:HiddenField ID="HiddenField6" runat="server" />

<div class="modal fade" id="PayModal" tabindex="-1" aria-labelledby="editModalLabel" aria-hidden="true" data-bs-backdrop="static" data-bs-keyboard="false">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content mt-4 mb-4 p-4" id="printArea1">

            <!-- Modal Header -->
            <div class="modal-header border-bottom-0">
              
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <!-- Invoice Header with Logo -->
          <div class="d-flex justify-content-between align-items-center mb-3">
            <!-- Left: Logo -->
            <div class="d-flex align-items-center">
                <img src="bankulogo1.png" alt="CompanyLogo" style="height:30px; margin-right: 10px;" />
            </div>

            <!-- Right: Label -->
            <asp:Label ID="lblheader" runat="server" CssClass="modal-title fw-bold fs-4 text-uppercase text-dark"></asp:Label>
        </div>

            <!-- Modal Body -->
            <div class="modal-body" >
                <!-- Header Section -->
                <div class="d-flex justify-content-between mb-4 border-bottom pb-3">
                    <div>
                        <h6 class="fw-bold mb-1">Bill to</h6>
                        <div><asp:Label ID="payName" runat="server" CssClass="text-dark fw-semibold"></asp:Label></div>
                        <div><asp:Label ID="payMobile" runat="server" CssClass="text-muted"></asp:Label></div>
                        <div><asp:Label ID="payOperator" runat="server" CssClass="text-muted"></asp:Label></div>
                    </div>
                    <div class="text-end">
                        <div><strong>Transaction ID:</strong> <asp:Label ID="PayTxnID" runat="server"></asp:Label></div>
                        <div><strong>Date:</strong> <asp:Label ID="payDate" runat="server"></asp:Label></div>
                    </div>
                </div>

                <!-- Bill Details Table -->
                <div class="table-responsive mb-4">
                    <table class="table table-bordered">
                        <thead class="table-light">
                            <tr>
                               
                                <th>Description</th>
                                <th>Rate</th>
                              
                                <th>Total</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                               
                                <td>Recharge</td>
                                <td>₹<asp:Label ID="payAmount" runat="server"></asp:Label></td>
                              
                                <td>₹<asp:Label ID="Label4" runat="server"></asp:Label></td>
                            </tr>
                        </tbody>
                    </table>
                </div>

                <!-- Summary Section -->
                <div class="d-flex justify-content-end mb-3">
                    <table class="table table-bordered w-auto mb-0">
                        <tr>
                            <td><strong>Commission</strong></td>
                            <td>₹<asp:Label ID="payCommission" runat="server"></asp:Label></td>
                        </tr>
                      
                        <tr>
                            <td><strong>Total</strong></td>
                            <td class="fw-bold text-success">₹<asp:Label ID="Label5" runat="server"></asp:Label></td>
                        </tr>
                    </table>
                </div>

                <!-- Extra Info -->
                <div class="mt-4">
                    <p><strong>Account Number:</strong> <asp:Label ID="payAccount" runat="server" CssClass="fw-semibold"></asp:Label></p>
                    <p><strong>Current Balance:</strong> <asp:Label ID="payCurrBal" runat="server" CssClass="fw-semibold"></asp:Label></p>
                </div>

                <!-- Authorized Sign -->
                <div class="mt-5 d-flex justify-content-end">
                    <div class="text-end">
                        <div class="border-top pt-2">Authorized Sign</div>
                    </div>
                </div>

                <!-- Final Message (if any) -->
                <div class="text-center mt-4">
                    <asp:Label ID="Label12" runat="server" CssClass="fw-bold fs-6 text-success"></asp:Label>
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

<!-- Receipt Modal -->
    <div class="modal fade" id="Recharge" tabindex="-1" aria-labelledby="editModalLabel" aria-hidden="true" data-bs-backdrop="static" data-bs-keyboard="false">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content mt-2 mb-2 p-4" id="printArea">

            <!-- Modal Header -->
            <div class="modal-header border-bottom-0">
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>

            <!-- Top Logo and Title -->
            <div class="d-flex justify-content-between align-items-center mb-3">
                <div class="d-flex align-items-center">
                    <img src="BankULogo1.png" alt="Company Logo" style="height:30px; margin-right: 10px;" />
                </div>
                <asp:Label ID="Label1" runat="server" CssClass="modal-title fw-bold fs-4 text-uppercase text-dark"></asp:Label>
            </div>

            <!-- Modal Body -->
            <div class="modal-body">

                <!-- Bill To & Transaction Info -->
                <div class="d-flex justify-content-between mb-4 border-bottom pb-3">
                    <div>
                        <h6 class="fw-bold mb-1">Recharge To</h6>
                        <div><asp:Label ID="Label2" runat="server" CssClass="text-dark fw-semibold"></asp:Label></div>
                        <div><asp:Label ID="lblOpe" runat="server" CssClass="text-muted"></asp:Label></div>
                    </div>
                    <div class="text-end">
                        <div><strong>Transaction ID:</strong> <asp:Label ID="lblTranID" runat="server"></asp:Label></div>
                        <div><strong>Date:</strong> <asp:Label ID="lblTranDate" runat="server"></asp:Label></div>
                          <div><strong>Type:</strong> <asp:Label ID="lbltype" runat="server"></asp:Label></div>
                    </div>
                </div>

                <!-- Summary Table -->
                <div class="table-responsive mb-4">
                    <table class="table table-bordered w-100">
                        <thead class="table-light">
                            <tr>
                                
                                <th>Description</th>
                                <th>Amount</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                
                                <td>Bill Amount</td>
                                <td>₹<asp:Label ID="Label6" runat="server"></asp:Label></td>
                            </tr>
                        <%--<tr>                             
                                <td>Commission</td>
                                <td>₹<asp:Label ID="lblCommission" runat="server"></asp:Label></td>
                            </tr>--%>
                        </tbody>
                    </table>
                </div>

                <!-- Current Balance -->
              <%--  <div class="mb-4">
                    <p><strong>Current Balance:</strong> <asp:Label ID="lblBalance" runat="server" CssClass="fw-semibold text-success"></asp:Label></p>
                </div>--%>

                <!-- Signature -->
                <div class="mt-5 d-flex justify-content-end">
                    <div class="text-end">
                        <div class="border-top pt-2">Authorized Sign</div>
                    </div>
                </div>

                <!-- Final Note -->
                <div class="text-center mt-4">
                    <asp:Label ID="Label7" runat="server" CssClass="fw-bold fs-6 text-success"></asp:Label>
                </div>
            </div>

            <!-- Modal Footer -->
            <div class="modal-footer no-print">
                <asp:LinkButton ID="LinkButton1" runat="server" CssClass="btn btn-success" OnClientClick="printReceipt(); return false;">Print</asp:LinkButton>
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
            </div>

        </div>
    </div>
</div>

</asp:Panel>

<asp:Panel ID="pnlError" runat="server" Visible="false" CssClass="text-center mt-5">
<div class="d-flex justify-content-center mt-5">
  <div class="alert alert-danger rounded-4 shadow-lg p-4" role="alert" style="max-width:700px">
    <h2 class="fw-bold text-danger mb-3">
      <i class="fa fa-exclamation-triangle"></i> Service Unavailable
    </h2>
    <p class="fs-5">
      The Bill Payment Service is currently down for maintenance or technical issues.  
      Please try again later.
    </p>
    <a href="Dashboard.aspx" class="btn btn-secondary mt-3">Back to Dashboard</a>
  </div>
</div>
</asp:Panel>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

 <script>
     const rowsPerPage = 10;
     const table = document.getElementById("payoutTable");
     const tbody = table.querySelector("tbody");
     const rows = Array.from(tbody.querySelectorAll("tr"));
     const pagination = document.getElementById("payoutPagination");

     let currentPage = 1;
     const totalPages = Math.ceil(rows.length / rowsPerPage);
     const maxVisiblePages = 3;

     function showPage(page) {
         if (page < 1 || page > totalPages) return;

         currentPage = page;

         rows.forEach((row, index) => {
             row.style.display =
                 index >= (page - 1) * rowsPerPage &&
                     index < page * rowsPerPage
                     ? ""
                     : "none";
         });

         updatePagination();
     }

     function createPageItem(text, page, isActive = false, isDisabled = false) {
         const li = document.createElement("li");
         li.className = "page-item";
         if (isActive) li.classList.add("active");
         if (isDisabled) li.classList.add("disabled");

         const a = document.createElement("a");
         a.className = "page-link";
         a.href = "#";
         a.innerText = text;

         if (!isDisabled) {
             a.onclick = function (e) {
                 e.preventDefault();
                 showPage(page);
             };
         }

         li.appendChild(a);
         return li;
     }

     function updatePagination() {
         pagination.innerHTML = "";

         pagination.appendChild(
             createPageItem("Prev", currentPage - 1, false, currentPage === 1)
         );

         let start = Math.max(1, currentPage - 1);
         let end = Math.min(totalPages, start + maxVisiblePages - 1);

         if (end - start < maxVisiblePages - 1) {
             start = Math.max(1, end - maxVisiblePages + 1);
         }

         if (start > 1) {
             pagination.appendChild(createPageItem(1, 1));
             pagination.appendChild(createPageItem("...", null, false, true));
         }

         for (let i = start; i <= end; i++) {
             pagination.appendChild(
                 createPageItem(i, i, i === currentPage)
             );
         }

         if (end < totalPages) {
             pagination.appendChild(createPageItem("...", null, false, true));
             pagination.appendChild(createPageItem(totalPages, totalPages));
         }

         pagination.appendChild(
             createPageItem("Next", currentPage + 1, false, currentPage === totalPages)
         );
     }

     showPage(1);
 </script>

<script>
    function printReceipt() {
        var printContent = document.getElementById('printArea1').innerHTML;
        var win = window.open('', '_blank');

        win.document.write(`
        <html>
            <head>
                <title>Print Receipt</title>
                <!-- Include Bootstrap CSS for print layout -->
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
                <style>
                    body { font-family: Arial, sans-serif; padding: 20px; }
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
      
        document.getElementById("<%= ddlOperatorBill.ClientID %>").addEventListener("change", function () {
            var selectedValue = this.value;
            document.getElementById("<%= hfOperatorText.ClientID %>").value = selectedValue;
        });

        document.querySelectorAll(".bill-card").forEach(card => {
            card.addEventListener("click", function () {
                let type = this.dataset.billtype;

                // Update sidebar title
                document.getElementById("billSidebarTitle").innerText = type + " Payment";
                document.getElementById("<%= hfBillType.ClientID %>").value = type;

                // Cache dropdown + button
                let ddl = document.getElementById("<%= ddlOperatorBill.ClientID %>");
                let btnPay = document.getElementById("<%= btnPayBill.ClientID %>");

                // Call WebMethod
                PageMethods.GetOperators(type, function (result) {
                    ddl.innerHTML = ""; // always clear first
                    ddl.add(new Option("-- Select Operator --", ""));

                    if (result.Status === "SUCCESS" && result.Data.length > 0) {
                        result.Data.forEach(op => {
                            ddl.add(new Option(op.OperatorName, op.Id));
                        });
                        btnPay.disabled = false; // enable if operators available
                    } else {
                        alert(result.Message || "Operator Not Added");
                        btnPay.disabled = true;
                    }

                    // Open sidebar
                    var sidebar = new bootstrap.Offcanvas(document.getElementById('billSidebar'));
                    sidebar.show();

                }, function (err) {
                    console.error("Error loading operators:", err);

                    ddl.innerHTML = "";
                    ddl.add(new Option("-- Select Operator --", ""));
                    btnPay.disabled = true;
                    alert("Error while loading operators");

                    var sidebar = new bootstrap.Offcanvas(document.getElementById('billSidebar'));
                    sidebar.show();
                });
            });
        });
    });
</script>


<script>

    function checkDate(dateString, type) {
        let rowDate = new Date(dateString);
        let today = new Date();
        today.setHours(0, 0, 0, 0);
        let yesterday = new Date(today);
        yesterday.setDate(today.getDate() - 1);
        rowDate.setHours(0, 0, 0, 0);

        if (type === "today") return rowDate.getTime() === today.getTime();
        if (type === "yesterday") return rowDate.getTime() === yesterday.getTime();
        return true; // No filter
    }

    // Main filter function
    function applyFilters() {
        let dateFilter = document.getElementById("dateFilter").value;
        let statusFilter = document.getElementById("statusFilter").value.toLowerCase();
        let colFilter = document.getElementById("columnFilter").value;
        let searchValue = document.getElementById("searchBox").value.toLowerCase();

        let table = document.getElementById("payoutTable").getElementsByTagName("tbody")[0];
        let rows = table.getElementsByTagName("tr");

        for (let i = 0; i < rows.length; i++) {
            // Skip details rows
            if (rows[i].classList.contains("details-row")) continue;

            let statusCell = rows[i].querySelector(".status-cell")?.innerText.toLowerCase() || "";
            let dateCell = rows[i].querySelector(".date-cell")?.innerText || "";
            let searchCellText = "";

            if (colFilter) {
                searchCellText = rows[i].querySelector("." + colFilter)?.innerText.toLowerCase() || "";
            } else {
                searchCellText = rows[i].innerText.toLowerCase();
            }

            let matchesDate = dateFilter ? checkDate(dateCell, dateFilter) : true;
            let matchesStatus = statusFilter ? statusCell.includes(statusFilter) : true;
            let matchesSearch = searchValue ? searchCellText.includes(searchValue) : true;

            if (matchesDate && matchesStatus && matchesSearch) {
                rows[i].style.display = "";
            } else {
                rows[i].style.display = "none";
            }
        }
    }

    // Bind events
    document.getElementById("dateFilter").addEventListener("change", applyFilters);
    document.getElementById("statusFilter").addEventListener("change", applyFilters);
    document.getElementById("columnFilter").addEventListener("change", applyFilters);
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
        a.download = "BillPay.csv";
        document.body.appendChild(a);
        a.click();
        document.body.removeChild(a);
    }

</script>

<script>
    $(document).ready(function () {
  
        $(document).on("click", ".btn-receipt", function () {
            var orderId = $(this).data("orderid");
            var operator = $(this).data("operator");
            var mobile = $(this).data("mobile");
            var date = $(this).data("date");
            var type = $(this).data("type");
            var amount = $(this).data("amount");
            var status = $(this).data("status");

         
            $("#<%= Label2.ClientID %>").text(mobile);            // Mobile
            $("#<%= lblOpe.ClientID %>").text(operator);          // Operator
            $("#<%= lblTranID.ClientID %>").text(orderId);        // Transaction ID
            $("#<%= lblTranDate.ClientID %>").text(date);         // Date
            $("#<%= Label6.ClientID %>").text(amount);            // Bill Amount
            $("#<%= lbltype.ClientID %>").text(type);
            $("#<%= Label1.ClientID %>").text("Payment Receipt");// Title

       
            var $statusLabel = $("#<%= Label7.ClientID %>");
            $statusLabel.text(status);

            if (status && status.toLowerCase() === "success") {
                $statusLabel.removeClass("text-danger").addClass("text-success");
            } else {
                $statusLabel.removeClass("text-success").addClass("text-danger");
            }


            var receiptModal = new bootstrap.Modal(document.getElementById('Recharge'));
            receiptModal.show();
        });
    });

    // Print function
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
</asp:Content>

