<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/NeoxAdmin.Master" AutoEventWireup="true" CodeBehind="AddUser.aspx.cs" Inherits="NeoXPayout.Admin.AddUser" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<style>
    /* Purple theme variables */
    :root {
        --primary-purple: #6f42c1; /* adjust to your exact shade */
        --light-purple: #f4f0fa;
    }

    /* Card Style */
    .card {
        border-radius: 12px;
        box-shadow: 0 4px 12px rgba(0,0,0,0.08);
        background-color: #fff;
        border: none;
    }

    .card-header1 {
       background-color:purple;
        color: #fff;
		padding:10px;
        font-size: 1.25rem;
        font-weight: 600;
        text-align: center;
        border-top-left-radius: 12px;
        border-top-right-radius: 12px;
    }

    /* Labels */
    .col-form-label {
        font-weight: 600;
        color: purple;
    }

    /* Inputs */
    .form-control, .form-select {
        border: 1px solid #d1c4e9;
        border-radius: 8px;
        padding: 10px 12px;
        transition: all 0.3s ease-in-out;
    }

    .form-control:focus, .form-select:focus {
        border-color: purple;
        box-shadow: 0 0 0 0.2rem rgba(111,66,193,0.25);
    }

    /* Buttons */
    .btn-purple {
        background-color: purple;
        border-color: var(--primary-purple);
        color: #fff;
        font-weight: 600;
        padding: 10px 20px;
        border-radius: 8px;
        transition: background-color 0.3s;
    }
    .btn-purple:hover {
        background-color: #5a35a5;
        border-color: #5a35a5;
    }

    /* Section titles */
    .section-title {
        font-size: 1.1rem;
        color: purple;
        font-weight: 600;
        border-bottom: 2px solid var(--light-purple);
        padding-bottom: 4px;
        margin-bottom: 16px;
    }
