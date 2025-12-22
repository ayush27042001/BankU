<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Registration.aspx.cs" Inherits="NeoXPayout.Registration"  %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta charset="UTF-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
<meta name="keywords" content="
BC banking platform, 
Banking correspondent services, 
API banking platform India, 
Banking APIs for developers, 
Fintech API provider, 
AEPS API provider, 
micro ATM API, 
DMT API provider, 
Banking as a Service, 
Open banking platform India, 
financial services API, 
neobank API provider, 
payout API, 
API for banking integration, 
UPI API provider, 
BBPS API integration, 
banking API reseller, 
digital banking platform, 
BankU API platform, 
start BC business, 
become a BC agent, 
white label fintech API, 
BC model banking India, 
API stack for fintech, 
Fintech as a service India"/>
 <title> BankU India : Modern Banking for Business - StartUp || SMEs || Enterprises </title>
  <!-- Title for preview -->
<meta property="og:title" content="BankU India : Modern Banking for Business - StartUp || SMEs || Enterprises" />
<script async src="https://www.googletagmanager.com/gtag/js?id=G-BSFCF5DHB7"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'G-BSFCF5DHB7');
</script>
<script>(function(w,d,s,l,i){
  w[l]=w[l]||[]; 
  w[l].push({'gtm.start': new Date().getTime(), event:'gtm.js'});
  var f=d.getElementsByTagName(s)[0],
      j=d.createElement(s), dl=l!='dataLayer'?'&l='+l:'';
  j.async=true; 
  j.src='https://www.googletagmanager.com/gtm.js?id='+i+dl; 
  f.parentNode.insertBefore(j,f);
})(window,document,'script','dataLayer','GTM-WCPWGP8K');
</script>
<!-- Description (optional but good for SEO) -->
<meta property="og:description" content="A new-age fintech revolution, BankU India is transforming the way Bharat accesses banking, financial, and essential utility services. With a strong presence across rural and semi-urban regions, we empower local entrepreneurs and citizens through a wide range of digital solutions — from AePS cash withdrawals and loan facilitation to bill payments, courier booking, and beyond. Our mission is to bridge the urban-rural financial gap and build a truly inclusive digital economy for every Indian." />

<!-- URL of your website -->
<meta property="og:url" content="https://banku.co.in/" />

<!-- Image that will show when shared -->
<meta property="og:image" content="https://banku.co.in//Website/assets/images/org/home.jpeg" />
<meta property="og:image:width" content="1200" />
<meta property="og:image:height" content="630" />

<!-- Type of content -->
<meta property="og:type" content="website" />

<!-- For Twitter (optional) -->
<meta name="twitter:card" content="summary_large_image" />
<meta name="twitter:image" content="https://banku.co.in//Website/assets/images/org/home.jpeg" />
  <!-- favicon  -->
  <link rel="shortcut icon" href="Website/assets/images/BankU1/logo-removebg.png" type="image/x-icon">
  <!-- faremwork of css -->
  <link rel="stylesheet" href="Website/assets/css/bootstrap-lib/bootstrap.min.css">
  <!-- style sheet of css -->
  <link rel="stylesheet" href="Website/assets/css/style.css">
  <!-- Responsive sheet of css -->
  <link rel="stylesheet" href="Website/assets/css/responsive.css">
  <!-- fonts awsome icon link  -->
  <link rel="stylesheet" href="Website/assets/font-awesome-lib/icon/font-awesome.min.css">
  <!-- slick-slider link css -->
  <link rel="stylesheet" href="Website/assets/css/slick.min.css">
  <!-- animation of css -->
  <link rel="stylesheet" href="Website/assets/css/aos.css">
<!-- ✅ LOGIN FORM in new design -->
<style>
    @media (max-width: 991.98px) {
    .login-section {
        margin-left: 0% !important;
 }
}

@media (min-width: 992px) {
    .login-section {
        margin-left: 15% !important;
    }
}

  .dropdown-menu {
    transition: all 0.3s ease;
  }
  .dropdown-menu .col {
    min-width: 180px;
  }
  .dropdown-menu h6 {
    font-size: 14px;
    font-weight: 600;
  }
  @media (max-width: 991.98px) {
  .dropdown-menu {
    overflow-x: hidden;
    overflow-y: auto;
    max-height: 80vh;
  }

  .tab-content {
    overflow-x: hidden;
  }
}
  @media (max-width: 991.98px) {
  .dropdown-menu {
    position: static !important;
    float: none;
    width: 100% !important;
    margin-top: 0;
    box-shadow: none !important;
  }

  .navbar-nav {
    flex-direction: column;
    gap: 0.5rem;
  }

  .dropdown .dropdown-menu {
    padding: 1rem 0.5rem;
  }

  .nav-logo img {
    height: 40px;
  }

  .open-aside {
    display: block;
  }

  .hover1.down-btn {
    font-size: 14px;
    padding: 6px 10px;
  }
}

@media (min-width: 992px) {
  .open-aside {
    display: none !important;
  }
}
</style>

    <style>
  #productMenu {
    background-color: #141224; /* match sidebar bg */
    color: white;
  }

  .dropdown-item {
    padding: 10px 15px;
    border-bottom: 1px solid rgba(255, 255, 255, 0.1);
  }

  .dropdown-item > div {
    cursor: pointer;
    display: flex;
    justify-content: space-between;
    align-items: center;
    color: white;
    font-weight: 500;
    font-size: 16px;
    padding: 8px 10px;
    transition: background 0.3s ease;
  }

  .dropdown-item > div:hover {
    background-color: rgba(255, 255, 255, 0.05);
    border-radius: 6px;
  }
 .submenu-list {
  list-style: none;
  padding-left: 20px;
  margin-top: 8px;
  margin-bottom: 8px;
  background-color: transparent !important; /* Ensures it doesn't default to white */
   transition: all 0.3s ease;
}
  .submenu-list li a {
    display: block;
    padding: 6px 0;
    color: #cfcfcf;
    font-size: 14px;
    text-decoration: none;
  }
  .dropdown-item {
  background-color: transparent;
}

.dropdown-item ul.submenu-list li a {
  color: #ccc;
  font-size: 14px;
}

