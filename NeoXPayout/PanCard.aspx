<%@ Page Title="" Language="C#" MasterPageFile="~/Neox.Master" AutoEventWireup="true" CodeBehind="PanCard.aspx.cs" Inherits="NeoXPayout.PanCard" %>
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
    <asp:HiddenField ID="hfPanServiceCode" runat="server" />

<div class="bnk-main-header">
    <div class="bnk-left-header">
        <h2>PAN Card Services</h2>
    </div>

    <div class="bnk-right-header">
        <button class="bnk-outline-btn" type="button"
                onclick="openSidebar('PAN Creation', '5024')">
            🆕 PAN Creation
        </button>

        <button class="bnk-outline-btn" type="button"
                onclick="openSidebar('PAN Correction', '5025')">
            ✏️ PAN Correction
        </button>
    </div>
</div>
<div class="bnk-sidebar" id="sidebar1">
    <button class="bnk-close-btn" type="button" onclick="closeSidebar()">&times;</button>

    <h3 id="bnk-sidebar-title"></h3>
    <p style="color:#555; font-size:14px">
        Fill the details to proceed with PAN application.
    </p>

    <div class="bnk-alert-box">
        <strong>⚠️ Charges</strong><br />
        ₹ 5,000 + 18% GST <br />
        <small>Non-refundable</small>
    </div>

    <!-- Name -->
    <label>Applicant Name</label>
    <asp:TextBox ID="txtName" runat="server" CssClass="form-control" />
    <asp:RequiredFieldValidator runat="server"
        ControlToValidate="txtName"
        ErrorMessage="Name required"
        CssClass="text-danger"
        ValidationGroup="PAN" />

    <!-- Mobile -->
    <label>Mobile Number</label>
    <asp:TextBox ID="txtMobile" runat="server" CssClass="form-control" MaxLength="10" />
    <asp:RequiredFieldValidator runat="server"
        ControlToValidate="txtMobile"
        ErrorMessage="Mobile number required"
        CssClass="text-danger"
        ValidationGroup="PAN" />

    <!-- Mode -->
    <label>PAN Mode</label>
    <asp:DropDownList ID="ddlMode" runat="server" CssClass="form-select">
        <asp:ListItem Text="-- Select Mode --" Value="" />
        <asp:ListItem Text="EKYC (Without Signature)" Value="EKYC" />
        <asp:ListItem Text="ESIGN (With Signature & Photo)" Value="ESIGN" />
    </asp:DropDownList>
    <asp:RequiredFieldValidator runat="server"
        ControlToValidate="ddlMode"
        InitialValue=""
        ErrorMessage="Select PAN mode"
        CssClass="text-danger"
        ValidationGroup="PAN" />

    <!-- Submit -->
    <div class="bnk-sidebar-footer">
        <asp:LinkButton ID="lnkSubmitPan"
            runat="server"
            CssClass="bnk-primary-btn w-100 text-center"
            ValidationGroup="PAN"
            OnClick="lnkSubmitPan_Click">
            Submit PAN Request
        </asp:LinkButton>
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
    function openSidebar(title, serviceCode) {
        document.getElementById("bnk-sidebar-title").innerText = title;
        document.getElementById("<%= hfPanServiceCode.ClientID %>").value = serviceCode;
        document.getElementById("sidebar1").classList.add("active");
    }

    function closeSidebar() {
        document.getElementById("sidebar1").classList.remove("active");
    }
</script>

</asp:Content>