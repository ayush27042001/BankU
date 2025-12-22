<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/NeoxAdmin.Master" AutoEventWireup="true" CodeBehind="AddMargin.aspx.cs" Inherits="NeoXPayout.Admin.AddMargin" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <hr />
     <div class="px-xl-5 px-lg-4 px-3 py-3 page-body">
	<div class="row">
		<div class="col-md-12">

			<div class="card mb-4">
				<div class="card-header py-3 bg-transparent border-bottom-0">
					<h6 class="card-title mb-0"><strong>Add Pricing</strong></h6>
					<asp:Label runat="server" ID="lblmessage" CssClass="text-success"></asp:Label>
						 
				</div>
				<div class="card-body card-main-one">
								
						<div class="row">
							<div class="mb-3 col-md-12 col-12">
								<label class="col-form-label">Service Name</label>
                                    <asp:TextBox ID="txtName" CssClass="form-control" runat="server" Placeholder="Enter Service Name"></asp:TextBox>
									<asp:RequiredFieldValidator ID="rfvApiName" runat="server" 
									ControlToValidate="txtName" 
										ValidationGroup="AddPricing"
									ErrorMessage="Service Name is required" 
									CssClass="text-danger" Display="Dynamic" />
							</div>

					    	

							<div class="mb-3 col-md-6 col-6">
                                <label class="col-form-label">Enter Operator Name</label>
                                <asp:TextBox ID="txtOperator" CssClass="form-control" runat="server" 
                                   Placeholder="Operator Name"></asp:TextBox>

                                <asp:RequiredFieldValidator ID="rfvStartDate" runat="server"
                                    ControlToValidate="txtOperator"
                                    ValidationGroup="AddPricing"
                                    ErrorMessage="Operator Name is required"
                                    CssClass="text-danger" 
                                    Display="Dynamic" />
                            </div>

                            <div class="mb-3 col-md-6 col-6">
                                <label class="col-form-label">IP Share</label>
                                <asp:TextBox ID="txtIPShare" CssClass="form-control" runat="server" 
                                     Placeholder="Enter IP Share"></asp:TextBox>

                                <asp:RequiredFieldValidator ID="rfvEndDate" runat="server"
                                    ControlToValidate="txtIPShare"
                                    ValidationGroup="AddPricing"
                                    ErrorMessage="IP Share is required"
                                    CssClass="text-danger" 
                                    Display="Dynamic" />
                            </div>

                             <div class="mb-3 col-md-6 col-6">
                                <label class="col-form-label">Wl Share</label>
                                <asp:TextBox ID="txtWLShare" CssClass="form-control" runat="server" 
                                     Placeholder="Enter Wl Share"></asp:TextBox>

                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                                    ControlToValidate="txtWLShare"
                                    ValidationGroup="AddPricing"
                                    ErrorMessage="Wl Share is required"
                                    CssClass="text-danger" 
                                    Display="Dynamic" />
                            </div>
                            <div class="mb-3 col-md-6 col-6">
                                <label class="col-form-label">Commission type</label>
                                <asp:TextBox ID="txtComtype" CssClass="form-control" runat="server" 
                                     Placeholder="Enter Commission type"></asp:TextBox>

                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
                                    ControlToValidate="txtComtype"
                                    ValidationGroup="AddPricing"
                                    ErrorMessage="Commission type is required"
                                    CssClass="text-danger" 
                                    Display="Dynamic" />
                            </div>

							
					
                                        
							<div class="col-12">
                                <asp:LinkButton ID="btnAdd" runat="server" class="btn btn-primary" ValidationGroup="AddPricing" style="background-color:purple" OnClick="btnAdd_Click">Add</asp:LinkButton>
								
								<a href="#" class="btn btn-outline-secondary">Cancel </a>
                                <br />
                                <asp:Label ID="Label1" runat="server" Font-Bold="True" ForeColor="Red"></asp:Label>
							</div>
						</div>
								
								
				</div>

			</div> <!-- Personal Information Card End -->

		</div>
	</div>
</div>


<div class="modal fade" id="successModal" tabindex="-1" aria-labelledby="successModalLabel" aria-hidden="true"
         data-bs-backdrop="static" data-bs-keyboard="false">
      <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content shadow-lg rounded-3 text-center">
      
          <!-- Modal Header -->
         <div class="modal-header text-white border-0" style="background-color:purple;">
            <h5 class="modal-title w-100" id="successModalLabel">Service Price Added Successfully</h5>
            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
          </div>
      
          <!-- Modal Body -->
          <div class="modal-body">
            <img src="https://cdn-icons-png.flaticon.com/512/845/845646.png" 
                 alt="Success" class="mb-3" width="80" height="80" />
            <h6 class="fw-semibold">Your Service has been added successfully!</h6>
            <%--<p class="text-muted mb-4">Reference ID: <span id="lblTxnId">#123456</span></p>--%>
            <button type="button" class="btn text-white w-100" style="background-color:purple;" data-bs-dismiss="modal">OK</button>
          </div>
      
        </div>
      </div>
    </div>

	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</asp:Content>
