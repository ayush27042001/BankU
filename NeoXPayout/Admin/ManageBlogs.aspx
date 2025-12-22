<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/NeoxAdmin.Master" AutoEventWireup="true" CodeBehind="ManageBlogs.aspx.cs" Inherits="NeoXPayout.Admin.ManageBlogs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
	<script src="https://cdn.ckeditor.com/4.22.1/standard/ckeditor.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="px-xl-5 px-lg-4 px-3 py-3 page-body">
	<div class="row">
		<div class="col-md-12">

			<div class="card mb-4">
				<div class="card-header py-3 bg-transparent border-bottom-0">
					<h6 class="card-title mb-0"><strong>Manage Blogs</strong></h6>
					<asp:Label runat="server" ID="lblmessage" CssClass="text-success"></asp:Label>
						 
				</div>
				<div class="card-body card-main-one">
								
						<div class="row">
							<div class="mb-3 col-md-12 col-12">
								<label class="col-form-label"> Picture</label>
									<asp:FileUpload ID="FileUpload1" runat="server" CssClass="form-control" />
                                    
							</div>
							<div class="mb-3 col-md-12 col-12">
								<label class="col-form-label">Heading</label>
                                    <asp:TextBox ID="txtheading" CssClass="form-control" runat="server" Placeholder="Enter Product Name"></asp:TextBox>
									
							</div>
							<div class="mb-3 col-md-12 col-12">
								<label class="col-form-label">Content</label>
									<asp:TextBox ID="txtcontent" CssClass="form-control" runat="server" Placeholder="Enter Product Discription"></asp:TextBox>
									
							</div>

							<div class="mb-3 col-md-12 col-12">
								<label class="col-form-label">Enter Long Desc</label>
								<asp:TextBox ID="Ckeditorcontrol4" runat="server" TextMode="MultiLine" Rows="10" Columns="80" ValidateRequestMode="Disabled"></asp:TextBox>
							</div>

							<div class="mb-3 col-md-12 col-12">
								<label class="col-form-label">Categoryc</label>
								<asp:TextBox ID="Ckeditorcontrol3" runat="server" TextMode="MultiLine" Rows="10" Columns="80" ValidateRequestMode="Disabled"></asp:TextBox>
								
							</div>
							<div class="mb-3 col-md-12 col-12">
								<label class="col-form-label">Date Time</label>
								<asp:TextBox ID="txtDateTime" runat="server" CssClass="form-control" 
									TextMode="DateTimeLocal" Placeholder="Select Date & Time">
								</asp:TextBox>
							</div>
							<div class="mb-3 col-md-12 col-12">
								<label class="col-form-label">Status</label>
								<asp:DropDownList ID="ddlstatus" runat="server" CssClass="form-control">
									<asp:ListItem>Active</asp:ListItem>
									<asp:ListItem>InActive</asp:ListItem>
								</asp:DropDownList>
							</div>
							        
							<div class="col-12">
                                <asp:LinkButton ID="btnAdd" runat="server" class="btn btn-primary" ValidationGroup="AddApi" style="background-color:purple" OnClick="btnAdd_Click" >Add</asp:LinkButton>
								
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

	<script>
		CKEDITOR.replace('<%= Ckeditorcontrol4.ClientID %>');
        CKEDITOR.replace('<%= Ckeditorcontrol3.ClientID %>');
    </script>
</asp:Content>
