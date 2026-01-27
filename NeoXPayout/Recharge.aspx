<%@ Page Title="" Language="C#" MasterPageFile="~/Neox.Master" AutoEventWireup="true" CodeBehind="Recharge.aspx.cs" Inherits="NeoXPayout.Recharge" %>
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
#pagination button.active {
    background-color: #2b71f0;
    color: white;
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

</style>
<style>
.status-success { color: green; font-weight: bold; }
.status-failed { color: red; font-weight: bold; }
.details-row { display: none; }
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<hr /> 
<asp:Panel runat="server" ID="pnlMain">
<div class="container py-4">
 
  <!-- Tabs -->
<div class="d-flex align-items-center overflow-hidden mb-3" style="gap:8px;">
    <div class="tab-scroll flex-grow-1">
        <ul class="nav nav-tabs mb-0" id="rechargeTabs" role="tablist">
            <li class="nav-item" role="presentation">
                <button class="nav-link active" id="mobile-tab" data-bs-toggle="tab"
                        data-bs-target="#mobile" type="button" role="tab"
                        aria-controls="mobile" aria-selected="true" style="color:#6e007c;">
                    Mobile Recharge
                </button>
            </li>
            <li class="nav-item" role="presentation">
                <button class="nav-link" id="dth-tab" data-bs-toggle="tab"
                        data-bs-target="#dth" type="button" role="tab"
                        aria-controls="dth" aria-selected="false" style="color:#6e007c;">
                    DTH Recharge
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
                <small class="text-muted">RECHARGE TODAY</small>
                <h5 class="mb-0"><asp:Label ID="lblTxnToday" runat="server" Text="0" /></h5>
            </div>
            <div class="col-md-auto summary-item">
                <small class="text-muted">TOTAL VALUE</small>
                <h5 class="mb-0"><asp:Label ID="lblTotalValue" runat="server" Text="₹0.00" /></h5>
            </div>
            <div class="col-md-auto summary-item">
                <small class="text-muted">AVG VALUE</small>
                <h5 class="mb-0"><asp:Label ID="lblAvgValue" runat="server" Text="₹0.00" /></h5>
            </div>
            <label runat="server" id="lblMessage" class="col text-end text-success"></label>
            <label runat="server" id="lblerror" class="col text-end text-danger"></label>
            <div class="col text-end">
                <button type="button" class="btn btn-primary" 
                        data-bs-toggle="offcanvas" data-bs-target="#singlePayoutSidebar"
                        style="background-color:#6e007c">+ Mobile Recharge</button>
            </div>
        </div>
    </div>

    <!-- DTH Recharge Tab -->
    <div class="tab-pane fade" id="dth" role="tabpanel" aria-labelledby="dth-tab">
        <div class="row mb-4 align-items-center summary-row">
            <div class="col-md-auto summary-item">
                <small class="text-muted">DTH RECHARGES TODAY</small>
                <h5 class="mb-0"><asp:Label ID="DthToday" runat="server" Text="₹0.00" /></h5>
            </div>
            <div class="col-md-auto summary-item">
                <small class="text-muted">TOTAL VALUE</small>
                <h5 class="mb-0"><asp:Label ID="DthTotal" runat="server" Text="₹0.00" /></h5>
            </div>
            <div class="col text-end">
                <button type="button" class="btn btn-primary"
                        data-bs-toggle="offcanvas" data-bs-target="#dthSidebar"
                        style="background-color:#6e007c">+ DTH Recharge</button>
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

    <div class="row mb-3">
        <div class="col-md-6 d-flex gap-2">     
            <asp:TextBox ID="txtfrom" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
            <asp:TextBox ID="txtto" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
            <asp:LinkButton runat="server" CssClass="btn btn-primary" ID="btnSearch" style=" background-color:purple; color:white;" OnClick="btnSearch_Click">Search</asp:LinkButton>
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
                    <th>Operator</th>
                    <th>Mobile No.</th>
                    <th>Date</th>
                    <th>Type</th>
                    <th>Amount (₹)</th>  
                    <th>Action</th>
                </tr>
            </thead>
          <tbody>
              <asp:Repeater runat="server" ID="gvRequests">
              <ItemTemplate>
                <tr>
                    <td class="toggle-btn" style="cursor:pointer;">+</td>
                    <td class="status-cell"> <span class="badge
                        <%# Eval("Status").ToString() == "SUCCESS" ? "bg-success" : 
                            Eval("Status").ToString() == "Pending" ? "bg-warning text-dark" : "bg-danger" %>">
                        <%# Eval("Status") %>
                    </span></td>
                    <td class="orderid "><%# Eval("TransID") %></td>
                    <td><%# Eval("OperatorName") %></td>
                    <td class="beneficiary"> <%# Eval("MobileNo") %></td>
                   
                    <td class="date-cell">
                        <%# string.Format("{0:yyyy-MM-dd HH:mm:ss}", Eval("TxnDate")) %>
                    </td>

                    <td><%# Eval("ServiceName") %></td>
                    <td class="amount"><%# Eval("Amount") %></td>         
                  <td>
                    <button type="button" class="btn btn-success btn-sm btn-receipt"
                        data-orderid='<%# Eval("TransID") %>'
                        data-operator='<%# Eval("OperatorName") %>'
                        data-mobile='<%# Eval("MobileNo") %>'
                        data-date='<%# string.Format("{0:yyyy-MM-dd HH:mm:ss}", Eval("TxnDate")) %>'
                        data-type='<%# Eval("ServiceName") %>'
                        data-amount='<%# Eval("Amount") %>'
                        data-status='<%# Eval("Status") %>'>
                        Receipt
                    </button>
                </td>
        
                </tr>
                <tr class="details-row">
                    <td colspan="10"><%# Eval("ServiceName") %></td>
                </tr>
               
                      </ItemTemplate>
              </asp:Repeater>
            
            </tbody>

        </table>
         <nav class="mt-3">
                    <ul class="pagination justify-content-end" id="payoutPagination"></ul>
                </nav>
         <div id="pagination" class="d-flex mt-3 gap-2"></div>
    </div>

