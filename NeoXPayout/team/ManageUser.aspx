<%@ Page Title="" Language="C#" MasterPageFile="~/team/Team.Master" AutoEventWireup="true" CodeBehind="ManageUser.aspx.cs" Inherits="NeoXPayout.team.ManageUser" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
         <!-- start: page header area -->
               <div class="px-xl-5 px-lg-4 px-3 py-2 page-header">
                    <div class="col-sm-6 ">
                         <ol class="breadcrumb mb-0 bg-transparent ">
                              <li class="breadcrumb-item"><a class="text-muted" href="index.html" title="home">Home</a>
                              </li>
                              <li class="breadcrumb-item active" aria-current="page" title="Dashboard">setting</li>
                         </ol>
                    </div>
               </div>
               <!-- start: page body area -->
               <div class="px-xl-5 px-lg-4 px-3 py-3 page-body">
                    <div class="row">
                         <div class="col-sm-12">
                              <div class="card ">
                                   <div class="card-header border-bottom pb-0 ">
                                        <!--=== tab buttons ===-->
                                        <ul class="nav nav-pills nav-pills-underline d-none d-sm-flex" id="pills-tab"
                                             role="tablist">
                                             <li class="nav-item" role="presentation">
                                                  <button class="nav-link active ps-0 pb-0" id="pills-home-tab"
                                                       data-bs-toggle="pill" data-bs-target="#pills-home" type="button"
                                                       role="tab" aria-controls="pills-home"
                                                       aria-selected="true">Account</button>
                                             </li>
                                             <li class="nav-item" role="presentation">
                                                  <button class="nav-link pb-0" id="pills-profile-tab"
                                                       data-bs-toggle="pill" data-bs-target="#pills-profile"
                                                       type="button" role="tab" aria-controls="pills-profile"
                                                       aria-selected="false">Business Details</button>
                                             </li>
                                             <li class="nav-item" role="presentation">
                                                  <button class="nav-link pb-0" id="pills-contact-tab"
                                                       data-bs-toggle="pill" data-bs-target="#pills-contact"
                                                       type="button" role="tab" aria-controls="pills-contact"
                                                       aria-selected="false">Personal Details</button>
                                             </li>
                                             <li class="nav-item" role="presentation">
                                                  <button class="nav-link pb-0 ps-0 ps-sm-3 " id="pills-disabled-tab"
                                                       data-bs-toggle="pill" data-bs-target="#pills-disabled"
                                                       type="button" role="tab" aria-controls="pills-disabled"
                                                       aria-selected="false">Bank Details</button>
                                             </li>
                                             <li class="nav-item" role="presentation">
                                                  <button class="nav-link pb-0" id="pills-disabled-tab-one"
                                                       data-bs-toggle="pill" data-bs-target="#pills-Localization"
                                                       type="button" role="tab" aria-controls="pills-disabled"
                                                       aria-selected="false">KYC Document</button>
                                             </li>
                                             <li class="nav-item" role="presentation">
                                                  <button class="nav-link pb-0" id="pills-disabled-tab-one1"
                                                       data-bs-toggle="pill" data-bs-target="#pills-Approval"
                                                       type="button" role="tab" aria-controls="pills-disabled"
                                                       aria-selected="false">Final Approval</button>
                                             </li>
                                           
                                        </ul>
                                        <!--=== dropdown tabs button ===-->
                                        <div class="dropdown w-100 d-sm-none mb-3">
                                             <button class="btn btn-secondary dropdown-toggle w-100"
                                                  id="dropdown-value-set" type="button" data-bs-toggle="dropdown"
                                                  aria-expanded="false">Accounts</button>
                                             <ul class="dropdown-menu w-100 " id="pills-tab-page" role="tablist">
                                                  <li class="dropdown-item ">
                                                       <button class="nav-link active ps-0 pb-0 w-100 "
                                                            id="pills-home-tab-one" data-bs-toggle="pill"
                                                            data-bs-target="#pills-home" type="button" role="tab"
                                                            aria-controls="pills-home"
                                                            aria-selected="true">Account</button>
                                                  </li>
                                                  <li class="dropdown-item">
                                                       <button class="nav-link pb-0 w-100" id="pills-profile-tab-two"
                                                            data-bs-toggle="pill" data-bs-target="#pills-profile"
                                                            type="button" role="tab" aria-controls="pills-profile"
                                                            aria-selected="false">Business Details</button>
                                                  </li>
                                                  <li class="dropdown-item">
                                                       <button class="nav-link pb-0 w-100" id="pills-contact-tabthree"
                                                            data-bs-toggle="pill" data-bs-target="#pills-contact"
                                                            type="button" role="tab" aria-controls="pills-contact"
                                                            aria-selected="false">Personal Details</button>
                                                  </li>
                                                  <li class="dropdown-item">
                                                       <button class="nav-link pb-0  w-100" id="pills-disabled-tab-two"
                                                            data-bs-toggle="pill" data-bs-target="#pills-disabled"
                                                            type="button" role="tab" aria-controls="pills-disabled"
                                                            aria-selected="false">Bank Details</button>
                                                  </li>
                                                  <li class="dropdown-item">
                                                       <button class="nav-link pb-0 w-100" id="pills-disabled-tab-three"
                                                            data-bs-toggle="pill" data-bs-target="#pills-Localization"
                                                            type="button" role="tab" aria-controls="pills-disabled"
                                                            aria-selected="false">KYC Document</button>
                                                  </li>
                                                   <li class="dropdown-item">
                                                       <button class="nav-link pb-0 w-100" id="pills-disabled-tab-four"
                                                            data-bs-toggle="pill" data-bs-target="#pills-Approval"
                                                            type="button" role="tab" aria-controls="pills-disabled"
                                                            aria-selected="false">Final Approval</button>
                                                  </li>
                                                
                                             </ul>
                                        </div>
                                   </div>
                                   <div class="card-body ">
                                        <div class="tab-content" id="pills-tabContent">
                                             <!--=== Account ===-->
                                             <div class="tab-pane fade show active" id="pills-home" role="tabpanel"
                                                  aria-labelledby="pills-home-tab" tabindex="0">
                                               
                                                  <div class="table-responsive custom_scroll">
                                                       <!-- Table -->
                                                       <table class="table table-hover">
                                                            <tbody>
                                                              
                                                                 <tr>
                                                                      <th>Full Name</th>
                                                                      <td colspan="2">
                                                                          <asp:Label ID="lblfullname" runat="server"></asp:Label></td>
                                                                 </tr>
                                                                 <tr>
                                                                      <th>Email Address</th>
                                                                      <td colspan="2"><asp:Label ID="lblemailid" runat="server"></asp:Label></td>
                                                                 </tr>
                                                                 <tr>
                                                                      <th>Phone Number</th>
                                                                      <td colspan="2"><asp:Label ID="lblmobileno" runat="server"></asp:Label></td>
                                                                 </tr>
                                                                 <tr>
                                                                      <th>Password</th>
                                                                      <td colspan="2"><asp:Label ID="lblpassword" runat="server"></asp:Label></td>
                                                                 </tr>
                                                                  <tr>
                                                                      <th>Signup Status</th>
                                                                      <td colspan="2"><asp:Label ID="lblsignupstatus" runat="server"></asp:Label></td>
                                                                 </tr>
                                                                  <tr>
                                                                      <th>Mobile Verified</th>
                                                                      <td colspan="2"><asp:Label ID="lblmobilevefified" runat="server"></asp:Label></td>
                                                                 </tr>
                                                            </tbody>
                                                       </table>
                                                  </div>
                                             </div>
                                             <!--=== settings ===-->
                                             <div class="tab-pane fade " id="pills-profile" role="tabpanel"
                                                  aria-labelledby="pills-profile-tab" tabindex="0">
                                                     <div class="table-responsive custom_scroll">
                                                       <!-- Table -->
                                                       <table class="table table-hover">
                                                            <tbody>
                                                              
                                                                 <tr>
                                                                      <th>Legal Business Name</th>
                                                                      <td colspan="2"><asp:Label ID="txtbusinessname" runat="server"></asp:Label></td>
                                                                 </tr>
                                                                 <tr>
                                                                      <th>Date of Incorporation</th>
                                                                      <td colspan="2"><asp:Label ID="txtdateofincorportation" runat="server"></asp:Label></td>
                                                                 </tr>
                                                                 <tr>
                                                                      <th>Correspondence Address</th>
                                                                      <td colspan="2"><asp:Label ID="txtbusinessaddress" runat="server"></asp:Label></td>
                                                                 </tr>
                                                                 <tr>
                                                                      <th>Udyam Registration Number</th>
                                                                      <td colspan="2"><asp:Label ID="txtdhyamregistrationnumber" runat="server"></asp:Label></td>
                                                                 </tr>
                                                                  <tr>
                                                                      <th>Business Type</th>
                                                                      <td colspan="2"><asp:Label ID="ddlbusinesstype" runat="server"></asp:Label></td>
                                                                 </tr>
                                                                <tr>
                                                                      <th>Business Details Status</th>
                                                                      <td colspan="2"><asp:Label ID="lblbusinessstatus" runat="server"></asp:Label></td>
                                                                 </tr>
                                                                  <tr>
                                                                      <th>Business Details Status</th>
                                                                      <td colspan="2">
                                                                          <asp:DropDownList ID="ddlbusinessstatus" runat="server" CssClass="form-control">
                                                                              <asp:ListItem>DONE</asp:ListItem>
                                                                              <asp:ListItem>Pending</asp:ListItem>
                                                                          </asp:DropDownList></td>
                                                                 </tr>
                                                                 <tr>
                                                                      <th>Notification</th>
                                                                      <td colspan="2">
                                                                          <asp:TextBox ID="TextBox1" runat="server" CssClass="form-control"></asp:TextBox>
                                                                        </td>
                                                                 </tr>
                                                                 <tr>
                                                                      <th></th>
                                                                      <td colspan="2">
                                                                       
                                                                          <asp:LinkButton ID="LinkButton2" runat="server" CssClass="btn btn-danger" OnClick="LinkButton2_Click">Update Details</asp:LinkButton>
                                                                        </td>
                                                                 </tr>
                                                                 
                                                            </tbody>
                                                       </table>
                                                  </div>
                                             </div>
                                             <!--=== notification ===-->
                                             <div class="tab-pane fade" id="pills-contact" role="tabpanel"
                                                  aria-labelledby="pills-contact-tab" tabindex="0">
                                                  <div class="table-responsive custom_scroll">
                                                       <!-- Table -->
                                                       <table class="table table-hover">
                                                            <tbody>
                                                              <tr>
                                                                      <th>Pan card No</th>
                                                                      <td colspan="2"><asp:Label ID="txtpanno" runat="server"></asp:Label></td>
                                                                 </tr>
                                                                 <tr>
                                                                      <th>Voter Id number</th>
                                                                      <td colspan="2"><asp:Label ID="txtvoterid" runat="server"></asp:Label></td>
                                                                 </tr>
                                                                 <tr>
                                                                      <th>Aadhaar Number</th>
                                                                      <td colspan="2"><asp:Label ID="txtaadharno" runat="server"></asp:Label></td>
                                                                 </tr>
                                                                 <tr>
                                                                      <th>Father's Name</th>
                                                                      <td colspan="2"><asp:Label ID="txtfathername" runat="server"></asp:Label></td>
                                                                 </tr>
                                                                 <tr>
                                                                      <th>Mother's Name</th>
                                                                      <td colspan="2"><asp:Label ID="txtmothername" runat="server"></asp:Label></td>
                                                                 </tr>
                                                                  <tr>
                                                                      <th>Date of Birth</th>
                                                                      <td colspan="2"><asp:Label ID="txtdob" runat="server"></asp:Label></td>
                                                                 </tr>
                                                                  <tr>
                                                                      <th>Gender</th>
                                                                      <td colspan="2"><asp:Label ID="lblgender" runat="server"></asp:Label></td>
                                                                 </tr>
                                                                 <tr>
                                                                      <th>User Position</th>
                                                                      <td colspan="2"><asp:Label ID="lbluserposition" runat="server"></asp:Label></td>
                                                                 </tr>
                                                                 <tr>
                                                                      <th>Permanent Address</th>
                                                                      <td colspan="2"><asp:Label ID="txtpermanentaddress" runat="server"></asp:Label></td>
                                                                 </tr>
                                                                 <tr>
                                                                      <th>State</th>
                                                                      <td colspan="2"><asp:Label ID="lblstate" runat="server"></asp:Label></td>
                                                                 </tr>
                                                                   <tr>
                                                                      <th>Pincode</th>
                                                                      <td colspan="2"><asp:Label ID="txtpincode" runat="server"></asp:Label></td>
                                                                 </tr>
                                                                   <tr>
                                                                      <th>Education</th>
                                                                      <td colspan="2"><asp:Label ID="lbleducation" runat="server"></asp:Label></td>
                                                                 </tr>
                                                                  <tr>
                                                                      <th>Personal Details Status</th>
                                                                      <td colspan="2"><asp:Label ID="lblpersonalstatus" runat="server"></asp:Label></td>
                                                                 </tr>
                                                                   <tr>
                                                                      <th>Personal Details Status Update</th>
                                                                      <td colspan="2">
                                                                          <asp:DropDownList ID="ddlpersonalstatus" runat="server" CssClass="form-control">
                                                                              <asp:ListItem>DONE</asp:ListItem>
                                                                              <asp:ListItem>Pending</asp:ListItem>
                                                                          </asp:DropDownList></td>
                                                                 </tr>
                                                                 <tr>
                                                                      <th>Notification</th>
                                                                      <td colspan="2">
                                                                          <asp:TextBox ID="TextBox2" runat="server" CssClass="form-control"></asp:TextBox>
                                                                        </td>
                                                                 </tr>
                                                                <tr>
                                                                      <th></th>
                                                                      <td colspan="2">
                                                                       
                                                                          <asp:LinkButton ID="LinkButton3" runat="server" CssClass="btn btn-danger" OnClick="LinkButton3_Click">Update Details</asp:LinkButton>
                                                                        </td>
                                                                 </tr>
                                                            </tbody>
                                                       </table>
                                                  </div>
                                             </div>
                                             <!--=== privacy & security ===-->
                                             <div class="tab-pane fade" id="pills-disabled" role="tabpanel"
                                                  aria-labelledby="pills-disabled-tab" tabindex="0">
                                                   <div class="table-responsive custom_scroll">
                                                       <!-- Table -->
                                                       <table class="table table-hover">
                                                            <tbody>
                                                              
                                                                 <tr>
                                                                      <th>Account Holder's</th>
                                                                      <td colspan="2"><asp:Label ID="lblaccountholder" runat="server"></asp:Label></td>
                                                                 </tr>
                                                                 <tr>
                                                                      <th>Bank Name</th>
                                                                      <td colspan="2"><asp:Label ID="lblbankname" runat="server"></asp:Label></td>
                                                                 </tr>
                                                                 <tr>
                                                                      <th>Account Number</th>
                                                                      <td colspan="2"><asp:Label ID="lblaccountno" runat="server"></asp:Label></td>
                                                                 </tr>
                                                                 <tr>
                                                                      <th>Account type</th>
                                                                      <td colspan="2"><asp:Label ID="lblaccounttype" runat="server"></asp:Label></td>
                                                                 </tr>
                                                                  <tr>
                                                                      <th>IFSC Code</th>
                                                                      <td colspan="2"><asp:Label ID="lblifsccode" runat="server"></asp:Label></td>
                                                                 </tr>
                                                                  
                                                                  <tr>
                                                                      <th>Bank Details Status</th>
                                                                      <td colspan="2"><asp:Label ID="lblbankdetailsstatus" runat="server"></asp:Label></td>
                                                                 </tr>
                                                                 <tr>
                                                                      <th>Bank Details Status Update</th>
                                                                      <td colspan="2">
                                                                          <asp:DropDownList ID="ddlbankdetailsstatus" runat="server" CssClass="form-control">
                                                                              <asp:ListItem>DONE</asp:ListItem>
                                                                              <asp:ListItem>Pending</asp:ListItem>
                                                                          </asp:DropDownList></td>
                                                                 </tr>
                                                                 <tr>
                                                                      <th>Notification</th>
                                                                      <td colspan="2">
                                                                          <asp:TextBox ID="TextBox3" runat="server" CssClass="form-control"></asp:TextBox>
                                                                        </td>
                                                                 </tr>
                                                                <tr>
                                                                      <th></th>
                                                                      <td colspan="2">
                                                                       
                                                                          <asp:LinkButton ID="LinkButton4" runat="server" CssClass="btn btn-danger" OnClick="LinkButton4_Click">Update Details</asp:LinkButton>
                                                                        </td>
                                                                 </tr>
                                                            </tbody>
                                                       </table>
                                                  </div>
                                             </div>
                                             <!--=== localization ===-->
                                             <div class="tab-pane fade" id="pills-Localization" role="tabpanel"
                                                  aria-labelledby="pills-disabled-tab" tabindex="0">
                                                   <div class="table-responsive custom_scroll">
                                                       <!-- Table -->
                                                       <table class="table table-hover">
                                                            <tbody>
                                                              
                                                                 <tr>
                                                                      <th>Upload Pancard</th>
                                                                      <td colspan="2">
                                                                          <a href=".<%=lbluploadpan.Text%>" target="_blank"><asp:Label ID="lbluploadpan" runat="server"></asp:Label></a></td>
                                                                 </tr>
                                                                 <tr>
                                                                      <th>Upload VoterCard</th>
                                                                      <td colspan="2"><a href=".<%=lbluploadvoter.Text%>" target="_blank"><asp:Label ID="lbluploadvoter" runat="server"></asp:Label></a></td>
                                                                 </tr>
                                                                 <tr>
                                                                      <th>Upload Aadhar Front</th>
                                                                      <td colspan="2"><a href=".<%=lblaadharfront.Text%>" target="_blank"><asp:Label ID="lblaadharfront" runat="server"></asp:Label></a></td>
                                                                 </tr>
                                                                 <tr>
                                                                      <th>Upload Aadhar Back</th>
                                                                      <td colspan="2"><a href=".<%=lblaadharback.Text%>" target="_blank"><asp:Label ID="lblaadharback" runat="server"></asp:Label></a></td>
                                                                 </tr>
                                                                  <tr>
                                                                      <th>Upload GST Certificate</th>
                                                                      <td colspan="2"><a href=".<%=lblgstcertificate.Text%>" target="_blank"><asp:Label ID="lblgstcertificate" runat="server"></asp:Label></a></td>
                                                                 </tr>
                                                                  
                                                                  <tr>
                                                                      <th>Upload Udyam Certificate</th>
                                                                      <td colspan="2"><a href=".<%=lbludyamcertificate.Text%>" target="_blank"><asp:Label ID="lbludyamcertificate" runat="server"></asp:Label></a></td>
                                                                 </tr>
                                                                  <tr>
                                                                      <th>Jio Tag Photo- 3 pic</th>
                                                                      <td colspan="2"><a href=".<%=lbljiotag.Text%>" target="_blank"><asp:Label ID="lbljiotag" runat="server"></asp:Label></a></td>
                                                                 </tr>
                                                                  <tr>
                                                                      <th>Passport Size Photo</th>
                                                                      <td colspan="2"><a href=".<%=lblpassportphoto.Text%>" target="_blank"><asp:Label ID="lblpassportphoto" runat="server"></asp:Label></a></td>
                                                                 </tr>
                                                                 <tr>
                                                                      <th>Upload Signed Copy of Onboarding Form</th>
                                                                      <td colspan="2"><a href=".<%=lblonboardingform.Text%>" target="_blank"><asp:Label ID="lblonboardingform" runat="server"></asp:Label></a></td>
                                                                 </tr>
                                                                 <tr>
                                                                      <th>Upload Signed Copy of Agrement</th>
                                                                      <td colspan="2"><a href=".<%=lblsignedagrement.Text%>" target="_blank"><asp:Label ID="lblsignedagrement" runat="server"></asp:Label></a></td>
                                                                 </tr>
                                                                 <tr>
                                                                      <th>Kyc Status</th>
                                                                      <td colspan="2"><asp:Label ID="lblkcystatus" runat="server"></asp:Label></td>
                                                                 </tr>
                                                                 <tr>
                                                                      <th>Onboarding Form Status</th>
                                                                      <td colspan="2"><asp:Label ID="lblregstatus" runat="server"></asp:Label></td>
                                                                 </tr>
                                                                 <tr>
                                                                      <th>Agrement Status</th>
                                                                      <td colspan="2"><asp:Label ID="lblagrementstatus" runat="server"></asp:Label></td>
                                                                 </tr>
                                                            </tbody>
                                                       </table>
                                                  </div>
                                             </div>

                                              <div class="tab-pane fade" id="pills-Approval" role="tabpanel"
                                                  aria-labelledby="pills-disabled-tab" tabindex="0">
                                                   <div class="table-responsive custom_scroll">
                                                       <!-- Table -->
                                                       <table class="table table-hover">
                                                            <tbody>
                                                              
                                                                
                                                              
                                                                
                                                                 <tr>
                                                                      <th>KYC Document Status</th>
                                                                      <td colspan="2">
                                                                          <asp:DropDownList ID="ddlkycdocumetstatus" runat="server" CssClass="form-control">
                                                                              <asp:ListItem>DONE</asp:ListItem>
                                                                              <asp:ListItem>Pending</asp:ListItem>
                                                                          </asp:DropDownList></td>
                                                                 </tr>
                                                                 <tr>
                                                                      <th>Onboarding Form Status</th>
                                                                      <td colspan="2">
                                                                          <asp:DropDownList ID="ddlonboardingformstatus" runat="server" CssClass="form-control">
                                                                              <asp:ListItem>DONE</asp:ListItem>
                                                                              <asp:ListItem>Pending</asp:ListItem>
                                                                          </asp:DropDownList></td>
                                                                 </tr>
                                                                   <tr>
                                                                      <th>Final Agrement Status</th>
                                                                      <td colspan="2">
                                                                          <asp:DropDownList ID="ddlagrementstatus" runat="server" CssClass="form-control">
                                                                              <asp:ListItem>DONE</asp:ListItem>
                                                                              <asp:ListItem>Pending</asp:ListItem>
                                                                          </asp:DropDownList></td>
                                                                 </tr>
                                                                 <tr>
                                                                      <th>Final Onboarding Status</th>
                                                                      <td colspan="2">
                                                                          <asp:DropDownList ID="ddlonboardingstatus" runat="server" CssClass="form-control">
                                                                               <asp:ListItem>Pending</asp:ListItem>
                                                                              <asp:ListItem>Process</asp:ListItem>
                                                                              <asp:ListItem>Approved</asp:ListItem>
                                                                              <asp:ListItem>Rejected</asp:ListItem>
                                                                          </asp:DropDownList></td>
                                                                 </tr>
                                                                  <tr>
                                                                      <th>Notification</th>
                                                                      <td colspan="2">
                                                                          <asp:TextBox ID="txtnotification" runat="server" CssClass="form-control"></asp:TextBox>
                                                                        </td>
                                                                 </tr>
                                                                <tr>
                                                                      <th></th>
                                                                      <td colspan="2">
                                                                          <asp:HiddenField ID="HiddenField1" runat="server" />
                                                                          <asp:LinkButton ID="LinkButton1" runat="server" CssClass="btn btn-danger" OnClick="LinkButton1_Click">Update Details</asp:LinkButton>
                                                                        </td>
                                                                 </tr>
                                                            </tbody>
                                                       </table>
                                                  </div>
                                             </div>
                                        </div>
                                   </div>
                              </div>
                         </div>
                    </div>
               </div>


  
</asp:Content>
