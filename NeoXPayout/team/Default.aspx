<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="NeoXPayout.team.Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
   <title>:: Welcome Admin</title>
     <meta charset="utf-8">
     <meta http-equiv="X-UA-Compatible" content="IE=Edge">
     <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
     
     <!--[ Favicon]-->
     <link rel="icon" type="image/x-icon" href="../assets/images/favicon.ico">
     <link rel="icon" type="image/png" sizes="16x16" href="../assets/images/favicon-16x16.png">
     <link rel="icon" type="image/png" sizes="32x32" href="../assets/images/favicon-32x32.png">
     <link rel="apple-touch-icon" sizes="180x180" href="../assets/images/apple-touch-icon.png">
     <!--[ Template main css file ]-->
     <link rel="stylesheet" href="../assets/css/style.min.css">
     <!--============== active class js =============-->
     <script src="../assets/js/active-class.js"></script>
</head>

<body data-theme="theme-Greylight" class="svgstroke-a">
    <form id="form1" runat="server">
        
     <main class="container-fluid px-0">
          <!-- start: page menu link -->
          <div class="content">
               <!-- start: page body area -->
               <div class="px-xl-5 px-lg-4 px-3 py-3 page-body my-2 py-2">
                    <div style="height: 90vh;" class="row justify-content-center align-items-center">
                         <div class="col-xl-4 col-lg-5 col-md-7">
                              <div class="card">
                                   <div class="card-body">
                                        <div class="d-flex flex-column align-items-center ">
                                             <div class="no-thumbnail rounded-circle border bg-light p-2">
                                                  <div class="no-thumbnail rounded-circle border bg-white p-2">
                                                       <svg xmlns="http://www.w3.org/2000/svg" width="34"
                                                            viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                                            stroke-linecap="round" stroke-linejoin="round"
                                                            class=" svg-stroke">
                                                            <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>
                                                            <path d="M8 7a4 4 0 1 0 8 0a4 4 0 0 0 -8 0"></path>
                                                            <path d="M16 19h6"></path>
                                                            <path d="M19 16v6"></path>
                                                            <path d="M6 21v-2a4 4 0 0 1 4 -4h4"></path>
                                                       </svg>
                                                  </div>
                                             </div>
                                             <div class="mt-3 ">
                                                  <h6 class="text-capitalize text-center fw-bold">Login to your Admin account
                                                  </h6>
                                                  <span class="text-muted text-capitalize">enter your details to
                                                       login</span>
                                             </div>
                                             <div class="mt-3 w-100">
                                                  <form class="form-horizontal" id="validateForm">
                                                       <fieldset>
                                                            <!--=== email ===-->
                                                            <div class="mb-3">
                                                                 <label for="email" class="form-label">Mobile No</label>
                                                                 <div class="input-group">
                                                                      <span class="input-group-text bg-transparent">
                                                                           <svg xmlns="http://www.w3.org/2000/svg"
                                                                                width="20" viewBox="0 0 24 24"
                                                                                fill="none" stroke="currentColor"
                                                                                stroke-linecap="round"
                                                                                stroke-linejoin="round"
                                                                                class=" svg-stroke">
                                                                                <path stroke="none" d="M0 0h24v24H0z"
                                                                                     fill="none"></path>
                                                                                <path
                                                                                     d="M3 7a2 2 0 0 1 2 -2h14a2 2 0 0 1 2 2v10a2 2 0 0 1 -2 2h-14a2 2 0 0 1 -2 -2v-10z">
                                                                                </path>
                                                                                <path d="M3 7l9 6l9 -6"></path>
                                                                           </svg>
                                                                      </span>
                                                                     <asp:TextBox ID="txtemailid" required=""  MaxLength="10" runat="server" class="form-control border-start-0"></asp:TextBox>
                                                                     
                                                                 </div>
                                                            </div>
                                                            <!-- Password input-->
                                                            <div class="form-group">
                                                                 <label for="password"
                                                                      class="form-label">Password</label>
                                                                 <div class="input-group">
                                                                      <span class="input-group-text bg-transparent">
                                                                           <svg xmlns="http://www.w3.org/2000/svg"
                                                                                width="20" viewBox="0 0 24 24"
                                                                                fill="none" stroke="currentColor"
                                                                                stroke-linecap="round"
                                                                                stroke-linejoin="round"
                                                                                class=" svg-stroke">
                                                                                <path stroke="none" d="M0 0h24v24H0z"
                                                                                     fill="none"></path>
                                                                                <path
                                                                                     d="M5 13a2 2 0 0 1 2 -2h10a2 2 0 0 1 2 2v6a2 2 0 0 1 -2 2h-10a2 2 0 0 1 -2 -2z">
                                                                                </path>
                                                                                <path d="M8 11v-4a4 4 0 1 1 8 0v4">
                                                                                </path>
                                                                                <path d="M15 16h.01"></path>
                                                                                <path d="M12.01 16h.01"></path>
                                                                                <path d="M9.02 16h.01"></path>
                                                                           </svg>
                                                                      </span>
                                                                     <asp:TextBox ID="txtpassword" required="" TextMode="Password" runat="server" class="form-control border-start-0"></asp:TextBox>
                                                                      
                                                                 </div>
                                                            </div>
                                                            <!-- check -->
                                                            <div class="d-flex justify-content-between my-3">
                                                                 <div class="form-check ">
                                                                   
                                                                 </div>
                                                                 
                                                            </div>
                                                            <!-- Button -->
                                                           
                                                            <div class="form-group">
                                                                <asp:LinkButton ID="LinkButton1" runat="server" class="btn btn-dark w-100" OnClick="LinkButton1_Click">sign in</asp:LinkButton>
                                                            </div>

                                                            
                                                       </fieldset>
                                                  </form>
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
                              href="#">@2025 By Your CompanyName</a>
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
