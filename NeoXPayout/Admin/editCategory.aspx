<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/NeoxAdmin.Master" AutoEventWireup="true" CodeBehind="editCategory.aspx.cs" Inherits="NeoXPayout.Admin.editCategory" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="px-xl-5 px-lg-4 px-3 py-3 page-body">
	<div class="row">
		<div class="col-md-12">

			<div class="card mb-4">
				<div class="card-header py-3 bg-transparent border-bottom-0">
					<h6 class="card-title mb-0"><strong>Edit Category</strong></h6>
					<asp:Label runat="server" ID="lblmessage" CssClass="text-success"></asp:Label>
						 
				</div>
				<div class="card-body card-main-one">
								
						<div class="row">
							<div class="mb-3 col-md-12 col-12">
								<label class="col-form-label">Category Name</label>
                                    <asp:TextBox ID="txtcategoryname" CssClass="form-control" runat="server" Placeholder="Enter Product Name"></asp:TextBox>
									
							</div>
							<asp:HiddenField ID="HiddenField1" runat="server" />
							<div class="mb-3 col-md-12 col-12">
								<label class="col-form-label">Status</label>
								<asp:DropDownList ID="ddlstatus" runat="server" CssClass="form-control">
									<asp:ListItem>Active</asp:ListItem>
									<asp:ListItem>InActive</asp:ListItem>
								</asp:DropDownList>
							</div>
							        
							<div class="col-12">
                                <asp:LinkButton ID="btnAdd" runat="server" class="btn btn-primary" ValidationGroup="AddApi" style="background-color:purple" OnClick="btnAdd_Click">Update</asp:LinkButton>
								<asp:LinkButton ID="btndelete" runat="server" class="btn btn-primary" style="background-color:red" OnClick="LinkButton1_Click">Delete</asp:LinkButton>
							</div>
						</div>		
				</div>
			</div> <!-- Personal Information Card End -->
		</div>
	</div>
</div>
</asp:Content>

