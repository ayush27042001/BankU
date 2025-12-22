<%@ Page Title="" Language="C#" MasterPageFile="~/Neox.Master" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="NeoXPayout.Profile" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<main class="container-fluid px-0">
    <div class="content">
        <!-- start: page header -->
			

			<!-- start: page body area -->
			<div class="px-xl-5 px-lg-4 px-3 py-3 page-body">
				<div class="row">
					<div class="col-sm-12">
						<div class="card ">
							<div class="card-header bg-card pb-3">

								<h6 class="card-title mb-0">My Profile</h6>
                                 <asp:LinkButton runat="server" ID="btnUpdate" CssClass="btn btn-sm ms-auto"
                                style="background-color: purple; color: #fff; border: none; "
                                      OnClientClick="openUpdateSidebar(); return false;">
                                         Update
                                 </asp:LinkButton>
								<div class="dropdown card-action">
									
									
								</div>
								<div class="card border-0 shadow-sm rounded-4 p-4 mt-4 w-100 bg-white">
									<div class="d-flex flex-column flex-md-row align-items-center">
										<!-- Profile Image -->
								<div class="text-center">
                                <div class="position-relative d-inline-block mb-3">
                                    <img id="imgPreview" src="assets/images/user.png"
                                         alt="User" runat="server"
                                         class="rounded-circle border border-3 border-light shadow-sm"
                                         style="width: 120px; height: 120px; object-fit: cover;">

                                    <!-- Online status -->
                                    <span class="position-absolute bottom-0 end-0 translate-middle p-2 bg-success border border-light rounded-circle shadow-sm"></span>

                                    <!-- Upload icon overlay -->
                                    <div onclick="document.getElementById('<%= profileUpload.ClientID %>').click();" 
                                         class="position-absolute bottom-0 start-50 translate-middle-x bg-white rounded-circle p-2 shadow-sm"
                                         style="cursor: pointer;">
                                        <i class="bi bi-camera text-primary"></i>
                                    </div>

                                    <asp:FileUpload ID="profileUpload" runat="server" CssClass="d-none" onchange="previewImage(event)" />
                                </div>

                                <!-- Save Button -->
                                <div class="text-center mt-2">
                                    <asp:Button ID="btnSaveImage" runat="server" 
                                                Text="Save Photo" 
                                                CssClass="btn btn-sm  shadow-sm px-3"
                                                OnClick="SaveImage_Click" style="background-color:purple; color:white"/>
                                 <asp:Label ID="lblMessage" runat="server" CssClass="mt-2 d-block fw-bold" 
                                 style="font-size:12px;"></asp:Label>

                                </div>
                            </div>


										<!-- User Info -->
										<div class="ms-md-4 mt-3 mt-md-0 text-center text-md-start flex-grow-1">
											<h4 class="fw-semibold mb-1 text-dark">
												<asp:Label ID="lblName" runat="server"></asp:Label>
											</h4>
											<p class="text-muted mb-3 small">
												<asp:Label ID="lblEmail" runat="server"></asp:Label>
											</p>

											<!-- Info Badges -->
											<div class="d-flex flex-wrap justify-content-center justify-content-md-start gap-2">
												<div class="bg-light rounded-3 py-2 px-3 shadow-sm border text-center">
													<small class="text-muted d-block">Date of Birth</small>
													<asp:Label ID="lblDob" runat="server" CssClass="fw-semibold text-dark"></asp:Label>
												</div>
												<div class="bg-light rounded-3 py-2 px-3 shadow-sm border text-center">
													<small class="text-muted d-block">Father’s Name</small>
													<asp:Label ID="lblFather" runat="server" CssClass="fw-semibold text-dark"></asp:Label>
												</div>
												<div class="bg-light rounded-3 py-2 px-3 shadow-sm border text-center">
													<small class="text-muted d-block">Gender</small>
													<asp:Label ID="lblGender" runat="server" CssClass="fw-semibold text-dark"></asp:Label>
												</div>
											</div>
										</div>
									</div>
								</div>


							</div>
							<div class="card-body border-top">
								<div class="row g-4">

									<div class="col-xl-4 col-lg-5">
                                        <div class="card border-0 shadow-sm rounded-4">
                                            <div class="card-body p-4">
                                              <div class="d-flex justify-content-between align-items-center mb-3">
                                                <h5 class="card-title fw-semibold mb-1 text-dark">Personal Information</h5>
                                                <asp:LinkButton runat="server" ID="btnAddVoter" CssClass="btn btn-sm"
                                                        style="background-color: purple; color: #fff; border: none;"
                                                        OnClientClick="openAddVoterModal(); return false;">
                                                        Add VoterId
                                                    </asp:LinkButton>
                                                 </div>
                                                 <asp:Label runat="server" ID="lblVoterErr" CssClass=" text-danger"></asp:Label>
                                                <p class="text-muted small mb-4">Below is your personal profile summary.</p>

                                                <div class="d-flex flex-column gap-3">

                                                    <div class="d-flex justify-content-between align-items-center border-bottom pb-2">
                                                        <small class="fw-semibold text-uppercase text-secondary">Full Name</small>
                                                        <asp:Label ID="lblFullName" runat="server" CssClass="text-dark fw-medium"></asp:Label>
                                                    </div>

                                                 <div class="d-flex justify-content-between align-items-center border-bottom pb-2">
                                                    <small class="fw-semibold text-uppercase text-secondary">Email</small>
                                                    <asp:Label ID="Email" runat="server" CssClass="text-dark fw-medium text-break text-end" Style="max-width: 250px;"></asp:Label>
                                                </div>

                                                    <div class="d-flex justify-content-between align-items-center border-bottom pb-2">
                                                        <small class="fw-semibold text-uppercase text-secondary">Phone</small>
                                                        <asp:Label ID="lblPhone" runat="server" CssClass="text-dark fw-medium"></asp:Label>
                                                    </div>

                                                    <div class="d-flex justify-content-between align-items-center border-bottom pb-2">
                                                        <small class="fw-semibold text-uppercase text-secondary">Date of Birth</small>
                                                        <asp:Label ID="DOB" runat="server" CssClass="text-dark fw-medium"></asp:Label>
                                                    </div>

                                                    <div class="d-flex justify-content-between align-items-center border-bottom pb-2">
                                                        <small class="fw-semibold text-uppercase text-secondary">Address</small>
                                                        <asp:Label ID="lblAddress" runat="server" CssClass="text-dark fw-medium text-end text-wrap" style="max-width: 180px;"></asp:Label>
                                                    </div>

                                                    <div class="d-flex justify-content-between align-items-center border-bottom pb-2">
                                                        <small class="fw-semibold text-uppercase text-secondary">State</small>
                                                        <asp:Label ID="lblState" runat="server" CssClass="text-dark fw-medium"></asp:Label>
                                                    </div>

                                                    <div class="d-flex justify-content-between align-items-center border-bottom pb-2">
                                                        <small class="fw-semibold text-uppercase text-secondary">Aadhaar Number</small>
                                                        <asp:Label ID="lblAadhaar" runat="server" CssClass="text-dark fw-medium"></asp:Label>
                                                    </div>

                                                    <div class="d-flex justify-content-between align-items-center border-bottom pb-2">
                                                        <small class="fw-semibold text-uppercase text-secondary">Voter ID Card</small>
                                                        <asp:Label ID="lblVoter" runat="server" CssClass="text-dark fw-medium"></asp:Label>
                                                    </div>

                                                    <div class="d-flex justify-content-between align-items-center border-bottom pb-2">
                                                        <small class="fw-semibold text-uppercase text-secondary">PAN Number</small>
                                                        <asp:Label ID="lblPan" runat="server" CssClass="text-dark fw-medium"></asp:Label>
                                                    </div>

                                                    <div class="d-flex justify-content-between align-items-center">
                                                        <small class="fw-semibold text-uppercase text-secondary">Postal Code</small>
                                                        <asp:Label ID="lblPostalCode" runat="server" CssClass="text-dark fw-medium"></asp:Label>
                                                    </div>

                                                </div>
                                            </div>
                                        </div>
                                    </div>


									<div class="col-xl-4 col-lg-5">
                                        <div class="card border-0 shadow-sm rounded-4">
                                            <div class="card-body p-4">
                                                  <div class="d-flex justify-content-between align-items-center mb-3">
                                                <h5 class="card-title fw-semibold mb-1 text-dark">Business Details</h5>
                                                <asp:LinkButton runat="server" ID="btnGST" CssClass="btn btn-sm"
                                                        style="background-color: purple; color: #fff; border: none;"
                                                        OnClientClick="openGStModal(); return false;">
                                                        Add GST
                                                    </asp:LinkButton>
                                                      </div>
                                                 <asp:Label runat="server" ID="lblErrorGst" CssClass=" text-danger"></asp:Label>
                                                <p class="text-muted small mb-4">Provide your business name, type, and registration details.</p>

                                                <div class="d-flex flex-column gap-3">

                                                    <div class="d-flex justify-content-between align-items-center border-bottom pb-2">
                                                        <small class="fw-semibold text-uppercase text-secondary">Business PAN</small>
                                                        <asp:Label ID="lblBusinessPan" runat="server" CssClass="text-dark fw-medium"></asp:Label>
                                                    </div>

                                                    <div class="d-flex justify-content-between align-items-center border-bottom pb-2">
                                                        <small class="fw-semibold text-uppercase text-secondary">Business Proof</small>
                                                        <asp:Label ID="lblBusinessProof" runat="server" CssClass="text-dark fw-medium text-end text-wrap" style="max-width: 180px;"></asp:Label>
                                                    </div>
                                                   <%-- <div class="d-flex justify-content-between align-items-center border-bottom pb-2">
                                                        <small class="fw-semibold text-uppercase text-secondary">Business Proof No.</small>
                                                        <asp:Label ID="lblProofNo" runat="server" CssClass="text-dark fw-medium text-end text-wrap" style="max-width: 180px;"></asp:Label>
                                                    </div>--%>

                                                    <div class="d-flex justify-content-between align-items-center border-bottom pb-2">
                                                        <small class="fw-semibold text-uppercase text-secondary">Nature of Business</small>
                                                        <asp:Label ID="lblNature" runat="server" CssClass="text-dark fw-medium text-end text-wrap"></asp:Label>
                                                    </div>

                                                    <div class="d-flex justify-content-between align-items-center border-bottom pb-2">
                                                        <small class="fw-semibold text-uppercase text-secondary">Business Type</small>
                                                        <asp:Label ID="lblBusinessType" runat="server" CssClass="text-dark fw-medium text-end text-wrap"></asp:Label>
                                                    </div>

                                                    <div class="d-flex justify-content-between align-items-center border-bottom pb-2">
                                                        <small class="fw-semibold text-uppercase text-secondary">GST No</small>
                                                        <asp:Label ID="lblGSTNo" runat="server" CssClass="text-dark fw-medium text-end text-wrap"></asp:Label>
                                                    </div>

                                                    <div class="d-flex justify-content-between align-items-center border-bottom pb-2">
                                                        <small class="fw-semibold text-uppercase text-secondary">Company Name</small>
                                                        <asp:Label ID="lblCompName" runat="server" CssClass="text-dark fw-medium text-end text-wrap"></asp:Label>
                                                    </div>

                                                     <div class="d-flex justify-content-between align-items-center border-bottom pb-2">
                                                        <small class="fw-semibold text-uppercase text-secondary">Company Address</small>
                                                        <asp:Label ID="lblCompAddress" runat="server" CssClass="text-dark fw-medium text-end text-wrap"></asp:Label>
                                                    </div>

                                                    <div class="d-flex justify-content-between align-items-center">
                                                        <small class="fw-semibold text-uppercase text-secondary">Company Registration</small>
                                                        <asp:Label ID="lbldate" runat="server" CssClass="text-dark fw-medium"></asp:Label>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>


									 <div class="col-xl-4 col-lg-5">
                                        <div class="card border-0 shadow-sm rounded-4">
                                            <div class="card-body p-4">
                                                <div class="d-flex justify-content-between align-items-center mb-3">
                                                    <h5 class="card-title fw-semibold mb-0 text-dark">Bank Account</h5>
                                                    <asp:LinkButton runat="server" ID="addAccount" CssClass="btn btn-sm"
                                                        style="background-color: purple; color: #fff; border: none;"
                                                        OnClientClick="openAddBankModal(); return false;">
                                                        Add
                                                    </asp:LinkButton>
                                                </div>
                                                <asp:Label runat="server" ID="lblError" CssClass=" text-danger"></asp:Label>
                                                <p class="text-muted small mb-4">Provide your bank account details for transactions.</p>

                                                <div class="d-flex flex-column gap-3">

                                                    <div class="d-flex justify-content-between align-items-center border-bottom pb-2">
                                                        <small class="fw-semibold text-uppercase text-secondary">Account Holder</small>
                                                        <asp:Label ID="lblAccountHolder" runat="server" CssClass="text-dark fw-medium"></asp:Label>
                                                    </div>

                                                    <div class="d-flex justify-content-between align-items-center border-bottom pb-2">
                                                        <small class="fw-semibold text-uppercase text-secondary">Bank Name</small>
                                                        <asp:Label ID="lblBankName" runat="server" CssClass="text-dark fw-medium"></asp:Label>
                                                    </div>

                                                    <div class="d-flex justify-content-between align-items-center border-bottom pb-2">
                                                        <small class="fw-semibold text-uppercase text-secondary">Account Number</small>
                                                        <asp:Label ID="lblAccountNumber" runat="server" CssClass="text-dark fw-medium"></asp:Label>
                                                    </div>

                                                    <div class="d-flex justify-content-between align-items-center border-bottom pb-2">
                                                        <small class="fw-semibold text-uppercase text-secondary">Account Type</small>
                                                        <asp:Label ID="lblAccountType" runat="server" CssClass="text-dark fw-medium"></asp:Label>
                                                    </div>

                                                    <div class="d-flex justify-content-between align-items-center">
                                                        <small class="fw-semibold text-uppercase text-secondary">IFSC Code</small>
                                                        <asp:Label ID="lblIFSC" runat="server" CssClass="text-dark fw-medium"></asp:Label>
                                                    </div>

                                                </div>
                                            </div>
                                        </div>
                                    </div>



								</div> <!--[ .row end ]-->
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
<!-- Add Bank Account Modal -->
<div class="modal fade" id="addBankModal" tabindex="-1" aria-labelledby="addBankModalLabel" aria-hidden="true"
     data-bs-backdrop="static" data-bs-keyboard="false">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content shadow-lg rounded-3">
      
      <!-- Modal Header -->
      <div class="modal-header text-white border-0" style="background-color:purple">
        <h5 class="modal-title w-100 text-center" id="addBankModalLabel">
          Add Bank Account
        </h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
      </div>

      <!-- Modal Body -->
      <div class="modal-body">
		  <!-- Account Number -->
		  <div class="mb-3">
			<label for="txtAccountNumber" class="form-label fw-semibold">Account Number</label>
			<asp:TextBox ID="txtAccountNumber" runat="server" CssClass="form-control" 
			  placeholder="Enter account number" MaxLength="20"></asp:TextBox>
			<asp:RequiredFieldValidator ID="rfvAccountNumber" runat="server"
			  ControlToValidate="txtAccountNumber"
				ValidationGroup="BankForm"
			  ErrorMessage="Account number is required"
			  CssClass="text-danger small" Display="Dynamic" />
			<asp:RegularExpressionValidator ID="revAccountNumber" runat="server"
			  ControlToValidate="txtAccountNumber"
				ValidationGroup="BankForm"
			  ValidationExpression="^[0-9]{9,20}$"
			  ErrorMessage="Enter a valid account number (9–20 digits)"
			  CssClass="text-danger small" Display="Dynamic" />
		  </div>

		  <!-- IFSC Code -->
		  <div class="mb-3">
			<label for="txtIFSC" class="form-label fw-semibold">IFSC Code</label>
			<asp:TextBox ID="txtIFSC" runat="server" CssClass="form-control text-uppercase" 
			  placeholder="Enter IFSC code" MaxLength="11"></asp:TextBox>
			<asp:RequiredFieldValidator ID="rfvIFSC" runat="server"
			  ControlToValidate="txtIFSC"
				ValidationGroup="BankForm"
			  ErrorMessage="IFSC code is required"
			  CssClass="text-danger small" Display="Dynamic" />
			<asp:RegularExpressionValidator ID="revIFSC" runat="server"
			  ControlToValidate="txtIFSC"
			  ValidationExpression="^[A-Z]{4}0[A-Z0-9]{6}$"
			  ValidationGroup="BankForm"
			  ErrorMessage="Enter a valid IFSC code (e.g. HDFC0001234)"
			  CssClass="text-danger small" Display="Dynamic" />
		  </div>

		  <!-- Account Type -->
		  <div class="form-group mb-3">
			<label class="form-label fw-semibold">Account Type</label>
			<asp:DropDownList ID="ddlBankAccType" runat="server" CssClass="form-control"
			  style="border-radius: 6px; height: 45px; -webkit-text-fill-color: black;">
			  <asp:ListItem Text="Select Account Type" Value="" />
			  <asp:ListItem Text="Saving Account" Value="Saving" />
			  <asp:ListItem Text="Current Account" Value="Current" />
			  <asp:ListItem Text="Others" Value="Others" />
			</asp:DropDownList>
			<asp:RequiredFieldValidator ID="rfvAccType" runat="server"
			  ControlToValidate="ddlBankAccType"
			  InitialValue=""
			  ErrorMessage="Please select an account type"
				ValidationGroup="BankForm"
			  CssClass="text-danger small" Display="Dynamic" />
		  </div>

		  <!-- Add Button -->
		
		  <asp:LinkButton ID="AddBank" runat="server"
			CssClass="btn w-100 fw-semibold"
			style="background-color: purple; color: white;"
			Text="Add Account"
			  onclick="AddBank_Click"
			ValidationGroup="BankForm"></asp:LinkButton>
		</div>


    </div>
  </div>
