<%@ Page Title="" Language="C#" MasterPageFile="~/Neox.Master" AutoEventWireup="true" CodeBehind="PanCard.aspx.cs" Inherits="NeoXPayout.PanCard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
  
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600&display=swap" rel="stylesheet" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />

<style>
:root{
  --purple:#6e007c;
  --bg:#f3f4f6;
  --card:#ffffff;
  --muted:#6b7280;
}

body{
  font-family:'Inter',sans-serif;
/*  background:
    radial-gradient(circle at top left, #e9d5ff, transparent 40%),
    radial-gradient(circle at bottom right, #fbcfe8, transparent 40%),
    var(--bg);*/
}

/* Main rounded body */
.pan-wrapper{
  max-width:1100px;
  margin:40px auto;
  padding:32px 28px;
  border-radius:28px;
  background:rgba(255,255,255,0.75);
  backdrop-filter:blur(16px);
  border:1px solid rgba(255,255,255,0.6);
  box-shadow:0 25px 55px rgba(0,0,0,0.15);
  justify-content:flex-start;
}

/* Title */
.pan-title{
  text-align:start;
  margin-bottom:30px;
}

.pan-title h1{
  font-weight:700;
  background:linear-gradient(90deg,#6f42c1,#9b59b6);
  -webkit-background-clip:text;
  -webkit-text-fill-color:transparent;
}

/* Cards grid – 2 column */
.bnk-card-grid{
  display:grid;
  grid-template-columns:repeat(2,1fr);
  gap:24px;
}

@media(max-width:768px){
  .bnk-card-grid{
    grid-template-columns:1fr;
  }
}

/* Card */
.bnk-card{
  background:rgba(255,255,255,0.9);
  border-radius:20px;
  padding:28px;
  cursor:pointer;
  border:1px solid rgba(255,255,255,0.4);
  box-shadow:
    0 12px 25px rgba(0,0,0,0.08),
    inset 0 1px 0 rgba(255,255,255,0.6);
  transition:all .35s ease;
}

.bnk-card:hover{
  transform:translateY(-6px) scale(1.02);
  box-shadow:0 22px 45px rgba(110,0,124,0.22);
  border-color:rgba(110,0,124,0.35);
}

/* Icon */
.bnk-card-icon{
  width:54px;
  height:54px;
  border-radius:14px;
  background:#ede9fe;
  color:var(--purple);
  font-size:30px;
  display:flex;
  align-items:center;
  justify-content:center;
  margin-bottom:14px;
}

/* Text */
.bnk-card-title{
  font-size:1.25rem;
  font-weight:600;
}

.bnk-card-desc{
  color:var(--muted);
  font-size:0.95rem;
  margin-bottom:10px;
}

/* Sidebar */
.bnk-sidebar{
  position:fixed;
  top:100px;
  right:-420px;
  width:360px;
  height:calc(100% - 100px);
  background:#fff;
  box-shadow:-6px 0 35px rgba(0,0,0,.18);
  transition:.35s;
  padding:24px;
  z-index:999;
  border-radius:22px 0 0 22px;
}

.bnk-sidebar.active{
  right:0;
}

.bnk-close-btn{
  position:absolute;
  right:18px;
  top:14px;
  background:none;
  border:none;
  font-size:22px;
}

.bnk-alert-box{
  background:#eef2ff;
  border-left:4px solid var(--purple);
  padding:12px;
  border-radius:10px;
  margin-bottom:16px;
  font-size:14px;
}

.bnk-primary-btn{
  width:100%;
  background:var(--purple);
  color:#fff;
  border:none;
  padding:12px;
  border-radius:12px;
  font-weight:600;
}
</style>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div class="pan-wrapper">

  <div class="pan-title">
    <h1>PAN Card</h1>
  </div>

  <div class="bnk-card-grid">

    <!-- PAN CREATION -->
    <div class="bnk-card" onclick="openSidebar('PAN Card Creation')">
      <div class="bnk-card-icon">🆕</div>
      <div class="bnk-card-title">PAN Card Creation</div>
      <div class="bnk-card-desc">
        Apply for a new PAN card using eKYC or eSign process.
      </div>
      <ul class="text-muted small">
        <li>Instant Application</li>
        <li>eKYC / eSign</li>
        <li>Fast Processing</li>
      </ul>
    </div>

    <!-- PAN CORRECTION -->
    <div class="bnk-card" onclick="openSidebar('PAN Card Correction')">
      <div class="bnk-card-icon">✏️</div>
      <div class="bnk-card-title">PAN Card Correction</div>
      <div class="bnk-card-desc">
        Correct or update details in existing PAN card.
      </div>
      <ul class="text-muted small">
        <li>Name / DOB Correction</li>
        <li>Address Update</li>
        <li>eSign Supported</li>
      </ul>
    </div>

  </div>
</div>

<!-- Sidebar -->
<div class="bnk-sidebar" id="sidebar1">

  <button type="button" class="bnk-close-btn" onclick="closeSidebar()">&times;</button>

  <h5 id="bnk-sidebar-title" class="mb-3"></h5>

  <div class="bnk-alert-box">
  <b>Charges:</b><br />
  <span id="panCharge">107</span> rs<br />
  <small>Non-refundable</small>
</div>


  <label>Applicant Name</label>
  <asp:TextBox ID="txtApplicantName" runat="server"
    CssClass="form-control mb-2" Placeholder="Enter Applicant Name" />
    <asp:RequiredFieldValidator ID="rfvName" runat="server" ControlToValidate="txtApplicantName"
    ErrorMessage="Applicant Name is required" CssClass="text-danger" Display="Dynamic" ValidationGroup="pancard"/>

  <label>Mobile Number</label>
  <asp:TextBox ID="txtMobile" runat="server"
    CssClass="form-control mb-2" Placeholder="Enter Mobile Number"
    MaxLength="10" />
    <asp:RequiredFieldValidator ID="rfvMobile" runat="server" ControlToValidate="txtMobile"
    ErrorMessage="Mobile Number is required" CssClass="text-danger" Display="Dynamic" ValidationGroup="pancard"/>

  <label>PAN Mode</label>
  <asp:DropDownList ID="ddlPanMode" runat="server" CssClass="form-control">
    <asp:ListItem Text="-- Select Mode --" Value="" />
    <asp:ListItem Text="eKYC" Value="EKYC" />
    <asp:ListItem Text="eSign" Value="ESIGN" />
  </asp:DropDownList>
      <asp:RequiredFieldValidator ID="rfvmode" runat="server" ControlToValidate="ddlPanMode"
    ErrorMessage="Mode is required" CssClass="text-danger" Display="Dynamic" ValidationGroup="pancard"/>

  <asp:Button ID="btnSubmit" runat="server"
    Text="Submit Request" ValidationGroup="pancard"
    CssClass="bnk-primary-btn mt-3"
    OnClick="btnSaveActivation_Click"
 />
</div>

<script>
    function openSidebar(title) {

        document.getElementById("bnk-sidebar-title").innerText = title;

        // 🔹 price logic
        var price = 107; // default

        if (title === "PAN Card Creation") {
            price = 105;
        }
        else if (title === "PAN Card Correction") {
            price = 107;
        }

        document.getElementById("panCharge").innerText = price;

        document.getElementById("sidebar1").classList.add("active");
    }

    function closeSidebar() {
        document.getElementById("sidebar1").classList.remove("active");
    }
</script>


</asp:Content>