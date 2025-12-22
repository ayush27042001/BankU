<%@ Page Title="" Language="C#" MasterPageFile="~/Neox.Master" AutoEventWireup="true" CodeBehind="Transaction.aspx.cs" Inherits="NeoXPayout.Transaction" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <hr />
    <!-- start: page header area -->
			<div class="px-xl-5 px-lg-4 px-3 py-2 page-header">
				<div class="col-sm-6 ">
					<ol class="breadcrumb mb-0 bg-transparent ">
						<li class="breadcrumb-item"><a class="text-muted" href="Transaction.aspx" title="home">Home</a></li>
						<li class="breadcrumb-item active" aria-current="page" title="Widgets Forms">Payout Transaction</li>
					</ol>
				</div>
			</div>
			<div class="px-xl-5 px-lg-4 px-3 py-3 page-body">
				<div class="row">
					<div class="col-md-12">

						<div class="card mb-4">
							<div class="card-header py-3 bg-transparent border-bottom-0">
								<h6 class="card-title mb-0"><strong>Make Payment</strong></h6>
								
							</div>
							<div class="card-body card-main-one">
								
									<div class="row">
										<div class="mb-3 col-md-6 col-12">
											<label class="col-form-label">Account Holder Name</label>
											<fieldset class="form-icon-group left-icon position-relative">
                                                <asp:TextBox ID="txtaccountholdername" CssClass="form-control" runat="server"></asp:TextBox>
                                                
												<div class="form-icon position-absolute">
													<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
														fill="currentColor" class="bi bi-person" viewBox="0 0 16 16">
														<path
															d="M8 8a3 3 0 1 0 0-6 3 3 0 0 0 0 6zm2-3a2 2 0 1 1-4 0 2 2 0 0 1 4 0zm4 8c0 1-1 1-1 1H3s-1 0-1-1 1-4 6-4 6 3 6 4zm-1-.004c-.001-.246-.154-.986-.832-1.664C11.516 10.68 10.289 10 8 10c-2.29 0-3.516.68-4.168 1.332-.678.678-.83 1.418-.832 1.664h10z">
														</path>
													</svg>
												</div>
											</fieldset>
										</div>
										<div class="mb-3 col-md-6 col-12">
											<label class="col-form-label">Account No</label>
											<fieldset class="form-icon-group left-icon position-relative">
												<asp:TextBox ID="txtaccountno" CssClass="form-control" runat="server"></asp:TextBox>
												<div class="form-icon position-absolute">
													<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
														fill="currentColor" class="bi bi-person" viewBox="0 0 16 16">
														<path
															d="M8 8a3 3 0 1 0 0-6 3 3 0 0 0 0 6zm2-3a2 2 0 1 1-4 0 2 2 0 0 1 4 0zm4 8c0 1-1 1-1 1H3s-1 0-1-1 1-4 6-4 6 3 6 4zm-1-.004c-.001-.246-.154-.986-.832-1.664C11.516 10.68 10.289 10 8 10c-2.29 0-3.516.68-4.168 1.332-.678.678-.83 1.418-.832 1.664h10z">
														</path>
													</svg>
												</div>
											</fieldset>
										</div>
										<div class="mb-3 col-md-6 col-12">
											<label class="col-form-label">IFSC Code</label>
											<fieldset class="form-icon-group left-icon position-relative">
												<asp:TextBox ID="txtifsccode" CssClass="form-control" runat="server"></asp:TextBox>
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
										</div>
										<div class="mb-3 col-md-6 col-12">
											<label class="col-form-label">Bank Name</label>
											<fieldset class="form-icon-group left-icon position-relative">
												<asp:TextBox ID="txtbankname" CssClass="form-control" runat="server"></asp:TextBox>
												<div class="form-icon position-absolute">
													<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
														fill="currentColor" class="bi bi-person" viewBox="0 0 16 16">
														<path
															d="M8 8a3 3 0 1 0 0-6 3 3 0 0 0 0 6zm2-3a2 2 0 1 1-4 0 2 2 0 0 1 4 0zm4 8c0 1-1 1-1 1H3s-1 0-1-1 1-4 6-4 6 3 6 4zm-1-.004c-.001-.246-.154-.986-.832-1.664C11.516 10.68 10.289 10 8 10c-2.29 0-3.516.68-4.168 1.332-.678.678-.83 1.418-.832 1.664h10z">
														</path>
													</svg>
												</div>
											</fieldset>
										</div>
										<div class="mb-3 col-md-6 col-12">
											<label class="col-form-label">Mobile Number</label>
											<fieldset class="form-icon-group left-icon position-relative">
                                                <asp:TextBox ID="txtmobileno" CssClass="form-control  phone-number" runat="server" placeholder="Ex: (000) 000-00-00"></asp:TextBox>
												
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
										</div>
										<div class="mb-3 col-md-6 col-12">
											<label class="col-form-label">Amount</label>
											<fieldset class="form-icon-group left-icon position-relative">
												<asp:TextBox ID="txtamount"  CssClass="form-control" runat="server"></asp:TextBox>
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
										</div>
										<div class="col-12">
                                            <asp:LinkButton ID="LinkButton1" runat="server" class="btn btn-primary" OnClick="LinkButton1_Click">Send Money</asp:LinkButton>
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
