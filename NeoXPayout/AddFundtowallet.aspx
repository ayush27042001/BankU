<%@ Page Title="" Language="C#" MasterPageFile="~/Neox.Master" AutoEventWireup="true" CodeBehind="AddFundtowallet.aspx.cs" Inherits="NeoXPayout.AddFundtowallet" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <hr />
    <!-- start: page header area -->
			<div class="px-xl-5 px-lg-4 px-3 py-2 page-header">
				<div class="col-sm-6 ">
					<ol class="breadcrumb mb-0 bg-transparent ">
						<li class="breadcrumb-item"><a class="text-muted" href="Transaction.aspx" title="home">Home</a></li>
						<li class="breadcrumb-item active" aria-current="page" title="Widgets Forms">Add Fund To Wallet</li>
					</ol>
				</div>
			</div>
			<div class="px-xl-5 px-lg-4 px-3 py-3 page-body">
				<div class="row">
					<div class="col-md-12">

						<div class="card mb-4">
							<div class="card-header py-3 bg-transparent border-bottom-0">
								<h6 class="card-title mb-0"><strong>Add Fund</strong></h6>
								
							</div>
							<div class="card-body card-main-one">
									<div class="row">
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
										<div class="mb-3 col-md-6 col-12" style="padding-top:38px">
                                            <asp:LinkButton ID="LinkButton1" runat="server" class="btn btn-primary" OnClick="LinkButton1_Click">AddFund</asp:LinkButton>
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
