<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="NeoXPayout.Admin.Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
   <title>BankU India Limited Admin</title>
     <meta charset="utf-8">
     <meta http-equiv="X-UA-Compatible" content="IE=Edge">
     <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
     
     <!--[ Favicon]-->
    <link rel="icon" type="image/x-icon" href="../assets/images/favicon.ico">
     <link rel="icon" type="image/png" sizes="16x16" href="../assets/images/apple-touch-icon.png">
     <link rel="icon" type="image/png" sizes="32x32" href="../assets/images/apple-touch-icon.png">
     <link rel="apple-touch-icon" sizes="180x180" href="../assets/images/apple-touch-icon.png">
     <!--[ Template main css file ]-->
     <link rel="stylesheet" href="../assets/css/style.min.css">
     <!--============== active class js =============-->
     <script src="../assets/js/active-class.js"></script>
</head>

<body data-theme="theme-Greylight" class="svgstroke-a">
    <form id="form1" runat="server">
        
     <main class="container-fluid px-0" style="background-color:#f3e8ff">
    <div class="content">
        <div class="px-xl-5 px-lg-4 px-3 py-3 page-body my-2 py-2">
            <div style="height: 90vh;" class="row justify-content-center align-items-center">
                <div class="col-xl-4 col-lg-5 col-md-7">
                    <div class="card shadow-lg border-0 rounded-4">
                        <div class="card-body p-4">
                            <div class="d-flex flex-column align-items-center">
                                <!-- Avatar -->
                                <div class="no-thumbnail  p-2">
                                    <div class="no-thumbnail p-2">
                                        <img src="../BankULogo1.png" style="height:70px; width:auto" />
                                    </div>
                                </div>

                                <!-- Heading -->
                                <div class="mt-3 text-center">
                                    <h5 class="fw-bold text-uppercase" style="color: purple;">
                                        Login to your Admin account
                                    </h5>
                                    <span class="text-muted text-capitalize">Enter your details to login</span>
                                </div>

                                <!-- Form -->
                                <div class="mt-4 w-100">
                                    <fieldset>
                                        <!-- Mobile input -->
                                        <div class="mb-3">
                                            <label for="txtNumber" class="form-label fw-semibold">Mobile No</label>
                                            <div class="input-group">
                                                <span class="input-group-text bg-transparent" style="color:purple;">
                                                    <i class="bi bi-phone"></i>
                                                </span>
                                                <asp:TextBox ID="txtNumber" TextMode="SingleLine"  MaxLength="10"
                                                    runat="server" AutoCompleteType="None"
                                                    CssClass="form-control border-start-0"
                                                    placeholder="Enter mobile number"></asp:TextBox>
                                                 <!-- Required Field Validator -->
                                               
                                            </div>
                                             <asp:RequiredFieldValidator 
                                                    ID="rfvNumber" runat="server" ControlToValidate="txtNumber" Display="Dynamic" ErrorMessage="Mobile number is required" CssClass="text-danger">
                                                </asp:RequiredFieldValidator>
                                            
                                                <asp:RegularExpressionValidator 
                                                    ID="revNumber" runat="server" ControlToValidate="txtNumber" ValidationExpression="^\d{10}$" Display="Dynamic" ErrorMessage="Enter a valid 10-digit mobile number"
                                                    CssClass="text-danger">
                                                </asp:RegularExpressionValidator>
                                        </div>
                                        <asp:Label runat="server" ID="lblError"></asp:Label>
                                        <!-- OTP Panel -->
                                        <asp:Panel ID="pnlOTP" runat="server" Visible="false">
                                            <div class="mb-3">
                                                <label for="txtOtp" class="form-label fw-semibold">OTP</label>
                                                <div class="input-group">
                                                    <span class="input-group-text bg-transparent" style="color:purple;">
                                                        <i class="bi bi-shield-lock"></i>
                                                    </span>
                                                    <asp:TextBox ID="txtOtp" MaxLength="4" TextMode="Password"
                                                        runat="server" autocomplete="off"
                                                        CssClass="form-control border-start-0"
                                                        placeholder="Enter 4-digit OTP"></asp:TextBox>
                                                </div>
                                            </div>
                                        </asp:Panel>
                                        <asp:Label runat="server" ID="lblOTPStatus" ></asp:Label>
                                        <!-- Submit button -->
                                        <div class="form-group mt-4">
                                            <asp:LinkButton ID="LinkButton1" runat="server" 
                                                CssClass="btn w-100 text-white"
                                                Style="background-color:purple; border:none;"
                                                OnClick="LinkButton1_Click">Sign In</asp:LinkButton>
                                        </div>
                                    </fieldset>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>

     <footer class="w-100 bg-body position-fixed bottom-0">
          <div class="container-fluid">
               <div class="d-flex align-items-center">
                    <div class="p-0 m-0">
                         <a class="link-offset-2 link-offset-3-hover link-underline link-underline-opacity-0 link-underline-opacity-75-hover text-reverse"
                              href="#">@2025 By BankU</a>
                    </div>
                    
               </div>
          </div>
     </footer>
    </form>

     <!--[ FintechWeb template vender js ]-->
     <script src="../assets/bundles/libscripts.bundle.js"></script>
     <script src="../assets/bundles/dynamicselect.js"></script>
     <!-- Template page js -->
     <script src="../assets/js/main.js" defer></script> 
</body>
</html>