.dropdown-item ul.submenu-list li a:hover {
  color: #fff;
}
  .submenu-list li a:hover {
    color: #fff;
    font-weight: 500;
  }

  .fa-caret-down {
    color: #a891f5;
    font-size: 14px;
  }

  /* Back button gradient fix */
  .btn-primary {
    background: linear-gradient(100.57deg, #3006A4 12.93%, #FFA37B 121.02%) !important;
    border: none;
    border-radius: 30px;
    padding: 6px 18px;
    font-weight: 500;
  }

  .btn-primary:hover {
    opacity: 0.9;
  }
</style>
  
  
	<script type="text/javascript">
    document.addEventListener('DOMContentLoaded', function () {
        const blockEvents = ['copy', 'cut', 'paste', 'contextmenu', 'selectstart', 'dragstart'];
        blockEvents.forEach(evt => {
            document.addEventListener(evt, function(e) {
                e.preventDefault();
            });
        });

        // Safari specific workaround
        document.body.style.webkitTouchCallout = "none";
    });
    </script>
</head>
<body oncontextmenu="return false;" onselectstart="return false;" ondragstart="return false;" oncopy="return false;" oncut="return false;" onpaste="return false;">
      <form id="form1" runat="server">
      
            <div class="site-wrapper">
    <!-- ======== 1.1. Header section ======== -->
    <header>
      <nav class="navbar navbar-expand-lg container pt-lg-6 pt-3 pb-lg-4 pb-3" >
        <div class="container-fluid justify-content-lg-start justify-content-between" style="box-shadow: 0px 10px 20px rgba(0, 0, 0, 0.2); background-color:white; border-radius:20px; padding:10px">
          <!-- site logo -->
          <a class="nav-logo p-0" href="https://www.banku.co.in/Default.aspx">
            <figure><img src="Website/assets/images/org/1.png" alt="logo" style="margin-left:10px"></figure>
          </a>
          <!-- navigation button  -->
          <div class="d-flex gap-3 flex-row-reverse" >
            <button class="open-aside" onclick="open_aside()" type="button">
              <i class="fa-solid fa-bars"></i>
            </button>
            <!-- navigation bar manu  -->
            <div class="d-flex justify-content-between gap-xl-4 gap-lg-3 w-100 align-items-center" >
              <div class="collapse navbar-collapse " id="navbarSupportedContent" >
                <ul
                  class="navbar-nav d-flex justify-content-center align-items-center gap-lg-4 gap-md-3 gap-sm-2 gap-2 mb-2 mb-lg-0">

                    <li class="nav-item dropdown position-static">
                      <a class="nav-link d-flex align-item-center gap-1" style="color:black" href="#">Products
                        <i class="fa-sharp fa-solid fa-sort-down ms-1"></i>
                      </a>

                      <!-- Mega Menu Starts -->
                      <div class="dropdown-menu w-100 border-0 shadow-lg p-4" style="max-width: 850px;  border-radius: 12px; background-color:white; min-height:350px">

                        <div class="d-flex">
                          <!-- Left Menu -->
                          <div class="pe-3 border-end" style="width: 220px;">
                            <ul class="nav flex-column" id="service-tabs">
                              <li class="nav-item">
                                <a class="nav-link active" href="#" data-tab="banking" style="color:black">Banking</a>
                              </li>
                              <li class="nav-item">
                                <a class="nav-link" href="#" data-tab="payments1" style="color:black">Payments</a>
                              </li>
                              <li class="nav-item">
                                <a class="nav-link" href="#" data-tab="insurance" style="color:black">Insurance</a>
                              </li>
                              <li class="nav-item">
                                <a class="nav-link" href="#" data-tab="identity" style="color:black">Identity Verification</a>
                              </li>
                              <li class="nav-item">
                                <a class="nav-link" href="#" data-tab="others" style="color:black">Other Services</a>
                              </li>
                            </ul>
                          </div>

                          <!-- Right Content -->
                          <div class="flex-grow-1 ps-3">
                            <div class="tab-content" id="service-content">

                              <!-- Banking -->
                              <div class="tab-pane fade show active" id="banking" >
                                <div class="row row-cols-2 g-3">
                                  <div class="col">
                                    <div class="border rounded p-3  shadow-sm" style="height:120px">
                                      <img src="Website/assets/images/BankU1/home1.png" alt="Connected Banking" class="mb-2" style="height:30px">
                                      <a href="https://www.banku.co.in/ConnectedBanking.aspx"><h6 style="color:black">Cash Withdrawal</h6><p class="small text-muted mb-0">cash withdrawal using AePS.</p></a>
                                      
                                    </div>
                                  </div>
                                  <div class="col">
                                    <div class="border rounded p-3  shadow-sm" style="height:120px">
                                      <img src="Website/assets/images/BankU1/credit1.png" alt="Expense Card" class="mb-2" style="height:30px">
                                     <a href="https://www.banku.co.in/ExpenseCard.aspx"> <h6 style="color:black">Expense Card</h6>
                                      <p class="small text-muted mb-0">Manage corporate expenses</p></a>
                                    </div>
                                  </div>
                                  <div class="col">
                                    <div class="border rounded p-3  shadow-sm" style="height:120px">
                                      <img src="https://img.icons8.com/ios-filled/30/000000/gift-card.png" alt="Gift Card" class="mb-2">
                                      <a href="https://www.banku.co.in/Giftcard.aspx"><h6 style="color:black">Gift Card</h6>
                                      <p class="small text-muted mb-0">Thoughtful gifts for every occasion</p></a>
                                    </div>
                                  </div>
                                  <div class="col">
                                    <div class="border rounded p-3  shadow-sm" style="height:120px">
                                      <img src="https://img.icons8.com/ios-filled/30/000000/money-bag.png" alt="Working Capital" class="mb-2" />
                                      <a href="https://www.banku.co.in/Workingcapital.aspx"><h6 style="color:black">Working Capital</h6>
                                      <p class="small text-muted mb-0">Unsecured corporate loans</p></a>
                                    </div>
                                  </div>
                                </div>
                              </div>

                              <!-- Payments -->
                              <div class="tab-pane fade" id="payments1">
  <div class="row row-cols-1 row-cols-md-3 g-3">
    
    <div class="col" >
      <div class="border rounded p-3  shadow-sm" style="height:140px">
        <img src="Website/assets/images/BankU1/home1.png" alt="Connected Banking" class="mb-2" style="height:30px">
        <a href="https://www.banku.co.in/Singlepayout.aspx">
          <h6 style="color:black">Payouts</h6>
          <p class="small text-muted mb-0">Payment Disbursal Simplified</p>
        </a>
      </div>
    </div>

    <div class="col">
      <div class="border rounded p-3  shadow-sm" style="height:140px">
        <img src="Website/assets/images/BankU1/credit1.png" alt="Expense Card" class="mb-2" style="height:30px">
        <a href="https://www.banku.co.in/sound_box.aspx">
          <h6 style="color:black">Sound Box</h6>
          <p class="small text-muted mb-0">Large-scale payments in click</p>
        </a>
      </div>
    </div>

    <div class="col">
      <div class="border rounded p-3 shadow-sm" style="height:140px">
        <img src="https://img.icons8.com/ios-filled/30/000000/gift-card.png" alt="Gift Card" class="mb-2">
        <a href="https://www.banku.co.in/PaymentGateway.aspx">
          <h6 style="color:black">Payment Gateway</h6>
          <p class="small text-muted mb-0">One gateway, all payment modes</p>
        </a>
      </div>
    </div>

    <div class="col">
      <div class="border rounded p-3 shadow-sm" style="height:140px">
        <img src="https://img.icons8.com/ios-filled/30/000000/home.png" alt="Property Insurance" class="mb-2">
        <a href="https://www.banku.co.in/BillPayments.aspx">
          <h6 style="color:black">Bill Payments</h6>
          <p class="small text-muted mb-0">Pay bills anywhere, anytime</p>
        </a>
      </div>
    </div>

    <div class="col">
      <div class="border rounded p-3  shadow-sm" style="height:140px">
        <img src="https://img.icons8.com/ios-filled/30/000000/gift-card.png" alt="Gift Card" class="mb-2">
        <a href="https://www.banku.co.in/Pos.aspx">
          <h6 style="color:black">POS</h6>
          <p class="small text-muted mb-0">Contactless point-of-Sale transaction</p>
        </a>
      </div>
    </div>

    <div class="col"  >
      <div class="border rounded p-3  shadow-sm" style="height:140px">
       <img src="https://img.icons8.com/ios-filled/30/000000/home.png" alt="Property Insurance" class="mb-2">
        <a href="https://www.banku.co.in/BNPL.aspx">
          <h6 style="color:black">Buy Now, Pay Later</h6>
          <p class="small text-muted mb-0">Instant credit for online shopping</p>
        </a>
      </div>
    </div>
  </div>                        
</div>
                              <!-- Insurance -->
                              <div class="tab-pane fade" id="insurance">
                                <div class="row row-cols-2 g-3">
                                  <div class="col">
                                    <div class="border rounded p-3 shadow-sm" style="height:120px">
                                      <img src="Website/assets/images/BankU1/home1.png" alt="Connected Banking" class="mb-2" style="height:30px">
                                     <a href="https://www.banku.co.in/GeneralInsurance.aspx"> <h6 style="color:black">General Insurance  </h6>
                                      <p class="small text-muted mb-0">Safeguard all corporate assets</p></a>
                                    </div>
                                  </div>
                                  <div class="col">
                                    <div class="border rounded p-3  shadow-sm" style="height:120px">
                                      <img src="Website/assets/images/BankU1/credit1.png" alt="Expense Card" class="mb-2" style="height:30px">
                                      <a href="https://www.banku.co.in/HealthInsurance.aspx"><h6 style="color:black">Health Insurance</h6>
                                      <p class="small text-muted mb-0">All-inclusive health coverage</p></a>
                                    </div>
                                  </div>
                                  <div class="col">
                                    <div class="border rounded p-3  shadow-sm" style="height:140px">
                                      <img src="https://img.icons8.com/ios-filled/30/000000/gift-card.png" alt="Gift Card" class="mb-2">
                                     <a href="https://www.banku.co.in/LifeInsurance.aspx"> <h6 style="color:black">Life Insurance</h6>
                                      <p class="small text-muted mb-0">Protect workforce with life coverage</p></a>
                                    </div>
                                  </div>
                                  
                                </div>
                              </div>

                              <!-- Identity Verification -->
                              <div class="tab-pane fade" id="identity">
                               <div class="row row-cols-2 g-3">
                                  <div class="col">
                                    <div class="border rounded p-3  shadow-sm" style="height:120px">
                                      <img src="Website/assets/images/BankU1/home1.png" alt="Connected Banking" class="mb-2" style="height:30px">
                                     <a href="https://www.banku.co.in/IndividualVerification.aspx"> <h6 style="color:black">Individual Verification</h6>
                                      <p class="small text-muted mb-0">Get user Verified in minutes</p></a>
                                    </div>
                                  </div>
                                  <div class="col">
                                    <div class="border rounded p-3  shadow-sm" style="height:120px">
                                      <img src="Website/assets/images/BankU1/credit1.png" alt="Expense Card" class="mb-2" style="height:30px">
                                      <a href="https://www.banku.co.in/BusinessVerification.aspx"><h6 style="color:black">Business Verification</h6>
                                      <p class="small text-muted mb-0">Verify business partners</p></a>
                                    </div>
                                  </div>
                                  <div class="col">
                                    <div class="border rounded p-3  shadow-sm" style="height:120px">
                                      <img src="https://img.icons8.com/ios-filled/30/000000/gift-card.png" alt="Gift Card" class="mb-2">
                                      <a href="https://www.banku.co.in/FinancialVerification.aspx"><h6 style="color:black">Financial Verification</h6>
                                      <p class="small text-muted mb-0">Assess financial credibility</p></a>
                                    </div>
                                  </div>
                                  <div class="col">
                                    <div class="border rounded p-3  shadow-sm" style="height:120px">
                                      <img src="https://img.icons8.com/ios-filled/30/000000/money-bag.png" alt="Working Capital" class="mb-2">
                                      <a href="https://www.banku.co.in/GEOIntelligence.aspx"><h6 style="color:black">Geo Intelligence</h6>
                                      <p class="small text-muted mb-0">Location-based insights</p></a>
                                    </div>
                                  </div>
                                </div>
                              </div>

                              <!-- Other Services -->
                              <div class="tab-pane fade" id="others">
                               <div class="row row-cols-2 g-3">
                                  <div class="col">
                                    <div class="border rounded p-3  shadow-sm" style="height:140px">
                                      <img src="Website/assets/images/BankU1/home1.png" alt="Connected Banking" class="mb-2" style="height:30px">
                                      <a href="https://www.banku.co.in/BankingAgent.aspx"><h6 style="color:black">Become a Banking Agent</h6>
                                      <p class="small text-muted mb-0">Offer Banking Services in your neighbourhood</p></a>
                                    </div>
                                  </div>
                                  <div class="col">
                                    <div class="border rounded p-3  shadow-sm" style="height:140px">
                                      <img src="Website/assets/images/BankU1/credit1.png" alt="Expense Card" class="mb-2" style="height:30px">
                                      <a href="https://www.banku.co.in/InsuranceAgent.aspx"><h6 style="color:black">Become a Distributor</h6>
                                      <p class="small text-muted mb-0">Start earning as Channel Partner in your City</p></a>
                                    </div>
                                  </div>
                                  
                                </div>
                              </div>
                            </div>
                          </div>
                        </div>
                      </div>
                      <!-- Mega Menu Ends -->

                    </li>
                  <li class="nav-item dropdown position-static">
                      <a class="nav-link d-flex align-item-center gap-1" style="color:black" href="#">Developer
                        <i class="fa-sharp fa-solid fa-sort-down ms-1"></i>
                      </a>

                      <!-- Mega Menu Starts -->
                      <div class="dropdown-menu w-100 border-0 shadow-lg p-4" style="max-width: 700px; border-radius: 12px;  background-color:white"">

                        <div class="d-flex">
                          <!-- Left Menu -->
                          <div class="pe-3 border-end" style="width: 220px;">
                            <ul class="nav flex-column" id="dev-tabs">
                              <li class="nav-item">
                                <a class="nav-link active" href="https://developers.banku.co.in/docs/getting-started" target="_blank" data-tab="api" style="color:black">Documentation & Guides</a>
                              </li>
                              <li class="nav-item">
                                <a class="nav-link" href="#" data-tab="sdk" style="color:black">Developer API</a>
                              </li>
                              
                            </ul>
                          </div>

                          <!-- Right Content -->
                          <div class="flex-grow-1 ps-3">
                            <div class="tab-content" id="dev-content">

                              <!-- API Docs -->
                              <div class="tab-pane fade show active" id="api">
                                <div class="row row-cols-2 g-3">
                                  <div class="col">
                                    <div class="border rounded p-3  shadow-sm" style="height:100px">
                                      <img src="https://img.icons8.com/ios-filled/30/000000/api-settings.png" class="mb-2" />
                                     <a href="https://www.banku.co.in/DeveloperAPI.aspx"> <h6 style="color:black">Developer API's</h6></a>
                 
                                    </div>
                                  </div>
                                  <div class="col">
                                    <div class="border rounded p-3  shadow-sm" style="height:100px">
                                      <img src="https://img.icons8.com/ios-filled/30/000000/webhook.png" class="mb-2" />
                                      <a href="https://developers.banku.co.in/" target="_blank"><h6 style="color:black">API Documentation</h6></a>
                              
                                    </div>
                                  </div>
                                    <div class="col">
                                    <div class="border rounded p-3  shadow-sm" style="height:100px">
                                      <img src="https://img.icons8.com/ios-filled/30/000000/webhook.png" class="mb-2" />
                                      <a href="https://developers.banku.co.in/docs/getting-started" target="_blank"><h6 style="color:black">Integration Guide</h6></a>
                       
                                    </div>
                                  </div>
                                </div>
                              </div>

                              <!-- SDKs -->
                              <div class="tab-pane fade" id="sdk">
                                <div class="row row-cols-2 g-3">
                                  <div class="col">
                                    <div class="border rounded p-3 shadow-sm" style="height:100px">
                                      <img src="https://img.icons8.com/ios-filled/30/000000/source-code.png" class="mb-2" />
                                      <a href="https://developers.banku.co.in/docs/reference/payouts-api" target="_blank"> <h6 style="color:black"> Automate Payouts </h6></a>
                           
                                    </div>
                                  </div>
                                  <div class="col">
                                    <div class="border rounded p-3 shadow-sm" style="height:100px">
                                      <img src="https://img.icons8.com/ios-filled/30/000000/source-code.png" class="mb-2" />
                                      <a href="https://developers.banku.co.in/docs/reference/marketplace-utility-bill-payments-overview" target="_blank"><h6 style="color:black">Manage & Pay All Bills</h6></a>
                          
                                    </div>
                                  </div>
                                    <div class="col">
                                    <div class="border rounded p-3  shadow-sm" style="height:100px">
                                      <img src="https://img.icons8.com/ios-filled/30/000000/source-code.png" class="mb-2" />
                                      <a href="https://developers.banku.co.in/docs/reference/banking-overview" target="_blank"><h6 style="color:black">Banking Services</h6></a>
                                  
                                    </div>
                                  </div>
                                    <div class="col">
                                    <div class="border rounded p-3  shadow-sm" style="height:100px">
                                      <img src="https://img.icons8.com/ios-filled/30/000000/source-code.png" class="mb-2" />
                                      <a href="https://developers.banku.co.in/reference/collect-overview" target="_blank"><h6 style="color:black">Collect Money</h6></a>
                                 
                                    </div>
                                  </div>
                                </div>
                              </div>

                              <!-- Sandbox -->
                              <div class="tab-pane fade" id="sandbox">
                                <p>Access to developer testing environment.</p>
                              </div>

                              <!-- Integration Guide -->
                              <div class="tab-pane fade" id="integration">
                                <p>Step-by-step integration tutorials.</p>
                              </div>

                              <!-- Support -->
                              <div class="tab-pane fade" id="support">
                                <p>Submit tickets, read FAQs, and get help from our team.</p>
                              </div>

                            </div>
                          </div>
                        </div>
                      </div>
                      <!-- Mega Menu Ends -->

                    </li>
                    
                  <li class="nav-item dropdown position-static">
                      <a class="nav-link d-flex align-item-center gap-1" style="color:black" href="#">Solutions
                        <i class="fa-sharp fa-solid fa-sort-down ms-1"></i>
                      </a>

                      <!-- Mega Menu Starts -->
                      <div class="dropdown-menu w-100 border-0 shadow-lg p-4" style="max-width: 600px; border-radius: 16px;background-color:white">

                        <!-- Grid Section -->
                        <div class="row row-cols-4 g-3 px-2">
                          <div class="col">
                            <div class="border rounded-3 p-3 text-center shadow-sm " style="height:100px">
                              <img src="https://img.icons8.com/ios-filled/30/shopping-cart.png" class="mb-2" />
                              <a href="https://www.banku.co.in/Ecommerce.aspx"><h6 class="mb-1" style="color:black">E-Commerce</h6></a>
                            </div>
                          </div>
                          <div class="col">
                            <div class="border rounded-3 p-3 text-center shadow-sm " style="height:100px">
                              <img src="https://img.icons8.com/ios-filled/30/delivery.png" class="mb-2" />
                              <a href="https://www.banku.co.in/Logistic.aspx"><h6 class="mb-1" style="color:black">Logistics</h6></a>
                            </div>
                          </div>
                          <div class="col">
                            <div class="border rounded-3 p-3 text-center shadow-sm " style="height:100px">
                              <img src="https://img.icons8.com/ios-filled/30/money.png" class="mb-2" />
                              <a href="https://www.banku.co.in/fmcg.aspx"><h6 class="mb-1" style="color:black">FMCG</h6></a>
                            </div>
                          </div>
                          
                          <div class="col">
                            <div class="border rounded-3 p-3 text-center shadow-sm " style="height:100px">
                              <img src="https://img.icons8.com/ios-filled/30/heart-health.png" class="mb-2" />
                              <a href="https://www.banku.co.in/Healthcare.aspx"><h6 class="mb-1" style="color:black">Healthcare</h6></a>
                            </div>
                          </div>
                          <div class="col">
                            <div class="border rounded-3 p-3 text-center shadow-sm " style="height:100px">
                              <img src="https://img.icons8.com/ios-filled/30/shopping-bag.png" class="mb-2" />
                              <a href="https://www.banku.co.in/Marketplace.aspx"><h6 class="mb-1" style="color:black">Marketplace</h6></a>
                            </div>
                          </div>
                          <div class="col">
                            <div class="border rounded-3 p-3 text-center shadow-sm " style="height:100px">
                              <img src="https://img.icons8.com/ios-filled/30/graduation-cap.png" class="mb-2" />
                              <a href="https://www.banku.co.in/Education.aspx"><h6 class="mb-1" style="color:black">Education</h6></a>
                            </div>
                          </div>
                          
                        </div>

                      </div>
                      <!-- Mega Menu Ends -->
                    </li>
                  <li class="dropdown">
                    <a class="nav-link d-flex align-item-center gap-1" style="color:black">Company<i
                        class="fa-sharp fa-solid fa-sort-down"></i></a>
                    <ul class="dropdown-menu">
                      <li><a class="dropdown-item" href="https://www.banku.co.in/AboutUs.aspx">About Us</a></li>
                      <li>
                        <a class="dropdown-item" href="https://www.banku.co.in/Careers.aspx">Careers</a>
                      </li>
                      <li><a class="dropdown-item" href="https://www.banku.co.in/Contact.aspx">Contact Us</a></li>
                      
                    </ul>
                  </li>
                  
                  <li class="nav-item">
                    <a class="nav-link" href="https://www.banku.co.in/Blogs.aspx" style="color:black">Blog</a>
                  </li>
                </ul>
              </div>
              <div>
                <a href="LoginBankU.aspx" class="hover1 down-btn" id="LoginAnchor" >Login</a>
              </div>
              
            </div>
          </div>
        </div>
      </nav>
      <!--===== aside navigation slidebar =====-->
      <aside>
          <div id="mySidenav" class="right-sidbar">
            <div class="side-nav-logo d-flex justify-content-between align-items-center ps-2 pe-1 nav-logo">
              <figure class="navbar-brand">
                <a href="https://www.banku.co.in/Default.aspx">
                  <img src="Website/assets/images/BankU1/21.png" alt="logo" style="margin-left:10px">
                </a>
              </figure>
              <button type="button"  class="fa-solid fa-xmark" onclick="close_aside()"></button>
            </div>

           <!-- Main Menu -->
        <ul id="mainMenu" class="pt-4">
  
          <li class="nav-item"><a href="#" onclick="showSubMenu('productMenu')" style="color:white">Products</a></li>
          <li class="nav-item"><a href="#" onclick="showSubMenu('devMenu')" style="color:white">Developer's Hub</a></li>
          <li class="nav-item"><a href="#" onclick="showSubMenu('solutionMenu')" style="color:white">Solutions</a></li>
          <li class="nav-item"><a href="#" onclick="showSubMenu('companyMenu')" style="color:white">Company</a></li>
           <li class="nav-item"><a href="https://www.banku.co.in/Blogs.aspx"  style="color:white">Blog</a></li>
          <li class="nav-item"><a href="#"  style="color:white;border-radius: 10px;padding: 8px 30px; background: linear-gradient(100.57deg, #3006A4 12.93%, #FFA37B 121.02%">Login</a></li>
        </ul>

        <!-- Submenus -->
                            <ul id="productMenu" class="submenu d-none pt-4 text-white">
                              <!-- Back Button -->
                              <li>
                                <button type="button" onclick="showMainMenu()" 
                                  class="btn btn-primary ps-3 text-white mb-3"
                                  style="border-radius: 30px; background: linear-gradient(100.57deg, #3006A4 12.93%, #FFA37B 121.02%)">
                                  ← Back
                                </button>
                              </li>

                              <!-- Banking Dropdown -->
                              <li class="Drppp12" >
                                <div class="d-flex justify-content-between align-items-center" onclick="toggleDropdown(this)">
                                  <span style="color:white">Banking</span>
                                  <i class="fa-solid fa-caret-down ps-2"></i>
                                </div>
                                <ul class="submenu-list d-none ps-3">
                                  <li><a class="text-white" href="https://www.banku.co.in/ConnectedBanking.aspx">Connected Banking</a></li>
                                  <li><a class="text-white" href="https://www.banku.co.in/ExpenseCard.aspx">Expense Card</a></li>
                                  <li><a class="text-white" href="https://www.banku.co.in/Giftcard.aspx">Gift Banking</a></li>
                                  <li><a class="text-white" href="https://www.banku.co.in/Workingcapital.aspx">Working Capital</a></li>
                                </ul>
                              </li>

                              <!-- Payment Dropdown -->
                              <li class="Drppp12">
                                <div class="d-flex justify-content-between align-items-center" onclick="toggleDropdown(this)">
                                  <span>Payment</span>
                                  <i class="fa-solid fa-caret-down ps-2"></i>
                                </div>
                                <ul class="submenu-list d-none ps-3">
                                  <li><a class="text-white" href="https://www.banku.co.in/Singlepayout.aspx">Single Payout</a></li>
                                  <li><a class="text-white" href="https://www.banku.co.in/BulkPayouts.aspx">Bulk Payout</a></li>
                                  <li><a class="text-white" href="https://www.banku.co.in/PaymentGateway.aspx">Payment Gateway</a></li>
                                  <li><a class="text-white" href="https://www.banku.co.in/BillPayments.aspx">Bill Payment</a></li>
                                  <li><a class="text-white" href="https://www.banku.co.in/Pos.aspx">POS</a></li>
                                    <li><a class="text-white" href="https://www.banku.co.in/BNPL.aspx">BNPL</a></li>
                                </ul>
                              </li>

                              <!-- Insurance Dropdown -->
                              <li class="Drppp12">
                                <div class="d-flex justify-content-between align-items-center" onclick="toggleDropdown(this)">
                                  <span>Insurance</span>
                                  <i class="fa-solid fa-caret-down ps-2"></i>
                                </div>
                                <ul class="submenu-list d-none ps-3">
                                  <li><a class="text-white" href="https://www.banku.co.in/HealthInsurance.aspx">Health Insurance</a></li>
                                  <li><a class="text-white" href="https://www.banku.co.in/LifeInsurance.aspx">Life Insurance</a></li>
                                  <li><a class="text-white" href="https://www.banku.co.in/GeneralInsurance.aspx">General Insurance</a></li>
                                </ul>
                              </li>

                              <!-- Identity Verification Dropdown -->
                              <li class="Drppp12">
                                <div class="d-flex justify-content-between align-items-center" onclick="toggleDropdown(this)">
                                  <span>Identity Verification</span>
                                  <i class="fa-solid fa-caret-down ps-2"></i>
                                </div>
                                <ul class="submenu-list d-none ps-3">
                                  <li><a class="text-white" href="https://www.banku.co.in/IndividualVerification.aspx">Individual Verification</a></li>
                                  <li><a class="text-white" href="https://www.banku.co.in/BusinessVerification.aspx">Business Verification</a></li>
                                  <li><a class="text-white" href="https://www.banku.co.in/FinancialVerification.aspx">Financial Verification</a></li>
                                  <li><a class="text-white" href="https://www.banku.co.in/GEOIntelligence.aspx">Geo Intelligence</a></li>
                                </ul>
                              </li>

                             <li class="Drppp12">
                                <div class="d-flex justify-content-between align-items-center" onclick="toggleDropdown(this)">
                                  <span>Other Services</span>
                                  <i class="fa-solid fa-caret-down ps-2"></i>
                                </div>
                                <ul class="submenu-list d-none ps-3">
                                  <li><a class="text-white" href="https://www.banku.co.in/BankingAgent.aspx">Become a Banking Agent</a></li>
                                  <li><a class="text-white" href="https://www.banku.co.in/distributor.aspx">Become a Distributor</a></li>
                                  
                                </ul>
                              </li>
                            </ul>



                            <ul id="devMenu" class="submenu d-none pt-4 text-white">
                              <!-- Back Button -->
                              <li>
                                <button type="button" onclick="showMainMenu()" 
                                  class="btn btn-primary ps-3 text-white mb-3"
                                  style="border-radius: 30px; background: linear-gradient(100.57deg, #3006A4 12.93%, #FFA37B 121.02%)">
                                  ← Back
                                </button>
                              </li>

                              <!-- Banking Dropdown -->
                              <li class="Drppp12">
                                <div class="d-flex justify-content-between align-items-center" onclick="toggleDropdown(this)">
                                  <span style="color:white">Documentation & Guides</span>
                                  <i class="fa-solid fa-caret-down ps-2"></i>
                                </div>
                                <ul class="submenu-list d-none ps-3">
                                  <li><a class="text-white" href="DeveloperAPI.aspx">Developer API's</a></li>
                                  <li><a class="text-white" href="https://developers.banku.co.in/" target="_blank">API Documentation</a></li>
                                  <li><a class="text-white" href="https://developers.banku.co.in/" target="_blank">Integration Guide</a></li>
                                  
                                </ul>
                              </li>

                              <!-- Payment Dropdown -->
                              <li class="Drppp12">
                                <div class="d-flex justify-content-between align-items-center" onclick="toggleDropdown(this)">
                                  <span>Developer API</span>
                                  <i class="fa-solid fa-caret-down ps-2"></i>
                                </div>
                                <ul class="submenu-list d-none ps-3">
                                  <li><a class="text-white" href="https://www.banku.co.in/PayoutAPI.aspx">Automate Your Payouts</a></li>
                                  <li><a class="text-white" href="https://www.banku.co.in/UtilityBillPayments.aspx">Manage & Pay All Bills</a></li>
                                  <li><a class="text-white" href="https://www.banku.co.in/BankingServices.aspx">Banking Services</a></li>
                                  <li><a class="text-white" href="https://www.banku.co.in/CollectMoney.aspx">Collect Money</a></li>
                                  
                                </ul>
                              </li>

                            </ul>

                            <ul id="solutionMenu" class="submenu d-none pt-4 text-white">
                              <li><button type="button" onclick="showMainMenu()" class="btn btn-primary ps-0 text-white" style="border-radius:30px; background: linear-gradient(100.57deg, #3006A4 12.93%, #FFA37B 121.02%)">← Back</button></li>
                              <li><a class="text-white" href="https://www.banku.co.in/Ecommerce.aspx">E-Commerce</a></li>
                              <li><a class="text-white" href="https://www.banku.co.in/Healthcare.aspx">Health Care</a></li>
                              <li><a class="text-white" href="https://www.banku.co.in/Logistic.aspx">Logistics</a></li>
                              <li><a class="text-white" href="https://www.banku.co.in/Lending.aspx">Lending</a></li>
                              <li><a class="text-white" href="https://www.banku.co.in/Education.aspx">Education</a></li>
                              <li><a class="text-white" href="https://www.banku.co.in/FMCG.aspx">FMGC</a></li>
                            </ul>

                            <ul id="companyMenu" class="submenu d-none pt-4 text-white">
                              <li><button type="button" onclick="showMainMenu()" class="btn btn-primary ps-0 text-white" style="border-radius:30px; background: linear-gradient(100.57deg, #3006A4 12.93%, #FFA37B 121.02%)">← Back</button></li>
                              <li><a class="text-white" href="https://www.banku.co.in/AboutUs.aspx">About Us</a></li>
                              <li><a class="text-white" href="https://www.banku.co.in/Careers.aspx">Careers</a></li>
                              <li><a class="text-white" href="https://www.banku.co.in/Contact.aspx">Contact Us</a></li>
                            </ul>
       
                          </div>
                        </aside>
    </header>
                
    <!-- ======== 1.7. Benefits section ======== -->
    <section class="Benefits">
        <div class="container">
            <div class="row">
                <!-- section now on left -->
                <div class="col-lg-5 d-none d-lg-block">
                    <figure class="position-relative pt-5 pt-lg-0" data-aos="zoom-in-up">
                        <img class="w-100" src="Website/assets/images/org/LOGIN_HOME.png" alt="mobile"/>
                    </figure>
                </div>
            
                <div class="col-lg-5 d-flex align-items-center justify-content-center bg-white login-section" style="padding: 40px;">
                    <div class="w-100" style="max-width: 400px;">
                        <h3 class="mb-4">Get Started</h3>
                        <div class="form-group mb-3">
                             <asp:Label runat="server"  ID="lblPanName"></asp:Label>
                        </div>
                    
                   
                     <!-- ✅ Add hidden fields here -->
                     <asp:HiddenField ID="hdnLatitude" runat="server" />
                     <asp:HiddenField ID="hdnLongitude" runat="server" />
                     <asp:HiddenField ID="hdnAddress" runat="server" />
                     <asp:HiddenField ID="hdnAadhaarRefId" runat="server" />
                     <asp:HiddenField ID="hdnGender" runat="server" />
                     <asp:HiddenField ID="hdnDOB" runat="server" />
                     <asp:HiddenField ID="hdnFatherName" runat="server" />
                     <asp:HiddenField ID="hdnstate" runat="server" />
                     <asp:HiddenField ID="hdnpostal" runat="server" />
                     <asp:HiddenField ID="hdnBankName" runat="server" />
                     <asp:HiddenField ID="hdnAccHolderName" runat="server" />
                     <asp:HiddenField ID="hdnImage" runat="server" />

                        
                     <asp:MultiView ID="mvSteps" runat="server" ActiveViewIndex="0">

                                <!-- Step 1: PAN & MPIN -->
                                <asp:View ID="viewStep1" runat="server">
                                    <div class="form-group mb-3">
                                        <asp:TextBox ID="TextBox1" runat="server" CssClass="form-control text-dark"
                                            MaxLength="10" Placeholder="Enter PAN"
                                            style="border: 1px solid red; border-radius: 6px; height: 45px; -webkit-text-fill-color:black">
                                        </asp:TextBox>

                                        <asp:RegularExpressionValidator 
                                            ID="revPAN" 
                                            runat="server" 
                                            ControlToValidate="TextBox1"
                                            ErrorMessage="Enter a valid PAN (e.g., ABCDE1234F)"
                                            ForeColor="Red" 
                                            Display="Dynamic"
                                            ValidationExpression="^[A-Z]{5}[0-9]{4}[A-Z]{1}$">
                                        </asp:RegularExpressionValidator>
                                    </div>
                                    <div class="form-group mb-3">
                                        <asp:TextBox ID="txtMPIN" onkeypress="return onlyNumbers(event)" runat="server" MaxLength="4" CssClass="form-control text-dark" Placeholder="MPIN" style="border: 1px solid red; border-radius: 6px; height: 45px; -webkit-text-fill-color:black"></asp:TextBox>
                                    </div>
                                    <div class="form-group mb-3">
                                        <asp:TextBox ID="txtConfMPIN" onkeypress="return onlyNumbers(event)" runat="server" MaxLength="4" CssClass="form-control text-dark" Placeholder="Confirm MPIN" style="border: 1px solid red; border-radius: 6px; height: 45px; -webkit-text-fill-color:black"></asp:TextBox>
                                    </div>
                                </asp:View>

                                <!-- Step 2: Business Details -->
                                <asp:View ID="viewStep2" runat="server">
                                    <div class="form-group mb-3">
                                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control text-dark" Placeholder="Email-Id" style="border: 1px solid red; border-radius: 6px; height: 45px; -webkit-text-fill-color:black"></asp:TextBox>
                                        <asp:RegularExpressionValidator 
                                            ID="revEmail" 
                                            runat="server" 
                                            ControlToValidate="txtEmail"
                                            ErrorMessage="Please enter a valid email address"
                                            ForeColor="Red"
                                            Display="Dynamic"
                                            ValidationExpression="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$">
                                        </asp:RegularExpressionValidator>
                                      </div>

                                    <div class="form-group mb-3">
                                        <asp:DropDownList ID="ddlAccType" runat="server" CssClass="form-control text-dark" style="border: 1px solid red; border-radius: 6px; height: 45px; -webkit-text-fill-color:black">
                                            <asp:ListItem Text="Select Account Type" Value="" />
                                            <asp:ListItem Text="BankU Seva Kendra" Value="BankU Seva Kendra" />
                                            <asp:ListItem Text="Distributor" Value="Distributor" />
                                            <asp:ListItem Text="Business & APIs" Value="Business & APIs" />
                                        </asp:DropDownList>
                                    </div>

                                    <div class="form-group mb-3">
                                        <asp:DropDownList ID="ddlBusinessType" runat="server"
                                            CssClass="form-control text-dark"
                                            AutoPostBack="true"
                                            OnSelectedIndexChanged="ddlBusinessType_SelectedIndexChanged"
                                            style="border: 1px solid red; border-radius: 6px; height: 45px; -webkit-text-fill-color:black;">
    
                                            <asp:ListItem Text="Select Nature of Business" Value="" />
                                            <asp:ListItem Text="Proprietorship" Value="Proprietorship" />
                                            <asp:ListItem Text="Partnership" Value="Partnership" />
                                            <asp:ListItem Text="Company" Value="Company" />
                                            <asp:ListItem Text="Trust and Society" Value="Trust and Society" />
                                            <asp:ListItem Text="PSU / Govt. Entitie" Value="PSU / Govt. Entitie" />
                                        </asp:DropDownList>

                                    </div>
                                </asp:View>

                                <!-- Step 3: KYC Details -->
                                <asp:View ID="viewStep3" runat="server">
                                    <div class="form-group mb-3">
                                        <asp:TextBox ID="txtBusiPan" runat="server" CssClass="form-control" Placeholder="Business Pan" style="border: 1px solid red; border-radius: 6px; height: 45px; -webkit-text-fill-color:black"></asp:TextBox>
                                    </div>
                                    <div class="form-group mb-3">
                                     
                                        <asp:DropDownList ID="ddlBusiProof" runat="server"
                                             onchange="handleBusiProofChange()"
                                            CssClass="form-control text-dark"
                                            style="border: 1px solid red; border-radius: 6px; height: 45px; -webkit-text-fill-color:black">
                                            <asp:ListItem Text="Select Business Proof" Value="" />
                                            <asp:ListItem Text="GST Registration Certificate" Value="GST" />
                                            <asp:ListItem Text="MSME / Udyam Registration" Value="UDYAM" />
                                            <asp:ListItem Text="Certificate of Incorporation" Value="CIN" />
                                        </asp:DropDownList>

                                    </div>

                                     <div class="form-group mb-3">
                                        <asp:TextBox ID="txtGSt" runat="server"  CssClass="form-control" Placeholder="GST Number" style="display:none; border: 1px solid red; border-radius: 6px; height: 45px; -webkit-text-fill-color:black"></asp:TextBox>
                                    </div>

                                     <div class="form-group mb-3">
                                        <asp:TextBox ID="txtBussName" runat="server"  CssClass="form-control" Placeholder="Business Name" style="display:none; border: 1px solid red; border-radius: 6px; height: 45px; -webkit-text-fill-color:black"></asp:TextBox>
                                    </div>

                                    <div class="form-group mb-3">
                                        <asp:TextBox ID="txtUdyam" runat="server" CssClass="form-control" Placeholder="Udyam Number" style=" display:none; border: 1px solid red; border-radius: 6px; height: 45px; -webkit-text-fill-color:black"></asp:TextBox>
                                    </div>

                                    <div class="form-group mb-3">
                                        <asp:TextBox ID="txtCIN" runat="server"  CssClass="form-control" Placeholder="CIN Number" style="display:none; border: 1px solid red; border-radius: 6px; height: 45px; -webkit-text-fill-color:black"></asp:TextBox>
                                    </div>

                                     <div class="form-group mb-3">
                                      <asp:DropDownList ID="ddlNature" runat="server" CssClass="form-control text-dark" style="border: 1px solid red; border-radius: 6px; height: 45px; -webkit-text-fill-color:black">
                                        <asp:ListItem Text="Select Nature of Business" Value="" />
                                        <asp:ListItem Text="Logistics & Supply Chain" Value="Logistics & Supply Chain" />
                                        <asp:ListItem Text="Waste Management & Recycling" Value="Waste Management & Recycling" />
                                        <asp:ListItem Text="Beauty & Personal Care Services" Value="Beauty & Personal Care Services" />
                                        <asp:ListItem Text="Media & Entertainment" Value="Media & Entertainment" />
                                        <asp:ListItem Text="Real Estate & Property Services" Value="Real Estate & Property Services" />
                                        <asp:ListItem Text="Transportation Services" Value="Transportation Services" />
                                        <asp:ListItem Text="Domestic & Informal Services" Value="Domestic & Informal Services" />
                                        <asp:ListItem Text="Defence & Aerospace" Value="Defence & Aerospace" />
                                        <asp:ListItem Text="eSports" Value="eSports" />
                                        <asp:ListItem Text="Green & Renewable Energy" Value="Green & Renewable Energy" />
                                        <asp:ListItem Text="Social Development (NGOs, SHG etc.)" Value="Social Development (NGOs, SHG etc.)" />
                                        <asp:ListItem Text="Event & Wedding Services" Value="Event & Wedding Services" />
                                        <asp:ListItem Text="Freelancing & Gig Economy" Value="Freelancing & Gig Economy" />
                                        <asp:ListItem Text="Scientific Research & Laboratories" Value="Scientific Research & Laboratories" />
                                        <asp:ListItem Text="Printing & Publishing" Value="Printing & Publishing" />
                                        <asp:ListItem Text="Security & Investigation" Value="Security & Investigation" />
                                        <asp:ListItem Text="Financial & Banking" Value="Financial & Banking" />
                                        <asp:ListItem Text="Telecom & Technology" Value="Telecom & Technology" />
                                        <asp:ListItem Text="Retail, Wholesale & FMCG" Value="Retail, Wholesale & FMCG" />
                                        <asp:ListItem Text="Education & EdTech" Value="Education & EdTech" />
                                        <asp:ListItem Text="E-commerce & Online Marketplaces" Value="E-commerce & Online Marketplaces" />
                                        <asp:ListItem Text="Infrastructure & Construction" Value="Infrastructure & Construction" />
                                        <asp:ListItem Text="IT & Software Services" Value="IT & Software Services" />
                                        <asp:ListItem Text="Training & Skill Development" Value="Training & Skill Development" />
                                        <asp:ListItem Text="Consulting & Compliance Services" Value="Consulting & Compliance Services" />
                                        <asp:ListItem Text="Travel, Tourism & Hospitality" Value="Travel, Tourism & Hospitality" />
                                        <asp:ListItem Text="B2B Service Aggregators" Value="B2B Service Aggregators" />
                                        <asp:ListItem Text="Others" Value="Others" />
                                    </asp:DropDownList>

                                    </div>
                                     
                                </asp:View>

                               
                         
                                <asp:View ID="viewStep4" runat="server">
                                   <div class="form-group mb-3">
                                        <asp:TextBox ID="txtAadhar" runat="server"  onkeypress="return event.charCode >= 48 && event.charCode <= 57"  MaxLength="12"  CssClass="form-control" Placeholder="Adhaar Number" style="border: 1px solid red; border-radius: 6px; height: 45px; -webkit-text-fill-color:black"></asp:TextBox>
                                          <asp:RegularExpressionValidator 
                                            ID="revAadhar" 
                                            runat="server" 
                                            ControlToValidate="txtAadhar"
                                            ErrorMessage="Enter a valid 12-digit Aadhaar number"
                                            ForeColor="Red" 
                                            Display="Dynamic"
                                            ValidationExpression="^\d{12}$">
                                        </asp:RegularExpressionValidator>
                                       </div>
                                      <!-- Resend OTP Button -->
                                    <div class="form-group mb-3 text-end">
                                        <asp:LinkButton ID="sendAadharOTP"
                                                        runat="server"
                                                         onclick="sendAadharOTP_Click"                                          
                                                        CssClass=" small"
                                                        Style="color: #0047AB;">
                                            send OTP
                                        </asp:LinkButton>
                                    </div>
                                     <div class="form-group mb-3">
                                        <asp:TextBox ID="txtOtp" runat="server" CssClass="form-control" MaxLength="6"  Placeholder="Enter Adhaar OTP" Visible="false" style="border: 1px solid red; border-radius: 6px; height: 45px; -webkit-text-fill-color:black"></asp:TextBox>
                                    </div>
                                   
                                </asp:View>
                            
                                   <!-- Step 7: Review & Submit -->
                                  <asp:View ID="viewStep5" runat="server">
                                    <p><strong> Congratulations! </strong>Your account has been successfully verified. You’re all set to get started.</p>
                                    <!-- You can show summary here -->
                                </asp:View>
                            </asp:MultiView>

                            <asp:Label ID="Label1" runat="server" CssClass="text-danger"></asp:Label>


                        <asp:Label runat="server" CssClass="text-danger" ID="lblError"></asp:Label>
                       
                     

                        <!-- OTP status message -->
                        <asp:Label runat="server" CssClass="text-danger" ID="lblOTPStatus"></asp:Label>
                      
                        <!-- Proceed Button -->
                        <div class="form-group mb-3">
                            <asp:LinkButton ID="LinkButton1" OnClick="LinkButton1_Click" runat="server" CssClass="btn btn-primary w-100" Style="border-radius: 6px; background-color: #0047AB; height: 45px;padding-top:10px ">NEXT</asp:LinkButton>
                        </div>

                        <!-- Trouble login -->
                        <div class="text-center mb-3">
                            <a href="#" style="color: #0047AB; font-size: 14px;">Trouble logging in?</a>
                        </div>

                        <!-- OR Separator -->
                        <div class="d-flex align-items-center mb-3">
                            <hr class="flex-grow-1" />
                            <span class="px-2" style="font-size: 12px;">OR</span>
                            <hr class="flex-grow-1" />
                        </div>

  

                        <!-- Google Button -->
                        <div class="form-group mb-2">
                        <a href="https://play.google.com/store/apps/dev?id=6290183038869767506" target="_blank">    <button type="button" class="btn btn-outline-secondary w-100" style="border-radius: 6px; height: 45px;">
                                <img src="Website/assets/images/icons/playstore.svg" alt="Google" style="height: 16px; margin-right: 8px;" />  Get it on Google Play
                            </button></a>
                        </div>

                        <!-- Apple Button -->
                        <div class="form-group mb-4">
                            <button type="button" class="btn btn-outline-secondary w-100" style="border-radius: 6px; height: 45px;">
                                <img src="Website/assets/images/org/apple.svg" alt="Apple" style="height: 16px; margin-right: 8px;" />Download on the App Store
                            </button>
                        </div>

                        <!-- Terms -->
                        <p class="text-center" style="font-size: 12px;">
                            By continuing you agree to our <a href="https://www.banku.co.in/policies.aspx#tab1" style="color: #0047AB;">Terms of Service</a> & <a href="https://www.banku.co.in/policies.aspx#tab2" style="color: #0047AB;">Privacy Policy</a>.
                        </p>
                    </div>
                </div>
           </div>
        </div>
    </section>
    <!-- ======== End of 1.7. Benefits section ======== -->

    <!-- ======== 1.12. Footer section ======== -->
    <footer>
      <div class="container">
       
        <div class="d-flex justify-content-between w-100">
          <div class="z-1 d-flex align-items-md-start align-items-center text-md-start text-center flex-column">
            <figure>
              <a href="https://www.banku.co.in/Default.aspx">
                <img src="Website/assets/images/org/2.png" alt="logo" style="margin-left:20px">
              </a>
            </figure>
            <p class="m-0">BankU India is leading a new-age fintech revolution, redefining how Bharat accesses banking, finance, and essential services. With deep roots in rural and semi-urban areas, we empower local entrepreneurs and citizens through innovative, easy-to-use digital solutions.</p>
            <div class="d-flex gap-lg-4 gap-md-3 flex-row">
              <a href="https://www.facebook.com/bankuindia" target="_blank">
                <figure class="d-flex justify-content-center align-items-center">
                  <i class="fa-brands fa-facebook-f"></i>
                </figure>
              </a>
              <a href="https://x.com/BankuSevakendra?t=B6GAKn6vqjLSaMPnayU1yA&s=09" target="_blank">
                <figure class="d-flex justify-content-center align-items-center">
                  <i class="fa-brands fa-twitter"></i>
                </figure>
              </a>
              <a href="https://www.youtube.com/channel/UCvPsJUB9QdOJp9dVQYpHJsw" target="_blank">
                <figure class="d-flex justify-content-center align-items-center"><i class="fa-brands fa-youtube"></i>
                </figure>
              </a>
			
              <a href="https://www.linkedin.com/company/banku-india" target="_blank">
                <figure class="d-flex justify-content-center align-items-center"><i class="fa-brands fa-linkedin"></i>
                </figure>
              </a>
            </div>
          </div>
          <div
            class="d-flex flex-column gap-lg-4 d-flex align-items-md-start align-items-center text-md-start text-center ms-0">
            <h5>Products</h5>
            <ul>
              <li><a href="https://www.banku.co.in/PaymentGateway.aspx">Gateway</a></li>
              <li><a href="https://www.banku.co.in/sound_box.aspx">SoundBox</a></li>
              <li><a href="https://www.banku.co.in/BNPL.aspx">BNPL APIs</a></li>
              <li><a href="https://www.banku.co.in/GeneralInsurance.aspx">Insurance</a></li>
              <li><a href="https://www.banku.co.in/Workingcapital.aspx">Loans</a></li>
              <li><a href="https://www.banku.co.in/BillPayments.aspx">Bill Payment</a></li>
              <li><a href="https://www.banku.co.in/BankingAgent.aspx">Kendra</a></li>
              <li><a href="https://www.banku.co.in/IndividualVerification.aspx">Verifications</a></li>
            </ul>
          </div>
            <div
            class="d-flex flex-column gap-lg-4 d-flex align-items-md-start align-items-center text-md-start text-center ms-0">
            <h5>Solutions</h5>
            <ul>
              <li><a href="https://www.banku.co.in/Ecommerce.aspx">Ecommerce</a></li>
              <li><a href="https://www.banku.co.in/Logistic.aspx">Logistics</a></li>
              <li><a href="https://www.banku.co.in/Marketplace.aspx">Marketplace</a></li>
              <li><a href="https://www.banku.co.in/Education.aspx">Education</a></li>
              <li><a href="https://www.banku.co.in/FMCG.aspx">FMCG</a></li>
              <li><a href="https://www.banku.co.in/Healthcare.aspx">Healthcare</a></li>
            </ul>
          </div>
        <div class="d-flex flex-column flex-md-column gap-4">
            <div class="d-flex flex-column flex-md-row gap-5">
            <div
            class="d-flex flex-column gap-lg-4 d-flex align-items-md-start align-items-center text-md-start text-center ms-0">
                <h5>Company</h5>
            <ul>
                <li><a href="https://www.banku.co.in/AboutUs.aspx">About Us</a></li>
                <li><a href="https://www.banku.co.in/Blogs.aspx">Our Blog</a></li>
                <li><a href="https://www.banku.co.in/Careers.aspx">Careers</a></li>
                <li><a href="https://www.banku.co.in/Contact.aspx">Contact Us</a></li>
            </ul>
            </div>
            <div
            class="d-flex flex-column gap-lg-4 d-flex align-items-md-start align-items-center text-md-start text-center ms-0">
                <h5>Resources</h5>
            <ul>
                <li><a href="https://www.banku.co.in/calculators.aspx">Calculators</a></li>
                <li><a href="https://www.banku.co.in/disclosures.aspx">Disclosures</a></li>
                <li><a href="https://www.banku.co.in/policies.aspx">Policy Center</a></li>
            </ul>
            </div>
            </div>
            <div
            class="d-flex gap-md-3 flex-column p-0 d-flex align-items-md-start align-items-center text-md-start text-center">
                <h5>DOWNLOAD THE APP</h5>
             <div class="d-flex gap-lg-3 gap-md-3">
                <a href="#">
            <div class="d-flex gap-lg-3 gap-2 justify-content-center align-items-center">
                <figure><img src="Website/assets/images/icons/apple.svg" alt="apple"></figure>
            <div>
                <p>Download on the </p>
                <h6>App Store</h6>
            </div>
            </div>
                </a>
                <a href="https://play.google.com/store/apps/dev?id=6290183038869767506" target="_blank">
            <div class="d-flex gap-lg-3 gap-2 justify-content-center align-items-center">
                <figure><img src="Website/assets/images/icons/playstore.svg" alt="playstore"/></figure>
            <div>
                <p>GET IT ON</p>
                <h6>Google Play</h6>
            </div>
            </div>
                </a>
            </div>
            </div>
        </div>
        </div>
        <div class="w-100 text-left py-lg-4 py-3">
          <p style="font-size:17px; font-weight:500"> &copy; <span id="year"></span> Intsalite Finserv Limited.</p><br>
          <p style="font-size:10px">BankU India is not a bank but a technology platform for digital financial services, advisory in partnership with RBI licensed Banks and IRDAI licensed Insurers. All funds in the customer's bank account are insured as per limits under the RBI’s deposit insurance scheme.</p>
          <p style="font-size:10px">Corporate Identity Number: U80904BR2022PLC059186 | IRDAI Corporate Agency Registration Number:   
		  <span style="font-size:8px; background-color:#e6b800; padding:2px 6px; border-radius:4px; color:#333; border:1px solid #ccc;">
    Soon </span></p>
          <p style="font-size:10px">Never share your password, card number, expiry date, CVV, PIN, OTP or other confidential information with anyone even if the person claims to be from BankUIndia.</p>
        </div>
      </div>
      <!-- scroll to top  -->
      <div class="scrollToTop">
        <div class="arrowUp">
          <i class="fa-solid fa-arrow-up"></i>
        </div>
        <div class="water">
          <svg viewBox="0 0 560 20" class="water_wave water_wave_back">
            <use xlink:href="#wave"></use>
          </svg>
          <svg viewBox="0 0 560 20" class="water_wave water_wave_front">
            <use xlink:href="#wave"></use>
          </svg>
          <svg version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"
            viewBox="0 0 560 20" style="display: none;">
            <symbol id="wave">
              <path
                d="M420,20c21.5-0.4,38.8-2.5,51.1-4.5c13.4-2.2,26.5-5.2,27.3-5.4C514,6.5,518,4.7,528.5,2.7c7.1-1.3,17.9-2.8,31.5-2.7c0,0,0,0,0,0v20H420z">
              </path>
              <path
                d="M420,20c-21.5-0.4-38.8-2.5-51.1-4.5c-13.4-2.2-26.5-5.2-27.3-5.4C326,6.5,322,4.7,311.5,2.7C304.3,1.4,293.6-0.1,280,0c0,0,0,0,0,0v20H420z">
              </path>
              <path
                d="M140,20c21.5-0.4,38.8-2.5,51.1-4.5c13.4-2.2,26.5-5.2,27.3-5.4C234,6.5,238,4.7,248.5,2.7c7.1-1.3,17.9-2.8,31.5-2.7c0,0,0,0,0,0v20H140z">
              </path>
              <path
                d="M140,20c-21.5-0.4-38.8-2.5-51.1-4.5c-13.4-2.2-26.5-5.2-27.3-5.4C46,6.5,42,4.7,31.5,2.7C24.3,1.4,13.6-0.1,0,0c0,0,0,0,0,0l0,20H140z">
              </path>
            </symbol>
          </svg>
        </div>
      </div>
    </footer>
    <!-- ======== End of 1.12. Footer section ======== -->
  </div>
      
 </form>
<!-- bootstrap min javascript -->
<script src="Website/assets/js/javascript-lib/bootstrap.min.js"></script>
<!-- j Query -->
<script src="Website/assets/js/jquery.js"></script>
<!-- slick slider js -->
<script src="Website/assets/js/slick.min.js"></script>
<!-- main javascript -->
<script src="Website/assets/js/custom.js"></script>
<!-- animation from javascript -->
<script src="Website/assets/js/aos.js"></script>
<script>
    function setupMegaMenu(navId, tabPrefix) {
        const navLinks = document.querySelectorAll(`#${navId} .nav-link`);
        const tabPanes = document.querySelectorAll(`#${tabPrefix}-content .tab-pane`);

        navLinks.forEach(link => {
            link.addEventListener('mouseenter', () => {
                navLinks.forEach(l => l.classList.remove('active'));
                link.classList.add('active');

                const tabId = link.getAttribute('data-tab');
                tabPanes.forEach(pane => {
                    if (pane.id === tabId) {
                        pane.classList.add('show', 'active');
                    } else {
                        pane.classList.remove('show', 'active');
                    }
                });
            });
        });
    }

    setupMegaMenu('service-tabs', 'service'); // for Services
    setupMegaMenu('dev-tabs', 'dev');         // for Developer's Hub
</script>

<script>
    function showSubMenu(menuId) {
     
        document.getElementById('mainMenu').classList.add('d-none');

      
        document.querySelectorAll('.submenu').forEach(menu => {
            menu.classList.add('d-none');
        });

        
        document.getElementById(menuId)?.classList.remove('d-none');
    }

    function showMainMenu() {
        
        document.querySelectorAll('.submenu').forEach(menu => {
            menu.classList.add('d-none');
        });

        
        document.getElementById('mainMenu').classList.remove('d-none');
    }
    function toggleDropdown(element) {
        const submenu = element.nextElementSibling;
        submenu.classList.toggle('d-none');
    }
</script>

<!-- ✅ Script to capture lat/lng -->
<script>
    window.onload = function () {
        if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(function (position) {
                document.getElementById('<%= hdnLatitude.ClientID %>').value = position.coords.latitude;
                document.getElementById('<%= hdnLongitude.ClientID %>').value = position.coords.longitude;
            }, function (error) {
                console.warn("Geolocation error: ", error.message);
            });
        } else {
            console.warn("Geolocation is not supported by this browser.");
        }
    };
