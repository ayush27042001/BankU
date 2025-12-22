<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/NeoxAdmin.Master" AutoEventWireup="true" CodeBehind="EditWebhook.aspx.cs" Inherits="NeoXPayout.Admin.EditWebhook" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
	<script src="https://cdn.ckeditor.com/4.22.1/standard/ckeditor.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<hr />

<div class="px-xl-5 px-lg-4 px-3 py-3 page-body">
	<div class="row">
		<div class="col-md-12">

			<div class="card mb-4">
				<div class="card-header py-3 bg-transparent border-bottom-0">
					<h6 class="card-title mb-0"><strong>Edit Webhook</strong></h6>
					<asp:Label runat="server" ID="lblmessage" CssClass="text-success"></asp:Label>							
				</div>
				<div class="card-body card-main-one">
								
						<div class="row">
							<div class="mb-3 col-md-12 col-12">
								<label class="col-form-label">Webhook Link</label>
                                    <asp:TextBox ID="txtLink" CssClass="form-control" runat="server" Placeholder="Enter Webhook Link"></asp:TextBox>
									<asp:RequiredFieldValidator ID="rfvApiName" runat="server" 
									ControlToValidate="txtLink" 
										ValidationGroup="AddApi"
									ErrorMessage="Link is required" 
									CssClass="text-danger" Display="Dynamic" />
							</div>


							<div class="mb-3 col-md-12 col-12">
								<label class="col-form-label">Request  Parameter</label>
								<asp:TextBox ID="txtReq" runat="server" TextMode="MultiLine" Rows="10" Columns="80" ValidateRequestMode="Disabled"></asp:TextBox>
							
					        </div>

							<div class="col-12">
                                <asp:LinkButton ID="btnUpdate" runat="server" class="btn btn-primary" ValidationGroup="AddApi" style="background-color:purple" OnClick="btnUpdate_Click">Update</asp:LinkButton>													
                                <br />
                                <asp:Label ID="Label1" runat="server" Font-Bold="True" ForeColor="Red"></asp:Label>
							</div>
						</div>								
								
				</div>

			</div> <!-- Personal Information Card End -->
		</div>
	</div>
</div>


 <script>
     CKEDITOR.replace('<%= txtReq.ClientID %>');
 </script>


<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</asp:Content>