</div>

<div class="modal fade" id="addGSTModal" tabindex="-1" aria-labelledby="addBankModalLabel" aria-hidden="true"
     data-bs-backdrop="static" data-bs-keyboard="false">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content shadow-lg rounded-3">
      
      <!-- Modal Header -->
      <div class="modal-header text-white border-0" style="background-color:purple">
        <h5 class="modal-title w-100 text-center" id="addGStModalLabel">
          Add GST Number
        </h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
      </div>

      <!-- Modal Body -->
      <div class="modal-body">
		  <!-- Account Number -->
		  <div class="mb-3">
			<label for="txtGSTNumber" class="form-label fw-semibold">GST Number</label>
			<asp:TextBox ID="txtGSTNumber" runat="server" CssClass="form-control" 
			  placeholder="Enter GST number" MaxLength="20"></asp:TextBox>
			<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
			  ControlToValidate="txtGSTNumber"
				ValidationGroup="GST"
			  ErrorMessage="GST number is required"
			  CssClass="text-danger small" Display="Dynamic" />
		
		  </div>

		  <!-- IFSC Code -->
		  <div class="mb-3">
			<label for="txtBussName" class="form-label fw-semibold">Business Name</label>
			<asp:TextBox ID="txtBussName" runat="server" CssClass="form-control " 
			  placeholder="Enter Business Name" ></asp:TextBox>
			<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
			  ControlToValidate="txtBussName"
				ValidationGroup="GST"
			  ErrorMessage="Business Name is required"
			  CssClass="text-danger small" Display="Dynamic" />
		  </div>


		  <!-- Add Button -->
		
		  <asp:LinkButton ID="btnADDGST" runat="server"
			CssClass="btn w-100 fw-semibold"
			style="background-color: purple; color: white;"
			Text="Add GST"
			onclick="btnADDGST_Click"
			ValidationGroup="GST"></asp:LinkButton>
		</div>


    </div>
  </div>
