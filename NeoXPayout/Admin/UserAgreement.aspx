<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/NeoxAdmin.Master" AutoEventWireup="true" CodeBehind="UserAgreement.aspx.cs" Inherits="NeoXPayout.Admin.UserAgreement" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<!-- jQuery FIRST -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!-- Select2 CSS -->
<link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />

<!-- Select2 JS -->
<script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>

<!-- Bootstrap CSS (optional) -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
   <div class="px-xl-5 px-lg-4 px-3 py-3 page-body">
	<div class="row">
		<div class="col-md-12">

			<div class="card mb-4">
				<div class="card-header py-3 bg-transparent border-bottom-0">
					<h6 class="card-title mb-0"><strong>Add Agreement</strong></h6>
					<asp:Label runat="server" ID="lblmessage" CssClass="text-success"></asp:Label>
						 
				</div>
				<div class="card-body card-main-one">
								
						<div class="row">
							<div class="mb-3 col-md-12 col-12">
								<label class="col-form-label">Agreement Type</label>
                                    <asp:TextBox ID="txtType" CssClass="form-control" runat="server" Placeholder="Enter Agreement Type"></asp:TextBox>
									<asp:RequiredFieldValidator ID="rfvAgreement" runat="server" 
									ControlToValidate="txtType" 
								    ValidationGroup="AddAgreement"
									ErrorMessage="Agreement Type is required" 
									CssClass="text-danger" Display="Dynamic" />
							</div>
                            <div class="mb-3 col-md-12 col-12">
								<label class="col-form-label">Agreement ID</label>
                                    <asp:TextBox ID="txtAggId" CssClass="form-control" runat="server" Placeholder="Enter Agreement ID"></asp:TextBox>
									<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
									ControlToValidate="txtAggId" 
									ValidationGroup="AddAgreement"
									ErrorMessage="Agreement ID is required" 
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
								ValidationGroup="AddAgreement"
								ErrorMessage="User Id is required"
								CssClass="text-danger"
								Display="Dynamic" />
					    	</div>

							<div class="mb-3 col-md-12 col-12">
								<label class="col-form-label"> Upload Agreement</label>
									<asp:FileUpload ID="fuAgreement" runat="server" CssClass="form-control" />
                                    <asp:Label ID="lblFileError" runat="server" ForeColor="Red"></asp:Label>
									<asp:RequiredFieldValidator ID="rfvApiIcon" runat="server" 
									ControlToValidate="fuAgreement" 
									InitialValue="" ValidationGroup="AddAgreement"
									ErrorMessage="Agreement is required" 
									CssClass="text-danger" Display="Dynamic" />
							</div>
					
                                        
							<div class="col-12">
                                <asp:LinkButton ID="btnAdd" runat="server" class="btn btn-primary" ValidationGroup="AddAgreement" style="background-color:purple" OnClick="btnAdd_Click">Add</asp:LinkButton>
								
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
<script>
    $(document).ready(function () {
        $('#<%= ddlUserId.ClientID %>').select2({
            placeholder: "-- Select User --",
            allowClear: true,
            width: '100%'
        });
    });
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</asp:Content>
