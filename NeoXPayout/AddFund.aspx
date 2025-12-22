<%@ Page Title="" Language="C#" MasterPageFile="~/Neox.Master" AutoEventWireup="true" CodeBehind="AddFund.aspx.cs" Inherits="NeoXPayout.AddFund" %>
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

</style>
<style>
.status-success { color: green; font-weight: bold; }
.status-failed { color: red; font-weight: bold; }
.details-row { display: none; }
</style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
       <hr /> 
      
<div class="container py-4">
    <%--<asp:LinkButton ID="forcecheck" runat="server" CssClass="btn btn-primary" OnClick="forcecheck_Click"> check now</asp:LinkButton>--%>
  <!-- Tabs -->
  <div class="d-flex align-items-center overflow-hidden mb-3" style="gap:8px;">
    <div class="tab-scroll flex-grow-1">

      <ul class="nav nav-tabs mb-0" id="fundTabs" role="tablist">
        <li class="nav-item" role="presentation">
          <button class="nav-link active" id="fund-tab" data-bs-toggle="tab"
                  data-bs-target="#fund" type="button" role="tab"
                  aria-controls="fund" aria-selected="true" style="color:#6e007c;">
             Add Fund
          </button>
        </li>
         
      </ul>
       
    </div>
  </div>
<asp:Label runat="server" ID="lblerror2" CssClass="text-danger"></asp:Label>
  <!-- Tab content -->
  <div class="tab-content">
    <div class="tab-pane fade show active" id="fund" role="tabpanel" aria-labelledby="fund-tab">
      <div class="row mb-4 align-items-center summary-row">
      <div class="col-md-auto summary-item">
        <small class="text-muted">TRANSACTIONS TODAY</small>
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
                data-bs-toggle="offcanvas" data-bs-target="#addFundSidebar"
                style="background-color:#6e007c">+ ADD</button>
      </div>
    </div>

    </div>
  </div>

  <!-- Filters -->
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
           <option value="pending">Pending</option>
        <option value="failed">Failed</option>
      </select>
    </div>
    <div class="col-md-6 d-flex justify-content-end gap-2">
      <select id="columnFilter" class="form-select form-select-sm" style="max-width:150px;">
        <option value="">Select Filter</option>
        <option value="orderid">Order ID</option>
        <option value="amount">Amount</option>
        <option value="status">Status</option>
      </select>
      <input id="searchBox" type="text" class="form-control form-control-sm" placeholder="Search" style="max-width:200px;" />
      <button class="btn btn-outline-secondary btn-sm" onclick="downloadTable()">Download</button>
    </div>
  </div>

  <!-- Fund Table -->
  <div class="table-responsive">
    <table id="fundTable" class="table table-bordered align-middle">
      <thead class="table-light">
        <tr>
          <th>#</th>
          <th>Status</th>
          <th>Order ID</th>
          <th>Date</th>
         <%-- <th>Type</th>--%>
          <th>Amount (₹)</th>
             <th>Amount Added (₹)</th>
        </tr>
      </thead>
      <tbody>
        <asp:Repeater runat="server" ID="rptFund">
          <ItemTemplate>
            <tr>
              <td class="toggle-btn" style="cursor:pointer;">+</td>
              <td class="status-cell"><span><%# Eval("Status") %></span></td>
              <td class="orderid"><%# Eval("OrderId") %></td>
              <td class="date-cell"><%# Eval("ReqDate") %></td>
            <%--  <td><%# Eval("Type") %></td>--%>
              <td class="amount"><%# Eval("Amount") %></td>     
                 <td class="amount"><%# Eval("AmountPaid") %></td>     
            </tr>
            <tr class="details-row">
              <td colspan="6"><%# Eval("UserName") %></td>
            </tr>
          </ItemTemplate>
        </asp:Repeater>
      </tbody>
    </table>
  </div>
     <div id="pagination" class="d-flex mt-3 gap-2"></div>
</div>
   