</div>

<div class="modal fade" id="addVoterModal" tabindex="-1" aria-labelledby="addVoterModalLabel" aria-hidden="true"
     data-bs-backdrop="static" data-bs-keyboard="false">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content shadow-lg rounded-3">
      
      <!-- Modal Header -->
      <div class="modal-header text-white border-0" style="background-color:purple">
        <h5 class="modal-title w-100 text-center" id="addaddVoterModalLabel">
          Add Voter ID Card Number
        </h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
      </div>

      <!-- Modal Body -->
      <div class="modal-body">
		  <!-- voter Number -->
		  <div class="mb-3">
			<label for="txtVoterID" class="form-label fw-semibold">Voter Id Number</label>
			<asp:TextBox ID="txtVoterID" runat="server" CssClass="form-control" 
			  placeholder="Enter Voter Id number" MaxLength="20"></asp:TextBox>
			<asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server"
			  ControlToValidate="txtVoterID"
				ValidationGroup="Voter"
			  ErrorMessage="Voter Id number is required"
			  CssClass="text-danger small" Display="Dynamic" />
		
		  </div>

		  <!-- Add Button -->
		
		  <asp:LinkButton ID="AddVoter" runat="server"
			CssClass="btn w-100 fw-semibold"
			style="background-color: purple; color: white;"
			Text="Add"
			onclick="AddVoter_Click"
			ValidationGroup="Voter"></asp:LinkButton>
		</div>


    </div>
  </div>
