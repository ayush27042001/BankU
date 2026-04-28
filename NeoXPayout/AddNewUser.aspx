<%@ Page Title="" Language="C#" MasterPageFile="~/Neox.Master" AutoEventWireup="true" CodeBehind="AddNewUser.aspx.cs" Inherits="NeoXPayout.AddNewUser" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
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

#otpModal .modal-content {
    border-radius: 20px;
    border: none;
    box-shadow: 0px 8px 30px rgba(0, 0, 0, 0.25);
    overflow: hidden;
}

#otpModal .modal-header {
    background: linear-gradient(135deg, #6A1B9A, #9C27B0); 
    color: #fff;
    border: none;
    text-align: center;
    justify-content: center;
}

#otpModal .modal-title {
    font-weight: 600;
    font-size: 1.25rem;
    letter-spacing: 0.5px;
}

#otpModal .modal-body {
    padding: 2rem;
    background-color: #f9f9f9;
}

#otpModal .modal-footer {
    border: none;
    background-color: #f9f9f9;
    justify-content: center;
    padding-bottom: 1.5rem;
}

#otpModal .form-control {
    border-radius: 12px;
    text-align: center;
    font-size: 1.5rem;
    letter-spacing: 8px;
    font-weight: bold;
    color: #6A1B9A;
    border: 2px solid #9C27B0;
}

#otpModal .btn-primary {
    background: #6A1B9A;
    border: none;
    border-radius: 10px;
    padding: 10px 25px;
    font-weight: 500;
    transition: 0.3s;
}
#otpModal .btn-primary:hover {
    background: #9C27B0;
}

#otpModal .btn-secondary {
    border-radius: 10px;
    padding: 10px 25px;
}
</style>
<style>
    @media print {
        .no-print {
            display: none !important;
        }
    }
.send-otp-btn {
    float: right;            
    font-weight: 600;         
    text-decoration: none !important;
    color: #800080;         
    cursor: pointer;          
    margin-top: 8px;         
}


.send-otp-btn:hover {
    text-decoration: none;
    color: #0056b3; 
}
.data-view {
  background: #fff;
  border-radius: 12px;
  box-shadow: 0px 4px 12px rgba(0,0,0,0.1);
  padding: 20px;
}