<!-- Sidebar -->
<div class="offcanvas offcanvas-end" tabindex="-1" id="addFundSidebar" data-bs-backdrop="static" data-bs-keyboard="false">
  <asp:HiddenField ID="hfOperator" runat="server" />

  <div class="offcanvas-header" style="background-color:whitesmoke">
    <h5 class="offcanvas-title">Add Fund</h5>
    <button type="button" class="btn-close" data-bs-dismiss="offcanvas"></button>
  </div>

  <div class="offcanvas-body d-flex flex-column">

    <h6 id="selectedOperator"></h6>

    <div class="mb-3">
      <label class="form-label fw-semibold">Current Balance</label>
      <asp:TextBox ID="txtCurrBal" runat="server" CssClass="form-control" placeholder="Current Balance" ReadOnly="true"></asp:TextBox>
    </div>

    <div class="mb-3">
      <asp:TextBox ID="txtAmount" runat="server" CssClass="form-control" placeholder="Amount (₹)" TextMode="Number"></asp:TextBox>
      <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
        ControlToValidate="txtAmount"
        ErrorMessage="Amount is required" CssClass="text-danger"
        Display="Dynamic" ValidationGroup="FundGroup" />
    </div>

    <asp:Label runat="server" ID="Label1" CssClass="text-danger"></asp:Label>

    <!--  Proceed Button -->
    <asp:LinkButton runat="server" CssClass="btn btn-primary w-100 mb-3"
      Style="background-color:#6e007c"
      ID="btnAddFund" ValidationGroup="FundGroup" OnClick="btnAddFund_Click">
      Proceed
    </asp:LinkButton>


    <!--  Whitelisted UPI List Here -->
   <%-- <div class="mb-3 flex-grow-1">
      <label class="form-label fw-semibold">Whitelisted UPI IDs</label>
      <asp:Repeater ID="rptUPIList" runat="server">
        <ItemTemplate>
          <div class="border rounded p-2 mb-2 d-flex justify-content-between align-items-center">
            <%# Eval("UPI") %>
            <span class="badge bg-success">✔suraj@ptsbi</span>
          </div>
        </ItemTemplate>
      </asp:Repeater>


      <asp:Label ID="lblNoUPI" runat="server" Text="No UPI whitelisted!" CssClass="text-muted d-none"></asp:Label>
    </div>--%>



<%--    <button type="button" class="btn  w-100" style="background-color: purple; color:white"
      data-bs-toggle="modal" data-bs-target="#upiWhitelist">
      + Add UPI
    </button>--%>

  </div>
</div>



<asp:HiddenField ID="hfLastSidebar" runat="server" />


<%--<div class="modal fade" id="paymentModal" tabindex="-1" aria-labelledby="paymentModalLabel"
     aria-hidden="true" data-bs-backdrop="static" data-bs-keyboard="false">
  <div class="modal-dialog modal-dialog-centered modal-xl"> <!-- use modal-xl for width -->
    <div class="modal-content shadow-lg rounded-3 overflow-hidden">

      <!-- Modal Header -->
      <div class="modal-header text-white border-0" style="background-color: purple;">
        <h5 class="modal-title w-100 text-center fw-semibold" id="paymentModalLabel">
          Complete Your Payment
        </h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
      </div>

      <!-- Modal Body -->
      <div class="modal-body text-center p-4" style="max-height: 90vh; overflow: hidden;">
        <p class="text-muted small mb-4">
          Scan this QR code with your preferred UPI or banking app to complete the payment.
        </p>

        <!-- Responsive iframe container -->
        <div class="d-flex justify-content-center">
          <iframe id="paymentFrame" runat="server"
                  style="border: 2px solid #eee; border-radius: 12px;
                         width: 100%; max-width: 600px; height: 550px;"
                  title="Payment" allowfullscreen></iframe>
        </div>
      </div>

      <!-- Modal Footer -->
      <div class="modal-footer border-0">
        <button type="button" class="btn btn-secondary w-100 fw-semibold" data-bs-dismiss="modal">
          Close
        </button>
      </div>

    </div>
  </div>
