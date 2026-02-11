<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/NeoxAdmin.Master" AutoEventWireup="true" CodeBehind="EditRm.aspx.cs" Inherits="NeoXPayout.Admin.EditRm" %>
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
		<h3>Add RM Form</h3>
	   </div>
			
				<div class="row g-3">
					<div class="col-md-12">

						<div class="card mb-4">
							<div class="card-header py-3 bg-transparent border-bottom-0">
								<h6 class="card-title mb-0"><strong>Add RM</strong></h6>
								
							</div>
							<div class="card-body card-main-one">
								
									<div class="row">
										
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
											<label class="col-form-label">Password</label>
											<fieldset class="form-icon-group left-icon position-relative">
                                                <asp:TextBox ID="txtPassword" CssClass="form-control" runat="server"></asp:TextBox>
												
												<div class="form-icon position-absolute">
													<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
														fill="currentColor" class="bi bi-person" viewBox="0 0 16 16">
														<path
															d="M8 8a3 3 0 1 0 0-6 3 3 0 0 0 0 6zm2-3a2 2 0 1 1-4 0 2 2 0 0 1 4 0zm4 8c0 1-1 1-1 1H3s-1 0-1-1 1-4 6-4 6 3 6 4zm-1-.004c-.001-.246-.154-.986-.832-1.664C11.516 10.68 10.289 10 8 10c-2.29 0-3.516.68-4.168 1.332-.678.678-.83 1.418-.832 1.664h10z">
														</path>
													</svg>
												</div>
											</fieldset>
											<asp:RequiredFieldValidator ID="RFCompany" runat="server" ValidationGroup="Add" ControlToValidate="txtPassword" Display="Dynamic" ForeColor="Red" ErrorMessage="Password Is Required"></asp:RequiredFieldValidator>
										</div>		
										<div class="mb-3 col-md-6 col-12">
											<label class="col-form-label">Status</label>
											<fieldset class="form-icon-group left-icon position-relative">
                                              
												<asp:DropDownList runat="server" CssClass="form-control"  ID="ddlStatus">
													<asp:ListItem Value="Active">Active</asp:ListItem>
													<asp:ListItem Value="InActive">InActive</asp:ListItem>
												</asp:DropDownList>

												<div class="form-icon position-absolute">
													<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
														fill="currentColor" class="bi bi-person" viewBox="0 0 16 16">
														<path
															d="M8 8a3 3 0 1 0 0-6 3 3 0 0 0 0 6zm2-3a2 2 0 1 1-4 0 2 2 0 0 1 4 0zm4 8c0 1-1 1-1 1H3s-1 0-1-1 1-4 6-4 6 3 6 4zm-1-.004c-.001-.246-.154-.986-.832-1.664C11.516 10.68 10.289 10 8 10c-2.29 0-3.516.68-4.168 1.332-.678.678-.83 1.418-.832 1.664h10z">
														</path>
													</svg>
												</div>
											</fieldset>
											<asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ValidationGroup="Add" ControlToValidate="ddlStatus" Display="Dynamic" ForeColor="Red" ErrorMessage="Password Is Required"></asp:RequiredFieldValidator>
										</div>		

										<div class="col-12">
                                              <asp:LinkButton ID="LinkButton1" runat="server" class="btn btn-purple" ValidationGroup="Add" OnClick="LinkButton1_Click">Update</asp:LinkButton>
											<asp:LinkButton ID="btnDelete" class="btn btn-outline-secondary"  OnClick="btnDelete_Click" runat="server">Delete</asp:LinkButton>
											<a href="DashboardAdmin.aspx" class="btn btn-outline-secondary">Cancel </a>
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