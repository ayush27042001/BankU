<%@ Page Title="" Language="C#" MasterPageFile="~/Neox.Master" AutoEventWireup="true" CodeBehind="DMT.aspx.cs" Inherits="NeoXPayout.DMT" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        body {
    background-color: #f8f9fa;
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
  display: none; /* scrollbar hide */
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
/* Method buttons */
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

/* Mode buttons */
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

.form-label {
        font-size: 15px;
        margin-bottom: 6px; /* label और textbox के बीच gap */
        display: inline-block;
        font-weight:bold;
        color:#6e007c;
    }

body{margin:0;background:#f1f5f9;font-family:system-ui}
  .wrap{
    display:flex;gap:8px;max-width:520px;
    background:#fff;border:1px solid #e5e7eb;border-radius:16px;
    padding:6px;box-shadow:0 6px 18px rgba(0,0,0,.06)
  }
  .txt{
    flex:1;border:none;outline:none;
    padding:14px 12px;font:16px system-ui
  }
  .btn{
    border:0;border-radius:12px;padding:12px 16px;cursor:pointer;
    background:linear-gradient(100.57deg, #3006A4 12.93%, #FFA37B 121.02%) !important;color:#fff;font-weight:600
  }
  .btn:hover{background:#1d4ed8; color:white}


  .side-left{margin-left:0;margin-right:auto}
  @media (max-width:520px){.wrap{flex-direction:column}}

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
        color: #0d6efd; /* Blue text */
        font-weight: 600;
        border-bottom: 2px solid #0d6efd; /* Blue underline */
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
        border-bottom: 1px solid #eee; /* optional separator */
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
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true" />
<asp:Panel runat="server" ID="pnlMain">
    <div class="container py-4">

<div class="d-flex align-items-center overflow-hidden mb-3" style="gap:8px;">
    <div class="tab-scroll flex-grow-1">
        <div class="container py-4">
            <div class="wrap side-left d-flex" style="margin-top:-20px; gap:8px;">
                
                <!-- Mobile Number Textbox -->
                <asp:TextBox ID="txtmobileno" runat="server" class="txt" placeholder="Enter number" ForeColor="Red"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="RequiredFieldValidator" Text="Enter Mobile No." ControlToValidate="txtmobileno"></asp:RequiredFieldValidator>
                <%--<asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="RegularExpressionValidator" Text="Enter Monile No." ControlToValidate="txtmobileno"></asp:RegularExpressionValidator>--%>
                
                <asp:LinkButton ID="LinkButton1" runat="server" 
                    class="btn btn-primary" OnClick="LinkButton1_Click">
                    Verify Number
                </asp:LinkButton>
            </div>

            <div>
                <asp:Label ID="lblName" runat="server" ForeColor="Green" Font-Bold="true"></asp:Label>
            </div>
        </div>
    </div>
     <asp:LinkButton ID="LinkButton4" runat="server" 
                    class="btn btn-primary" 
                    data-bs-toggle="offcanvas" 
                    data-bs-target="#singlePayoutSidebar1" style="margin-top:-20px">
                    Add Beneficiary
                </asp:LinkButton>
</div>
  
            <!-- Table -->
        <asp:Label ID="labelerror" runat="server" cssclass="text-danger"></asp:Label>
        <asp:Label ID="lblRequest" runat="server" ></asp:Label>
        <asp:Label ID="lblResponse" runat="server" ></asp:Label>
            <div class="table-responsive">
    <table class="table table-bordered align-middle shadow">
        <thead class="table-light">
            <tr>
                <th>ID</th>
                <th style="font-size:14px">Name</th>
                <th style="font-size:14px">Account No</th>
                <th style="font-size:14px">Ifsc Code</th>
                <th style="font-size:14px">Bank Name</th>
                <th style="font-size:14px">TXN Mode</th>
                 <th style="font-size:14px">Action</th>
            </tr>
        </thead>
        <tbody>
            <asp:Repeater runat="server" ID="Repeater1">
                <ItemTemplate>
                    <tr>
                        <td><%# Container.ItemIndex + 1 %></td>
                        <td style="font-size:14px"><%# Eval("BeneName") %></td>
                        <td style="display:none;"><%# Eval("BeneId") %></td>
                        <td style="font-size:14px"><%# Eval("AccountNo") %></td>
                        <td style="font-size:14px"><%# Eval("IFSCCode") %></td>
                        <td style="font-size:14px"><%# Eval("BeneBank") %></td>
                        <td style="font-size:14px"><%# Eval("TransferMode") %></td>
                        <td>
                            <button type="button" class="btn btn-success btn-sm" 
                                    onclick="openPayPopup('<%# Eval("BeneName") %>', '<%# Eval("AccountNo") %>', '<%# Eval("IFSCCode") %>', '<%# Eval("BeneBank") %>','<%# Eval("BeneId") %>')">
                                Pay Now
                            </button>
                        </td>
                    </tr>
                </ItemTemplate>
            </asp:Repeater>
        </tbody>
    </table>
</div>
        </div>
    <!-- Offcanvas Sidebar -->
    <!-- Offcanvas (Sender Form) -->
    <div class="offcanvas offcanvas-end" tabindex="-1" id="singlePayoutSidebar" data-bs-backdrop="static" data-bs-keyboard="false">
        <div class="offcanvas-header">
            <h5 class="offcanvas-title">Add Sender</h5>
            <button type="button" class="btn-close" data-bs-dismiss="offcanvas"></button>
        </div>
        <div class="offcanvas-body">
            <!-- Sender Name -->
            <div class="mb-3">
                <asp:Label ID="Label1" runat="server" CssClass="form-label">Sender Name:</asp:Label>
                <asp:TextBox ID="txtname" runat="server" CssClass="form-control" placeholder="Sender Name"></asp:TextBox>
            </div>

            <!-- Mobile Number -->
            <div class="mb-3">
                <asp:Label ID="Label2" runat="server" CssClass="form-label">Mobile Number:</asp:Label>
                <asp:TextBox ID="txtmobile" runat="server" CssClass="form-control" placeholder="Mobile Number"></asp:TextBox>
            </div>

            <!-- Gender -->
            <div class="mb-3">
                <asp:Label ID="Label3" runat="server" CssClass="form-label">Select Gender:</asp:Label>
                <asp:DropDownList ID="ddlgender" runat="server" CssClass="form-control">
                    <asp:ListItem>Male</asp:ListItem>
                    <asp:ListItem>Female</asp:ListItem>
                </asp:DropDownList>
            </div>

            <!-- Add Sender Button -->
            <asp:LinkButton ID="LinkButton2" runat="server" CssClass="btn btn-primary w-100" 
                OnClick="LinkButton2_Click" >Add Sender</asp:LinkButton>
        </div>
    </div>

    <asp:HiddenField ID="hdnSenderId" runat="server" />

    <!-- PayNow Modal -->
    <div class="modal fade" id="payNowModal" tabindex="-1" aria-hidden="true"  data-bs-backdrop="static" 
         data-bs-keyboard="false">
      <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content p-3 rounded-3 shadow-lg">
          <div class="modal-header">
            <h5 class="modal-title">Make Payment</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
          </div>

          <div class="modal-body">
            <p><b>Bene Name:</b> <span id="popupBeneName"></span></p>
            <p><b>Account No:</b> <span id="popupAccountNo"></span></p>
            <p><b>IFSC Code:</b> <span id="popupIFSC"></span></p>
        
            <asp:HiddenField ID="txtBeneficiaryId" runat="server" />
            <p><b>Bank:</b> <span id="popupBank"></span></p>
              <div class="mb-3">
              <label class="form-label">Transfer Mode</label>
                  <asp:DropDownList ID="ddlTransferType" runat="server" CssClass="form-control">
                      <asp:ListItem>IMPS</asp:ListItem>
                      <asp:ListItem>RTGS</asp:ListItem>
                      <asp:ListItem>RTGS</asp:ListItem>
                  </asp:DropDownList>
         
            </div>
            <div class="mb-3">
              <label class="form-label">Enter Amount</label>
              <asp:TextBox ID="txtAmount" runat="server" CssClass="form-control" placeholder="Enter Amount"></asp:TextBox>
            </div>

            <div class="mb-3">
              <label class="form-label">Txn Pin</label>
              <asp:TextBox ID="txtTxnPin" runat="server" CssClass="form-control" placeholder="Enter transaction pin" type="password"></asp:TextBox>
            </div>
          </div>

          <div class="modal-footer">
              <asp:LinkButton ID="LinkButton6" runat="server" class="btn btn-primary w-100" OnClick="LinkButton6_Click">Pay Now</asp:LinkButton>
          </div>
        </div>
      </div>
    </div>

    <!-- OTP Modal -->
    <div class="modal fade" id="otpModal" tabindex="-1" aria-labelledby="otpModalLabel" aria-hidden="true" 
         data-bs-backdrop="static" data-bs-keyboard="false">
      <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content shadow-lg rounded-3">
          <div class="modal-header bg-primary text-white">
            <h5 class="modal-title" id="otpModalLabel">OTP Verification</h5>
            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
          </div>
          <div class="modal-body">
            <!-- OTP Section -->
            <asp:Label ID="LabelOtp" runat="server" CssClass="form-label fw-semibold">Enter OTP:</asp:Label>
            <asp:TextBox ID="txtOtp" runat="server" CssClass="form-control mb-3" placeholder="Enter OTP"></asp:TextBox>
            <asp:LinkButton ID="LinkButton3" runat="server" CssClass="btn btn-success w-100" 
                OnClick="LinkButton3_Click">Verify OTP</asp:LinkButton>
            <asp:HiddenField ID="HiddenField1" runat="server" />
          </div>
        </div>
      </div>
    </div>


    <!-- Transaction Success Modal -->
    <div class="modal fade" id="successModal" tabindex="-1" aria-labelledby="successModalLabel" aria-hidden="true"
         data-bs-backdrop="static" data-bs-keyboard="false">
      <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content shadow-lg rounded-3 text-center">
      
          <!-- Modal Header -->
          <div class="modal-header bg-success text-white border-0">
            <h5 class="modal-title w-100" id="successModalLabel">Transaction Successful</h5>
            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
          </div>
      
          <!-- Modal Body -->
          <div class="modal-body">
            <img src="https://cdn-icons-png.flaticon.com/512/845/845646.png" 
                 alt="Success" class="mb-3" width="80" height="80" />
            <h6 class="fw-semibold">Your transaction has been completed successfully!</h6>
            <%--<p class="text-muted mb-4">Reference ID: <span id="lblTxnId">#123456</span></p>--%>
            <button type="button" class="btn btn-success w-100" data-bs-dismiss="modal">OK</button>
          </div>
      
        </div>
      </div>
    </div>


    <!-- Dynamic Message Modal -->
    <div class="modal fade" id="messageModal" tabindex="-1" aria-labelledby="messageModalLabel" aria-hidden="true"
         data-bs-backdrop="static" data-bs-keyboard="false">
      <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content shadow-lg rounded-3 text-center">
      
          <!-- Header -->
          <div class="modal-header bg-primary text-white border-0">
            <h5 class="modal-title w-100" id="messageModalLabel">Message</h5>
          </div>
      
          <!-- Body -->
          <div class="modal-body">
            <asp:Label ID="lblMessage" runat="server" CssClass="fw-semibold d-block mb-3"></asp:Label>
            <button type="button" class="btn btn-primary w-100" data-bs-dismiss="modal">OK</button>
          </div>
      
        </div>
      </div>
    </div>


    <!-- Offcanvas Sidebar -->
    <div class="offcanvas offcanvas-end" tabindex="-1" id="singlePayoutSidebar1" aria-labelledby="sidebarLabel" data-bs-backdrop="static" 
         data-bs-keyboard="false">
      <div class="offcanvas-header">
        <h5 id="sidebarLabel">Add Beneficiary</h5>
        <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
      </div>
      <div class="offcanvas-body">
          <div class="mb-3">
            <label for="beneficiaryName" class="form-label">Sender Mobile</label>
            <asp:TextBox ID="txtsendermobile" runat="server" class="form-control" placeholder="Sender Mobile"></asp:TextBox>
          </div>
          <div class="mb-3">
            <label for="beneficiaryName" class="form-label">Beneficiary Mobile No.</label>
            <asp:TextBox ID="txtbenemobile" runat="server" class="form-control" placeholder="Beneficiary Mobile No."></asp:TextBox>
          </div>
          <div class="mb-3">
            <label for="beneficiaryName" class="form-label">Beneficiary Name</label>
            <asp:TextBox ID="txtbenename" runat="server" class="form-control" placeholder="Enter Beneficiary Name"></asp:TextBox>
          </div>
          <div class="mb-3">
            <label for="accountNo" class="form-label">Account Number</label>
              <asp:TextBox ID="txtaccountno" runat="server" class="form-control" placeholder="Enter Account Number"></asp:TextBox>
          </div>
          <div class="mb-3">
            <label for="ifscCode" class="form-label">IFSC Code</label>
            <asp:TextBox ID="txtifsccode" runat="server" class="form-control" placeholder="Enter IFSC Code"></asp:TextBox>
          </div>
      
          <div class="mb-3">
            <label for="bankName" class="form-label">Bank Name</label>
            <asp:TextBox ID="txtbankname" runat="server" class="form-control" placeholder="Enter Bank Name"></asp:TextBox>
          </div>

          <div class="mb-3">
            <label for="bankName" class="form-label">Transfer Mode</label>
              <asp:DropDownList ID="ddltransfermode" runat="server" class="form-control">
                  <asp:ListItem>IMPS</asp:ListItem>
                  <asp:ListItem>RTGS</asp:ListItem>
                  <asp:ListItem>NEFT</asp:ListItem>
              </asp:DropDownList>
       
          </div>
          <asp:LinkButton ID="LinkButton5" runat="server" class="btn btn-success w-100" OnClick="LinkButton5_Click">Add Beneficiary</asp:LinkButton>
      </div>
    </div>
</asp:panel>

<asp:Panel ID="pnlError" runat="server" Visible="false" CssClass="text-center mt-5">
<div class="d-flex justify-content-center mt-5">
  <div class="alert alert-danger rounded-4 shadow-lg p-4" role="alert" style="max-width:700px">
    <h2 class="fw-bold text-danger mb-3">
      <i class="fa fa-exclamation-triangle"></i> Service Unavailable
    </h2>
    <p class="fs-5">
      The DMT Service is currently down for maintenance or technical issues.  
      Please try again later.
    </p>
    <a href="Dashboard.aspx" class="btn btn-secondary mt-3">Back to Dashboard</a>
  </div>
</div>
</asp:Panel>


    <script>
        function openPayPopup(name, account, ifsc, bank,beneid) {
            document.getElementById("popupBeneName").innerText = name;
            document.getElementById("popupAccountNo").innerText = account;
            document.getElementById("popupIFSC").innerText = ifsc;
            document.getElementById("popupBank").innerText = bank;
            document.getElementById('<%= txtBeneficiaryId.ClientID %>').value = beneid;  // ✅ ASP.NET control ke liye
            var myModal = new bootstrap.Modal(document.getElementById('payNowModal'));
            myModal.show();
        }
    </script>


    <script type="text/javascript">
        function keepSidebarOpen() {
            setTimeout(function () {
                var sidebarEl = document.getElementById('singlePayoutSidebar');
                var bsOffcanvas = bootstrap.Offcanvas.getOrCreateInstance(sidebarEl);
                bsOffcanvas.show();
            }, 200);
            return true; // backend code bhi chalega
        }
    </script>
    <%--<script>
        function showOtpBox() {
            document.getElementById("otpBox").style.display = "block";
        }
    </script>--%>
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

    <%--<script>
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
    </script>--%>

    <script>
        function openSidebar() {
            var myOffcanvas = document.getElementById('singlePayoutSidebar');
            var bsOffcanvas = new bootstrap.Offcanvas(myOffcanvas);
            bsOffcanvas.show();
        }
    </script>

    <script>
        function validateAadhaar(input) {
            input.value = input.value.replace(/[^0-9]/g, ''); // only numbers
            if (input.value.length > 12) {
                input.value = input.value.substring(0, 12); // max 12 digits
            }
        }
    </script>

    <script>
        function copyMobileToSidebar() {
            var source = document.getElementById("<%= txtmobileno.ClientID %>").value;
        var target = document.getElementById("<%= txtmobile.ClientID %>");
            target.value = source;
        }
    </script>

    <script>
        function openSidebar1() {
            document.getElementById("beneficiarySidebar").style.width = "350px";
        }
        function closeSidebar() {
            document.getElementById("beneficiarySidebar").style.width = "0";
        }
    </script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</asp:Content>