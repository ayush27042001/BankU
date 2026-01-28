<%@ Page Title="" Language="C#" MasterPageFile="~/Neox.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="NeoXPayout.Dashboard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<link href="https://fonts.googleapis.com/css2?family=Segoe+UI&display=swap" rel="stylesheet">

<style>
    .card-box {
    border: none;
    border-radius: 16px;
    background: #fff;
    padding: 20px;
    box-shadow: 0 6px 18px rgba(0, 0, 0, 0.05);
    height: 100%;
}

.quick-touch-card {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    height: 100px;
    border-radius: 12px;
    background: linear-gradient(to bottom right, #fff, #f0f0f0);
    box-shadow: 0 4px 8px rgba(0,0,0,0.04);
    transition: all 0.3s ease;
    text-align: center;
    font-weight: 600;
    color: #444;
    cursor: pointer;
}

    .quick-touch-card:hover {
        transform: translateY(-3px);
        background: #eef1ff;
        color: #580069;
        box-shadow: 0 6px 16px rgba(0,0,0,0.08);
    }

    .quick-touch-card i {
        font-size: 24px;
        margin-bottom: 5px;
    }

.stat-card {
    background-color: #ffffff;
    border-radius: 14px;
    padding: 20px;
    box-shadow: 0 6px 12px rgba(0,0,0,0.06);
    transition: 0.3s;
}

    .stat-card:hover {
        transform: scale(1.02);
    }

.stat-title {
    font-size: 14px;
    color: #666;
    display: flex;
    justify-content: space-between;
    align-items: center;
    font-weight: 600;
}

.stat-value {
    font-size: 22px;
    font-weight: 700;
    color: #212529;
    margin-top: 5px;
}

.stat-icon {
    font-size: 18px;
    color: #888;
}

</style>
<style>
.equal-card {
    height: 100%;
    display: flex;
}

.equal-card-inner {
    width: 100%;
    max-width: 420px;
    min-height: 220px;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
}

.wallet-card {
    min-height: 220px;
    padding: 20px;
    border-radius: 16px;
    color: #fff;
    background-image: linear-gradient(to top, var(--bs-purple));
}

.virtual-card {
    min-height: 220px;
    padding: 20px;
    background-color: #f2e7fb;
    border-radius: 16px;
}

.carousel-card img {
    height: 220px;
    object-fit: cover;
    border-radius: 16px;
}

@media (max-width: 768px) {
    .equal-card-inner {
        max-width: 100%;
    }
}
.equal-card {
    height: 100%;
    border-radius: 18px;
}

.equal-card-inner {
    height: 100%;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
}

/* MAIN CARD RADIUS */
.equal-card,
.equal-card-inner {
    border-radius: 20px;
}

/* CAROUSEL IMAGE RADIUS FIX */
.carousel-inner,
.carousel-item,
.carousel-item img {
    border-radius: 20px;
}

/* PREVENT IMAGE OVERFLOW */
.equal-card-inner {
    overflow: hidden;
}

</style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
 
  <!-- start: page body area -->
<div class="px-xl-5 px-lg-4 px-3 py-3 page-body">
                  

<div class="row g-3 mb-3 row-deck align-items-stretch">

<div class="col-md-4 d-flex">
<div class="equal-card w-100">
    <div class="equal-card-inner p-4 text-white"
            style="background: linear-gradient(to top, var(--bs-purple));">

        <div class="d-flex justify-content-between align-items-center">
            <div class="fw-bold fs-5">Business Wallet</div>
            <img src="BankU.png" height="28" />
        </div>

        <div class="mt-4 fs-5">

            <!-- ASP.NET label  -->
          <asp:Label 
            ID="Label3" 
            runat="server" 
            ClientIDMode="Static"
            CssClass="d-none">
        </asp:Label>


            <!-- Visible toggle text -->
            <span id="balanceToggle"
                    style="cursor:pointer; text-decoration:none;"
                    onclick="toggleBalanceInline()">
                View Balance
            </span>

                </div>

            <div class="fs-4 mt-2">
                <asp:Label ID="Label10" runat="server" />
            </div>

            <div class="d-flex justify-content-between mt-auto">
                <a href="ReportBanku.aspx" class="text-white">View Statement</a>
                <a href="AddFund.aspx" class="text-white">Add Money</a>
            </div>

        </div>
    </div>
</div>



<%--<asp:PlaceHolder ID="pnlOutletLimit1" runat="server" Visible="false">
    <div class="col-md-4 col-lg-4 col-xl-4">      
        <div class="card-body d-flex justify-content-center flex-column">
            <div class="card-wrapper align-self-center" style="width:400px">
                <div class="cc visa" style="height:200px; background-image: linear-gradient(to top, var(--bs-red));">
                    <div class="card-data">
                        <div class="type" style="font-size:large; font-weight:bold">Outlet Limit</div>
                        <div class="circuit">
                            <img src="BankU.png" />
                        </div>
                    </div>
                    <div class="card-data" style="margin-top:35px">
                        <h6 style="margin-top:5px">₹<asp:Label ID="lblsuccess" runat="server"></asp:Label></h6>
                    </div>
                    <div class="card-data" style="margin-top:105px">
                        <asp:Label ID="Label8" class="number" runat="server" style="font-size:large"></asp:Label>
                    </div>
                    <div class="holder d-flex">
                        <a class="name" href="#" style="z-index:970; position:relative;">View Total</a>
                        <a class="name me-5" href="#" style="z-index:960; position:relative; margin-left:70px">View Used</a>
                        <a class="name" href="#" style="z-index:950; position:relative">Add Usable</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:PlaceHolder>--%>

<asp:PlaceHolder ID="pnlbutton" runat="server" Visible="true">
<div class="col-md-4 d-flex">
    <div class="equal-card w-100">
        <div class="equal-card-inner p-4"
             style="background:#f2e7fb;">

            <div class="d-flex justify-content-between">
                <div class="fw-medium">Virtual Account</div>
                <i class="bi bi-info-circle"></i>
            </div>

            <div class="fs-5 fw-bold text-danger mt-1">Inactive</div>

            <div>
                <div class="fw-medium mt-2">Account Number</div>
                <div class="d-flex justify-content-between">
                    <span>XXXXXXXXXXXX</span>
                     <i class="bi bi-clipboard" style="cursor: pointer;" onclick="copyText('XXXXXXXXXXXX')"></i>
                </div>

                <div class="fw-medium mt-2">IFSC Code</div>
                <div class="d-flex justify-content-between">
                    <span>XXXXXXXX</span>
                  <i class="bi bi-clipboard" style="cursor: pointer;" onclick="copyText('XXXXXXXX')"></i>
                </div>
            </div>

        </div>
    </div>
</div>
</asp:PlaceHolder>


<!--Promotional Carousel Card -->
<div class="col-md-4 d-flex">
    <div class="equal-card w-100">
        <div class="equal-card-inner overflow-hidden">

            <div id="imageCarousel" class="carousel slide h-100">
                <div class="carousel-inner h-100">
                    <div class="carousel-item active h-100">
                        <img src="assets/images/lg/scan.png"
                             class="w-100 h-100"
                             style="object-fit:cover;">
                    </div>
                    <div class="carousel-item h-100">
                        <img src="assets/images/lg/gift_bank.png"
                             class="w-100 h-100"
                             style="object-fit:cover;">
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>


</div>

<div class="container-fluid">
  <div class="row g-4">

    <!-- Left Section: Modern Icon Cards -->
    <div class="col-lg-6">
      <div class="card-box">
        <h6 class="mb-3"><strong>Quick Access</strong></h6>
        <div class="row g-3">
          <div class="col-4">
  <a href="Payout.aspx" class="quick-touch-card">
    <i class="bi bi-wallet2"></i>
    <span>Payout</span>
  </a>
</div>

<div class="col-4">
  <a href="Calling.aspx" class="quick-touch-card" style="background:#e9e3ff;color:#580069;">
    <i class="bi bi-telephone-forward-fill"></i>
    <span>Call</span>
  </a>
</div>

<div class="col-4">
  <a href="BillPayment.aspx" class="quick-touch-card">
    <i class="bi bi-lightning-fill"></i>
    <span>Utility</span>
  </a>
</div>

<div class="col-4">
  <a href="Recharge.aspx" class="quick-touch-card">
    <i class="bi bi-arrow-repeat"></i>
    <span>Recharge</span>
  </a>
</div>

<div class="col-4">
  <a href="Logistics.aspx" class="quick-touch-card">
    <i class="bi bi-truck"></i>
    <span>Logistics</span>
  </a>
</div>

<div class="col-4">
  <a href="Shopping.aspx" class="quick-touch-card">
    <i class="bi bi-bag"></i>
    <span>Shopping</span>
  </a>
</div>

         
     
        </div>
      </div>
    </div>

    <!-- Right Section: Styled Stat Cards with Quick Touch Title -->
    <div class="col-lg-6">
      <div class="card-box">
        <h6 class="mb-3"><strong>Recently Used</strong></h6>
        <div class="row g-3">
          <div class="col-md-6">
            <div class="stat-card">
              <a href="WalletReport.aspx">
                  <div class="stat-title">Money In <span class="stat-icon bi bi-chevron-right"></span></div>
                  <asp:Label ID="lblMoneyIn" runat="server" Text="₹0.00" class="stat-value"></asp:Label>
              </a>
            </div>
          </div>
          <div class="col-md-6">
            <div class="stat-card">
                  <a href="WalletReport.aspx">
              <div class="stat-title">Money Out <span class="stat-icon bi bi-chevron-right"></span></div>
               <asp:Label ID="lblMoneyOut" runat="server" Text="₹0.00" class="stat-value"></asp:Label>
                      </a>
            </div>
          </div>
          <div class="col-md-6">
            <div class="stat-card">
             <a href="WalletReport.aspx">
                  <div class="stat-title">Settlements<span class="stat-icon bi bi-chevron-right"></span></div>
                  <div class="stat-value">₹0.00</div>
              </a>
            </div>
          </div>
            <div class="col-md-6">
            <div class="stat-card">
              <a href="WalletReport.aspx">
                  <div class="stat-title">Collections <span class="stat-icon bi bi-chevron-right"></span></div>
                  <div class="stat-value">₹0.00</div>
              </a>
            </div>
          </div>
        
        
        </div>
      </div>
    </div>

  </div>
</div>
                             
 </div> 
<div id="copyToast" 
     style="position: fixed; top: 15px; right: 15px; 
            background: #4CAF50; color: white; 
            padding: 10px 15px; border-radius: 8px; 
            font-size: 0.9rem; display:none;
            box-shadow: 0 4px 10px rgba(0,0,0,0.2); 
            z-index:9999;">
    Copied
    <span style="margin-left:10px; cursor:pointer; font-weight:bold;" onclick="hideToast()">×</span>
</div>
    <script src="CustomJS/Dashboard.js" ></script>
<script>
    $(document).ready(function () {
        checkStatusAjax();
    });
</script>

        
</asp:Content>