</div>--%>

<div class="modal fade" id="upiWhitelist" tabindex="-1" aria-labelledby="upiWhitelistLabel" aria-hidden="true"
     data-bs-backdrop="static" data-bs-keyboard="false">

  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content shadow-lg rounded-3">

    
      <div class="modal-header text-white border-0" style="background-color:#6e007c;">
        <h5 class="modal-title w-100 text-center" id="upiWhitelistLabel">
          Add UPI ID
        </h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
      </div>

     
      <div class="modal-body">

       
        <div class="mb-3">
          <label for="txtUPI" class="form-label fw-semibold">UPI ID</label>
          <asp:TextBox ID="txtUPI" runat="server" CssClass="form-control text-lowercase"
            placeholder="example@upi" MaxLength="50"></asp:TextBox>

          <asp:RequiredFieldValidator ID="rfvUPI" runat="server"
            ControlToValidate="txtUPI"
            ErrorMessage="UPI ID is required"
            ValidationGroup="UPIGroup"
            CssClass="text-danger small" Display="Dynamic" />

         
          <asp:RegularExpressionValidator ID="revUPI" runat="server"
            ControlToValidate="txtUPI"
            ValidationGroup="UPIGroup"
            ValidationExpression="^[a-zA-Z0-9.\-_]{2,256}@[a-zA-Z]{2,64}$"
            ErrorMessage="Enter valid UPI ID (e.g., user@bank)"
            CssClass="text-danger small" Display="Dynamic" />
        </div>

        <!-- Add Button -->
        <asp:LinkButton ID="btnAddUPI" runat="server"
          CssClass="btn w-100 fw-semibold"
          Style="background-color:#6e007c; color:white;"
          Text="Add UPI"
          ValidationGroup="UPIGroup">
        </asp:LinkButton>

      </div>

    </div>
  </div>
</div>



<div class="offcanvas offcanvas-end" tabindex="-1" id="paymentSidebar"
     data-bs-backdrop="static" data-bs-keyboard="false">
  <div class="offcanvas-header text-white" style="background-color: purple;">
    <h5 class="offcanvas-title fw-semibold">Complete Your Payment</h5>
    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="offcanvas"
        onclick="document.getElementById('<%= btnCheckStatus.ClientID %>').click();">
    </button>
  </div>

  <div class="offcanvas-body text-center">
    <p class="text-muted small mb-2">
      Scan this QR code with your preferred UPI or banking app to complete the payment.<br />
        After completing the payment, please wait until the timer finishes.
    </p>

    <!-- Payment Amount Label -->
    <asp:Label ID="lblAmount" runat="server" CssClass="fw-bold fs-5 mb-3 d-block text-primary">
        Amount: ₹0.00
    </asp:Label>

    <!-- Timer display -->
    <p id="paymentTimer" class="fw-bold text-danger mb-4">01:30</p>

    <!-- Responsive image container -->
    <div class="d-flex justify-content-center mb-4">
      <asp:Image ID="paymentQrImage" runat="server"
                 CssClass="border rounded-3"
                 Style="border: 2px solid #eee; border-radius: 12px; width: 100%; max-width: 400px; height: auto;"
                 AlternateText="QR Code for Payment" />
    </div>

    <!-- Payment Done button -->
   <%-- <button type="button" class="btn btn-success w-100 fw-semibold mb-2" 
            onclick="window.location.href='TransactionDone.aspx'">
      Payment Done
    </button>--%>
      <%--<asp:LinkButton class="btn btn-success w-100 fw-semibold mb-2" runat="server" ID="btnPayment" Text="Payment Done" OnClick="btnPayment_Click"></asp:LinkButton>--%>
    
      <!-- Hidden button -->
      <asp:Button ID="btnCheckStatus" runat="server" Text="Check" 
    OnClick="btnCheckStatus_Click" Style="display:none;" />

    <!-- Close button -->
   <button type="button" class="btn btn-secondary w-100 fw-semibold" 
    data-bs-dismiss="offcanvas"
    onclick="document.getElementById('<%= btnCheckStatus.ClientID %>').click();">
  Cancel
