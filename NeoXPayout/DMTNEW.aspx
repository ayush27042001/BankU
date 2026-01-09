<%@ Page Title="" Language="C#" MasterPageFile="~/Neox.Master" AutoEventWireup="true" CodeBehind="DMTNEW.aspx.cs" Inherits="NeoXPayout.DMTNEW" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

    <link rel="stylesheet" href="CustomCSS/Dmt.css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:Panel runat="server" ID="pnlMain">  
<!-- NEW HEADER BAR -->
<div class="transfer-header">
    <div class="header-left">
        <div class="title-badge">
            <i class="fa-solid fa-building-columns"></i>
            <span id="transferTitle">BankU – Money Transfer</span>
        </div>
    </div>

    <div class="header-tabs">
        <asp:Label ID="lblMessage1" runat="server"></asp:Label>
        <asp:Repeater ID="rptTransferTabs" runat="server">
            <ItemTemplate>
                <button 
                    type="button"
                    class='header-tab <%# Container.ItemIndex == 0 ? "active" : "" %>'
                    onclick="changeTransfer(this,'Money Transfer - <%# Eval("ProviderCode") %>')">
                    Money Transfer - <%# Eval("ProviderCode") %>
                </button>
            </ItemTemplate>
        </asp:Repeater>
    </div>

    <div class="header-right">
        <button class="history-btn" type="button">
            <i class="fa-solid fa-clock-rotate-left"></i>
            History
        </button>
    </div>
</div>



<!-- NEW MAIN PANEL -->
<div class="transfer-panel">
  <div class="panel-accent"></div>

  <div class="panel-content">
    <h3 class="panel-title">
      Verify Sender
      <span>Enter mobile number to continue</span>
    </h3>

    <div class="input-row">
      <div class="input-box">
        <i class="fa-solid fa-mobile-screen-button"></i>
        <input type="text" id="mobile" maxlength="10" placeholder="Mobile Number">
      </div>

      <div class="action-group">
        <button class="action primary" type="button" onclick="openSenderSidebar()">
          Verify
        </button>
        <button class="action secondary" type="button" onclick="openSenderAvail()">
          Avail
        </button>
        <button class="action ghost" type="button" onclick="clearInput()">
          Cancel
        </button>
      </div>
    </div>
  </div>
</div>

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


<%--  sender preview --%>
<div id="senderPopup" class="popup-overlay">

  <div class="popup-card">

    <div class="popup-header">
      Add-Sender Preview - BankU
      <span class="close-btn" onclick="closePopup()">✕</span>
    </div>

    <div class="popup-body">

      <div class="table-wrapper">
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
            <td>ABC</td>
            <td>9999999999</td>
            <td>111111111111</td>
            <td>Delhi</td>
            <td>1</td>
            <td>110041</td>
          </tr>
        </table>
      </div>

      <h6 class="section-title">Select Fingerprint Device</h6>

      <div class="device-row">

        <div class="device-box">
          <img src="assets/images/mantra.png" class="device-img">
          Mantra L1
        </div>

        <div class="device-box">
          <img src="assets/images/morpho.png" class="device-img">
          Morpho L1
        </div>

        <div class="device-box">
          <img src="assets/images/secugen.png" class="device-img">
          Startek L1
        </div>

      </div>

      <button class="scan-btn">
        <img src="assets/images/payment/imgi_4_aeps-icon.png" width="22" height="22">
        Scan Fingerprint
      </button>

    </div>

    <div class="footer-buttons">
      <button onclick="closePopup()" type="button">Cancel</button>
      <button type="button">✔ Confirm & Proceed</button>
    </div>

  </div>
</div>



<%-- Avail user--%>
<!-- Recent Beneficiary List -->
    <div class="offcanvas offcanvas-end" tabindex="-1" id="rightSidebar" data-bs-backdrop="static" data-bs-keyboard="false">
        <div class="offcanvas-header d-flex align-items-center justify-content-between"
         style="background-color: purple; color:white">

        <h5 class="mb-0">Recent Beneficiary</h5>

        <div class="d-flex align-items-center gap-2">
            <!-- Add New Beneficiary Button (Small) -->
            <button id="openBeneficiaryPopupBtn"
                    type="button"
                    class="btn btn-sm text-black"
                    style="background:White;border-radius:6px;">
                + Add
            </button>

            <!-- Close -->
            <span onclick="closeSenderAvail()"
                  style="cursor:pointer;font-size:20px;line-height:1;">
                ✖
            </span>
        </div>
      </div>


     <div class="offcanvas-body">

        <div class="mb-3">
           

        <div > <label>Search Beneficiary</label> 
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
      <button class="pay-btn" type="button">Pay Now</button>
      <span class="delete-btn">🗑️</span>
    </div>
  </div>

</div>

</div>
          
        </div>
    </div>
</div>

<%--  end--%>

<div class="offcanvas offcanvas-end" tabindex="-1" id="rightBeneficiaryPopup" data-bs-backdrop="static" data-bs-keyboard="false">
        <div class="offcanvas-header" style="background-color: purple; color:white">       
              <h5>Add New Beneficiary  </h5>          
       </div>

     <div class="offcanvas-body">

        <div class="mb-3">
           

            <input type="text" placeholder="Bank Name" class="field">
            <input type="text" placeholder="Account Number" class="field">
            <input type="text" placeholder="Beneficiary Name" class="field">
            <input type="text" placeholder="IFSC Code" class="field">

            <div class="btn-row">
                <button class="primary-btn" type="button">Add Account</button>
                <button id="closeBeneficiarySidebar" type="button" class="cancel-btn">Cancel</button>
            </div>
          
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

      <button class="otp-btn" type="button">Resend OTP</button>
    </div>

    <div class="btn-row">
      <button id="closeMoneySidebar" type="button" class="cancel-btn">Cancel</button>
      <button class="confirm-btn" type="button">Confirm & Proceed</button>
    </div>

  </div>
</div>

<%-- end here --%>
</asp:Panel>

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

    <script src="CustomJS/DMT.js"></script>
      
</asp:Content>
