<%@ Page Title="" Language="C#" MasterPageFile="~/Neox.Master" AutoEventWireup="true" CodeBehind="PaymentRequestBankU.aspx.cs" Inherits="NeoXPayout.PaymentRequestBankU" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <hr />
    <!-- start: page header area -->
			<div class="px-xl-5 px-lg-4 px-3 py-3 page-body">
				<div class="row">
					<div class="col-md-12">

						<div class="card mb-4">
							
							<div class="card-body card-main-one">
									<div class="row">
                                        <div class="mb-3 col-md-6 col-12">
                                            <div class="card-header py-3 bg-transparent border-bottom-0">
								<h6 class="card-title mb-0"><strong>Payment Request</strong></h6>
								
							</div>
                                            <div class="row">
                                                <div class="mb-3 col-md-12 col-12">
											<label class="col-form-label">Payment Type</label>
											<fieldset class="form-icon-group left-icon position-relative">
                                                <asp:DropDownList ID="ddlpaymenttype" runat="server" CssClass="form-control">
                                                    <asp:ListItem>BANK</asp:ListItem>
                                                    <asp:ListItem>QR</asp:ListItem>
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
										</div>
                                             <div class="mb-3 col-md-12 col-12">
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
                                                <div class="mb-3 col-md-12 col-12">
											<label class="col-form-label">TxnId</label>
											<fieldset class="form-icon-group left-icon position-relative">
												<asp:TextBox ID="txttxnid"  CssClass="form-control" runat="server"></asp:TextBox>
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
                                                <div class="mb-3 col-md-12 col-12">
											<label class="col-form-label">Upload Slip</label>
											<fieldset class="form-icon-group left-icon position-relative">
                                                <asp:FileUpload ID="FileUpload1" runat="server" CssClass="form-control"/>
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
                                            <asp:LinkButton ID="LinkButton1" runat="server" class="btn btn-primary" OnClick="LinkButton1_Click">Fund Request</asp:LinkButton>
											<%--<button class="btn btn-primary">Save</button>--%>
											<a href="Dashboard.aspx" class="btn btn-outline-secondary">Cancel </a>
                                            <br />
                                            <asp:Label ID="Label1" runat="server" Font-Bold="True" ForeColor="Red"></asp:Label>
										</div>
                                            </div>
                                        </div>
                                        <div class="mb-3 col-md-6 col-12" style="padding-left:30px; background-color:aliceblue">
                                         <div class="card-header py-3 bg-transparent border-bottom-0">
								<h6 class="card-title mb-0"><strong>QR Code</strong></h6>
								
							</div>
                                            <asp:HiddenField ID="HiddenField1" runat="server" />
                                            <img src="<%=HiddenField1.Value %>" />
                                            <div class="card-header py-3 bg-transparent border-bottom-0">
								<h6 class="card-title mb-0"><strong>Account Details</strong></h6>
								
							</div>
                                            <p>Bene name: 
                                                <br /><b><asp:Label ID="lblbenename" runat="server"></asp:Label></b></p>
                                            <hr />
                                            <p>A/C No:<br /> <b><asp:Label ID="lblaccountno" runat="server"></asp:Label></b></p>
                                            <hr />
                                            <p>IFSC Code: <br /><b><asp:Label ID="lblifsccode" runat="server"></asp:Label></b></p>
                                            <hr />
                                            <p>Bank Name: <br /><b><asp:Label ID="lblbankname" runat="server"></asp:Label></b></p>
                                        </div>
										
										
									</div>
							</div>

						</div> <!-- Personal Information Card End -->
					</div>
				</div>
			</div>

            <div class="px-xl-5 px-lg-4 px-3 py-3 page-body">
	          
                            <div class="card">
                                <div class="card-header">
                                    <h6 class="card-title mb-0">Payment Request History (Monthly)</h6>
                                    <div class="card-action">
                                        <div>
                                            <a href="#" class="card-fullscreen" data-bs-toggle="tooltip" title="Card Full Screen">
                                                <svg class="svg-stroke" xmlns="http://www.w3.org/2000/svg"
                                                     width="20" height="20" viewBox="0 0 24 24" fill="none"
                                                     stroke="currentColor" stroke-linecap="round"
                                                     stroke-linejoin="round">
                                                    <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>
                                                    <path d="M21 12v3a1 1 0 0 1 -1 1h-16a1 1 0 0 1 -1 -1v-10a1 1 0 0 1 1 -1h9"></path>
                                                    <path d="M7 20l10 0"></path>
                                                    <path d="M9 16l0 4"></path>
                                                    <path d="M15 16l0 4"></path>
                                                    <path d="M17 4h4v4"></path>
                                                    <path d="M16 9l5 -5"></path>
                                                </svg>
                                            </a>
                                            
                                        </div>
                                    </div>
                                </div>
                                <div class="card-body">
                                    <!-- Row Template -->
                                    <div class="d-flex align-items-center mb-3">
                                        <img class="avatar rounded" src="assets/images/xs/Rupee.png" alt="">
                                        <div class="flex-fill ms-3">
                                            <div class="h6 mb-0">7988313165</div>
                                            <small class="text-muted">Adani Power Limited</small>
                                        </div>
                                        <div class="flex-end flex-column d-flex text-end">
                                            <small class="fw-medium" style="color:green;">₹199.00</small>
                                            <small class="text-muted">Feb 05, 2024</small>
                                        </div>
                                    </div><hr />

                                    <div class="d-flex align-items-center mb-3">
                                        <img class="avatar rounded" src="assets/images/xs/Rupee.png" alt="">
                                        <div class="flex-fill ms-3">
                                            <div class="h6 mb-0">8897273823</div>
                                            <small class="text-muted">Indraprastha Gas</small>
                                        </div>
                                        <div class="flex-end flex-column d-flex text-end">
                                            <small class="fw-medium" style="color:green;">₹299.00</small>
                                            <small class="text-muted">March 15, 2024</small>
                                        </div>
                                    </div><hr />

                                    <div class="d-flex align-items-center mb-3">
                                        <img class="avatar rounded" src="assets/images/xs/Rupee.png" alt="">
                                        <div class="flex-fill ms-3">
                                            <div class="h6 mb-0">8676793448</div>
                                            <small class="text-muted">Delhi Jal Board</small>
                                        </div>
                                        <div class="flex-end flex-column d-flex text-end">
                                            <small class="fw-medium" style="color:green;">₹249.00</small>
                                            <small class="text-muted">Feb 05, 2024</small>
                                        </div>
                                    </div><hr />
                                    <div class="d-flex align-items-center mb-3">
                                        <img class="avatar rounded" src="assets/images/xs/Rupee.png" alt="">
                                        <div class="flex-fill ms-3">
                                            <div class="h6 mb-0">7988313165</div>
                                            <small class="text-muted">Paytm FASTag</small>
                                        </div>
                                        <div class="flex-end flex-column d-flex text-end">
                                            <small class="fw-medium" style="color:green;">₹199.00</small>
                                            <small class="text-muted">Feb 05, 2024</small>
                                        </div>
                                    </div><hr />
                                    <div class="d-flex align-items-center mb-3">
                                        <img class="avatar rounded" src="assets/images/xs/Rupee.png" alt="">
                                        <div class="flex-fill ms-3">
                                            <div class="h6 mb-0">8897273823</div>
                                            <small class="text-muted">HDFC Loan</small>
                                        </div>
                                        <div class="flex-end flex-column d-flex text-end">
                                            <small class="fw-medium" style="color:green;">₹299.00</small>
                                            <small class="text-muted">May 25, 2025</small>
                                        </div>
                                    </div><hr />
                                    <div class="d-flex align-items-center mb-3">
                                        <img class="avatar rounded" src="assets/images/xs/Rupee.png" alt="">
                                        <div class="flex-fill ms-3">
                                            <div class="h6 mb-0">8676793448</div>
                                            <small class="text-muted">Jio Postpaid</small>
                                        </div>
                                        <div class="flex-end flex-column d-flex text-end">
                                            <small class="fw-medium" style="color:green;">₹249.00</small>
                                            <small class="text-muted">April 13, 2024</small>
                                        </div>
                                    </div>

                                    <a href="#" class="mt-3 btn btn-grey-outline w-100 fw-medium">Show All</a>
                                </div>
                            </div>
            </div>

</asp:Content>