</button>
  </div>
</div>

<div class="modal fade" id="successModal" tabindex="-1" aria-labelledby="successModalLabel" aria-hidden="true"
         data-bs-backdrop="static" data-bs-keyboard="false">
      <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content shadow-lg rounded-3 text-center">
      
          <!-- Modal Header -->
          <div class="modal-header bg-success text-white border-0">
            <%--<h5 >Transaction Successful</h5>--%>
              <asp:Label runat="server" class="modal-title w-100" id="successModalLabel">Transaction Successful</asp:Label>
            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
          </div>
      
          <!-- Modal Body -->
         <div class="modal-body text-center">
          <div>
            <img src="https://cdn-icons-png.flaticon.com/512/845/845646.png" 
                 alt="Success" width="80" height="80" class="mb-3" />
          </div>

          <div>
            <asp:Label CssClass="fw-semibold d-block" ID="lblSuccessMsg" runat="server">
              Payment Completed Successfully.
            </asp:Label>
          </div>

          <button type="button" class="btn btn-success w-100 mt-3" data-bs-dismiss="modal">OK</button>
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
            <div>
                <img src="https://cdn-icons-png.flaticon.com/512/463/463612.png"
                 alt="Error" class="mb-3" width="80" height="80" />
            </div>
            <div>
                <asp:Label runat="server" class="fw-semibold text-dark mb-3" ID="lblmsg">Payment Unsuccessfull, Try again.</asp:Label>
            </div>
            <div>
               <button type="button" class="btn btn-danger w-100" data-bs-dismiss="modal">Try Again</button>
            </div>
          </div>
        </div>
      </div>
    </div>


<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Toggle expand/collapse rows
    document.addEventListener("DOMContentLoaded", function () {
        document.querySelectorAll("#fundTable .toggle-btn").forEach(btn => {
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
    });


    document.addEventListener("DOMContentLoaded", function () {
        // Check if the query string has openSidebar=true
        const urlParams = new URLSearchParams(window.location.search);
        const openSidebar = urlParams.get('openSidebar');

        if (openSidebar === 'true') {
            const offcanvasEl = document.getElementById('addFundSidebar');
            const offcanvas = new bootstrap.Offcanvas(offcanvasEl);
            offcanvas.show();
        }
    });

</script>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        const rows = document.querySelectorAll("#fundTable tbody tr");
        const pageSize = 10;
        const paginationContainer = document.getElementById("pagination");

        const mainRows = [];
        rows.forEach((row, index) => {
            if ((index % 2) === 0) mainRows.push(row);
        });

        const pageCount = Math.ceil(mainRows.length / pageSize);

        function showPage(page) {
            let start = page * pageSize;
            let end = start + pageSize;

            rows.forEach((r) => (r.style.display = "none"));

            for (let i = start * 2; i < end * 2; i++) {
                if (rows[i]) rows[i].style.display = "";
            }

            // ✅ Update active page button styling
            document
                .querySelectorAll("#pagination button")
                .forEach((btn) => btn.classList.remove("active"));

            const activeBtn = document.getElementById("btn-" + page);
            if (activeBtn) activeBtn.classList.add("active");
        }

        function createPagination() {
            paginationContainer.innerHTML = "";

            for (let i = 0; i < pageCount; i++) {
                let btn = document.createElement("button");
                btn.innerText = i + 1;
                btn.className = "btn btn-sm btn-outline-primary";
                btn.id = "btn-" + i;

                // ✅ Prevent page refresh!
                btn.type = "button";

                btn.addEventListener("click", function (e) {
                    e.preventDefault();
                    e.stopPropagation();
                    showPage(i);
                });

                paginationContainer.appendChild(btn);
            }
        }

        createPagination();
        showPage(0);
    });
