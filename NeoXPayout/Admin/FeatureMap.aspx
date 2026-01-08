<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/NeoxAdmin.Master" AutoEventWireup="true" CodeBehind="FeatureMap.aspx.cs" Inherits="NeoXPayout.Admin.FeatureMap" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
 <hr />

<div class="px-xl-5 px-lg-4 px-3 py-3 page-body">
    <div class="row">
        <div class="col-md-12">

            <div class="card mb-4">
                <div class="card-header py-3 bg-transparent border-bottom-0">
                    <h6 class="card-title mb-0"><strong>Add Service Provider Feature Map</strong></h6>
                    <asp:Label runat="server" ID="lblmessage" CssClass="text-success"></asp:Label>
                </div>

                <div class="card-body card-main-one">
                    <div class="row">

                        <!-- Service Code -->
                        <div class="mb-3 col-md-12 col-12">
                            <label class="col-form-label">Service Code</label>
                            <asp:TextBox ID="txtService" CssClass="form-control" runat="server"
                                Placeholder="Enter Service Code"></asp:TextBox>

                            <asp:RequiredFieldValidator ID="rfvService" runat="server"
                                ControlToValidate="txtService"
                                ValidationGroup="AddFeature"
                                ErrorMessage="Service Code is required"
                                CssClass="text-danger" Display="Dynamic" />
                        </div>

                       
                        <div class="mb-3 col-md-12 col-12">
                            <label class="col-form-label">Provider Code</label>
                            <asp:TextBox ID="txtProvider" CssClass="form-control" runat="server"
                                Placeholder="Enter Provider Code"></asp:TextBox>

                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server"
                                ControlToValidate="txtProvider"
                                ValidationGroup="AddFeature"
                                ErrorMessage="Provider Code is required"
                                CssClass="text-danger" Display="Dynamic" />
                        </div>

                        <div class="mb-3 col-md-12 col-12">
								<label class="col-form-label">Feature Code</label>
                                    <asp:TextBox ID="txtFeatureCode" CssClass="form-control" runat="server" Placeholder="Enter Feature Code"></asp:TextBox>
									<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
									ControlToValidate="txtFeatureCode" 
										ValidationGroup="AddFeature"
									ErrorMessage="Feature Code is required" 
									CssClass="text-danger" Display="Dynamic" />
							</div>
                        
                        <!-- Buttons -->
                        <div class="col-12">
                            <asp:LinkButton ID="btnAdd" runat="server"
                                class="btn btn-primary"
                                ValidationGroup="AddFeature"
                                style="background-color:purple"
                                OnClick="btnAdd_Click">
                                Add
                            </asp:LinkButton>

                            <a href="#" class="btn btn-outline-secondary">Cancel</a>
                            <br />
                            <asp:Label ID="Label1" runat="server" Font-Bold="True" ForeColor="Red"></asp:Label>
                        </div>

                    </div>
                </div>
            </div>

        </div>
    </div>
</div>

    <div class="modal fade" id="successModal" tabindex="-1" aria-labelledby="successModalLabel" aria-hidden="true"
         data-bs-backdrop="static" data-bs-keyboard="false">
      <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content shadow-lg rounded-3 text-center">
      
          <!-- Modal Header -->
         <div class="modal-header text-white border-0" style="background-color:purple;">
            <h5 class="modal-title w-100" id="successModalLabel">Feature Map Added Successfully</h5>
            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
          </div>
      
          <!-- Modal Body -->
          <div class="modal-body">
            <img src="https://cdn-icons-png.flaticon.com/512/845/845646.png" 
                 alt="Success" class="mb-3" width="80" height="80" />
            <h6 class="fw-semibold">Your Feature Map has been added successfully!</h6>
            <%--<p class="text-muted mb-4">Reference ID: <span id="lblTxnId">#123456</span></p>--%>
            <button type="button" class="btn text-white w-100" style="background-color:purple;" data-bs-dismiss="modal">OK</button>
          </div>
      
        </div>
      </div>
    </div>

	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</asp:Content>

