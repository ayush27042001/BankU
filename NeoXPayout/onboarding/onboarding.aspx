<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="onboarding.aspx.cs" Inherits="NeoXPayout.onboarding.onboarding" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Onboading outlet bankU Seva Kendra </title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    body {
      background-color: #f8f9fa;
      font-family: 'Segoe UI', sans-serif;
      
    }

    header {
      background: #fff;
      border-bottom: 1px solid #ddd;
      padding: 10px 0;
      display: flex;
      justify-content: space-between;
      align-items: center;
      position: relative;
    }

    .logo {
      margin-left: 15%;
    }

    .logo img {
      height: 32px;
    }

    .nav {
      margin-right: 15%;
      display: flex;
      align-items: center;
      gap: 20px;
    }

    .nav-link {
      text-decoration: none;
      color: #555;
      font-size: 14px;
      border-bottom: 1px solid orange;
    }

    .dashboard-btn {
      display: flex;
      align-items: center;
      gap: 6px;
      padding: 6px 12px;
      font-size: 14px;
      border: 1px solid rgb(221, 206, 0);
      color: rgb(136, 0, 163);
      text-decoration: none;
      border-radius: 4px;
      transition: background 0.2s;
    }

    .dashboard-btn:hover {
      background: #e6fafa;
    }

    .icon {
      font-size: 16px;
    }

    .menu-toggle {
      display: none;
      font-size: 24px;
      cursor: pointer;
      position: absolute;
      right: 20px;
    }

    @media (max-width: 768px) {
      .logo, .nav {
        margin: 0 20px;
      }

      .nav {
        position: absolute;
        top: 60px;
        right: 0;
        background: #fff;
        flex-direction: column;
        align-items: flex-start;
        width: 100%;
        padding: 10px 20px;
        border-top: 1px solid #ddd;
        display: none;
      }

      .nav.show {
        display: flex;
      }

      .menu-toggle {
        display: block;
      }
    }
    .status-line {
      display: flex;
      justify-content: center;
      gap: 30px;
      margin: 40px 0;
      flex-wrap: wrap;
    }
    .status-item {
      text-align: center;
    }
    .status-circle {
      width: 40px;
      height: 40px;
      border-radius: 50%;
      display: inline-flex;
      align-items: center;
      justify-content: center;
      font-size: 18px;
      color: #fff;
      margin-bottom: 8px;
    }
    .status-success {
      background-color: #6f0091;
    }
    .status-process {
      background-color: #ddd;
    }
    .status-fail {
      background-color: #d63031;
    }
    .status-item p {
      margin: 0;
      font-size: 14px;
    }
    .accordion-button::after {
      background-image: none;
      content: "▼";
      transform: rotate(0deg);
      transition: transform 0.2s;
    }
    .accordion-button.collapsed::after {
      transform: rotate(-90deg);
    }
    .step-badge {
      background-color: #dfe6e9;
      padding: 2px 8px;
      font-size: 0.75rem;
      border-radius: 6px;
      margin-right: 10px;
      color: #0984e3;
    }
    .accordion-button {
      background-color: #ffffff !important;
    }
    .header {
      background-color: #ffffff;
      border-bottom: 1px solid #ddd;
      padding: 10px 30px;
      display: flex;
      flex-wrap: wrap;
      justify-content: space-between;
      align-items: center;
      position: fixed;
      width: 100%;
      
    }
    .step-number {
      background-color: #f5e9fd;
      color: #6f42c1;
      border-radius: 4px;
      font-weight: bold;
      padding: 2px 8px;
      font-size: 12px;
      margin-right: 10px;
    }
    
  </style>
</head>
<body>
    <form id="form1" runat="server">
      <header>
        <div class="logo">
          <img src="bsk_logo.png" alt="BankU Logo" />
        </div>
        <div class="menu-toggle" onclick="toggleMenu()">☰</div>
        <nav class="nav" id="navMenu">
          <a href="#" class="nav-link"> <b> KYC TEAM:-</b> nodal.officer@banku.co.in</a>
          <a href="#" class="nav-link"><b> SALES TEAM:-</b> sales@banku.co.in</a>
          <a href="../login.aspx" class="dashboard-btn">
            <span class="icon"><img src="logout_icon.PNG" width="20px" alt="BankU Logo"/></span>
            Log Out
          </a>
        </nav>
      </header>
      

