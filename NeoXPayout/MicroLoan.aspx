<%@ Page Title="" Language="C#" MasterPageFile="~/Neox.Master" AutoEventWireup="true" CodeBehind="MicroLoan.aspx.cs" Inherits="NeoXPayout.MicroLoan" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600&display=swap" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
  <style>
    :root {
      --purple: #6e007c;
      --bg: #f9fafb;
      --text-dark: #1f2937;
      --text-light: #6b7280;
      --card-bg: #ffffff;
    }

    * {
      box-sizing: border-box;
      margin: 0;
      padding: 0;
      font-family: 'Inter', sans-serif;
    }

    /* Header */
    .bnk-main-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin: 20px 0;
      padding: 20px;
      background-color: var(--card-bg);
      border-radius: 16px;
      box-shadow: 0 4px 12px rgba(0,0,0,0.05);
    }

    .bnk-left-header {
      display: flex;
      align-items: center;
      gap: 20px;
    }

    .bnk-left-header h2 {
      font-size: 1.5rem;
      font-weight: 600;
      color: var(--text-dark);
    }

    .bnk-dropdown select {
      padding: 10px 14px;
      border-radius: 10px;
      border: 1px solid #e5e7eb;
      font-size: 14px;
      background-color: white;
      cursor: pointer;
    }

    .bnk-right-header {
      display: flex;
      gap: 10px;
    }

    .bnk-outline-btn {
      display: flex;
      align-items: center;
      gap: 6px;
      padding: 10px 14px;
      border: 1px solid #d1d5db;
      border-radius: 10px;
      background-color: white;
      color: var(--text-dark);
      font-size: 14px;
      cursor: pointer;
      transition: all 0.2s ease-in-out;
    }

    .bnk-outline-btn:hover {
      background-color: #f3f4f6;
    }

    .bnk-primary-btn {
      padding: 10px 16px;
      background-color: var(--purple);
      color: white;
      border: none;
      border-radius: 10px;
      font-weight: 600;
      cursor: pointer;
      font-size: 14px;
      transition: all 0.2s ease-in-out;
    }

    .bnk-primary-btn:hover {
      background-color: #6e007c;
    }

    /* Card Grid */
    .bnk-card-grid {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(260px, 1fr));
      gap: 24px;
      margin-top: 4px;
    }

    .bnk-card {
      background: var(--card-bg);
      border-radius: 16px;
      padding: 24px;
      box-shadow: 0 4px 14px rgba(0,0,0,0.05);
      display: flex;
      flex-direction: column;
      gap: 14px;
      transition: all 0.3s ease;
    }

    .bnk-card:hover {
      transform: translateY(-4px);
      box-shadow: 0 6px 18px rgba(0,0,0,0.08);
    }

    .bnk-card-icon {
      background-color: #ede9fe;
      color: var(--purple);
      border-radius: 10px;
      width: 44px;
      height: 44px;
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 20px;
    }

    .bnk-card-title {
      font-size: 1.1rem;
      font-weight: 600;
      color: var(--text-dark);
    }

    .bnk-card-desc {
      font-size: 0.9rem;
      color: var(--text-light);
    }

    .bnk-activate-btn {
      align-self: flex-end;
      background-color: var(--purple);
      color: white;
      border: none;
      padding: 8px 16px;
      border-radius: 8px;
      font-size: 14px;
      cursor: pointer;
      transition: background 0.2s ease;
    }

    .bnk-activate-btn:hover {
      background-color: #6e007c;
    }
  
    .bnk-sidebar {
      position: fixed;
      top: 120px;
      right: -420px;
      width: 360px;
      height: calc(100% - 80px);
      background-color: #ffffff;
      box-shadow: -2px 0 16px rgba(0, 0, 0, 0.1);
      transition: right 0.3s ease-in-out;
      padding: 24px;
      z-index: 999;
      overflow-y: auto;
      border-radius: 16px 0 0 16px;
    }

    .bnk-sidebar.active {
      right: 0; 
    }
   
    .bnk-sidebar h3 {
      margin-bottom: 10px;
      color: var(--purple);
      font-size: 1.2rem;
    }

    .bnk-close-btn {
      position: absolute;
      top: 16px;
      right: 20px;
      background: none;
      border: none;
      font-size: 22px;
      cursor: pointer;
      color: var(--text-dark);
    }

    .bnk-alert-box {
      background-color: #eef2ff;
      border-left: 4px solid var(--purple);
      padding: 10px 12px;
      border-radius: 8px;
      margin-bottom: 20px;
      font-size: 14px;
      color: #333;
    }

    label {
      font-weight: 600;
      margin-bottom: 6px;
      display: block;
      font-size: 14px;
    }

    input, textarea {
      width: 100%;
      padding: 10px;
      margin-bottom: 16px;
      border: 1px solid #d1d5db;
      border-radius: 8px;
      font-size: 14px;
    }

    .bnk-sidebar-footer {
      margin-top: 20px;
    }

    .bnk-sidebar-footer button {
      width: 100%;
      padding: 12px;
      background-color: var(--purple);
      color: white;
      border: none;
      border-radius: 10px;
      cursor: pointer;
      font-size: 15px;
      font-weight: 600;
    }

    .bnk-sidebar-footer a {
      color: var(--purple);
      text-decoration: underline;
      display: block;
      margin-top: 12px;
      text-align: center;
      font-size: 14px;
    }
    .request-btn {
    background-color: orange;
    color: white;
    padding: 8px 16px;
    border-radius: 6px;
    border: none;
    font-weight: bold;
    cursor: pointer;
}

