<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="signup.aspx.cs" Inherits="NeoXPayout.onboarding.signup" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
   <meta charset="UTF-8">
  <link rel="icon" type="image/png" href="img/banku_fevicon.png">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Registration: BankU Seva Kendra</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="style.css">

  <style>
    body {
      background-color: #680088;
      font-family: 'Segoe UI', sans-serif;
      color: white;
      background: url('https://images.unsplash.com/photo-1503264116251-35a269479413') no-repeat center center fixed;
  background-size: cover;
  font-family: 'Segoe UI', sans-serif;
    }
    
  </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="auth-wrapper px-3">
  
  <div class="auth-box row g-0">
    <header>
      <div class="logo">
        <img src="bsk_logo.png" alt="BankU Logo" />
      </div>
      <div class="menu-toggle" onclick="toggleMenu()">☰</div>
      <nav class="nav" id="navMenu">
        <a href="https://partner.banku.co.in/login.aspx" class="dashboard-btn">
          <span class="icon"></span>
          Log in
        </a>
      </nav>
    </header>
    <!-- Left Panel with Slider -->
    <div class="col-md-6 d-none d-md-block left-panel">
      <a href="https://banku.co.in/" class="btn btn-sm btn-outline-light back-btn">Back to Home</a>
      <div id="carouselImages" class="carousel slide h-100" data-bs-ride="carousel">
        <div class="carousel-inner h-100">
          <div class="carousel-item active h-100" style="background-image: url('https://partner.banku.co.in/onboarding/img/1.png');">
            <div class="d-flex h-100 align-items-end justify-content-center text-center p-3">
              <div class="carousel-caption">
                <h5>Last Mile Banking Solutions</h5>
                <p>Register and access 200+ services</p>
              </div>
            </div>
          </div>
          <div class="carousel-item h-100" style="background-image: url('https://partner.banku.co.in/onboarding/img/CashDeposit.png');">
            <div class="d-flex h-100 align-items-end justify-content-center text-center p-3">
              <div class="carousel-caption">
                <h5>Last Mile Banking Solutions</h5>
                <p>Register and access 200+ services</p>
              </div>
            </div>
          </div>
          <div class="carousel-item h-100" style="background-image: url('https://partner.banku.co.in/onboarding/img/3.png');">
            <div class="d-flex h-100 align-items-end justify-content-center text-center p-3">
              <div class="carousel-caption">
                <h5>Last Mile Banking Solutions</h5>
                <p>Register and access 200+ services</p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Right Panel -->
    <div class="col-md-6 p-5 bg-dark">
      <h3 class="mb-4">create a new account</h3>
      <p class="mb-4">Already have an account? <a href="https://partner.banku.co.in/login.aspx" class="text-decoration-none text-light">Log in</a></p>
        <div class="row">
          <div class="col-md-6 mb-3">
                <asp:TextBox ID="txtmobileno" MaxLength="10" runat="server" class="form-control" required="" placeholder="Mobile no linked with Aadhaar"></asp:TextBox>
          </div>
          <div class="col-md-6 mb-3">
              <asp:TextBox ID="txtpancardno" runat="server" class="form-control" required="" MaxLength="10" placeholder="Pan Number"></asp:TextBox>
          </div>
        </div>
        <div class="mb-3">
            <asp:TextBox ID="txtemail" runat="server" class="form-control" required="" TextMode="Email" placeholder="Emailid"></asp:TextBox>
        </div>
        <div class="mb-3">
            <asp:TextBox ID="txtpassword" runat="server" class="form-control" required="" TextMode="Password" placeholder="Create your password"></asp:TextBox>
        </div>
        <div class="form-check mb-4">
          <input class="form-check-input" type="checkbox" id="termsCheck">
          <label class="form-check-label" for="termsCheck">
            I agree to the <a href="https://banku.co.in/policies.html#term" target="_blank">Terms & Conditions</a> 
          </label>
        </div>
        <div class="d-grid mb-3">
             <asp:LinkButton ID="LinkButton2" runat="server" class="btn btn-primary" OnClick="LinkButton1_Click">Create account</asp:LinkButton>
          
        </div>
    </div>
  </div>
</div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    
    </form>
</body>
</html>
