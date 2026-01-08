<%@ Page Title="" Language="C#" MasterPageFile="~/Neox.Master" AutoEventWireup="true" CodeBehind="DMTNEW.aspx.cs" Inherits="NeoXPayout.DMTNEW" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

<style>
:root{--primary:#81007f;}
body{margin-left:10px; padding:20px;background:#f5f7fb;font-family:Segoe UI, sans-serif;}

/* Top bar */
.top-bar{
  display:flex;
  justify-content:space-between;
  align-items:center;
  flex-wrap:wrap;
  gap:10px;
  margin-bottom:15px;
  margin-top:25px;
  margin-left:15px;
}

.tabs{
  display:flex;
  gap:80px;
}

/* Buttons */
.tab-btn,
.recent-btn,
.btn{
  background:var(--primary);
  color:#fff;
  border:none;
  padding:10px 18px;
  border-radius:8px;
  cursor:pointer;
  font-size:14px;
  display:flex;
  align-items:center;
  gap:6px;
  transition:all 0.3s ease;
}

/* Hover animation */
.tab-btn:hover,
.recent-btn:hover,
.btn:hover{
  transform:translateY(-4px) scale(1.03);
  box-shadow:0 10px 20px rgba(129,0,127,0.35);
}

/* Active tab */
.tab-btn.active{
  background:#a300a0;
}

/* Cancel button */
.btn-cancel{
  background:#fff;
  color:var(--primary);
  border:1px solid var(--primary);
}

.btn-cancel:hover{
  background:var(--primary);
  color:#fff;
}

/* Card */
.card{
  background:#fff;
  border-radius:12px;
  box-shadow:0 4px 10px rgba(0,0,0,0.08);
  overflow:hidden;
  transition:all 0.35s ease;
  margin-left:15px;
}

/* Card hover popup */
.card:hover{
  transform:translateY(-8px) scale(1.01);
  box-shadow:0 18px 35px rgba(129,0,127,0.25);
}

/* Card header */
.card-header{
  padding:14px 18px;
  color:#fff;
  font-weight:600;
  background:linear-gradient(90deg,#81007f,#b300b0);
  display:flex;
  align-items:center;
  gap:8px;
}

.card-body{
  padding:25px;
}

/* Form */
.form-group{
  display:flex;
  align-items:center;
  flex-wrap:wrap;
  gap:15px;
}

.form-group label{
  min-width:140px;
  display:flex;
  align-items:center;
  gap:8px;
  font-weight:500;
  transition:color 0.3s ease;
}

/* Label hover */
.form-group:hover label{
  color:var(--primary);
}

.form-group input{
  width:280px;
  padding:12px 14px;
  border-radius:8px;
  border:1px solid #ccc;
  font-size:15px;
  transition:all 0.3s ease;
}

.form-group input:focus{
  border-color:var(--primary);
  box-shadow:0 0 0 3px rgba(129,0,127,0.15);
  outline:none;
}

/* Mobile */
@media(max-width:600px){
  .form-group{
    flex-direction:column;
    align-items:stretch;
  }
  .form-group input{
    width:100%;
  }
}


/*pop up form css */
/* Sidebar Overlay */
.sidebar-overlay{
  position:fixed;
  top:0;
  right:0;
  width:100%;
  height:100%;
  background:rgba(0,0,0,0.45);
  display:none;
  justify-content:flex-end;
  z-index:999999;
}

/* Sidebar Card */
.sidebar-card{
  width:420px;
  height:100%;
  background:#fff;
  box-shadow:-5px 0 20px rgba(0,0,0,0.2);
  animation:slideIn 0.35s ease;
  display:flex;
  flex-direction:column;
}

@keyframes slideIn{
  from{transform:translateX(100%);}
  to{transform:translateX(0);}
}

/* Header */
.sidebar-header{
  background:#81007f;
  color:#fff;
  padding:16px 18px;
  font-size:18px;
  font-weight:600;
  display:flex;
  justify-content:space-between;
  align-items:center;
}

/* Body */
.sidebar-body{
  padding:20px;
  overflow-y:auto;
}

/* Close */
.close-btn{
  cursor:pointer;
  font-size:24px;
}

/* Inputs (reuse your styles) */
.input-group{
  margin-bottom:14px;
}

.input-group label{
  display:flex;
  gap:8px;
  margin-bottom:5px;
}

.input-group input{
  width:100%;
  padding:11px 14px;
  border-radius:8px;
  border:1px solid #ccc;
}

.input-group input:focus{
  border-color:#81007f;
  outline:none;
  box-shadow:0 0 0 2px rgba(129,0,127,0.15);
}

/* Submit */
.btn-submit{
  width:100%;
  background:#81007f;
  color:#fff;
  padding:12px;
  border:none;
  border-radius:8px;
  margin-top:10px;
  cursor:pointer;
}

.btn-submit:hover{
  background:#a300a0;
  box-shadow:0 8px 18px rgba(129,0,127,0.3);
}


/*end here */

/*sender preview css */
.popup-overlay{
  position:fixed;
  top:0;
  left:0;
  width:100%;
  height:100%;
  background:rgba(0,0,0,0.45);
  display:none;
  justify-content:center;
  align-items:center;
  z-index:999999;
}

.popup-card{
  width:850px;
  background:#fff;
  border-radius:12px;
  overflow:hidden;
}

.popup-header{
  background:#81007f;
  color:#fff;
  padding:14px 18px;
  font-size:18px;
  font-weight:600;
}

.details-table{
  width:100%;
  border-collapse:collapse;
}

.details-table th,
.details-table td{
  padding:10px;
  border:1px solid #ddd;
  text-align:center;
}

.center{
  text-align:center;
  margin-top:15px;
}

.device-row{
  display:flex;
  justify-content:center;
  gap:18px;
  margin:15px 0;
}

.device-box{
  border:1px solid #ccc;
  padding:15px 25px;
  border-radius:10px;
  cursor:pointer;
}

.scan-btn{
  width:95%;
  margin:10px auto;
  display:block;
  padding:12px;
  background:#a46eb6;
  color:white;
  border:0;
  border-radius:8px;
  font-size:16px;
}

.footer-buttons{
  display:flex;
  justify-content:space-between;
  padding:12px 20px;
  border-radius:5px;
}

/* Scan button hover */
.scan-btn{
  transition: background 0.3s ease, transform 0.2s ease;
}

.scan-btn:hover{
  background:#81007f;      /* darker shade */
  transform: translateY(-2px);
}

/* Footer buttons styling + hover */
.footer-buttons button{
  padding:10px 18px;
  border-radius:5px;
  border:1px solid #81007f;
  background:#fff;
  cursor:pointer;
  transition: background 0.3s ease, color 0.3s ease, transform 0.2s ease;
}

.footer-buttons button:hover{
  background:#81007f;
  color:#fff;
  transform: translateY(-2px);
}
.device-img{
  width:55px;
  height:55px;
  object-fit:contain;
  display:block;
  margin:auto;
  margin-bottom:8px;
}


/*end*/

/*avail user */
/* Right sidebar main container */
.right-sidebar{
  position:fixed;
  top:0;
  right:-420px;      /* hidden initially */
  width:380px;
  height:100vh;
  background:#fff;
  box-shadow:-2px 0 10px rgba(0,0,0,0.2);
  transition:0.4s ease;
  z-index:100000;
}

/* Responsive */
@media(max-width:768px){
  .right-sidebar{
    width:100%;
  }
}

/* Header */
.sidebar-header{
  background:#81007f;
  color:#fff;
  padding:14px 16px;
  font-size:18px;
  font-weight:600;
  display:flex;
  justify-content:space-between;
  align-items:center;
}

/* Close icon hover */
.close-btn{
  cursor:pointer;
  font-size:18px;
  transition:0.3s;
}

.close-btn:hover{
  transform:scale(1.2);
}

/* Content */
.sidebar-content{
  padding:18px;
}

/* Inputs */
.input-box{
  width:100%;
  padding:10px;
  border-radius:8px;
  border:1px solid #ccc;
  margin-top:6px;
  margin-bottom:15px;
}

/* Main action button */
.sidebar-action-btn{
  width:100%;
  padding:12px;
  border-radius:8px;
  border:none;
  background:#81007f;
  color:white;
  font-size:15px;
  cursor:pointer;
  transition:0.3s;
}

/* Hover effect */
.sidebar-action-btn:hover{
  background:#6a0066;
  transform:translateY(-2px);
}

.recent-beneficiary-list {
  margin-top: 10px;
}

.beneficiary-item {
  display: flex;
  align-items: center;
  padding: 12px 10px;
  border-bottom: 1px solid #eee;
}

.bank-icon {
  font-size: 28px;
  margin-right: 12px;
}

.bank-icon.hdfc {
  color: #e4002b;
}

.beneficiary-details {
  flex: 1;
}

.beneficiary-details .account {
  font-size: 15px;
  color: #111;
}

.beneficiary-details .bank {
  font-size: 13px;
  color: #666;
  margin-top: 3px;
}

.actions {
  display: flex;
  align-items: center;
  gap: 10px;
}

.pay-btn {
  background: #81007f;
  color: #fff;
  border: none;
  padding: 6px 14px;
  border-radius: 6px;
  cursor: pointer;
  font-size: 13px;
}

.delete-btn {
  cursor: pointer;
  color: #d11a2a;
  font-size: 16px;
}

/*end*/


   /*address bebeficiary css*/
   /* open button */
.open-btn{
  padding:10px 16px;
  background:#81007f;
  color:#fff;
  border:none;
  border-radius:6px;
  cursor:pointer;
}

.open-btn:hover{
  background:#6a0066;
}

/* sidebar drawer */
.sidebar-popup{
  position:fixed;
  top:0;
  right:-450px;
  height:100vh;
  width:450px;
  background:#fff;
  box-shadow:-4px 0 20px rgba(0,0,0,0.25);
  z-index:999999;
  transition:0.4s ease;
}

/* header */
.popup-header{
  background:#81007f;
  color:#fff;
  padding:16px 20px;
  font-size:18px;
  font-weight:600;
}

/* body */
.popup-body{
  padding:18px;
}

/* input fields */
.field{
  width:100%;
  padding:12px;
  border:1px solid #ccc;
  border-radius:8px;
  margin-bottom:12px;
  font-size:15px;
}

/* button row */
.btn-row{
  display:flex;
  gap:10px;
}

/* purple primary button */
.primary-btn{
  flex:1;
  padding:10px;
  background:#81007f;
  color:white;
  border:none;
  border-radius:8px;
  cursor:pointer;
}

.primary-btn:hover{
  background:#6a0066;
}

/* cancel button */
.cancel-btn{
  flex:1;
  padding:10px;
  background:white;
  border:1px solid #ccc;
  border-radius:8px;
  cursor:pointer;
}

/* 🔥 Responsive mobile view */
@media(max-width:600px){
  .sidebar-popup{
    width:100%;
  }
}

     /* end*/


       /*money transfer css */
       /* sidebar drawer */
.preview-sidebar{
  position:fixed;
  top:0;
  right:-500px;
  height:100vh;
  width:500px;
  background:white;
  box-shadow:-5px 0 20px rgba(0,0,0,0.25);
  transition:0.4s ease;
  z-index:9999999;
}

/* header */
.sidebar-header{
  background:#6f1a8a;
  color:white;
  font-size:18px;
  padding:14px 16px;
  font-weight:600;
}

/* body */
.sidebar-body{
  padding:14px 16px;
}

/* table */
.info-table{
  width:100%;
  border-collapse:collapse;
  margin-bottom:16px;
}

.info-table th,
.info-table td{
  border:1px solid #ddd;
  padding:8px;
  text-align:center;
}

/* inputs row */
.field-row{
  display:grid;
 /* grid-template-columns:1fr 1fr 1fr auto;*/
  gap:10px;
  margin-top:10px;
}

/* input */
.input{
  padding:10px;
  border-radius:8px;
  border:1px solid #ccc;
}

/* otp button */
.otp-btn{
  padding:10px 12px;
  border:none;
  background:#1b8f53;
  color:white;
  border-radius:8px;
  cursor:pointer;
}

/* bottom buttons */
.btn-row{
  margin-top:18px;
  display:flex;
  gap:10px;
}

/* cancel button */
.cancel-btn{
  flex:1;
  padding:10px;
  border-radius:8px;
  border:1px solid #ccc;
  background:white;
}

/* confirm button */
.confirm-btn{
  flex:1;
  padding:10px;
  border-radius:8px;
  border:none;
  background:#6f1a8a;
  color:white;
}

/* 🔥 responsive */
@media(max-width:600px){
  .preview-sidebar{
    width:100%;
  }

  .field-row{
    grid-template-columns:1fr;
  }
}
/* sidebar open animation hover feel (optional) */
.preview-sidebar:hover{
  box-shadow:-8px 0 25px rgba(0,0,0,0.35);
}

/* table row hover */
.info-table tr:hover{
  background:#f7f2fa;
}

/* input hover + focus */
.input:hover{
  border-color:#6f1a8a;
}

.input:focus{
  border-color:#6f1a8a;
  outline:none;
  box-shadow:0 0 4px rgba(111,26,138,0.4);
}

/* OTP button hover */
.otp-btn:hover{
  background:#167543;
}

/* cancel button hover */
.cancel-btn:hover{
  background:#f2f2f2;
  cursor:pointer;
}

/* confirm button hover */
.confirm-btn:hover{
  background:#521066;
  cursor:pointer;
}

/* header hover glow (optional) */
.sidebar-header:hover{
  background:#5a1471;
}


      /* end*/
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
      
<!-- TOP BAR -->
<div class="top-bar">
  <div class="tabs">
    <button class="tab-btn active" onclick="changeTransfer(this,'FINO - Money Transfer')">
      <i class="fa-solid fa-money-bill-transfer"></i> BankU - Money Transfer 
    </button>

    <button class="tab-btn" onclick="changeTransfer(this,'Money Transfer - 2')">
      <i class="fa-solid fa-money-bill-transfer"></i> Money Transfer - 2
    </button>

    <button class="tab-btn" onclick="changeTransfer(this,'Money Transfer - 3')">
      <i class="fa-solid fa-money-bill-transfer"></i> Money Transfer - 3
    </button>
  </div>

  <button class="recent-btn">
    <i class="fa-solid fa-clock-rotate-left"></i> Show Recent Transactions
  </button>
</div>

<!-- CARD -->
<div class="card">
  <div class="card-header">
    <i class="fa-solid fa-money-bill-transfer"></i>
    <marquee direction="left" scrollamount="7">
  <span id="transferTitle">BankU - Money Transfer</span>
</marquee>

  </div>

  <div class="card-body">
    <div class="form-group">
      <label>
        <i class="fa-solid fa-mobile-screen-button"></i>
        Mobile Number
      </label>

      <input type="text" id="mobile" placeholder="Enter Mobile Number" maxlength="10">

     <button class="btn btn-verify" type="button" onclick="openSenderSidebar()">
    <i class="fa-solid fa-circle-check"></i> Verify Number
</button>
        <button class="btn btn-verify" type="button" onclick="openSenderAvail()">
  <i class="fa-solid fa-circle-check"></i> Avail User
</button>






      <button class="btn btn-cancel" onclick="clearInput()">
        <i class="fa-solid fa-xmark"></i> Cancel
      </button>
    </div>
  </div>
</div>
<%--     pop up form --%>

  <!-- Right Sidebar Overlay -->
<div class="sidebar-overlay" id="senderSidebar">

  <div class="sidebar-card">

    <div class="sidebar-header">
      Add New Sender
      <span class="close-btn" onclick="closeSenderSidebar()">×</span>
    </div>

    <div class="sidebar-body">

      <div class="input-group">
        <label><i class="fa-solid fa-user"></i> Sender Name</label>
        <input type="text" placeholder="Enter Sender Name">
      </div>

      <div class="input-group">
        <label><i class="fa-solid fa-mobile-screen-button"></i> Mobile Number </label>
        <input type="text" placeholder="Enter Mobile Number">
      </div>

      <div class="input-group">
        <label><i class="fa-solid fa-id-card"></i> Aadhaar Number</label>
        <input type="text" placeholder="Enter Aadhaar Number">
      </div>

      <div class="input-group">
        <label><i class="fa-solid fa-location-dot"></i> Address</label>
        <input type="text" placeholder="Enter Address">
      </div>

      <div class="input-group">
        <label><i class="fa-solid fa-city"></i> City</label>
        <input type="text" placeholder="Enter City">
      </div>

      <div class="input-group">
        <label><i class="fa-solid fa-map-pin"></i> Pin Code</label>
        <input type="text" placeholder="Enter Pin Code">
      </div>

     <button class="btn btn-submit" type="button" onclick="openPopup()">
  <i class="fa-solid fa-check"></i> Register Sender
</button>


    </div>
  </div>
</div>



   <%-- end here --%>

  <%--  sender preview --%>
    <div id="senderPopup" class="popup-overlay">
  <div class="popup-card">
    
    <div class="popup-header">
      Add-Sender Preview - BankU
    </div>

    <table class="details-table">
      <tr>
        <th>Sender Name</th>
        <th>Mobile Number</th>
        <th>Aadhar Number</th>
        <th>Address</th>
        <th>City</th>
        <th>Pin Code</th>
      </tr>
      <tr>
        <td>Chandan</td>
        <td>9999999999</td>
        <td>111111111111</td>
        <td>Delhi</td>
        <td>1</td>
        <td>110041</td>
      </tr>
    </table>

    <h6 class="center">Select Fingerprint Device:</h6>
<div class="device-row">
  
  <div class="device-box">
    <img src="assets\images\payment\imgi_6_myntra.png" alt="Mantra L1" class="device-img">
    <div>Mantra L1</div>
  </div>

  <div class="device-box">
    <img src="assets\images\payment\imgi_7_morpho.png" alt="Morpho L1" class="device-img">
    <div>Morpho L1</div>
  </div>
    
  <div class="device-box">
    <img src="assets\images\payment\imgi_8_Startek.png" alt="Startek L1" class="device-img">
    <div>Startek L1</div>
  </div>

</div>


    <button class="scan-btn">
  <img src="assets\images\payment\imgi_4_aeps-icon.png" alt="Scan" style="width:22px;height:22px;margin-right:8px;vertical-align:middle;">
  Scan Fingerprint
</button>


    <div class="footer-buttons">
      <button onclick="closePopup()">Cancel</button>
      <button>✔ Confirm & Proceed</button>
    </div>

  </div>
</div>


   <%-- end here--%>

   <%-- Avail user--%>
   <!-- Recent Beneficiary List -->
<div id="rightSidebar" style=" position:fixed; top:0; right:-420px; width:380px; height:100vh; background:#ffffff; box-shadow:-2px 0 10px rgba(0,0,0,0.25); transition:0.4s ease; z-index:999999; "> <div style=" background:#81007f; color:white; padding:14px 18px; font-size:18px; font-weight:600; display:flex; justify-content:space-between; "> Recent Beneficiary <span style="cursor:pointer" onclick="closeSenderAvail()">✖</span> </div> <div style="padding:18px"> <label>Search Beneficiary</label> 
    <input type="text" placeholder="Search here…" style=" width:100%; padding:10px; border-radius:8px; border:1px solid #ccc; margin-top:5px; margin-bottom:15px; "> 

    <!-- Recent Beneficiary List -->
<div class="recent-beneficiary-list">

  <div class="beneficiary-item">
    <div class="bank-icon">
      🏦
    </div>

    <div class="beneficiary-details">
      <div class="account">
        <strong>782418110002859</strong> || Ayush Awasthi
      </div>
      <div class="bank">
        Bank Of India || BKID0007824
      </div>
    </div>

    <div class="actions">
     <button class="pay-btn" type="button">Pay Now</button>

      <span class="delete-btn">🗑️</span>
    </div>
  </div>

  <div class="beneficiary-item">
    <div class="bank-icon hdfc">
      🟥
    </div>

    <div class="beneficiary-details">
      <div class="account">
        <strong>50100410433250</strong> || Chandan Thakur
      </div>
      <div class="bank">
        HDFC BANK || HDFC0001127
      </div>
    </div>

    <div class="actions">
      <button class="pay-btn">Pay Now</button>
      <span class="delete-btn">🗑️</span>
    </div>
  </div>

</div>

    <button id="openBeneficiaryPopupBtn" style="padding:10px 16px;background:#81007f;color:#fff;border:none;border-radius:6px;cursor:pointer;" type="button" class="open-btn"> Add New Beneficiary </button> </div> </div>


  <%--  end--%>

   <%-- add beneficiary--%>
 <div id="rightBeneficiaryPopup" class="sidebar-popup">

  <div class="popup-header">
    Add New Beneficiary
  </div>

  <div class="popup-body">

    <input type="text" placeholder="Bank Name" class="field">
    <input type="text" placeholder="Account Number" class="field">
    <input type="text" placeholder="Beneficiary Name" class="field">
    <input type="text" placeholder="IFSC Code" class="field">

    <div class="btn-row">
      <button class="primary-btn">Add Account</button>
      <button id="closeBeneficiarySidebar" class="cancel-btn">Cancel</button>
    </div>

  </div>
</div>
      <%--  money transfer page --%>
    <div id="moneyPreviewSidebar" class="preview-sidebar">

  <div class="sidebar-header">
    Money-Transfer Preview – BankU
  </div>

  <div class="sidebar-body">

    <table class="info-table">
      <tr>
        <th>Bank</th>
        <th>Account Number</th>
        <th>Beneficiary Name</th>
        <th>IFSC Code</th>
      </tr>

      <tr>
        <td>Bank Of India</td>
        <td>782418110002859</td>
        <td>Ayush Awasthi</td>
        <td>BKID0007824</td>
      </tr>
    </table>

    <div class="field-row">
      <input class="input" placeholder="Txn Type" value="IMPS">
      <input class="input" placeholder="Amount"> 
      <input class="input" placeholder="Enter OTP">

      <button class="otp-btn">Resend OTP</button>
    </div>

    <div class="btn-row">
      <button id="closeMoneySidebar" class="cancel-btn">Cancel</button>
      <button class="confirm-btn">Confirm & Proceed</button>
    </div>

  </div>
</div>

     <%-- end here --%>

   <%-- end--%>
<script>
    function changeTransfer(btn, title) {
        document.getElementById("transferTitle").innerText = title;
        document.querySelectorAll(".tab-btn").forEach(b => b.classList.remove("active"));
        btn.classList.add("active");
    }

    function verifyNumber() {
        const mobile = document.getElementById("mobile").value;
        if (mobile.length !== 10 || isNaN(mobile)) {
            alert("Enter valid 10 digit mobile number");
            return;
        }
        alert("Mobile number verified successfully ✅");
    }

    function clearInput() {
        document.getElementById("mobile").value = "";
    }
</script>
     
   <%-- pop up form script here --%>
    <script>
        function openSenderSidebar() {
            document.getElementById("senderSidebar").style.display = "flex";
            document.body.style.overflow = "hidden";
        }

        function closeSenderSidebar() {
            document.getElementById("senderSidebar").style.display = "none";
            document.body.style.overflow = "auto";
        }

        window.onclick = function (e) {
            let sidebar = document.getElementById("senderSidebar");
            if (e.target === sidebar) {
                closeSenderSidebar();
            }
        }
    </script>


   <%-- end here--%>

  <%--  sender preview start --%>
    <script>
        function openPopup() {
            document.getElementById("senderPopup").style.display = "flex";
        }

        function closePopup() {
            document.getElementById("senderPopup").style.display = "none";
        }
    </script>

   <%-- end --%>

  <%--  avail user --%>
   <script>
       function openSenderAvail() {
           document.getElementById("rightSidebar").style.right = "0";
       }

       function closeSenderAvail() {
           document.getElementById("rightSidebar").style.right = "-420px";
       }
   </script>


  <%--  end--%>
  <%--  add beneficiary --%>
  <script>
      (function () {

          const drawer = document.getElementById("rightBeneficiaryPopup");
          const openBtn = document.getElementById("openBeneficiaryPopupBtn");
          const closeBtn = document.getElementById("closeBeneficiarySidebar");

          function openRightDrawer() {
              drawer.style.right = "0px";
          }

          function closeRightDrawer() {
              drawer.style.right = "-420px";
          }

          openBtn.addEventListener("click", openRightDrawer);
          closeBtn.addEventListener("click", closeRightDrawer);

      })();
  </script>


<%--end--%>

  <%--  money transffer --%>
    <script>
        (function () {

            const drawer = document.getElementById("moneyPreviewSidebar");
            const closeBtn = document.getElementById("closeMoneySidebar");

            // open on any Pay Now button click
            document.addEventListener("click", function (e) {
                if (e.target.classList.contains("pay-btn")) {
                    drawer.style.right = "0";
                }
            });

            // close
            closeBtn.addEventListener("click", function () {
                drawer.style.right = "-500px";
            });

            // ESC close
            document.addEventListener("keydown", function (e) {
                if (e.key === "Escape") {
                    drawer.style.right = "-500px";
                }
            });

        })();
    </script>
   

  <%--  end --%>
      
</asp:Content>
