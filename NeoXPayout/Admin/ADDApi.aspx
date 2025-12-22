<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/NeoxAdmin.Master" AutoEventWireup="true" CodeBehind="ADDApi.aspx.cs" Inherits="NeoXPayout.Admin.ADDApi" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<hr />

<div class="px-xl-5 px-lg-4 px-3 py-3 page-body">
	<div class="row">
		<div class="col-md-12">

			<div class="card mb-4">
				<div class="card-header py-3 bg-transparent border-bottom-0">
					<h6 class="card-title mb-0"><strong>Add API</strong></h6>
					<asp:Label runat="server" ID="lblmessage" CssClass="text-success"></asp:Label>
						   <asp:LinkButton ID="btnAddCat" runat="server" class="btn btn-primary"  OnClientClick="openAddCategoryModal(); return false;" style="background-color:purple" >Add API Category</asp:LinkButton>		
				</div>
				<div class="card-body card-main-one">
								
						<div class="row">
							<div class="mb-3 col-md-12 col-12">
								<label class="col-form-label">API Name</label>
                                    <asp:TextBox ID="txtcompanyname" CssClass="form-control" runat="server" Placeholder="Enter API Name"></asp:TextBox>
									<asp:RequiredFieldValidator ID="rfvApiName" runat="server" 
									ControlToValidate="txtcompanyname" 
										ValidationGroup="AddApi"
									ErrorMessage="API Name is required" 
									CssClass="text-danger" Display="Dynamic" />
							</div>
							<div class="mb-3 col-md-12 col-12">
								<label class="col-form-label">API Category</label>
								<asp:DropDownList ID="ddlCategory" CssClass="form-control" runat="server" ValidationGroup="AddApi">
									
								</asp:DropDownList>

								<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
									ControlToValidate="ddlCategory" ValidationGroup="AddApi"
									InitialValue=""  
									ErrorMessage="API Category is required"
									CssClass="text-danger" Display="Dynamic" />
							</div>
							<div class="mb-3 col-md-12 col-12">
								<label class="col-form-label">API Discription</label>
									<asp:TextBox ID="txtfullname" CssClass="form-control" runat="server" Placeholder="Enter API Discription"></asp:TextBox>
									<asp:RequiredFieldValidator ID="rfvApiDesc" runat="server" 
									ControlToValidate="txtfullname" ValidationGroup="AddApi"
									ErrorMessage="API Description is required" 
									CssClass="text-danger" Display="Dynamic" />
							</div>
							<div class="mb-3 col-md-12 col-12">
								<label class="col-form-label">API Icon (less then 10 kb)(60px X 60px)</label>
									<asp:FileUpload ID="fuApiIcon" runat="server" CssClass="form-control" />
                                    <asp:Label ID="lblFileError" runat="server" ForeColor="Red"></asp:Label>
									<asp:RequiredFieldValidator ID="rfvApiIcon" runat="server" 
									ControlToValidate="fuApiIcon" 
									InitialValue="" ValidationGroup="AddApi"
									ErrorMessage="API Icon is required" 
									CssClass="text-danger" Display="Dynamic" />
							</div>
							<div class="mb-3 col-md-12 col-12">
								<label class="col-form-label">API Price</label>
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
                                <asp:LinkButton ID="btnAdd" runat="server" class="btn btn-primary" ValidationGroup="AddApi" style="background-color:purple" OnClick="btnAdd_Click">Add API</asp:LinkButton>
								<%--<button class="btn btn-primary">Save</button>--%>
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
            <h5 class="modal-title w-100" id="successModalLabel">API Added Successfully</h5>
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

<div class="modal fade" id="Addcategory" tabindex="-1" aria-labelledby="categoryModalLabel" aria-hidden="true"
         data-bs-backdrop="static" data-bs-keyboard="false">
      <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content shadow-lg rounded-3 text-center">
      
          <!-- Modal Header -->
         <div class="modal-header text-white border-0" style="background-color:purple;">
            <h5 class="modal-title w-100" id="categoryModalLabel">Add Category</h5>
            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
          </div>
      
          <!-- Modal Body -->
          <div class="modal-body">
           <div class="row">
					<div class="mb-3 col-md-12 col-12">
						<label class="col-form-label">Add Category</label>
                            <asp:TextBox ID="AddCategory" CssClass="form-control" ValidationGroup="AddCat" runat="server" Placeholder="Enter API Category"></asp:TextBox>
							<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
							ControlToValidate="AddCategory" 
							ValidationGroup="AddCat"
							ErrorMessage="API Category is required" 
							CssClass="text-danger" Display="Dynamic" />
					</div>
			   <div class="col-12">
			    <asp:LinkButton ID="LinkButton1" runat="server" class="btn btn-primary" ValidationGroup="AddCat" OnClick="LinkButton1_Click" style="background-color:purple">Add</asp:LinkButton>
			   </div>
			   </div>
          </div> 
        </div>
      </div>
    </div>

<script>
    function openAddCategoryModal() {
        var myModal = new bootstrap.Modal(document.getElementById('Addcategory'));
        myModal.show();
    }
</script>
<script>
    document.getElementById("<%= fuApiIcon.ClientID %>").addEventListener("change", function () {
        const file = this.files[0];
        if (file && file.size > 10240) { // 10 KB = 10240 bytes
            alert("File size must be less than 10 KB.");
            this.value = ""; // clear file
        }
    });
</script>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</asp:Content>