.request-btn:disabled {
    opacity: 0.8;
    cursor: not-allowed;
}
     .spinner {
  display: inline-block;
  animation: spin-stop 3s ease-in-out infinite;
}

@keyframes spin-stop {
  0%   { transform: rotate(0deg); }
  45%  { transform: rotate(180deg); }
  55%  { transform: rotate(180deg); } /* pause */
  100% { transform: rotate(360deg); }
}
  </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<br> 
 <asp:Label runat="server" ID="lblError" style="margin-left:10px"></asp:Label>
<div class="bnk-card-grid" style="margin:10px">

  <div class="bnk-card">
    <div class="bnk-card-icon">💰</div>

    <div class="bnk-card-title">Loan Services Activation Request</div>

    <div class="bnk-card-desc">
      BankU Seva Kendra retailers can submit this request to activate Loan Services on their portal.
      Once activated, retailers will be able to access loan products offered by BankU Seva Kendra’s
      authorized Bank / NBFC / Lending Partners.
    </div>

    <ul style="font-size: 0.9rem; color: var(--text-light); padding-left: 18px;">
      <li><strong>Unsecured Laghu Loan:</strong> ₹1,000 – ₹50,000</li>
      <li><strong>Unsecured Business Loan:</strong> ₹50,000 & above</li>
      <li>Quick & Paperless Loan Processing</li>
      <li>Secure & Transparent Lending Process</li>
      <li>Access to Loan Dashboard & Tools</li>
    </ul>

    <div class="bnk-card-desc mt-2">
      <strong>Commission:</strong><br />
      Commission ranges between <strong>1% to 2%</strong> of the disbursed loan amount.
      The exact commission will be determined by the respective Bank / NBFC / Lending Partner.
      Earnings are credited <strong>every Saturday</strong> after successful loan disbursement.
    </div>

    <hr />

    <div class="bnk-card-desc">
      <strong>Activation Charges (One-Time, Non-Refundable):</strong><br />
      Activation Fee: ₹2,100.00<br />
      GST (18%): ₹378.00<br />
      <strong>Total Payable: ₹2,478.00</strong>
    </div>

    <div class="bnk-card-desc mt-2">
      <strong>Important Notice:</strong>
      <ul style="padding-left: 18px; margin-top: 6px;">
        <li>This is a one-time, non-refundable setup fee</li>
        <li>Fee is charged only for loan service activation & processing</li>
        <li>Payment does not guarantee loan approval or disbursement</li>
      </ul>
    </div>

    <div class="bnk-card-desc">
      <strong>Purpose of Activation Fee:</strong>
      <ul style="padding-left: 18px; margin-top: 6px;">
        <li>Retailer profile verification</li>
        <li>KYC & compliance checks</li>
        <li>Onboarding with lending partners</li>
        <li>Technical setup & system enablement</li>
      </ul>
    </div>

    <div class="bnk-card-desc">
      <strong>Processing Timeline:</strong><br />
      🕒 Loan services activation is usually completed within
      <strong>3–7 working days</strong> after successful payment and verification.
    </div>


    <asp:Button 
      ID="btnActivate" 
      runat="server" 
      CssClass="bnk-activate-btn" 
      Text="Proceed to Payment" 
      OnClientClick="openSidebar('Loan Services Activation'); return false;" />
  </div>