.data-view h2 {
  background: linear-gradient(90deg, #800080, #800080);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  font-size: 24px;
  margin-bottom: 15px;
}

table {
  width: 100%;
  border-collapse: collapse;
  overflow: hidden;
  border-radius: 10px;
}

thead {
  background:#800080;
  color: #fff;
}

thead th {
  padding: 12px;
  text-align: left;
}

tbody tr:nth-child(even) {
  background: #f9f9f9;
}

tbody td {
  padding: 12px;
  border-bottom: 1px solid #ddd;
}

.status {
  padding: 5px 10px;
  border-radius: 20px;
  font-size: 12px;
  font-weight: bold;
}

.status.active {
  background: #28a745;
  color: #fff;
}

.status.inactive {
  background: #dc3545;
  color: #fff;
}

.custom-tab {
        background: linear-gradient(135deg, #4e73df, #1cc88a);
        color: #fff !important;
        border-radius: 25px;
        padding: 8px 18px;
        font-weight: 500;
        box-shadow: 0 3px 6px rgba(0, 0, 0, 0.1);
        transition: all 0.3s ease;
    }
    .custom-tab:hover {
        background: linear-gradient(135deg, #1cc88a, #4e73df);
        transform: translateY(-2px);
        box-shadow: 0 6px 12px rgba(0, 0, 0, 0.15);
    }
    .custom-tab.active {
        background: #1cc88a !important;
        color: #fff !important;
    }
 .banku-modal {
    border-radius: 18px;
    background: #ffffff;
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
}

/* Header */
.banku-modal .modal-title {
    font-size: 1.1rem;
}

/* Referral box */
.ref-box {
    display: flex;
    align-items: center;
    background: #f4f6f9;
    border-radius: 12px;
    padding: 6px 8px;
}

.ref-box .form-control {
    font-size: 0.9rem;
    padding-left: 8px;
}

/* Copy button inside box */
.copy-btn {
    background: #800080;
    color: #fff;
    border: none;
    padding: 6px 14px;
    border-radius: 8px;
    font-size: 0.8rem;
    transition: 0.2s ease;
}

.copy-btn:hover {
    background:#c219c2;
}

/* Primary button */
.btn-banku-primary {
    background: #800080;
    color: #fff;
    border: none;
    border-radius: 10px;
    height: 44px;
    font-weight: 500;
    transition: 0.2s ease;
}

.btn-banku-primary:hover {
    background:#c219c2;
}

/* Secondary button */
.btn-light {
    border-radius: 10px;
    height: 44px;
    font-size: 0.9rem;
}

/* Smooth animation */
.modal-content {
    animation: bankuFade 0.25s ease;
}

@keyframes bankuFade {
    from {
        transform: translateY(20px);
        opacity: 0;
    }
    to {
        transform: translateY(0);
        opacity: 1;
    }
}
.toast-msg {
    position: fixed;
    bottom: 20px;
    left: 50%;
    transform: translateX(-50%);
    background: #b01cad;
    color: #fff;
    padding: 10px 18px;
    border-radius: 20px;
    font-size: 0.85rem;
    z-index: 9999;
}
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
              <hr />
       <div class="px-xl-6 px-lg-6  px-3 py-3 page-body">
                    <div class="row">
                         <div class="col-md-6 col-lg-12 col-xl-12">
                              <div class="card ">
                                   <div class="card-header border-bottom pb-0 bg-light shadow-sm rounded-top">
                                        <!--=== tab buttons ===-->
                                       <ul class="nav nav-pills justify-content-between mb-2 px-2" style="overflow-x:auto; white-space:nowrap; gap:10px;">

                                        <li class="nav-item">
                                            <asp:LinkButton runat="server" ID="btnElectricity" CommandArgument="CreditCard"
                                                CssClass="nav-link custom-tab">Add New User</asp:LinkButton>
                                        </li>

                                        <!-- Referral Button -->
                                        <li class="nav-item ms-auto">
                                            <asp:LinkButton ID="btnReferral" runat="server"
                                                CssClass="btn btn-success"
                                                OnClientClick="openReferralModal(); return false;">
                                                <i class="bi bi-share-fill"></i> Referral
                                            </asp:LinkButton>
                                        </li>

                                    </ul>
                                    </div>
                                   <div class="card-body ">
                                        <div class="tab-content" id="pills-tabContent">

                                             <div class="tab-pane fade show active" id="pills-home" role="tabpanel"
                                                  aria-labelledby="pills-home-tab" tabindex="0">
                                              
                                                  <div class="table-responsive custom_scroll">
                                                       
                                                    <div class="card-body card-main-one">
                                                        <div class="row">
                                                            <div class="mb-2 col-md-12 col-12">
                                                                <label class="col-form-label">Mobile Number</label>
                                                                <fieldset class="form-icon-group left-icon position-relative">
                                                                    <asp:TextBox ID="txtMobile" MaxLength="10" onkeypress="return event.charCode >= 48 && event.charCode <= 57" CssClass="form-control" runat="server"></asp:TextBox>
                                                                    <div class="form-icon">
                                                                        <i class="bi bi-phone"></i>
                                                                    </div>
                                                                </fieldset>

                                                                <!-- Required Field Validator -->
                                                                <asp:RequiredFieldValidator ID="rfvMobile" runat="server" ControlToValidate="txtMobile"
                                                                    ErrorMessage="Mobile Number is required."
                                                                    ForeColor="Red"
                                                                    Display="Dynamic"
                                                                    SetFocusOnError="True" />

                                                                <!-- Regular Expression Validator for Numbers only -->
                                                                <asp:RegularExpressionValidator ID="revMobile" runat="server" ControlToValidate="txtMobile"
                                                                    ErrorMessage="Enter a valid 10-digit mobile number."
                                                                    ForeColor="Red"
                                                                    Display="Dynamic"
                                                                    SetFocusOnError="True"
                                                                    ValidationExpression="^\d{10}$" />
                                                            </div>
                                                            <!-- Send OTP LinkButton -->
                                                             <div class="mb-2 col-md-12 col-12">                                                      
                                                                <asp:LinkButton ID="lnkSendOtp" runat="server" CssClass="send-otp-btn" 
                                                                    OnClick="lnkSendOtp_Click">Send OTP</asp:LinkButton>
                                                            </div>
                                                            </div>
                                                                                                                             <!-- OTP Modal Popup -->
                                                            <!-- OTP Modal Popup -->
                                                            <div class="modal fade" id="otpModal" tabindex="-1"  data-bs-backdrop="static"
     data-bs-keyboard="false" aria-labelledby="otpModalLabel" aria-hidden="true">
                                                              <div class="modal-dialog modal-dialog-centered">
                                                                <div class="modal-content">

                                                                  <!-- Header -->
                                                                  <div class="modal-header">
                                                                    <h5 class="modal-title" id="otpModalLabel">
                                                                      <i class="bi bi-shield-lock-fill me-2"></i> Verify OTP
                                                                    </h5>
                                                                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                                                                  </div>

                                                                  <!-- Body -->
                                                                  <div class="modal-body text-center">
                                                                    <asp:Panel ID="pnlOtpSection" runat="server" Visible="false">
                                                                      <div class="mb-3">
                                                                        <label class="col-form-label fw-bold">Enter the OTP sent to your Mobile</label>
                                                                        <fieldset class="form-icon-group left-icon position-relative d-flex justify-content-center">
                                                                          <asp:TextBox ID="txtOTP" MaxLength="4" CssClass="form-control w-50 text-center"
                                                                            onkeypress="return event.charCode >= 48 && event.charCode <= 57" runat="server"></asp:TextBox>
                                                                        </fieldset>

                                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtOTP"
                                                                            ErrorMessage="OTP is Required." ForeColor="Red" Display="Dynamic" SetFocusOnError="True" />

                                                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtOTP"
                                                                            ErrorMessage="Enter a valid OTP." ForeColor="Red" Display="Dynamic" SetFocusOnError="True"
                                                                            ValidationExpression="^\d{4}$" />
                                                                      </div>
                                                                    </asp:Panel>
                                                                  </div>

                                                                  <!-- Footer -->
                                                                  <div class="modal-footer">
                                                                    <asp:LinkButton ID="btnSubmitOtp" runat="server" CssClass="btn btn-primary px-4" OnClick="LinkButton1_Click">
                                                                      Submit OTP
                                                                    </asp:LinkButton>
                                                                    <button type="button" class="btn btn-secondary px-4" data-bs-dismiss="modal">Close</button>
                                                                  </div>

                                                                </div>
                                                              </div>
                                                            </div>

                                                            <!-- Submit Buttons -->
                                                            <div class="col-12">
                                                                
                                                                  <%--<asp:LinkButton ID="LinkButton1" runat="server" CssClass="btn btn-primary" onclick="LinkButton1_Click">ADD</asp:LinkButton>
                                                                <a href="AddNewUser.aspx" class="btn btn-outline-secondary">Cancel</a>--%>
                                                                <br />
                                                                <asp:Label ID="Label2" runat="server" Font-Bold="True" ForeColor="Green"></asp:Label>
                                                                <asp:Label ID="Label1" runat="server" Font-Bold="True" ForeColor="Red"></asp:Label>
                                                            </div>

                                                        </div>
                                                    </div>
                                                </div>       
                                             </div>
                                           
                                        </div>
                                   </div>
                              </div>
                         </div>
                    </div>
    <div class="data-view">
  <h2>View User</h2>
  <table>
    <thead>
      <tr>
       <%-- <th>S No.</th>--%>
        <th>Mobile</th>
        <th>Full Name</th>
        <th>Email</th>
          <th>Pan No.</th>
          <th>Aadhar No.</th>
        <th>Status</th>
      </tr>
    </thead>
    <tbody>
    <asp:Repeater runat="server" ID="rptProduct">
        <ItemTemplate>
        <tr>
            <%--<td></td>--%>
            <td><%# Eval("MobileNo") %></td>
            <td><%# Eval("FullName") %></td>
            <td><%# Eval("Email") %></td>
            <td><%# Eval("PanNo") %></td>
            <td><%# Eval("AadharNo") %></td>
            <td><%# Eval("Status") %></td>
        </tr>
        </ItemTemplate>
    </asp:Repeater>
    </tbody>
  </table>
</div>
  <div class="modal fade" id="referralModal" tabindex="-1"  data-bs-backdrop="static"
     data-bs-keyboard="false">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content banku-modal border-0">

            <!-- Header -->
            <div class="modal-header border-0">
                <div>
                    <h5 class="modal-title fw-semibold mb-0">
                       Add User Using Link
                    </h5>
                    <small class="text-muted">Share your referral link</small>
                </div>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>

            <!-- Body -->
            <div class="modal-body px-4 pb-4">

                <!-- Referral Box -->
                <div class="ref-box mb-3">
                    <asp:TextBox ID="txtReferralLink" runat="server"
                        CssClass="form-control border-0 bg-transparent fw-semibold"
                        ReadOnly="true"></asp:TextBox>

                    <button class="copy-btn" onclick="copyReferral()" type="button">
                        Copy
                    </button>
                </div>

                <!-- Primary Action -->
                <button class="btn btn-banku-primary w-100 mb-2" type="button"
                        onclick="shareWhatsApp()">
                    Share via WhatsApp
                </button>

                <!-- Secondary Action -->
                <button class="btn btn-light w-100 border" type="button"
                        onclick="copyReferral()">
                    Copy Link
                </button>

            </div>

        </div>
    </div>
</div>
<script>
    function openReferralModal() {
        var modal = new bootstrap.Modal(document.getElementById('referralModal'));
        modal.show();
    }

    function copyReferral() {
        var copyText = document.getElementById('<%= txtReferralLink.ClientID %>');
       copyText.select();
       document.execCommand("copy");

       // BankU style feedback
       document.body.insertAdjacentHTML("beforeend",
           `<div class="toast-msg">Copied ✔</div>`);

       setTimeout(() => {
           document.querySelector(".toast-msg").remove();
       }, 2000);
   }


    function shareWhatsApp() {
        var link = document.getElementById('<%= txtReferralLink.ClientID %>').value;
        var message = "Join using my referral link: " + link;
        window.open("https://wa.me/?text=" + encodeURIComponent(message), "_blank");
    }
</script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
</asp:Content>