</div>

<!-- Sidebar Update Panel -->
<div class="offcanvas offcanvas-end" tabindex="-1" id="UpdateSidebar" aria-labelledby="UpdateSidebarLabel" data-bs-backdrop="static" data-bs-keyboard="false">
  <div class="offcanvas-header text-white" style="background-color: purple;">
    <h5 class="offcanvas-title" id="UpdateSidebarLabel">Update Details</h5>
    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="offcanvas"></button>
  </div>

  <div class="offcanvas-body">

    <!-- Dropdown field -->
    <div class="mb-2">
      <label class="form-label fw-semibold">Select Detail to Update</label>
      <asp:DropDownList ID="ddlDetailType" runat="server" CssClass="form-control">
        <asp:ListItem Value="">-- Select --</asp:ListItem>
        <asp:ListItem Value="FullName">Full Name</asp:ListItem>
        <asp:ListItem Value="MobileNo">Mobile No</asp:ListItem>
        <asp:ListItem Value="Email">Email</asp:ListItem>
        <asp:ListItem Value="PANNo">PAN No</asp:ListItem>
        <asp:ListItem Value="GSTNo">GST No</asp:ListItem>
        <asp:ListItem Value="BankAccount">Bank Account No</asp:ListItem>
      </asp:DropDownList>
      <asp:RequiredFieldValidator runat="server" ID="rfvDetailType"
        ControlToValidate="ddlDetailType"
        InitialValue="" CssClass="text-danger small"
        ErrorMessage="Please select a detail"
        ValidationGroup="UpdateUser" />
    </div>

    <!-- Reason -->
    <div class="mb-2">
      <label class="form-label fw-semibold">Reason for Update</label>
      <asp:TextBox ID="txtReason" runat="server" TextMode="MultiLine"
        CssClass="form-control" placeholder="Enter reason"></asp:TextBox>
      <asp:RequiredFieldValidator ID="rfvReason" runat="server"
        ControlToValidate="txtReason" CssClass="text-danger small"
        ErrorMessage="Reason is required" ValidationGroup="UpdateUser" />
    </div>

    <!-- New Value -->
    <div class="mb-2">
      <label class="form-label fw-semibold">New Value</label>
      <asp:TextBox ID="txtNewValue" runat="server" CssClass="form-control"
        placeholder="Enter new value"></asp:TextBox>
      <asp:RequiredFieldValidator ID="rfvNewValue" runat="server"
        ControlToValidate="txtNewValue" CssClass="text-danger small"
        ErrorMessage="New value required" ValidationGroup="UpdateUser" />
    </div>

    <!-- Submit -->
    <asp:LinkButton ID="btnSubmitUpdate" runat="server"
      CssClass="btn w-100 fw-semibold"
      style="background-color: purple; color: white;"
      Text="Send Request"
      OnClick="btnSubmitUpdate_Click"
      ValidationGroup="UpdateUser">
    </asp:LinkButton>

      <hr class="my-3">