</div>


<div class="bnk-sidebar" id="sidebar1" >
  <button class="bnk-close-btn" type="button" onclick="closeSidebar()">&times;</button>
  <h3 id="bnk-sidebar-title"></h3>
  <p style="margin-bottom: 10px; color: #555;">
    Activate Micro Loan services and provide customers an easy, reliable way to access small-ticket loans instantly.
  </p>

  <div class="bnk-alert-box">
    <strong>⚠️ Attention!</strong><br>
    ₹ 2,100 + 18% GST <br /> <b> Sub Total:- </b> 2,478.00 <span style="font-size: x-small;"> non-refundable fee</span>
  </div>

  <label for="website-url">Enter Message</label>
  <asp:TextBox ID="txtUseCase" runat="server" Rows="4" placeholder="Enter your Message" CssClass="form-control" />
  <asp:RequiredFieldValidator ID="rfvUseCase" runat="server"
        ControlToValidate="txtUseCase"
        ErrorMessage="Message required."
        Display="Dynamic"
        CssClass="text-danger" 
        ValidationGroup="APIRequest"/>

  <div class="bnk-sidebar-footer">
      <asp:Button ID="btnRequestActivation" runat="server" 
        Text="Request Activation"
        style="color:white; background-color:#6e007c"
        ValidationGroup="APIRequest"
        OnClick="btnSaveActivation_Click" />

      <asp:Button ID="btnSaveActivation" runat="server" 
          Text="Hidden Save" 
          CssClass="d-none" 
          ValidationGroup="APIRequest"
          OnClick="btnSaveActivation_Click" />
      <a href="#">View Business Model</a>
  </div>
</div>
<div class="modal fade" id="successModal" tabindex="-1" aria-labelledby="successModalLabel" aria-hidden="true"
         data-bs-backdrop="static" data-bs-keyboard="false">
      <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content shadow-lg rounded-3 text-center">
      
          <!-- Modal Header -->
          <div class="modal-header  text-white border-0" style="background-color:purple">
            <h5 class="modal-title w-100" id="successModalLabel">Request Added Successful</h5>
            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
          </div>
      
          <!-- Modal Body -->
          <div class="modal-body">
            <img src="https://cdn-icons-png.flaticon.com/512/845/845646.png" 
                 alt="Success" class="mb-3" width="80" height="80" />
            <h6 class="fw-semibold">Your request has been added successfully!</h6>
            <button type="button" class="btn w-100" data-bs-dismiss="modal" style="background-color:purple; color:white">OK</button>
          </div>
      
        </div>
      </div>
    </div>
       	
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function openSidebar(title) {
        document.getElementById("bnk-sidebar-title").innerText = title;
        document.getElementById("sidebar1").classList.add("active");
    }

    function closeSidebar() {
        document.getElementById("sidebar1").classList.remove("active");
    }
</script>

<script>
    function submitActivation() {
      
        if (typeof (Page_ClientValidate) == 'function') {
            if (!Page_ClientValidate('APIRequest')) {
                return false;
            }
        }

        
        document.getElementById("<%= btnSaveActivation.ClientID %>").click();
    }
</script>


</asp:Content>