</div>

    <!-- Offcanvas Sidebar -->
    <div class="offcanvas offcanvas-end" tabindex="-1" id="singlePayoutSidebar">
        <asp:HiddenField ID="hfOperator" runat="server" />
    <div class="offcanvas-header" style="background-color:whitesmoke">
        <h5 class="offcanvas-title">Mobile Prepaid</h5>
        <button type="button" class="btn-close" data-bs-dismiss="offcanvas"></button>
    </div>
    <div class="offcanvas-body">

        <!-- STEP 1: Select Operator -->
        <div id="step1">
            <h6>Select Operator</h6>
            <div class="row g-2">
                 <asp:Repeater ID="rptMobileOperators" runat="server">
            <ItemTemplate>
                <div class="col-12">
                    <button type="button" class="operator-card w-100 p-3 border rounded" 
                            data-operator='<%# Eval("Id") %>'>
                        <img src='assets/images/xs/<%# Eval("OperatorName") %>.png' 
                             alt='<%# Eval("OperatorName") %>' 
                             class="me-2" style="height:24px;" />
                        <%# Eval("OperatorName") %>
                    </button>
                </div>
            </ItemTemplate>
        </asp:Repeater>
            </div>

        </div>

        <!-- STEP 2: Fill Details -->
        <div id="step2" class="d-none">
            <h6 id="selectedOperator"></h6>
            <div class="mb-3">
                <asp:TextBox ID="txtMobile" runat="server" CssClass="form-control" placeholder="Mobile Number"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvMobile" runat="server" ControlToValidate="txtMobile"
                    ErrorMessage="Mobile number is required" CssClass="text-danger" Display="Dynamic" ValidationGroup="BankPayoutGroup"/>
            </div>

            <div class="mb-3">
                <asp:DropDownList ID="ddlCircle" runat="server" CssClass="form-control">
                        <asp:ListItem Value="52">BIHAR</asp:ListItem>
                        <asp:ListItem Value="105">JHARKHAND</asp:ListItem>
                        <asp:ListItem Value="56">ASSAM</asp:ListItem>
                        <asp:ListItem Value="10">DELHI</asp:ListItem>
                        <asp:ListItem Value="104">MIZZORAM</asp:ListItem>
                        <asp:ListItem Value="103">MEGHALAY</asp:ListItem>
                        <asp:ListItem Value="102">GOA</asp:ListItem>
                        <asp:ListItem Value="101">CHHATISGARH</asp:ListItem>
                        <asp:ListItem Value="100">TRIPURA</asp:ListItem>
                        <asp:ListItem Value="99">SIKKIM</asp:ListItem>
                        <asp:ListItem Value="49">AP</asp:ListItem>
                        <asp:ListItem Value="95">KERALA</asp:ListItem>
                        <asp:ListItem Value="94">TAMIL NADU</asp:ListItem>
                        <asp:ListItem Value="40">CHENNAI</asp:ListItem>
                        <asp:ListItem Value="06">KARNATAKA</asp:ListItem>
                        <asp:ListItem Value="16">NESA</asp:ListItem>
                        <asp:ListItem Value="53">ORISSA</asp:ListItem>
                        <asp:ListItem Value="51">West Bengal</asp:ListItem>
                        <asp:ListItem Value="31">KOLKATTA</asp:ListItem>
                        <asp:ListItem Value="70">RAJASTHAN</asp:ListItem>
                        <asp:ListItem Value="93">MP</asp:ListItem>
                        <asp:ListItem Value="98">GUJARAT</asp:ListItem>
                        <asp:ListItem Value="90">MAHARASHTRA</asp:ListItem>
                        <asp:ListItem Value="92">MUMBAI</asp:ListItem>
                        <asp:ListItem Value="54">UP(East)</asp:ListItem>
                        <asp:ListItem Value="55">J&K</asp:ListItem>
                        <asp:ListItem Value="96">HARYANA</asp:ListItem>
                        <asp:ListItem Value="03">HP</asp:ListItem>
                        <asp:ListItem Value="02">PUNJAB</asp:ListItem>
                        <asp:ListItem Value="97">UP(West)</asp:ListItem>
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="rfvCircle" runat="server" ControlToValidate="ddlCircle"
                    InitialValue="" ErrorMessage="Please select a Circle" CssClass="text-danger" Display="Dynamic" ValidationGroup="BankPayoutGroup"/>
            </div>

            <div class="mb-3">
                <asp:TextBox ID="txtAmount" runat="server" CssClass="form-control" placeholder="Amount (₹)" TextMode="Number"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvAmount" runat="server" ControlToValidate="txtAmount"
                    ErrorMessage="Amount is required" CssClass="text-danger" Display="Dynamic" ValidationGroup="BankPayoutGroup"/>
            </div>
            <div class="text-end mt-1">
                <%--<button type="button" class="btn btn-link p-0 text-primary view-plans-btn" 
                        data-bs-toggle="offcanvas" data-bs-target="#plansSidebar">
                    View Plans
                </button>--%>
                <asp:LinkButton runat="server" class="btn btn-link p-0 text-primary view-plans-btn" OnClientClick="document.getElementById('<%= hfLastSidebar.ClientID %>').value='singlePayoutSidebar';" ID="PlanMobile" OnClick="PlanMobile_Click">View Plans</asp:LinkButton>
            </div>


            <div class="d-flex justify-content-between mt-2">
                <button type="button" class="btn btn-outline-secondary" id="backStep">⬅ Back</button>
                <asp:LinkButton runat="server" CssClass="btn btn-primary" Style="background-color:#6e007c"
                    ID="BankPayout" OnClick="BankPayout_Click" ValidationGroup="BankPayoutGroup">
                    Proceed
                </asp:LinkButton>
            </div>
        </div>

    </div>