</script>
<script>
    function onlyNumbers(e) {
        var charCode = (e.which) ? e.which : e.keyCode;
        // Allow only number keys (0–9)
        if (charCode < 48 || charCode > 57) {
            e.preventDefault();
            return false;
        }
        return true;
    }
</script>


<script type="text/javascript">
    var personalPan = '<%= Session["PanName"] != null ? Session["PanName"].ToString() : "" %>';
    function handleBusinessTypeChange() {
        var selectedValue = document.getElementById('<%= ddlBusinessType.ClientID %>').value;
        var panValue = document.getElementById('<%= TextBox1.ClientID %>').value;
        var txtBusiPan = document.getElementById('<%= txtBusiPan.ClientID %>');

        if (selectedValue === "Proprietorship" || selectedValue === "PSU / Govt. Entitie") {
            txtBusiPan.value = panValue;
            txtBusiPan.readOnly = true;
        } else {
            txtBusiPan.value = "";
            txtBusiPan.readOnly = false;
        }
    }
</script>

<script type="text/javascript">
    function handleBusiProofChange() {
        var selectedValue = document.getElementById('<%= ddlBusiProof.ClientID %>').value;

        var txtGSt = document.getElementById('<%= txtGSt.ClientID %>');
        var txtUdyam = document.getElementById('<%= txtUdyam.ClientID %>');
        var txtCIN = document.getElementById('<%= txtCIN.ClientID %>');
        var txtBussName = document.getElementById('<%= txtBussName.ClientID %>');

        // Hide all first
        txtGSt.style.display = "none";
        txtUdyam.style.display = "none";
        txtCIN.style.display = "none";
        txtBussName.style.display = "none";

        // Show based on selected value
        switch (selectedValue) {
            case "GST":
                txtGSt.style.display = "block";
                txtBussName.style.display = "block";
                break;
            case "UDYAM":
                txtUdyam.style.display = "block";
                break;
            case "CIN":
                txtCIN.style.display = "block";
                break;
        }
    }
    function showCINBox() {
        var txtCIN = document.getElementById('<%= txtCIN.ClientID %>');
         if (txtCIN) {
             txtCIN.style.display = "block";
         }
     }
</script>

<script>
    function showCINBox() {
        var txtCIN = document.getElementById('<%= txtCIN.ClientID %>');
         if (txtCIN) {
             txtCIN.style.display = "block";
         }
    }
    function showGSTBox() {
        var txtBussName = document.getElementById('<%= txtBussName.ClientID %>');
        var txtGSt = document.getElementById('<%= txtGSt.ClientID %>');
        if (txtGSt) {
            txtGSt.style.display = "block";
            txtBussName.style.display = "block";
         }
    }
    function showUDYAMBox() {
        var txtUdyam = document.getElementById('<%= txtUdyam.ClientID %>');
        if (txtUdyam) {
            txtUdyam.style.display = "block";       
        }
    }
</script>
</body>
</html>