<div class="container py-4">
  <div class="text-center mb-4">
    <h2 class="step-header">Hello <asp:Label ID="lblname" runat="server"></asp:Label>, Activate Your outlet </h2>
    <p class="text-muted">Agent ID: <b> BANKU-<asp:Label ID="lblid" runat="server"></asp:Label></b></p>
      <asp:HiddenField ID="hfNotificationType" runat="server" />
    <div class="alert alert-warning">
      <strong>Live Status:- </strong> <asp:Label ID="lblremarks" runat="server"></asp:Label>
    </div>
  </div>
    <asp:HiddenField ID="hfcreateaccount" runat="server" />
    <asp:HiddenField ID="hfbusinessdetails" runat="server" />
    <asp:HiddenField ID="hfpersonaldetails" runat="server" />
    <asp:HiddenField ID="hfbankaccount" runat="server" />
    <asp:HiddenField ID="hfkycdoc" runat="server" />
    <asp:HiddenField ID="hfcompleteonboarding" runat="server" />
    <asp:HiddenField ID="hffinalagrement" runat="server" />
    
  <!-- Status Row -->
  <div class="status-line">
    <div class="status-item">
      <div class="status-circle <%=hfcreateaccount.Value%>">✔</div>
      <p>Create New Account</p>
    </div>
    <div class="status-item">
      <div class="status-circle <%=hfbusinessdetails.Value%>">✔</div>
      <p>Business Details</p>
    </div>
      <div class="status-item">
      <div class="status-circle <%=hfpersonaldetails.Value%>">✔</div>
      <p>Personal Details</p>
    </div>
    <div class="status-item">
      <div class="status-circle <%=hfbankaccount.Value%>">✔</div>
      <p>Bank Account</p>
    </div>
    
    <div class="status-item">
      <div class="status-circle <%=hfkycdoc.Value%>">✔</div>
      <p>KYC Documents</p>
    </div>
      <div class="status-item">
      <div class="status-circle <%=hfcompleteonboarding.Value%>">✔</div>
      <p>Complete Onboarding</p>
      
    </div>
      <div class="status-item">
      <div class="status-circle <%=hffinalagrement.Value%>">✔</div>
      <p>Final Agrement</p>
      
    </div>
  </div>


  <div class="container mt-4">
    <div class="accordion" id="kycAccordion">
         <!-- Step 1 -->
      <div class="accordion-item">
        <h2 class="accordion-header" id="heading1">
          <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapse1">
            <span class="step-number">STEP 1</span> <b> Create a new account </b>
          </button>
        </h2>
        <div id="collapse1" class="accordion-collapse collapse show" data-bs-parent="#kycAccordion">
          <div class="accordion-body">
            <p class="text-muted">Enter your details to register</p>
            <div class="row g-3">
              <div class="col-md-6">
                <label><i> Mobile number linked with Aadhaar </i></label>
                  <asp:TextBox ID="txtmobileno" runat="server" class="form-control" ReadOnly="true"></asp:TextBox>
              </div>
              <div class="col-md-6">
                <label><i> e-mail ID</i></label>
                <asp:TextBox ID="txtemailid" runat="server" class="form-control" ReadOnly="true"></asp:TextBox>
              </div>
              <div class="col-md-6">
                <label><i> Full Name (Pan On Pancard) </i></label>
               <asp:TextBox ID="txtfullname" runat="server" class="form-control" ReadOnly="true"></asp:TextBox>
              </div>
              <div class="col-md-6">
                <label><i> Pan Number</i></label>
                <asp:TextBox ID="txtpanno" runat="server" class="form-control" ReadOnly="true"></asp:TextBox>
              </div>
                <div class="col-md-6" id="otpbox" runat="server">
                    <asp:HiddenField ID="hfSignupStatus" runat="server" />
                    <asp:HiddenField ID="hfMobileverifyStatus" runat="server" />
                <label><i> OTP for Mobile Verification</i> <asp:LinkButton ID="LinkButton15" runat="server" OnClick="LinkButton15_Click">Resend OTP</asp:LinkButton></label>
                <asp:TextBox ID="txtotp" runat="server" class="form-control" ></asp:TextBox>
              </div>
              <div class="col-6 text-end"><br />
                  <asp:LinkButton ID="LinkButton1" runat="server" class="btn btn-success" OnClick="LinkButton1_Click">Proceed to Verify</asp:LinkButton>
                
              </div>
            </div>
          </div>
        </div>
      </div>

    
      <!-- Step 2 -->
      <div class="accordion-item">
        <h2 class="accordion-header" id="heading2">
          <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapse2">
            <span class="step-number">STEP 2</span> <b>Business Details </b>
          </button>
        </h2>
        <div id="collapse2" class="accordion-collapse collapse" data-bs-parent="#kycAccordion">
          <div class="accordion-body">
            <p class="text-muted">Provide your business name, type, and registration details.</p>
            <div class="row g-3">
              <div class="col-md-6">
                  <asp:HiddenField ID="hfbusinessdetailsstatus" runat="server" />
                <label><i> Legal Business Name </i></label>
               <asp:TextBox ID="txtbusinessname" runat="server" class="form-control" ></asp:TextBox>
              </div>
             
              <div class="col-md-6">
                <label><i> Date of Incorporation(Business Start Date) </i></label>
                  <asp:TextBox ID="txtdateofincorportation" runat="server" class="form-control" TextMode="Date" ></asp:TextBox>
                
              </div>
              <div class="col-md-6">
                <label><i> Correspondence Address </i></label>
                  <asp:TextBox ID="txtbusinessaddress" runat="server" class="form-control" ></asp:TextBox>
                
            </div>
            <div class="col-md-6">
                <label><i> Udyam Registration Number </i></label>
                <asp:TextBox ID="txtdhyamregistrationnumber" runat="server" class="form-control" ></asp:TextBox>
              </div>
              <div class="col-md-6">
                <label><i> Business Type</i></label>
                  <asp:DropDownList ID="ddlbusinesstype" runat="server" CssClass="form-control">
                      <asp:ListItem>Select Type</asp:ListItem>
                      <asp:ListItem>Mobile Recharge Shop</asp:ListItem>
                      <asp:ListItem>Grocery Store</asp:ListItem>
                      <asp:ListItem>Electronics Store</asp:ListItem>
                      <asp:ListItem>Stationery Shop</asp:ListItem>
                      <asp:ListItem>Printing and Xerox Shops</asp:ListItem>
                      <asp:ListItem>Community Centers</asp:ListItem>
                      <asp:ListItem>Petrol Pumps</asp:ListItem>
                      <asp:ListItem>Travel Agencies</asp:ListItem>
                      <asp:ListItem>Other</asp:ListItem>
                  </asp:DropDownList>
              
              </div>
             
              <div class="col-12 text-end">
                  <asp:LinkButton ID="LinkButton2" runat="server" class="btn btn-success" OnClick="LinkButton2_Click">Proceed to Verify</asp:LinkButton>
                
              </div>
            </div>
          </div>
        </div>
      </div>

  
  <!-- Step 3 -->
  <div class="accordion-item">
    <h2 class="accordion-header" id="heading2">
      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapse3">
        <span class="step-number">STEP 3</span> <b>Personal Details </b>
      </button>
    </h2>
    <div id="collapse3" class="accordion-collapse collapse" data-bs-parent="#kycAccordion">
      <div class="accordion-body">
        <p class="text-muted">Provide your personal Details.</p>
        <div class="row g-3">
          <div class="col-md-6">
            <label>Voter Id number</label>
              <asp:TextBox ID="txtvoterid" runat="server" class="form-control" ></asp:TextBox>
          </div>
          <div class="col-md-6">
            <label>Aadhaar Number</label>
             <asp:TextBox ID="txtaadharno" runat="server" class="form-control" ></asp:TextBox>
          </div>
          <div class="col-md-6">
            <label>Father's Name</label>
              <asp:TextBox ID="txtfathername" runat="server" class="form-control" ></asp:TextBox>
          </div>
          <div class="col-md-6">
            <label>Mother's Name</label>
          <asp:TextBox ID="txtmothername" runat="server" class="form-control" ></asp:TextBox>
          </div>
             <div class="col-md-6">
            <label>Date of Birth</label>
          <asp:TextBox ID="txtdob" TextMode="Date" runat="server" class="form-control" ></asp:TextBox>
          </div>
          <div class="col-md-6">
            <label>Gender</label>
              <asp:DropDownList ID="ddlgender" runat="server" class="form-select">
                  <asp:ListItem>Male</asp:ListItem>
                  <asp:ListItem>Female</asp:ListItem>
                  <asp:ListItem>Others</asp:ListItem>
              </asp:DropDownList>
          
          </div>
          <div class="col-md-6">
            <label>User Position</label>
                 <asp:DropDownList ID="ddluserposition" runat="server" class="form-select">
                  <asp:ListItem>Proprietor</asp:ListItem>
                  <asp:ListItem>Authorized Signatory</asp:ListItem>
                  <asp:ListItem>Power of Autorny</asp:ListItem>
              </asp:DropDownList>
          
          </div>
          <div class="col-md-6">
            <label><i> Permanent Address</i></label>
            <asp:TextBox ID="txtpermanentaddress" runat="server" class="form-control" ></asp:TextBox>
          </div>
          <div class="col-md-6">
            <label>State</label>
          <asp:DropDownList ID="ddlstate" runat="server" class="form-select">
                <asp:ListItem>Select State</asp:ListItem>
                <asp:ListItem>Andhra Pradesh</asp:ListItem>
                <asp:ListItem>Arunachal Pradesh</asp:ListItem>
                <asp:ListItem>Assam</asp:ListItem>
                <asp:ListItem>Bihar</asp:ListItem>
                <asp:ListItem>Chhattisgarh</asp:ListItem>
                <asp:ListItem>Goa</asp:ListItem>
               <asp:ListItem>Gujarat</asp:ListItem>
                <asp:ListItem>Haryana</asp:ListItem>
                <asp:ListItem>Himachal Pradesh</asp:ListItem>
                <asp:ListItem>Jharkhand</asp:ListItem>
                <asp:ListItem>Karnataka</asp:ListItem>
                <asp:ListItem>Kerala</asp:ListItem>
                <asp:ListItem>Madhya Pradesh</asp:ListItem>
                <asp:ListItem>Maharashtra</asp:ListItem>
                <asp:ListItem>Manipur</asp:ListItem>
                <asp:ListItem>Meghalaya</asp:ListItem>
                <asp:ListItem>Mizoram</asp:ListItem>
                <asp:ListItem>Nagaland</asp:ListItem>
                <asp:ListItem>Odisha</asp:ListItem>
                <asp:ListItem>Punjab</asp:ListItem>
                <asp:ListItem>Rajasthan</asp:ListItem>
                <asp:ListItem>Sikkim</asp:ListItem>
                <asp:ListItem>Tamil Nadu</asp:ListItem>
                <asp:ListItem>Telangana</asp:ListItem>
                <asp:ListItem>Tripura</asp:ListItem>
                <asp:ListItem>Uttar Pradesh</asp:ListItem>
                <asp:ListItem>Uttarakhand</asp:ListItem>
                <asp:ListItem>West Bengal</asp:ListItem>
             
                <asp:ListItem>Andaman and Nicobar Islands</asp:ListItem>
                <asp:ListItem>Chandigarh</asp:ListItem>
                <asp:ListItem>Dadra and Nagar Haveli and Daman and Diu</asp:ListItem>
               <asp:ListItem>Delhi</asp:ListItem>
                <asp:ListItem>Jammu and Kashmir</asp:ListItem>
                <asp:ListItem>Ladakh</asp:ListItem>
               <asp:ListItem>Lakshadweep</asp:ListItem>
                <asp:ListItem>Puducherry</asp:ListItem>
                
         
             </asp:DropDownList>
          </div>
              <div class="col-md-6">
            <label><i> Pincode</i></label>
            <asp:TextBox ID="txtpincode" runat="server" class="form-control" ></asp:TextBox>
          </div>
          <div class="col-md-6">
            <label>Education</label>
           <asp:DropDownList ID="ddleducation" runat="server" class="form-select">
                <asp:ListItem>Illiterate</asp:ListItem>
                <asp:ListItem>Below 10th</asp:ListItem>
                <asp:ListItem>10th Pass</asp:ListItem>
               <asp:ListItem>12th Pass</asp:ListItem>
                <asp:ListItem>Diploma</asp:ListItem>
                <asp:ListItem>Graduate</asp:ListItem>
                <asp:ListItem>Postgraduate</asp:ListItem>
                <asp:ListItem>Doctorate</asp:ListItem>
                <asp:ListItem>Professional Degree</asp:ListItem>
                <asp:ListItem>Other</asp:ListItem>
                
         
            </asp:DropDownList>
          </div>
          <div class="col-12 text-end">
              <asp:HiddenField ID="hfPersonalInfoStatus" runat="server" />
              <asp:LinkButton ID="LinkButton3" runat="server" class="btn btn-success" OnClick="LinkButton3_Click">Proceed to Verify</asp:LinkButton>
          
          </div>
        </div>
      </div>
    </div>
  </div>


 <!-- Step 4 -->
 <div class="accordion-item">
    <h2 class="accordion-header" id="heading2">
      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapse4">
        <span class="step-number">STEP 4</span> <b>Bank Account White Listing </b>
      </button>
    </h2>
    <div id="collapse4" class="accordion-collapse collapse" data-bs-parent="#kycAccordion">
      <div class="accordion-body">
        <p class="text-muted">Provide your business name, type, and registration details.</p>
        <div class="row g-3">
          <div class="col-md-6">
            <label>Account Holder's</label>
           <asp:TextBox ID="txtaccountholder" runat="server" class="form-control" ></asp:TextBox>
          </div>
          <div class="col-md-6">
            <label>Bank Name</label>
            <asp:DropDownList ID="ddlbank" runat="server" class="form-select">
              <asp:ListItem>Select Bank</asp:ListItem>
              <asp:ListItem>Bank of Baroda</asp:ListItem>
              <asp:ListItem>Bank of India</asp:ListItem>
              <asp:ListItem>Bank of Maharashtra</asp:ListItem>
              <asp:ListItem>Canara Bank</asp:ListItem>
              <asp:ListItem>Central Bank of India</asp:ListItem>
              <asp:ListItem>Indian Bank</asp:ListItem>
              <asp:ListItem>Indian Overseas Bank</asp:ListItem>
              <asp:ListItem>Punjab and Sind Bank</asp:ListItem>
              <asp:ListItem>Punjab National Bank</asp:ListItem>
              <asp:ListItem>State Bank of India</asp:ListItem>
              <asp:ListItem>UCO Bank</asp:ListItem>
              <asp:ListItem>Union Bank of India</asp:ListItem>
             <asp:ListItem>Axis Bank</asp:ListItem>
              <asp:ListItem>Bandhan Bank</asp:ListItem>
              <asp:ListItem>CSB Bank</asp:ListItem>
              <asp:ListItem>City Union Bank</asp:ListItem>
              <asp:ListItem>DCB Bank</asp:ListItem>
              <asp:ListItem>Dhanlaxmi Bank</asp:ListItem>
             <asp:ListItem>Federal Bank</asp:ListItem>
              <asp:ListItem>HDFC Bank</asp:ListItem>
              <asp:ListItem>ICICI Bank</asp:ListItem>
              <asp:ListItem>IDBI Bank</asp:ListItem>
              <asp:ListItem>IDFC First Bank</asp:ListItem>
             <asp:ListItem>IndusInd Bank</asp:ListItem>
              <asp:ListItem>Jammu & Kashmir Bank</asp:ListItem>
             <asp:ListItem>Karnataka Bank</asp:ListItem>
             <asp:ListItem>Karur Vysya Bank</asp:ListItem>
              <asp:ListItem>Kotak Mahindra Bank</asp:ListItem>
              <asp:ListItem>Nainital Bank</asp:ListItem>
             <asp:ListItem>RBL Bank</asp:ListItem>
             <asp:ListItem>South Indian Bank</asp:ListItem>
              <asp:ListItem>Tamilnad Mercantile Bank</asp:ListItem>
              <asp:ListItem>Yes Bank</asp:ListItem>
              <asp:ListItem>Andhra Pradesh Grameena Bank</asp:ListItem>
              <asp:ListItem>Arunachal Pradesh Rural Bank</asp:ListItem>
              <asp:ListItem>Assam Gramin Vikash Bank</asp:ListItem>
              <asp:ListItem>Bihar Gramin Bank</asp:ListItem>
              <asp:ListItem>Chhattisgarh Rajya Gramin Bank</asp:ListItem>
              <asp:ListItem>Gujarat Gramin Bank</asp:ListItem>
              <asp:ListItem>Sarva Haryana Gramin Bank</asp:ListItem>
             <asp:ListItem>Himachal Pradesh Gramin Bank</asp:ListItem>
              <asp:ListItem>Jammu and Kashmir Gramin Bank</asp:ListItem>
              <asp:ListItem>Jharkhand Rajya Gramin Bank</asp:ListItem>
              <asp:ListItem>Karnataka Grameena Bank</asp:ListItem>
             <asp:ListItem>Kerala Gramin Bank</asp:ListItem>
              <asp:ListItem>Madhya Pradesh Gramin Bank</asp:ListItem>
              <asp:ListItem>Maharashtra Gramin Bank</asp:ListItem>
              <asp:ListItem>Manipur Rural Bank</asp:ListItem>
              <asp:ListItem>Meghalaya Rural Bank</asp:ListItem>
              <asp:ListItem>Mizoram Rural Bank</asp:ListItem>
              <asp:ListItem>Nagaland Rural Bank</asp:ListItem>
              <asp:ListItem>Odisha Gramin Bank</asp:ListItem>
              <asp:ListItem>Puduvai Bharathiar Grama Bank</asp:ListItem>
              <asp:ListItem>Punjab Gramin Bank</asp:ListItem>
              <asp:ListItem>Rajasthan Gramin Bank</asp:ListItem>
              <asp:ListItem>Tamil Nadu Grama Bank</asp:ListItem>
              <asp:ListItem>Telangana Grameena Bank</asp:ListItem>
              <asp:ListItem>Tripura Gramin Bank</asp:ListItem>
              <asp:ListItem>Uttar Pradesh Gramin Bank</asp:ListItem>
              <asp:ListItem>Uttarakhand Gramin Bank</asp:ListItem>
              <asp:ListItem>West Bengal Gramin Bank</asp:ListItem>
              <asp:ListItem>AU Small Finance Bank</asp:ListItem>
              <asp:ListItem>Capital Small Finance Bank</asp:ListItem>
              <asp:ListItem>Equitas Small Finance Bank</asp:ListItem>
              <asp:ListItem>ESAF Small Finance Bank</asp:ListItem>
              <asp:ListItem>Jana Small Finance Bank</asp:ListItem>
              <asp:ListItem>North East Small Finance Bank</asp:ListItem>
              <asp:ListItem>Shivalik Small Finance Bank</asp:ListItem>
              <asp:ListItem>Suryoday Small Finance Bank</asp:ListItem>
              <asp:ListItem>Ujjivan Small Finance Bank</asp:ListItem>
              <asp:ListItem>Unity Small Finance Bank</asp:ListItem>
              <asp:ListItem>Utkarsh Small Finance Bank</asp:ListItem>
              <asp:ListItem>Airtel Payments Bank</asp:ListItem>
              <asp:ListItem>Fino Payments Bank</asp:ListItem>
              <asp:ListItem>India Post Payments Bank</asp:ListItem>
              <asp:ListItem>NSDL Payments Bank</asp:ListItem>
              <asp:ListItem>Jio Payments Bank</asp:ListItem>
              <asp:ListItem>Paytm Payments Bank</asp:ListItem>
                                                                      
           </asp:DropDownList>
          </div>

       
          <div class="row g-3">
            <div class="col-md-6">
              <label>Account Number</label>
               <asp:TextBox ID="txtaccountnumber" runat="server" class="form-control" ></asp:TextBox>
            </div>
            <div class="col-md-6">
                <label>Accounttype</label>
                <asp:DropDownList ID="ddlaccounttype" runat="server" class="form-select">
                    <asp:ListItem>Savings Account</asp:ListItem>
                    <asp:ListItem>Current Account</asp:ListItem>
                    <asp:ListItem>Joint Account</asp:ListItem>
                    <asp:ListItem>Minor Account</asp:ListItem>
                    <asp:ListItem>Other</asp:ListItem>
             
              </asp:DropDownList>
              </div>
              <div class="row g-3">
                <div class="col-md-6">
                  <label>IFSC Code</label><asp:HiddenField ID="hfBankaccountstatus" runat="server" />
                   <asp:TextBox ID="txtifsccode" runat="server" class="form-control" ></asp:TextBox>
                </div>
                <div class="col-12 text-end">
                    <asp:LinkButton ID="LinkButton4" runat="server" class="btn btn-success" OnClick="LinkButton4_Click">Proceed to Verify</asp:LinkButton>
                  
                  </div>
        </div>
      </div>
    </div>
  </div>





  </div>