</script>



  <script>
      let timerInterval; // store interval ID globally
      let timeLeft = 90; // 1 minute 30 seconds (90 seconds)

      const paymentSidebar = document.getElementById('paymentSidebar');
      const timerDisplay = document.getElementById('paymentTimer');

      // Function to start timer
      function startPaymentTimer() {
          // Reset timer each time sidebar opens
          timeLeft = 90;
          timerDisplay.textContent = "01:30";

          clearInterval(timerInterval); // avoid multiple intervals
          timerInterval = setInterval(() => {
              const minutes = Math.floor(timeLeft / 60).toString().padStart(2, '0');
              const seconds = (timeLeft % 60).toString().padStart(2, '0');
              timerDisplay.textContent = `${minutes}:${seconds}`;

              if (timeLeft <= 0) {
                  clearInterval(timerInterval);

                  const offcanvas = bootstrap.Offcanvas.getInstance(paymentSidebar);
                  if (offcanvas) offcanvas.hide();

                  // Trigger hidden ASP.NET button
                  __doPostBack('<%= btnCheckStatus.UniqueID %>', '');
            }

            timeLeft--;
        }, 1000);
      }

      // Function to stop timer when sidebar closes
      function stopPaymentTimer() {
          clearInterval(timerInterval);
          timerDisplay.textContent = "01:30"; // reset display
      }

      // Attach event listeners for offcanvas open/close
      paymentSidebar.addEventListener('shown.bs.offcanvas', startPaymentTimer);
      paymentSidebar.addEventListener('hidden.bs.offcanvas', stopPaymentTimer);
  </script>


<script>
    function parseCustomDate(dateString) {
        // expected format: dd-MM-yyyy HH:mm:ss
        if (!dateString) return null;

        const [datePart, timePart] = dateString.split(" ");
        if (!datePart) return null;

        const [day, month, year] = datePart.split("-").map(Number);
        let hours = 0, minutes = 0, seconds = 0;

        if (timePart) {
            [hours, minutes, seconds] = timePart.split(":").map(Number);
        }

        // Construct a valid Date object
        return new Date(year, month - 1, day, hours, minutes, seconds);
    }

    function checkDate(dateString, type) {
        let rowDate = parseCustomDate(dateString);
        if (!rowDate || isNaN(rowDate)) return false;

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

        let mainRows = document.querySelectorAll("#fundTable tbody tr:not(.details-row)");

        mainRows.forEach(row => {
            let statusCell = row.querySelector(".status-cell")?.innerText.toLowerCase() || "";
            let dateCell = row.querySelector(".date-cell")?.innerText || "";

            // choose which column to filter
            let searchCellText = "";
            if (colFilter === "orderid") searchCellText = row.querySelector(".orderid")?.innerText.toLowerCase() || "";
            else if (colFilter === "amount") searchCellText = row.querySelector(".amount")?.innerText.toLowerCase() || "";
            else if (colFilter === "status") searchCellText = statusCell;
            else searchCellText = row.innerText.toLowerCase();

            let matchesDate = dateFilter ? checkDate(dateCell, dateFilter) : true;
            let matchesStatus = statusFilter ? statusCell.includes(statusFilter) : true;
            let matchesSearch = searchValue ? searchCellText.includes(searchValue) : true;

            let isMatch = matchesDate && matchesStatus && matchesSearch;

            // show/hide main row
            row.style.display = isMatch ? "" : "none";

            // also show/hide its details row
            let detailsRow = row.nextElementSibling;
            if (detailsRow && detailsRow.classList.contains("details-row")) {
                detailsRow.style.display = isMatch ? "" : "none";
            }
        });
    }

    // attach events
    ["dateFilter", "statusFilter", "columnFilter"].forEach(id => {
        document.getElementById(id).addEventListener("change", applyFilters);
    });
    document.getElementById("searchBox").addEventListener("input", applyFilters);
</script>



<script>
    function downloadTable() {
        let table = document.getElementById("fundTable");
        if (!table) {
            alert("Table not found!");
            return;
        }

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
        a.download = "AddFund.csv";
        document.body.appendChild(a);
        a.click();
        document.body.removeChild(a);
    }
</script>

</asp:Content>