<h6 class="fw-bold text-dark mb-2">Previous Requests</h6>

<asp:Repeater ID="rptRequests" runat="server">
    <HeaderTemplate>
        <div class="list-group">
    </HeaderTemplate>

    <ItemTemplate>
        <div class="list-group-item border rounded shadow-sm mb-2">
            <div class="fw-semibold"><%# Eval("DetailType") %> ➝ <%# Eval("NewValue") %></div>
            <div class="small text-muted">Reason: <%# Eval("Reason") %></div>
            <div class="small">
                Status: 
                <span class="fw-bold 
                  <%# Eval("RequestStatus").ToString() == "Pending" ? "text-warning" : (Eval("RequestStatus").ToString()=="Approved" ? "text-success" : "text-danger") %>">
                  <%# Eval("RequestStatus") %>
                </span>
            </div>
            <div class="small text-muted"><%# Eval("RequestDate") %></div>
        </div>
    </ItemTemplate>

    <FooterTemplate>
        </div>
    </FooterTemplate>
</asp:Repeater>

<asp:Label ID="lblNoRequests" runat="server" CssClass="text-muted small d-none"></asp:Label>

    
  </div>
</div>



<div class="modal fade" id="successModal" tabindex="-1" aria-labelledby="successModalLabel" aria-hidden="true"
         data-bs-backdrop="static" data-bs-keyboard="false">
      <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content shadow-lg rounded-3 text-center">
      
          <!-- Modal Header -->
          <div class="modal-header bg-success text-white border-0">
          
              <asp:Label runat="server" class="modal-title w-100" id="successModalLabel">Update Successful</asp:Label>
            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
          </div>
      
          <!-- Modal Body -->
         <div class="modal-body text-center">
          <div>
            <img src="https://cdn-icons-png.flaticon.com/512/845/845646.png" 
                 alt="Success" width="80" height="80" class="mb-3" />
          </div>

          <div>
            <asp:Label CssClass="fw-semibold d-block" ID="lblSuccessMsg" runat="server">
              Account Updated Successfully.
            </asp:Label>
          </div>

          <button type="button" class="btn btn-success w-100 mt-3" data-bs-dismiss="modal">OK</button>
         </div>
        </div>
      </div>
    </div>