</div>

    <asp:HiddenField ID="hfLastSidebar" runat="server" />

    <div class="offcanvas offcanvas-end" tabindex="-1" id="dthSidebar">
        <asp:HiddenField ID="HiddenField2" runat="server" />
        <div class="offcanvas-header" style="background-color:whitesmoke">
            <h5 class="offcanvas-title">DTH Recharge</h5>
            <button type="button" class="btn-close" data-bs-dismiss="offcanvas"></button>
        </div>
        <div class="offcanvas-body">

        <!-- STEP 1: Select Operator -->
        <div id="step11">
            <h6>Select Operator</h6>
            <div class="row g-2">
               <asp:Repeater ID="rptDthOperators" runat="server">
                <ItemTemplate>
                    <div class="col-12">
                        <button type="button" class="operator-card w-100 p-3 border rounded" 
                                data-operator='<%# Eval("Id") %>'>
                            <img src='assets/images/xs/<%# Eval("OperatorName") %>.png' 
                                 alt='<%# Eval("OperatorName") %>' 
                                 class="me-2" style="height:24px;" />
                            <%# Eval("OperatorName") %>
                        </button>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
            </div>

        </div>

        <!-- STEP 2: Fill Details -->
        <div id="step12" class="d-none">
            <h6 id="selectedOperator1"></h6>
            <div class="mb-3">
                <asp:TextBox ID="TextBox1" runat="server" CssClass="form-control" placeholder="Mobile Number"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TextBox1"
                    ErrorMessage="Mobile number is required" CssClass="text-danger" Display="Dynamic" ValidationGroup="BankPayoutGroup1"/>
            </div>

            <div class="mb-3">
                <asp:DropDownList ID="DropDownList1" runat="server" CssClass="form-control">
                    <asp:ListItem Value="52">BIHAR</asp:ListItem>
                                            <asp:ListItem Value="105">JHARKHAND</asp:ListItem>
                                            <asp:ListItem Value="56">ASSAM</asp:ListItem>
                                            <asp:ListItem Value="10">DELHI</asp:ListItem>
                                            <asp:ListItem Value="104">MIZZORAM</asp:ListItem>
                                            <asp:ListItem Value="103">MEGHALAY</asp:ListItem>
                                            <asp:ListItem Value="102">GOA</asp:ListItem>
                                            <asp:ListItem Value="101">CHHATISGARH</asp:ListItem>
                                            <asp:ListItem Value="100">TRIPURA</asp:ListItem>
                                            <asp:ListItem Value="99">SIKKIM</asp:ListItem>
                                            <asp:ListItem Value="49">AP</asp:ListItem>
                                            <asp:ListItem Value="95">KERALA</asp:ListItem>
                                            <asp:ListItem Value="94">TAMIL NADU</asp:ListItem>
                                            <asp:ListItem Value="40">CHENNAI</asp:ListItem>
                                            <asp:ListItem Value="06">KARNATAKA</asp:ListItem>
                                            <asp:ListItem Value="16">NESA</asp:ListItem>
                                            <asp:ListItem Value="53">ORISSA</asp:ListItem>
                                            <asp:ListItem Value="51">West Bengal</asp:ListItem>
                                            <asp:ListItem Value="31">KOLKATTA</asp:ListItem>
                                            <asp:ListItem Value="70">RAJASTHAN</asp:ListItem>
                                            <asp:ListItem Value="93">MP</asp:ListItem>
                                            <asp:ListItem Value="98">GUJARAT</asp:ListItem>
                                            <asp:ListItem Value="90">MAHARASHTRA</asp:ListItem>
                                            <asp:ListItem Value="92">MUMBAI</asp:ListItem>
                                            <asp:ListItem Value="54">UP(East)</asp:ListItem>
                                            <asp:ListItem Value="55">J&K</asp:ListItem>
                                            <asp:ListItem Value="96">HARYANA</asp:ListItem>
                                            <asp:ListItem Value="03">HP</asp:ListItem>
                                            <asp:ListItem Value="02">PUNJAB</asp:ListItem>
                                            <asp:ListItem Value="97">UP(West)</asp:ListItem>
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="ddlCircle"
                    InitialValue="" ErrorMessage="Please select a Circle" CssClass="text-danger" Display="Dynamic" ValidationGroup="BankPayoutGroup1"/>
            </div>

            <div class="mb-3">
                <asp:TextBox ID="TextBox2" runat="server" CssClass="form-control" placeholder="Amount (₹)" TextMode="Number"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="TextBox2"
                    ErrorMessage="Amount is required" CssClass="text-danger" Display="Dynamic" ValidationGroup="BankPayoutGroup1"/>
            </div>
            <div class="text-end mt-1">
               <%-- <button type="button" class="btn btn-link p-0 text-primary view-plans-btn" 
                        data-bs-toggle="offcanvas" data-bs-target="#plansSidebar">
                    View Plans
                </button>--%>
                <asp:LinkButton runat="server" class="btn btn-link p-0 text-primary view-plans-btn" ID="PlanDth"  OnClientClick="document.getElementById('<%= hfLastSidebar.ClientID %>').value='dthSidebar';" OnClick="PlanDth_Click">View Plans</asp:LinkButton>
            </div>


            <div class="d-flex justify-content-between mt-2">
                <button type="button" class="btn btn-outline-secondary" id="backStep1">⬅ Back</button>
                <asp:LinkButton runat="server" CssClass="btn btn-primary" Style="background-color:#6e007c"
                    ID="btnDth" OnClick="btnDth_Click"  ValidationGroup="BankPayoutGroup1">
                    Proceed
                </asp:LinkButton>
            </div>
        </div>

    </div> 
        </div>

    <!-- Plans Sidebar -->
    <div class="offcanvas offcanvas-end" tabindex="-1" id="plansSidebar">
      <div class="offcanvas-header">
    
           <!-- Back Button -->
            <div >
              <button type="button" class="btn btn-outline-secondary w-100" id="backToRecharge">⬅ <b>Plans</b></button>
            </div>
        <button type="button" class="btn-close" data-bs-dismiss="offcanvas"></button>
      </div>
      <div class="offcanvas-body">
          
         <asp:Literal ID="litPlansHtml" runat="server"></asp:Literal>
         <asp:Label ID="lblNoPlans" runat="server" CssClass="text-danger" Visible="false" />
      </div>
    </div>

    <!-- Transaction Success Modal -->
    <div class="modal fade" id="successModal" tabindex="-1" aria-labelledby="successModalLabel" aria-hidden="true"
         data-bs-backdrop="static" data-bs-keyboard="false">
      <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content shadow-lg rounded-3 text-center">
      
          <!-- Modal Header -->
          <div class="modal-header bg-success text-white border-0">
            <%--<h5 >Transaction Successful</h5>--%>
              <asp:Label runat="server" class="modal-title w-100" id="successModalLabel"></asp:Label>
            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
          </div>
      
          <!-- Modal Body -->
          <div class="modal-body">
            <img src="https://cdn-icons-png.flaticon.com/512/845/845646.png" 
                 alt="Success" class="mb-3" width="80" height="80" />
              <asp:Label CssClass="fw-semibold" ID="lblSuccessMsg" runat="server"></asp:Label>
           
            <button type="button" class="btn btn-success w-100" data-bs-dismiss="modal">OK</button>
          </div>
      
        </div>
      </div>
    </div>

    <div class="modal fade" id="errorModal" tabindex="-1" aria-labelledby="errorModalLabel" aria-hidden="true"
         data-bs-backdrop="static" data-bs-keyboard="false">
      <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content shadow-lg rounded-3 text-center">

          <!-- Modal Header -->
          <div class="modal-header bg-danger text-white border-0">
         
              <asp:Label runat="server" class="modal-title w-100" id="errorModalLabel"> Transaction Failed</asp:Label>
            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>

          <!-- Modal Body -->
          <div class="modal-body">
            <img src="https://cdn-icons-png.flaticon.com/512/463/463612.png"
                 alt="Error" class="mb-3" width="80" height="80" />
              <asp:Label runat="server" class="fw-semibold text-dark mb-3" ID="lblmsg"> </asp:Label>
         
            <button type="button" class="btn btn-danger w-100" data-bs-dismiss="modal">Try Again</button>
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
                <asp:Label ID="editModalLabel" runat="server" CssClass="modal-title fw-bold fs-4 text-uppercase text-dark"></asp:Label>
            </div>

            <!-- Modal Body -->
            <div class="modal-body">

                <!-- Bill To & Transaction Info -->
                <div class="d-flex justify-content-between mb-4 border-bottom pb-3">
                    <div>
                        <h6 class="fw-bold mb-1">Recharge To</h6>
                        <div><asp:Label ID="lblNumber" runat="server" CssClass="text-dark fw-semibold"></asp:Label></div>
                        <div><asp:Label ID="lblOpe" runat="server" CssClass="text-muted"></asp:Label></div>
                    </div>
                    <div class="text-end">
                        <div><strong>Transaction ID:</strong> <asp:Label ID="lblTranID" runat="server"></asp:Label></div>
                        <div><strong>Date:</strong> <asp:Label ID="lblTranDate" runat="server"></asp:Label></div>
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
                                <td>₹<asp:Label ID="lblBillAmount" runat="server"></asp:Label></td>
                            </tr>
                           <%-- <tr>
                               
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
 </asp:Panel>
    
