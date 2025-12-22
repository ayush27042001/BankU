<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/NeoxAdmin.Master" AutoEventWireup="true" CodeBehind="EditProduct.aspx.cs" Inherits="NeoXPayout.Admin.EditProduct" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
	    <h3 class="mt-4 mb-3 fw-bold" style="color:#2c3e50; font-family:'Segoe UI', Tahoma, sans-serif; margin-left:20px;">
Edit Product 
</h3>
    <div class="px-xl-5 px-lg-4 px-3 py-3 page-body">
	<div class="row">
		<div class="col-md-12">

			<div class="card mb-4">
				<div class="card-header py-3 bg-transparent border-bottom-0">
					<h6 class="card-title mb-0"><strong>Edit product</strong></h6>
					<asp:Label runat="server" ID="lblmessage" CssClass="text-success"></asp:Label>						 
				</div>
				<div class="card-body card-main-one">								
						<div class="row">
							<div class="mb-3 col-md-12 col-12">
								<label class="col-form-label">Name</label>
                                    <asp:TextBox ID="txtname" CssClass="form-control" runat="server" Placeholder="Enter API Name"></asp:TextBox>
									<asp:RequiredFieldValidator ID="rfvApiName" runat="server" 
									ControlToValidate="txtname" 
										ValidationGroup="AddApi"
									ErrorMessage="API Name is required" 
									CssClass="text-danger" Display="Dynamic" />
							</div>
							<div class="mb-3 col-md-12 col-12">
								<label class="col-form-label">Model</label>
									<asp:TextBox ID="txtModel" CssClass="form-control" runat="server" Placeholder="Enter API Discription"></asp:TextBox>
									<asp:RequiredFieldValidator ID="rfvApiDesc" runat="server" 
									ControlToValidate="txtModel" ValidationGroup="AddApi"
									ErrorMessage="API Description is required" 
									CssClass="text-danger" Display="Dynamic" />
							</div>
							<div class="mb-3 col-md-12 col-12">
								<label class="col-form-label">Status</label>
							    <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-control">
									<asp:ListItem Text="In Stock" Value="In Stock" />	
									<asp:ListItem Text="Out Of Stock" Value="Out Of Stock" />	
								</asp:DropDownList>
								<asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
									ControlToValidate="ddlStatus" ValidationGroup="AddApi"
									ErrorMessage="API Status is required" 
									CssClass="text-danger" Display="Dynamic" />
							</div>
							
							<div class="mb-3 col-md-12 col-12">
								<label class="col-form-label">Description</label>
                                    <asp:TextBox ID="txtDesc" CssClass="form-control" runat="server" Placeholder="Enter API Name"></asp:TextBox>
									<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
									ControlToValidate="txtDesc" 
										ValidationGroup="AddApi"
									ErrorMessage="API Name is required" 
									CssClass="text-danger" Display="Dynamic" />
							</div>
							<div class="mb-3 col-md-12 col-12">
								<label class="col-form-label"> Picture(1280px X 720px)</label>
									<asp:FileUpload ID="fuApiIcon" runat="server" CssClass="form-control" />
                                    <asp:Label ID="lblFileError" runat="server" ForeColor="Red"></asp:Label>
								 <asp:Image ID="imgApiIcon" runat="server" CssClass="img-thumbnail mb-2" Width="60" Height="60" />
							</div>

							<div class="mb-3 col-md-12 col-12">
								<label class="col-form-label">Product Price</label>
									<asp:TextBox ID="txtAmount" CssClass="form-control" runat="server" Placeholder="Enter API Price"></asp:TextBox>
									<asp:RequiredFieldValidator ID="rfvApiPrice" runat="server" 
									ControlToValidate="txtAmount" ValidationGroup="AddApi"
									ErrorMessage="API Price is required" 
									CssClass="text-danger" Display="Dynamic" />
									<asp:RegularExpressionValidator ID="revApiPrice" runat="server" 
									ControlToValidate="txtAmount" ValidationGroup="AddApi"
									ValidationExpression="^\d+(\.\d{1,2})?$" 
									ErrorMessage="Enter a valid price (e.g., 99.99)" 
									CssClass="text-danger" Display="Dynamic" />
							</div>
                                        
							<div class="col-12">
                                <asp:LinkButton ID="LinkButton1" runat="server" class="btn btn-primary" ValidationGroup="AddApi" style="background-color:purple" OnClick="LinkButton1_Click">Update</asp:LinkButton>
								<asp:LinkButton runat="server" ID="btnDelete" CssClass="btn btn-danger" OnClick="btnDelete_Click" Style="margin-left:5px;">
									Delete
								</asp:LinkButton>

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
            <h5 class="modal-title w-100" id="successModalLabel">Product Added Successfully</h5>
            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
          </div>
      
          <!-- Modal Body -->
          <div class="modal-body">
            <img src="https://cdn-icons-png.flaticon.com/512/845/845646.png" 
                 alt="Success" class="mb-3" width="80" height="80" />
            <h6 class="fw-semibold">Your API has been added successfully!</h6>
            <%--<p class="text-muted mb-4">Reference ID: <span id="lblTxnId">#123456</span></p>--%>
            <button type="button" class="btn text-white w-100" style="background-color:purple;" data-bs-dismiss="modal">OK</button>
          </div>
      
        </div>
      </div>
    </div>

	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</asp:Content>