</div>
         <!-- Step 5 -->
 <div class="accordion-item">
    <h2 class="accordion-header" id="heading2">
      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapse5">
        <span class="step-number">STEP 5</span> <b>KYC Document Upload </b>
      </button>
    </h2>
    <div id="collapse5" class="accordion-collapse collapse" data-bs-parent="#kycAccordion">
      <div class="accordion-body">
        <p class="text-muted">Provide your All Kyc Document details.</p>
        <div class="row g-3">
          <div class="col-md-5">
              <asp:HiddenField ID="hfKycStatus" runat="server" />
            <label>Upload Pancard (Signed By Owner/Director)</label>
              <asp:FileUpload ID="FileUpload1" runat="server" class="form-control"/>
              <asp:Label ID="lblpancard" runat="server" ForeColor="#669900" Font-Bold="True"></asp:Label>
          </div>
             <div class="col-md-1"><br />
              <asp:LinkButton ID="lbnpancard" runat="server" class="btn btn-primary" Width="100%" OnClick="lbnpancard_Click">Upload</asp:LinkButton>
          </div>
           <div class="col-md-5">
            <label>Upload VoterCard (Signed By Owner/Director)</label>
              <asp:FileUpload ID="FileUpload2" runat="server" class="form-control"/>
              <asp:Label ID="lblvotercard" runat="server" ForeColor="#669900" Font-Bold="True"></asp:Label>
          </div>
        <div class="col-md-1"><br />
              <asp:LinkButton ID="lbnvotercard" runat="server" class="btn btn-primary" Width="100%" OnClick="lbnvotercard_Click">Upload</asp:LinkButton>
          </div>
            </div>
          <hr />
          <div class="row g-3">
        <div class="col-md-5">
            <label>Upload Aadhar Front (Signed By Owner/Director)</label>
              <asp:FileUpload ID="FileUpload3" runat="server" class="form-control"/>
              <asp:Label ID="lblaadharfront" runat="server" ForeColor="#669900" Font-Bold="True"></asp:Label>
          </div>
                <div class="col-md-1"><br />
              <asp:LinkButton ID="lbnaadharfront" runat="server" class="btn btn-primary" Width="100%" OnClick="lbnaadharfront_Click">Upload</asp:LinkButton>
          </div>
               <div class="col-md-5">
            <label>Upload Aadhar Back (Signed By Owner/Director)</label>
              <asp:FileUpload ID="FileUpload4" runat="server" class="form-control"/>
              <asp:Label ID="lblaadharback" runat="server" ForeColor="#669900" Font-Bold="True"></asp:Label>
          </div>
                <div class="col-md-1"><br />
              <asp:LinkButton ID="lbnaadharback" runat="server" class="btn btn-primary" Width="100%" OnClick="lbnaadharback_Click">Upload</asp:LinkButton>
          </div>
              </div>
          <hr />
              <div class="row g-3">
                <div class="col-md-5">
            <label>Upload GST Certificate (Signed By Owner/Director)</label>
              <asp:FileUpload ID="FileUpload5" runat="server" class="form-control"/>
              <asp:Label ID="lblgstcertificate" runat="server" ForeColor="#669900" Font-Bold="True"></asp:Label>
          </div>  
                  <div class="col-md-1"><br />
              <asp:LinkButton ID="lbngst" runat="server" class="btn btn-primary" Width="100%" OnClick="lbngst_Click">Upload</asp:LinkButton>
          </div>
                   <div class="col-md-5">
            <label>Upload Udyam Certificate (Signed By Owner/Director)</label>
              <asp:FileUpload ID="FileUpload6" runat="server" class="form-control"/>
              <asp:Label ID="lbludyamcertificate" runat="server" ForeColor="#669900" Font-Bold="True"></asp:Label>
          </div>  
                  <div class="col-md-1"><br />
              <asp:LinkButton ID="lbnudyam" runat="server" class="btn btn-primary" Width="100%" OnClick="lbnudyam_Click">Upload</asp:LinkButton>
          </div>
                  </div>
          <hr />
                  <div class="row g-3">
        <div class="col-md-5">
            <label>Jio Tag Photo- 3 pic(in pdf)</label>
              <asp:FileUpload ID="FileUpload7" runat="server" class="form-control"/>
              <asp:Label ID="lbljiophoto" runat="server" ForeColor="#669900" Font-Bold="True"></asp:Label>
          </div>  
                      <div class="col-md-1"><br />
              <asp:LinkButton ID="lbnjiophoto" runat="server" class="btn btn-primary" Width="100%" OnClick="lbnjiophoto_Click">Upload</asp:LinkButton>
          </div>
               <div class="col-md-5">
            <label>Passport Size Photo</label>
              <asp:FileUpload ID="FileUpload8" runat="server" class="form-control"/>
              <asp:Label ID="lblpassportsizephoto" runat="server" ForeColor="#669900" Font-Bold="True"></asp:Label>
          </div>  
                      <div class="col-md-1"><br />
              <asp:LinkButton ID="lbnpassport" runat="server" class="btn btn-primary" Width="100%" OnClick="lbnpassport_Click">Upload</asp:LinkButton>
          </div>
                      </div>
          <hr /><div class="row g-3">
                <div class="col-12 text-end">
                    <asp:LinkButton ID="LinkButton5" runat="server" class="btn btn-success" OnClick="LinkButton5_Click">Proceed to Verify</asp:LinkButton>
                  
                  </div>
        </div>
      </div>
   





  </div>

        </div>

            <!-- Step 6 -->
 <div class="accordion-item">
    <h2 class="accordion-header" id="heading2">
      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapse6">
        <span class="step-number">STEP 6</span> <b>Complete Onboarding </b>
      </button>
    </h2>
    <div id="collapse6" class="accordion-collapse collapse" data-bs-parent="#kycAccordion">
      <div class="accordion-body">
        <p class="text-muted">Upload Final Form and Complete your Full Onboarding.</p>
           <div class="alert alert-warning">
      <strong>Note:- </strong> Download Full Onborading Form and Upload Below After Signed and Stump <a href="#" class="btn btn-primary">Download</a>
    </div>
        
          <div class="row g-3">
        <div class="col-md-12">
            <label>Upload Signed Copy of Onboarding Form</label><asp:HiddenField ID="hfDocumentStatus" runat="server" />
              <asp:FileUpload ID="FileUpload9" runat="server" class="form-control"/>
              <asp:Label ID="lblregistrationform" runat="server" ForeColor="#669900" Font-Bold="True"></asp:Label>
          </div>
               
               
              </div>
          <hr />
              
         <div class="row g-3">
                <div class="col-12 text-end">
                    <asp:LinkButton ID="LinkButton22" runat="server" class="btn btn-success" OnClick="LinkButton22_Click">Proceed to Verify</asp:LinkButton>
                  
                  </div>
        </div>
      </div>
   





  </div>

        </div>
        <!-- Step 7 -->
 <div class="accordion-item">
    <h2 class="accordion-header" id="heading2">
      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapse7">
        <span class="step-number">STEP 7</span> <b>Final Signed Agrement</b>
      </button>
    </h2>
    <div id="collapse7" class="accordion-collapse collapse" data-bs-parent="#kycAccordion">
      <div class="accordion-body">
           <div class="alert alert-warning">
      <strong>Note:- </strong> Download Agrement and Upload Below After Signed and Stump <a href="#" class="btn btn-primary">Download</a>
    </div>
        
          <div class="row g-3">
        <div class="col-md-12">
            <label>Upload Signed Copy of Agrement</label><asp:HiddenField ID="hfOnboardingStatus" runat="server" />
              <asp:FileUpload ID="FileUpload10" runat="server" class="form-control"/>
              <asp:Label ID="lblagrementcopy" runat="server" ForeColor="#669900" Font-Bold="True"></asp:Label>
          </div>
              </div>
          <hr />
              
         <div class="row g-3">
                <div class="col-12 text-end">
                    <asp:LinkButton ID="LinkButton14" runat="server" class="btn btn-success" OnClick="LinkButton14_Click">Proceed to Verify</asp:LinkButton>
                  
                  </div>
        </div>
      </div>
  </div>

        </div>
    </div>
  

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

    </form>
</body>
</html>