<asp:Panel ID="pnlError" runat="server" Visible="false" CssClass="text-center mt-5">
<div class="d-flex justify-content-center mt-5">
  <div class="alert alert-danger rounded-4 shadow-lg p-4" role="alert" style="max-width:700px">
    <h2 class="fw-bold text-danger mb-3">
      <i class="fa fa-exclamation-triangle"></i> Service Unavailable
    </h2>
    <p class="fs-5">
      The Recharge Service is currently down for maintenance or technical issues.  
      Please try again later.
    </p>
    <a href="Dashboard.aspx" class="btn btn-secondary mt-3">Back to Dashboard</a>
  </div>
</div>
</asp:Panel>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

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
    document.addEventListener("DOMContentLoaded", function () {
        let lastRechargeSidebar = null;

        // --- Step Navigation (Mobile & DTH) ---
        document.querySelectorAll(".operator-card").forEach(btn => {
            btn.addEventListener("click", function () {
                let operator = this.dataset.operator;

                if (this.closest("#singlePayoutSidebar")) { // Mobile
                    document.getElementById("step1").classList.add("d-none");
                    document.getElementById("step2").classList.remove("d-none");
                    document.getElementById("selectedOperator").innerText = "Operator: " + operator;
                    document.getElementById('<%= hfOperator.ClientID %>').value = operator;
                    
                    let mobileBox = document.getElementById("<%= txtMobile.ClientID %>");
                    let amountBox = document.getElementById("<%= txtAmount.ClientID %>");
                    if (mobileBox) mobileBox.value = "";
                    if (amountBox) {
                        amountBox.value = "";
                        amountBox.readOnly = false; // allow manual input again
                    }
            }
            else if (this.closest("#dthSidebar")) { // DTH
                document.getElementById("step11").classList.add("d-none");
                document.getElementById("step12").classList.remove("d-none");
                document.getElementById("selectedOperator1").innerText = "Operator: " + operator;
                    document.getElementById('<%= HiddenField2.ClientID %>').value = operator;
                   
                    let dthBox = document.getElementById("<%= TextBox1.ClientID %>");
                    let amountBox = document.getElementById("<%= TextBox2.ClientID %>");
                    if (dthBox) dthBox.value = "";
                    if (amountBox) {
                        amountBox.value = "";
                        amountBox.readOnly = false;
                    }
            }

            // Highlight selected card
            this.closest(".row").querySelectorAll(".operator-card").forEach(b => b.classList.remove("active"));
            this.classList.add("active");
        });
    });

    // Track which sidebar is active
    ["singlePayoutSidebar", "dthSidebar"].forEach(id => {
        let el = document.getElementById(id);
        if (el) {
            el.addEventListener("show.bs.offcanvas", function () {
                lastRechargeSidebar = id;
                document.getElementById("<%= hfLastSidebar.ClientID %>").value = id;
            });
        }
    });

    // --- Plan Selection ---
    document.addEventListener("click", function (e) {
        const btn = e.target.closest(".plan-btn");
        if (!btn) return;

        const amount = btn.getAttribute("data-amount") || "";
        let returnSidebar = lastRechargeSidebar || document.getElementById("<%= hfLastSidebar.ClientID %>").value;

        if (returnSidebar === "singlePayoutSidebar") {
            let amountBox = document.getElementById("<%= txtAmount.ClientID %>");
            if (amountBox) {
                amountBox.value = amount;
                amountBox.readOnly = true;
            }
            // Force stay on Step 2
            document.getElementById("step1").classList.add("d-none");
            document.getElementById("step2").classList.remove("d-none");
         
            let op = document.getElementById('<%= hfOperator.ClientID %>').value;
            if (op) document.getElementById("selectedOperator").innerText = "Operator: " + op;
        } 
        else if (returnSidebar === "dthSidebar") {
            let amountBox = document.getElementById("<%= TextBox2.ClientID %>");
            if (amountBox) {
                amountBox.value = amount;
                amountBox.readOnly = true;
            }
            // Force stay on Step 12
            document.getElementById("step11").classList.add("d-none");
            document.getElementById("step12").classList.remove("d-none");

          
            let op = document.getElementById('<%= HiddenField2.ClientID %>').value;
            if (op) document.getElementById("selectedOperator1").innerText = "Operator: " + op;
        }

        // Close plans and reopen recharge sidebar
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

                // ✅ Force correct step (no operator reset)
                if (returnSidebar === "singlePayoutSidebar") {
                    document.getElementById("step1").classList.add("d-none");
                    document.getElementById("step2").classList.remove("d-none");
                   
                    let op = document.getElementById('<%= hfOperator.ClientID %>').value;
                    if (op) document.getElementById("selectedOperator").innerText = "Operator: " + op;
                }
                else if (returnSidebar === "dthSidebar") {
                    document.getElementById("step11").classList.add("d-none");
                    document.getElementById("step12").classList.remove("d-none");

                    let op = document.getElementById('<%= HiddenField2.ClientID %>').value;
                    if (op) document.getElementById("selectedOperator1").innerText = "Operator: " + op;
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

    document.getElementById("backStep1").addEventListener("click", function () {
        document.getElementById("step12").classList.add("d-none");
        document.getElementById("step11").classList.remove("d-none");
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
    document.getElementById('singlePayoutSidebar').addEventListener('hidden.bs.offcanvas', function () {
        // Remove readonly from all inputs inside the sidebar
        this.querySelectorAll('input').forEach(input => {
            input.removeAttribute("readonly");
            input.value = ""; // also clear values
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
    });

</script>

<script>
    // Date check helper
    function checkDate(dateString, type) {
        if (!dateString) return true;
        let rowDate = new Date(dateString.trim());
        if (isNaN(rowDate)) return true; // Skip invalid dates

        let today = new Date();
        today.setHours(0, 0, 0, 0);

        let yesterday = new Date(today);
        yesterday.setDate(today.getDate() - 1);

        rowDate.setHours(0, 0, 0, 0);

        if (type === "today") return rowDate.getTime() === today.getTime();
        if (type === "yesterday") return rowDate.getTime() === yesterday.getTime();
        return true; // "All Dates"
    }

    // Main filter function
    function applyFilters() {
        const dateFilter = document.getElementById("dateFilter").value;
        const statusFilter = document.getElementById("statusFilter").value.toLowerCase();
        const colFilter = document.getElementById("columnFilter").value;
        const searchValue = document.getElementById("searchBox").value.toLowerCase().trim();

        const tableBody = document.querySelector("#payoutTable tbody");
        const rows = tableBody.querySelectorAll("tr:not(.details-row)");

        rows.forEach(row => {
            const statusCell = row.querySelector(".status-cell")?.innerText.toLowerCase() || "";
            const dateCell = row.querySelector(".date-cell")?.innerText.trim() || "";

            // ✅ Determine which column to search in
            let searchText = "";
            if (colFilter) {
                searchText = row.querySelector("." + colFilter)?.innerText.toLowerCase() || "";
            } else {
                searchText = row.innerText.toLowerCase();
            }

            // ✅ Apply all filters
            const matchesDate = dateFilter ? checkDate(dateCell, dateFilter) : true;
            const matchesStatus = statusFilter ? statusCell.includes(statusFilter) : true;
            const matchesSearch = searchValue ? searchText.includes(searchValue) : true;

            row.style.display = (matchesDate && matchesStatus && matchesSearch) ? "" : "none";
        });
    }

    // Event bindings (after DOM load)
    document.addEventListener("DOMContentLoaded", function () {
        document.getElementById("dateFilter").addEventListener("change", applyFilters);
        document.getElementById("statusFilter").addEventListener("change", applyFilters);
        document.getElementById("columnFilter").addEventListener("change", applyFilters);
        document.getElementById("searchBox").addEventListener("input", applyFilters);
    });

  
    function downloadTable() {
        const table = document.getElementById("payoutTable");
        if (!table) {
            alert("Table not found!");
            return;
        }

        const rows = table.querySelectorAll("tr");
        const csv = [];

        rows.forEach(row => {
            if (row.classList.contains("details-row")) return; 
            //if (row.style.display === "none") return; 

            const cols = row.querySelectorAll("th, td");
            const rowData = [];

            cols.forEach(col => {
                let text = col.innerText.replace(/\n/g, " ").trim();
                if (text.includes(",") || text.includes('"')) {
                    text = '"' + text.replace(/"/g, '""') + '"';
                }
                rowData.push(text);
            });

            csv.push(rowData.join(","));
        });

        const csvContent = "data:text/csv;charset=utf-8," + encodeURIComponent(csv.join("\n"));
        const a = document.createElement("a");
        a.href = csvContent;
        a.download = "Recharge.csv";
        document.body.appendChild(a);
        a.click();
        document.body.removeChild(a);
    }
</script>

<script>
    $(document).ready(function () {
        // When Receipt button is clicked
        $(document).on("click", ".btn-receipt", function () {
            var orderId = $(this).data("orderid");
            var operator = $(this).data("operator");
            var mobile = $(this).data("mobile");
            var date = $(this).data("date");
            var type = $(this).data("type");
            var amount = $(this).data("amount");
            var status = $(this).data("status");

            // Fill modal fields (using ASP.NET ClientIDs)
            $("#<%= lblNumber.ClientID %>").text(mobile);
            $("#<%= lblOpe.ClientID %>").text(operator);
            $("#<%= lblTranID.ClientID %>").text(orderId);
            $("#<%= lblTranDate.ClientID %>").text(date);
            $("#<%= lblBillAmount.ClientID %>").text(amount);
            $("#<%= editModalLabel.ClientID %>").text("Recharge Receipt");


            var $statusLabel = $("#<%= Label3.ClientID %>");
            $statusLabel.text(status);

            if (status && status.toLowerCase() === "success") {
                $statusLabel.removeClass("text-danger").addClass("text-success");
            } else {
                $statusLabel.removeClass("text-success").addClass("text-danger");
            }

            // Show modal
            var receiptModal = new bootstrap.Modal(document.getElementById('Recharge'));
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

</asp:Content>
