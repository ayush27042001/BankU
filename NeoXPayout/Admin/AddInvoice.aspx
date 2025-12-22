<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/NeoxAdmin.Master" AutoEventWireup="true" CodeBehind="AddInvoice.aspx.cs" Inherits="NeoXPayout.Admin.AddInvoice" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <div class="px-xl-5 px-lg-4 px-3 py-3 page-body">
	<div class="row">
		<div class="col-md-12">

			<div class="card mb-4">
				<div class="card-header py-3 bg-transparent border-bottom-0">
					<h6 class="card-title mb-0"><strong>Add Invoice</strong></h6>
					<asp:Label runat="server" ID="lblmessage" CssClass="text-success"></asp:Label>
						 
				</div>
				<div class="card-body card-main-one">
								
						<div class="row">
							<div class="mb-3 col-md-12 col-12">
								<label class="col-form-label">Invoice Type</label>
                                    <asp:TextBox ID="txtType" CssClass="form-control" runat="server" Placeholder="Enter Invoice Type"></asp:TextBox>
									<asp:RequiredFieldValidator ID="rfvApiName" runat="server" 
									ControlToValidate="txtType" 
										ValidationGroup="AddInvoice"
									ErrorMessage="Invoice Type is required" 
									CssClass="text-danger" Display="Dynamic" />
							</div>
                            <div class="mb-3 col-md-12 col-12">
								<label class="col-form-label">Invoice ID</label>
                                    <asp:TextBox ID="txtInvId" CssClass="form-control" runat="server" Placeholder="Enter Invoice ID"></asp:TextBox>
									<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
									ControlToValidate="txtInvId" 
									ValidationGroup="AddInvoice"
									ErrorMessage="Invoice ID is required" 
									CssClass="text-danger" Display="Dynamic" />
							</div>

					    	<div class="mb-3 col-md-12 col-12">
							<label class="col-form-label">User Id</label>
    
							<asp:DropDownList ID="ddlUserId" CssClass="form-control" runat="server" 
								DataTextField="UserName" DataValueField="UserId" AppendDataBoundItems="true">
								<asp:ListItem Value="">-- Select User --</asp:ListItem>
							</asp:DropDownList>

							<asp:RequiredFieldValidator ID="rfvUserId" runat="server"
								ControlToValidate="ddlUserId"
								InitialValue=""
								ValidationGroup="AddInvoice"
								ErrorMessage="User Id is required"
								CssClass="text-danger"
								Display="Dynamic" />
					    	</div>

							<div class="mb-3 col-md-6 col-6">
                                <label class="col-form-label">Start Date</label>
                                <asp:TextBox ID="txtStartDate" CssClass="form-control" runat="server" 
                                    TextMode="Date" Placeholder="Select Start Date"></asp:TextBox>

                                <asp:RequiredFieldValidator ID="rfvStartDate" runat="server"
                                    ControlToValidate="txtStartDate"
                                    ValidationGroup="AddInvoice"
                                    ErrorMessage="Start Date is required"
                                    CssClass="text-danger" 
                                    Display="Dynamic" />
                            </div>

                            <div class="mb-3 col-md-6 col-6">
                                <label class="col-form-label">End Date</label>
                                <asp:TextBox ID="txtEndDate" CssClass="form-control" runat="server" 
                                    TextMode="Date" Placeholder="Select End Date"></asp:TextBox>

                                <asp:RequiredFieldValidator ID="rfvEndDate" runat="server"
                                    ControlToValidate="txtEndDate"
                                    ValidationGroup="AddInvoice"
                                    ErrorMessage="End Date is required"
                                    CssClass="text-danger" 
                                    Display="Dynamic" />
                            </div>

							<div class="mb-3 col-md-12 col-12">
								<label class="col-form-label"> Upload Invoice</label>
									<asp:FileUpload ID="fuInvoice" runat="server" CssClass="form-control" />
                                    <asp:Label ID="lblFileError" runat="server" ForeColor="Red"></asp:Label>
									<asp:RequiredFieldValidator ID="rfvApiIcon" runat="server" 
									ControlToValidate="fuInvoice" 
									InitialValue="" ValidationGroup="AddInvoice"
									ErrorMessage="Invoice is required" 
									CssClass="text-danger" Display="Dynamic" />
							</div>
					
                                        
							<div class="col-12">
                                <asp:LinkButton ID="btnAdd" runat="server" class="btn btn-primary" ValidationGroup="AddInvoice" style="background-color:purple" OnClick="btnAdd_Click">Add</asp:LinkButton>
								
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
            <h5 class="modal-title w-100" id="successModalLabel">Invoice Added Successfully</h5>
            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
          </div>
      
          <!-- Modal Body -->
          <div class="modal-body">
            <img src="https://cdn-icons-png.flaticon.com/512/845/845646.png" 
                 alt="Success" class="mb-3" width="80" height="80" />
            <h6 class="fw-semibold">Your Invoice has been added successfully!</h6>
            <%--<p class="text-muted mb-4">Reference ID: <span id="lblTxnId">#123456</span></p>--%>
            <button type="button" class="btn text-white w-100" style="background-color:purple;" data-bs-dismiss="modal">OK</button>
          </div>
      
        </div>
      </div>
    </div>


<%--
<script>
    function openAddCategoryModal() {
        var myModal = new bootstrap.Modal(document.getElementById('Addcategory'));
        myModal.show();
    }
</script>--%>
<%--<script>
    document.getElementById("<%= fuApiIcon.ClientID %>").addEventListener("change", function () {
        const file = this.files[0];
        if (file && file.size > 10240) { // 10 KB = 10240 bytes
            alert("File size must be less than 10 KB.");
            this.value = ""; // clear file
        }
    });
</script>--%>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</asp:Content>