</style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <hr />
	<div class="px-xl-5 px-lg-4 px-3 py-2  card">
	  <div class="card-header1">
		<h3>Onboarding Form</h3>
	   </div>
			
				<div class="row g-3">
					<div class="col-md-12">

						<div class="card mb-4">
							<div class="card-header py-3 bg-transparent border-bottom-0">
								<h6 class="card-title mb-0"><strong>Add Retailer</strong></h6>
								
							</div>
							<div class="card-body card-main-one">
								
									<div class="row">
										<div class="mb-3 col-md-6 col-12">
											<label class="col-form-label">CompanyName</label>
											<fieldset class="form-icon-group left-icon position-relative">
                                                <asp:TextBox ID="txtcompanyname" CssClass="form-control" runat="server"></asp:TextBox>
												
												<div class="form-icon position-absolute">
													<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
														fill="currentColor" class="bi bi-person" viewBox="0 0 16 16">
														<path
															d="M8 8a3 3 0 1 0 0-6 3 3 0 0 0 0 6zm2-3a2 2 0 1 1-4 0 2 2 0 0 1 4 0zm4 8c0 1-1 1-1 1H3s-1 0-1-1 1-4 6-4 6 3 6 4zm-1-.004c-.001-.246-.154-.986-.832-1.664C11.516 10.68 10.289 10 8 10c-2.29 0-3.516.68-4.168 1.332-.678.678-.83 1.418-.832 1.664h10z">
														</path>
													</svg>
												</div>
											</fieldset>
											<asp:RequiredFieldValidator ID="RFCompany" runat="server" ValidationGroup="Add" ControlToValidate="txtcompanyname" Display="Dynamic" ForeColor="Red" ErrorMessage="Company Name Is Required"></asp:RequiredFieldValidator>
										</div>
										<div class="mb-3 col-md-6 col-12">
											<label class="col-form-label">Full Name</label>
											<fieldset class="form-icon-group left-icon position-relative">
												<asp:TextBox ID="txtfullname" CssClass="form-control" runat="server"></asp:TextBox>
												
												<div class="form-icon position-absolute">
													<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
														fill="currentColor" class="bi bi-person" viewBox="0 0 16 16">
														<path
															d="M8 8a3 3 0 1 0 0-6 3 3 0 0 0 0 6zm2-3a2 2 0 1 1-4 0 2 2 0 0 1 4 0zm4 8c0 1-1 1-1 1H3s-1 0-1-1 1-4 6-4 6 3 6 4zm-1-.004c-.001-.246-.154-.986-.832-1.664C11.516 10.68 10.289 10 8 10c-2.29 0-3.516.68-4.168 1.332-.678.678-.83 1.418-.832 1.664h10z">
														</path>
													</svg>
												</div>
											</fieldset>
											<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ValidationGroup="Add" ControlToValidate="txtfullname" Display="Dynamic" ForeColor="Red" ErrorMessage="Full Name Is Required"></asp:RequiredFieldValidator>
										</div>
										<div class="mb-3 col-md-6 col-12">
											<label class="col-form-label">MobileNo</label>
											<fieldset class="form-icon-group left-icon position-relative">
												<asp:TextBox ID="txtmobileno" MaxLength="10" CssClass="form-control" runat="server" placeholder="Ex: (000) 000-00-00"></asp:TextBox>
												
												<div class="form-icon position-absolute">
													<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
														fill="currentColor" class="bi bi-phone" viewBox="0 0 16 16">
														<path
															d="M11 1a1 1 0 0 1 1 1v12a1 1 0 0 1-1 1H5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1h6zM5 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h6a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2H5z">
														</path>
														<path d="M8 14a1 1 0 1 0 0-2 1 1 0 0 0 0 2z"></path>
													</svg>
												</div>
											</fieldset>
											<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ValidationGroup="Add" ControlToValidate="txtmobileno" Display="Dynamic" ForeColor="Red" ErrorMessage="Mobile No. Is Required"></asp:RequiredFieldValidator>
										</div>
										<div class="mb-3 col-md-6 col-12">
											<label class="col-form-label">Email Id</label>
											<fieldset class="form-icon-group left-icon position-relative">
												<asp:TextBox ID="txtemailid" CssClass="form-control" runat="server"></asp:TextBox>								
												<div class="form-icon position-absolute">
													<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
														fill="currentColor" class="bi bi-envelope-fill"
														viewBox="0 0 16 16">
														<path
															d="M.05 3.555A2 2 0 0 1 2 2h12a2 2 0 0 1 1.95 1.555L8 8.414.05 3.555zM0 4.697v7.104l5.803-3.558L0 4.697zM6.761 8.83l-6.57 4.027A2 2 0 0 0 2 14h12a2 2 0 0 0 1.808-1.144l-6.57-4.027L8 9.586l-1.239-.757zm3.436-.586L16 11.801V4.697l-5.803 3.546z">
														</path>
													</svg>
												</div>
											</fieldset>
											<asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ValidationGroup="Add" ControlToValidate="txtemailid" Display="Dynamic" ForeColor="Red" ErrorMessage="Email Id Is Required"></asp:RequiredFieldValidator>
										</div>
										<div class="mb-3 col-md-6 col-12">
											<label class="col-form-label">MPIN</label>
											<fieldset class="form-icon-group left-icon position-relative">
                                                <asp:TextBox ID="txtpassword" MaxLength="4" CssClass="form-control  phone-number" runat="server" placeholder="xxxxxx"></asp:TextBox>
												<div class="form-icon position-absolute">
													<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
														fill="currentColor" class="bi bi-eye" viewBox="0 0 16 16">
														<path
															d="M16 8s-3-5.5-8-5.5S0 8 0 8s3 5.5 8 5.5S16 8 16 8zM1.173 8a13.133 13.133 0 0 1 1.66-2.043C4.12 4.668 5.88 3.5 8 3.5c2.12 0 3.879 1.168 5.168 2.457A13.133 13.133 0 0 1 14.828 8c-.058.087-.122.183-.195.288-.335.48-.83 1.12-1.465 1.755C11.879 11.332 10.119 12.5 8 12.5c-2.12 0-3.879-1.168-5.168-2.457A13.134 13.134 0 0 1 1.172 8z">
														</path>
														<path
															d="M8 5.5a2.5 2.5 0 1 0 0 5 2.5 2.5 0 0 0 0-5zM4.5 8a3.5 3.5 0 1 1 7 0 3.5 3.5 0 0 1-7 0z">
														</path>
													</svg>
												</div>
											</fieldset>
											<asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ValidationGroup="Add" ControlToValidate="txtpassword" Display="Dynamic" ForeColor="Red" ErrorMessage="MPIN Is Required"></asp:RequiredFieldValidator>
										</div>
										<div class="mb-3 col-md-6 col-12">
											<label class="col-form-label">Address</label>
											<fieldset class="form-icon-group left-icon position-relative">
												<asp:TextBox ID="txtaddress"  CssClass="form-control" runat="server"></asp:TextBox>
												
												<div class="form-icon position-absolute">
													<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
														fill="currentColor" class="bi bi-map" viewBox="0 0 16 16">
														<path
															d="M16 8s-3-5.5-8-5.5S0 8 0 8s3 5.5 8 5.5S16 8 16 8zM1.173 8a13.133 13.133 0 0 1 1.66-2.043C4.12 4.668 5.88 3.5 8 3.5c2.12 0 3.879 1.168 5.168 2.457A13.133 13.133 0 0 1 14.828 8c-.058.087-.122.183-.195.288-.335.48-.83 1.12-1.465 1.755C11.879 11.332 10.119 12.5 8 12.5c-2.12 0-3.879-1.168-5.168-2.457A13.134 13.134 0 0 1 1.172 8z">
														</path>
														<path
															d="M8 5.5a2.5 2.5 0 1 0 0 5 2.5 2.5 0 0 0 0-5zM4.5 8a3.5 3.5 0 1 1 7 0 3.5 3.5 0 0 1-7 0z">
														</path>
													</svg>
												</div>
											</fieldset>
											<asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ValidationGroup="Add" ControlToValidate="txtaddress" Display="Dynamic" ForeColor="Red" ErrorMessage="Address is Required"></asp:RequiredFieldValidator>
										</div>

                                        <div class="mb-3 col-md-6 col-12">
											<label class="col-form-label">Pincode</label>
											<fieldset class="form-icon-group left-icon position-relative">
												<asp:TextBox ID="txtpincode" MaxLength="6"  CssClass="form-control" runat="server"></asp:TextBox>
												
												<div class="form-icon position-absolute">
													<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
														fill="currentColor" class="bi bi-eye" viewBox="0 0 16 16">
														<path
															d="M16 8s-3-5.5-8-5.5S0 8 0 8s3 5.5 8 5.5S16 8 16 8zM1.173 8a13.133 13.133 0 0 1 1.66-2.043C4.12 4.668 5.88 3.5 8 3.5c2.12 0 3.879 1.168 5.168 2.457A13.133 13.133 0 0 1 14.828 8c-.058.087-.122.183-.195.288-.335.48-.83 1.12-1.465 1.755C11.879 11.332 10.119 12.5 8 12.5c-2.12 0-3.879-1.168-5.168-2.457A13.134 13.134 0 0 1 1.172 8z">
														</path>
														<path
															d="M8 5.5a2.5 2.5 0 1 0 0 5 2.5 2.5 0 0 0 0-5zM4.5 8a3.5 3.5 0 1 1 7 0 3.5 3.5 0 0 1-7 0z">
														</path>
													</svg>
												</div>
											</fieldset>
											<asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ValidationGroup="Add" ControlToValidate="txtpincode" Display="Dynamic" ForeColor="Red" ErrorMessage="Pincode is Required"></asp:RequiredFieldValidator>
										</div>

                                        <div class="mb-3 col-md-6 col-12">
											<label class="col-form-label">AadharNo</label>
											<fieldset class="form-icon-group left-icon position-relative">
												<asp:TextBox ID="txtaadharcard" MaxLength="12"  CssClass="form-control" runat="server"></asp:TextBox>
												
												<div class="form-icon position-absolute">
													<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
														fill="currentColor" class="bi bi-eye" viewBox="0 0 16 16">
														<path
															d="M16 8s-3-5.5-8-5.5S0 8 0 8s3 5.5 8 5.5S16 8 16 8zM1.173 8a13.133 13.133 0 0 1 1.66-2.043C4.12 4.668 5.88 3.5 8 3.5c2.12 0 3.879 1.168 5.168 2.457A13.133 13.133 0 0 1 14.828 8c-.058.087-.122.183-.195.288-.335.48-.83 1.12-1.465 1.755C11.879 11.332 10.119 12.5 8 12.5c-2.12 0-3.879-1.168-5.168-2.457A13.134 13.134 0 0 1 1.172 8z">
														</path>
														<path
															d="M8 5.5a2.5 2.5 0 1 0 0 5 2.5 2.5 0 0 0 0-5zM4.5 8a3.5 3.5 0 1 1 7 0 3.5 3.5 0 0 1-7 0z">
														</path>
													</svg>
												</div>
											</fieldset>
											<asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ValidationGroup="Add" ControlToValidate="txtaadharcard" Display="Dynamic" ForeColor="Red" ErrorMessage="Aadhar No. Required"></asp:RequiredFieldValidator>
										</div>
                                        <div class="mb-3 col-md-6 col-12">
											<label class="col-form-label">PanNo</label>
											<fieldset class="form-icon-group left-icon position-relative">
												<asp:TextBox ID="txtpancard" CssClass="form-control" runat="server"></asp:TextBox>
												
												<div class="form-icon position-absolute">
													<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
														fill="currentColor" class="bi bi-eye" viewBox="0 0 16 16">
														<path
															d="M16 8s-3-5.5-8-5.5S0 8 0 8s3 5.5 8 5.5S16 8 16 8zM1.173 8a13.133 13.133 0 0 1 1.66-2.043C4.12 4.668 5.88 3.5 8 3.5c2.12 0 3.879 1.168 5.168 2.457A13.133 13.133 0 0 1 14.828 8c-.058.087-.122.183-.195.288-.335.48-.83 1.12-1.465 1.755C11.879 11.332 10.119 12.5 8 12.5c-2.12 0-3.879-1.168-5.168-2.457A13.134 13.134 0 0 1 1.172 8z">
														</path>
														<path
															d="M8 5.5a2.5 2.5 0 1 0 0 5 2.5 2.5 0 0 0 0-5zM4.5 8a3.5 3.5 0 1 1 7 0 3.5 3.5 0 0 1-7 0z">
														</path>
													</svg>
												</div>
											</fieldset>
											<asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ValidationGroup="Add" ControlToValidate="txtpancard" Display="Dynamic" ForeColor="Red" ErrorMessage="Pan No. Required"></asp:RequiredFieldValidator>
										</div>
										 <div class="mb-3 col-md-6 col-12">
											<label class="col-form-label">Account Type</label>
											<fieldset class="form-icon-group left-icon position-relative">
												
												<asp:DropDownList ID="txtAccount1" CssClass="form-control" runat="server">
												    <asp:ListItem Text="-- Select Account --" Value="" />
													<asp:ListItem Text="Distributor" Value="Distributor" />
													<asp:ListItem Text="BankU Seva Kendra" Value="BankU Seva Kendra" />
													<asp:ListItem Text="Business & APIs" Value="Business & APIs" />
												</asp:DropDownList>
												
												<div class="form-icon position-absolute">
													<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
														fill="currentColor" class="bi bi-eye" viewBox="0 0 16 16">
														<path
															d="M16 8s-3-5.5-8-5.5S0 8 0 8s3 5.5 8 5.5S16 8 16 8zM1.173 8a13.133 13.133 0 0 1 1.66-2.043C4.12 4.668 5.88 3.5 8 3.5c2.12 0 3.879 1.168 5.168 2.457A13.133 13.133 0 0 1 14.828 8c-.058.087-.122.183-.195.288-.335.48-.83 1.12-1.465 1.755C11.879 11.332 10.119 12.5 8 12.5c-2.12 0-3.879-1.168-5.168-2.457A13.134 13.134 0 0 1 1.172 8z">
														</path>
														<path
															d="M8 5.5a2.5 2.5 0 1 0 0 5 2.5 2.5 0 0 0 0-5zM4.5 8a3.5 3.5 0 1 1 7 0 3.5 3.5 0 0 1-7 0z">
														</path>
													</svg>
												</div>
											</fieldset>
											 <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ValidationGroup="Add" ControlToValidate="txtAccount1" Display="Dynamic" ForeColor="Red" ErrorMessage="Account Type Required"></asp:RequiredFieldValidator>
										</div>
										 <div class="mb-3 col-md-6 col-12">
											<label class="col-form-label">Business Type</label>
											<fieldset class="form-icon-group left-icon position-relative">
												<%--<asp:TextBox ID="txtBusiness"  CssClass="form-control" runat="server"></asp:TextBox>--%>
												 <asp:DropDownList ID="ddlBusinessType" runat="server"
													CssClass="form-control text-dark"
																		
													style=" border-radius: 6px; height: 45px; -webkit-text-fill-color:black;">
    
													<asp:ListItem Text="Select Type of Business" Value="" />
													<asp:ListItem Text="Proprietorship" Value="Proprietorship" />
													<asp:ListItem Text="Partnership" Value="Partnership" />
													<asp:ListItem Text="Company" Value="Company" />
													<asp:ListItem Text="Trust and Society" Value="Trust and Society" />
													<asp:ListItem Text="PSU / Govt. Entitie" Value="PSU / Govt. Entitie" />
												</asp:DropDownList>
												
												<div class="form-icon position-absolute">
													<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
														fill="currentColor" class="bi bi-eye" viewBox="0 0 16 16">
														<path
															d="M16 8s-3-5.5-8-5.5S0 8 0 8s3 5.5 8 5.5S16 8 16 8zM1.173 8a13.133 13.133 0 0 1 1.66-2.043C4.12 4.668 5.88 3.5 8 3.5c2.12 0 3.879 1.168 5.168 2.457A13.133 13.133 0 0 1 14.828 8c-.058.087-.122.183-.195.288-.335.48-.83 1.12-1.465 1.755C11.879 11.332 10.119 12.5 8 12.5c-2.12 0-3.879-1.168-5.168-2.457A13.134 13.134 0 0 1 1.172 8z">
														</path>
														<path
															d="M8 5.5a2.5 2.5 0 1 0 0 5 2.5 2.5 0 0 0 0-5zM4.5 8a3.5 3.5 0 1 1 7 0 3.5 3.5 0 0 1-7 0z">
														</path>
													</svg>
												</div>
											</fieldset>
											 <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ValidationGroup="Add" ControlToValidate="ddlBusinessType" Display="Dynamic" ForeColor="Red" ErrorMessage="Business Type Required"></asp:RequiredFieldValidator>
										</div>
										 <div class="mb-3 col-md-6 col-12">
											<label class="col-form-label">Business PAN</label>
											<fieldset class="form-icon-group left-icon position-relative">
												<asp:TextBox ID="txtBusiPan" CssClass="form-control" runat="server"></asp:TextBox>
												
												<div class="form-icon position-absolute">
													<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
														fill="currentColor" class="bi bi-eye" viewBox="0 0 16 16">
														<path
															d="M16 8s-3-5.5-8-5.5S0 8 0 8s3 5.5 8 5.5S16 8 16 8zM1.173 8a13.133 13.133 0 0 1 1.66-2.043C4.12 4.668 5.88 3.5 8 3.5c2.12 0 3.879 1.168 5.168 2.457A13.133 13.133 0 0 1 14.828 8c-.058.087-.122.183-.195.288-.335.48-.83 1.12-1.465 1.755C11.879 11.332 10.119 12.5 8 12.5c-2.12 0-3.879-1.168-5.168-2.457A13.134 13.134 0 0 1 1.172 8z">
														</path>
														<path
															d="M8 5.5a2.5 2.5 0 1 0 0 5 2.5 2.5 0 0 0 0-5zM4.5 8a3.5 3.5 0 1 1 7 0 3.5 3.5 0 0 1-7 0z">
														</path>
													</svg>
												</div>
											</fieldset>
											 <asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" ValidationGroup="Add" ControlToValidate="txtBusiPan" Display="Dynamic" ForeColor="Red" ErrorMessage="Business Pan Required"></asp:RequiredFieldValidator>
										</div>

										<div class="mb-3 col-md-6 col-12">
											<label class="col-form-label">Business Proof</label>
											<fieldset class="form-icon-group left-icon position-relative">
												<%--<asp:TextBox ID="txtProof" CssClass="form-control" runat="server"></asp:TextBox>--%>
												  <asp:DropDownList ID="ddlBusiProof" runat="server"
													
													CssClass="form-control text-dark"
													style=" border-radius: 6px; height: 45px; -webkit-text-fill-color:black">
													<asp:ListItem Text="Select Business Proof" Value="" />
													<asp:ListItem Text="GST Registration Certificate" Value="GST" />
													<asp:ListItem Text="MSME / Udyam Registration" Value="UDYAM" />
													<asp:ListItem Text="Certificate of Incorporation" Value="CIN" />
												</asp:DropDownList>
												
												<div class="form-icon position-absolute">
													<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
														fill="currentColor" class="bi bi-eye" viewBox="0 0 16 16">
														<path
															d="M16 8s-3-5.5-8-5.5S0 8 0 8s3 5.5 8 5.5S16 8 16 8zM1.173 8a13.133 13.133 0 0 1 1.66-2.043C4.12 4.668 5.88 3.5 8 3.5c2.12 0 3.879 1.168 5.168 2.457A13.133 13.133 0 0 1 14.828 8c-.058.087-.122.183-.195.288-.335.48-.83 1.12-1.465 1.755C11.879 11.332 10.119 12.5 8 12.5c-2.12 0-3.879-1.168-5.168-2.457A13.134 13.134 0 0 1 1.172 8z">
														</path>
														<path
															d="M8 5.5a2.5 2.5 0 1 0 0 5 2.5 2.5 0 0 0 0-5zM4.5 8a3.5 3.5 0 1 1 7 0 3.5 3.5 0 0 1-7 0z">
														</path>
													</svg>
												</div>
											</fieldset>
											<asp:RequiredFieldValidator ID="RequiredFieldValidator12" runat="server" ValidationGroup="Add" ControlToValidate="ddlBusiProof" Display="Dynamic" ForeColor="Red" ErrorMessage="Business Proof Required"></asp:RequiredFieldValidator>
										</div>

										<div class="mb-3 col-md-6 col-12">
											<label class="col-form-label">NatureOfBusiness</label>
											<fieldset class="form-icon-group left-icon position-relative">
												
												<asp:DropDownList ID="ddlNature" runat="server" CssClass="form-control text-dark" style="border-radius: 6px; height: 45px; -webkit-text-fill-color:black">
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
												
												<div class="form-icon position-absolute">
													<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
														fill="currentColor" class="bi bi-eye" viewBox="0 0 16 16">
														<path
															d="M16 8s-3-5.5-8-5.5S0 8 0 8s3 5.5 8 5.5S16 8 16 8zM1.173 8a13.133 13.133 0 0 1 1.66-2.043C4.12 4.668 5.88 3.5 8 3.5c2.12 0 3.879 1.168 5.168 2.457A13.133 13.133 0 0 1 14.828 8c-.058.087-.122.183-.195.288-.335.48-.83 1.12-1.465 1.755C11.879 11.332 10.119 12.5 8 12.5c-2.12 0-3.879-1.168-5.168-2.457A13.134 13.134 0 0 1 1.172 8z">
														</path>
														<path
															d="M8 5.5a2.5 2.5 0 1 0 0 5 2.5 2.5 0 0 0 0-5zM4.5 8a3.5 3.5 0 1 1 7 0 3.5 3.5 0 0 1-7 0z">
														</path>
													</svg>
												</div>
											</fieldset>
											<asp:RequiredFieldValidator ID="RequiredFieldValidator13" runat="server" ValidationGroup="Add" ControlToValidate="ddlNature" Display="Dynamic" ForeColor="Red" ErrorMessage="Nature Of Business Required"></asp:RequiredFieldValidator>
										</div>

										<div class="mb-3 col-md-6 col-12">
											<label class="col-form-label">Gender</label>
											<fieldset class="form-icon-group left-icon position-relative">
												
												<asp:DropDownList runat="server" ID="ddlGender" CssClass="form-control text-dark" style="border-radius: 6px; height: 45px; -webkit-text-fill-color:black">
													<asp:ListItem Text="Select Gender" Value="" />
													<asp:ListItem Text="Male" Value="M" />
													<asp:ListItem Text="Female" Value="F" />
													<asp:ListItem Text="Other" Value="NA" />
												</asp:DropDownList>
												
												<div class="form-icon position-absolute">
													<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
														fill="currentColor" class="bi bi-eye" viewBox="0 0 16 16">
														<path
															d="M16 8s-3-5.5-8-5.5S0 8 0 8s3 5.5 8 5.5S16 8 16 8zM1.173 8a13.133 13.133 0 0 1 1.66-2.043C4.12 4.668 5.88 3.5 8 3.5c2.12 0 3.879 1.168 5.168 2.457A13.133 13.133 0 0 1 14.828 8c-.058.087-.122.183-.195.288-.335.48-.83 1.12-1.465 1.755C11.879 11.332 10.119 12.5 8 12.5c-2.12 0-3.879-1.168-5.168-2.457A13.134 13.134 0 0 1 1.172 8z">
														</path>
														<path
															d="M8 5.5a2.5 2.5 0 1 0 0 5 2.5 2.5 0 0 0 0-5zM4.5 8a3.5 3.5 0 1 1 7 0 3.5 3.5 0 0 1-7 0z">
														</path>
													</svg>
												</div>
											</fieldset>
											<asp:RequiredFieldValidator ID="RequiredFieldValidator14" runat="server" ValidationGroup="Add" ControlToValidate="ddlGender" Display="Dynamic" ForeColor="Red" ErrorMessage="Gender Required"></asp:RequiredFieldValidator>
										</div>

										<div class="mb-3 col-md-6 col-12">
											<label class="col-form-label">DOB</label>
											<fieldset class="form-icon-group left-icon position-relative">
												<asp:TextBox ID="txtDOB" TextMode="Date"  CssClass="form-control" runat="server"></asp:TextBox>
												
												<div class="form-icon position-absolute">
													<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
														fill="currentColor" class="bi bi-eye" viewBox="0 0 16 16">
														<path
															d="M16 8s-3-5.5-8-5.5S0 8 0 8s3 5.5 8 5.5S16 8 16 8zM1.173 8a13.133 13.133 0 0 1 1.66-2.043C4.12 4.668 5.88 3.5 8 3.5c2.12 0 3.879 1.168 5.168 2.457A13.133 13.133 0 0 1 14.828 8c-.058.087-.122.183-.195.288-.335.48-.83 1.12-1.465 1.755C11.879 11.332 10.119 12.5 8 12.5c-2.12 0-3.879-1.168-5.168-2.457A13.134 13.134 0 0 1 1.172 8z">
														</path>
														<path
															d="M8 5.5a2.5 2.5 0 1 0 0 5 2.5 2.5 0 0 0 0-5zM4.5 8a3.5 3.5 0 1 1 7 0 3.5 3.5 0 0 1-7 0z">
														</path>
													</svg>
												</div>
											</fieldset>
											<asp:RequiredFieldValidator ID="RequiredFieldValidator15" runat="server" ValidationGroup="Add" ControlToValidate="txtDOB" Display="Dynamic" ForeColor="Red" ErrorMessage="Date Of Birth Required"></asp:RequiredFieldValidator>
										</div>
                                        
										<div class="mb-3 col-md-6 col-12">
											<label class="col-form-label">Father Name</label>
											<fieldset class="form-icon-group left-icon position-relative">
												<asp:TextBox ID="txtFather" CssClass="form-control" runat="server"></asp:TextBox>
												
												<div class="form-icon position-absolute">
													<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
														fill="currentColor" class="bi bi-eye" viewBox="0 0 16 16">
														<path
															d="M16 8s-3-5.5-8-5.5S0 8 0 8s3 5.5 8 5.5S16 8 16 8zM1.173 8a13.133 13.133 0 0 1 1.66-2.043C4.12 4.668 5.88 3.5 8 3.5c2.12 0 3.879 1.168 5.168 2.457A13.133 13.133 0 0 1 14.828 8c-.058.087-.122.183-.195.288-.335.48-.83 1.12-1.465 1.755C11.879 11.332 10.119 12.5 8 12.5c-2.12 0-3.879-1.168-5.168-2.457A13.134 13.134 0 0 1 1.172 8z">
														</path>
														<path
															d="M8 5.5a2.5 2.5 0 1 0 0 5 2.5 2.5 0 0 0 0-5zM4.5 8a3.5 3.5 0 1 1 7 0 3.5 3.5 0 0 1-7 0z">
														</path>
													</svg>
												</div>
											</fieldset>
											<asp:RequiredFieldValidator ID="RequiredFieldValidator16" runat="server" ValidationGroup="Add" ControlToValidate="txtFather" Display="Dynamic" ForeColor="Red" ErrorMessage="Father Name Required"></asp:RequiredFieldValidator>
										</div>

										<div class="mb-3 col-md-6 col-12">
											<label class="col-form-label">State</label>
											<fieldset class="form-icon-group left-icon position-relative">
												<asp:TextBox ID="txtState"  CssClass="form-control" runat="server"></asp:TextBox>
												
												<div class="form-icon position-absolute">
													<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
														fill="currentColor" class="bi bi-eye" viewBox="0 0 16 16">
														<path
															d="M16 8s-3-5.5-8-5.5S0 8 0 8s3 5.5 8 5.5S16 8 16 8zM1.173 8a13.133 13.133 0 0 1 1.66-2.043C4.12 4.668 5.88 3.5 8 3.5c2.12 0 3.879 1.168 5.168 2.457A13.133 13.133 0 0 1 14.828 8c-.058.087-.122.183-.195.288-.335.48-.83 1.12-1.465 1.755C11.879 11.332 10.119 12.5 8 12.5c-2.12 0-3.879-1.168-5.168-2.457A13.134 13.134 0 0 1 1.172 8z">
														</path>
														<path
															d="M8 5.5a2.5 2.5 0 1 0 0 5 2.5 2.5 0 0 0 0-5zM4.5 8a3.5 3.5 0 1 1 7 0 3.5 3.5 0 0 1-7 0z">
														</path>
													</svg>
												</div>
											</fieldset>
											<asp:RequiredFieldValidator ID="RequiredFieldValidator17" runat="server" ValidationGroup="Add" ControlToValidate="txtState" Display="Dynamic" ForeColor="Red" ErrorMessage="State is Required"></asp:RequiredFieldValidator>
										</div>

										<div class="col-12">
                                            <asp:LinkButton ID="LinkButton1" runat="server" class="btn btn-purple" ValidationGroup="Add" OnClick="LinkButton1_Click">Add Users</asp:LinkButton>

											<%--<button class="btn btn-primary">Save</button>--%>
											<a href="Dashboard.aspx" class="btn btn-outline-secondary">Cancel </a>
                                            <br />
                                            <asp:Label ID="Label1" runat="server" Font-Bold="True" ForeColor="Red"></asp:Label>
										</div>
									</div>
								
								
							</div>

						</div> <!-- Personal Information Card End -->

					

					</div>
				</div>
		
		</div>
</asp:Content>