</main>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function openAddBankModal() {
        var myModal = new bootstrap.Modal(document.getElementById('addBankModal'));
        myModal.show();
    }
    function openGStModal() {
        var myModal = new bootstrap.Modal(document.getElementById('addGSTModal'));
        myModal.show();
    } 
    function openAddVoterModal() {
        var myModal = new bootstrap.Modal(document.getElementById('addVoterModal'));
        myModal.show();
    }
    function openUpdateSidebar() {
        var mySidebar = new bootstrap.Offcanvas(document.getElementById('UpdateSidebar'));
        mySidebar.show();
    }
</script>

<script>
    function previewImage(event) {
        const file = event.target.files[0];
        if (!file) return;

        // ✅ Check file type (only images)
        if (!file.type.startsWith('image/')) {
            alert('Please select a valid image file (jpg, png, etc).');
            event.target.value = ''; // reset input
            return;
        }

        // ✅ Check file size (less than 500 KB)
        const maxSize = 500 * 1024; // 500 KB in bytes
        if (file.size > maxSize) {
            alert('Image size must be less than 500 KB.');
            event.target.value = ''; // reset input
            return;
        }

        // ✅ Show image preview
        const reader = new FileReader();
        reader.onload = function () {
            document.getElementById('imgPreview').src = reader.result;
        };
        reader.readAsDataURL(file);
    }
</script>
</asp:Content>
