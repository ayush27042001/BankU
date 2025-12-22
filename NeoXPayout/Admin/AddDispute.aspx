<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/NeoxAdmin.Master" AutoEventWireup="true" CodeBehind="AddDispute.aspx.cs" Inherits="NeoXPayout.Admin.AddDispute" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <div class="px-xl-5 px-lg-4 px-3 py-3 page-body">
    <div class="row">
        <div class="col-md-12">

            <div class="card mb-4">
                <div class="card-header py-3 bg-transparent border-bottom-0">
                    <h6 class="card-title mb-0"><strong>Add Dispute</strong></h6>
                    <asp:Label runat="server" ID="lblmessage" CssClass="text-success"></asp:Label>
                </div>

                <div class="card-body card-main-one">

                    <div class="row">

                        <!-- Dispute Type -->
                        <div class="mb-3 col-md-12">
                            <label class="col-form-label">Dispute Type</label>
                            <asp:TextBox ID="txtDisputeType" CssClass="form-control"
                                runat="server" Placeholder="e.g. Failed Transaction"></asp:TextBox>

                            <asp:RequiredFieldValidator runat="server"
                                ControlToValidate="txtDisputeType"
                                ValidationGroup="AddDispute"
                                ErrorMessage="Dispute Type is required"
                                CssClass="text-danger" Display="Dynamic" />
                        </div>

                        <!-- Transaction ID -->
                        <div class="mb-3 col-md-12">
                            <label class="col-form-label">Transaction ID</label>
                            <asp:TextBox ID="txtTransactionId" CssClass="form-control"
                                runat="server" Placeholder="Enter Transaction ID"></asp:TextBox>

                            <asp:RequiredFieldValidator runat="server"
                                ControlToValidate="txtTransactionId"
                                ValidationGroup="AddDispute"
                                ErrorMessage="Transaction ID is required"
                                CssClass="text-danger" Display="Dynamic" />
                        </div>

                        <!-- User -->
                        <div class="mb-3 col-md-12">
                            <label class="col-form-label">User</label>

                            <asp:DropDownList ID="ddlUserId" CssClass="form-control"
                                runat="server" DataTextField="UserName"
                                DataValueField="UserId" AppendDataBoundItems="true">
                                
                            </asp:DropDownList>

                            <asp:RequiredFieldValidator runat="server"
                                ControlToValidate="ddlUserId"
                                InitialValue=""
                                ValidationGroup="AddDispute"
                                ErrorMessage="User is required"
                                CssClass="text-danger" Display="Dynamic" />
                        </div>

                        <!-- Dispute Description -->
                        <div class="mb-3 col-md-12">
                            <label class="col-form-label">Dispute Description</label>
                            <asp:TextBox ID="txtDescription" runat="server"
                                CssClass="form-control" TextMode="MultiLine"
                                Rows="4" Placeholder="Explain the issue in detail"></asp:TextBox>

                            <asp:RequiredFieldValidator runat="server"
                                ControlToValidate="txtDescription"
                                ValidationGroup="AddDispute"
                                ErrorMessage="Description is required"
                                CssClass="text-danger" Display="Dynamic" />
                        </div>

                        <!-- Upload Proof -->
                        <div class="mb-3 col-md-12">
                            <label class="col-form-label">Upload Proof </label>
                            <asp:FileUpload ID="fuProof" runat="server" CssClass="form-control" />
                            <asp:Label ID="lblFileError" runat="server" ForeColor="Red"></asp:Label>
                              <asp:RequiredFieldValidator
                        ID="rfvProof"
                        runat="server"
                        ControlToValidate="fuProof"
                        ValidationGroup="AddDispute"
                        ErrorMessage="Proof file is required"
                        CssClass="text-danger"
                        Display="Dynamic" />
                        </div>

                        <!-- Buttons -->
                        <div class="col-12">
                            <asp:LinkButton ID="btnAddDispute" runat="server"
                                CssClass="btn btn-primary"
                                Style="background-color:purple"
                                ValidationGroup="AddDispute"
                                OnClick="btnAddDispute_Click">
                                Submit Dispute
                            </asp:LinkButton>

                            <a href="javascript:void(0);" 
   class="btn btn-outline-secondary"
   onclick="clearDisputeForm();">
   Cancel
</a>


                            <br />
                            <asp:Label ID="Label1" runat="server"
                                Font-Bold="True" ForeColor="Red"></asp:Label>
                        </div>

                    </div>

                </div>
            </div>

        </div>
    </div>
</div>


<div class="modal fade" id="successModal" tabindex="-1"
     aria-hidden="true" data-bs-backdrop="static">

    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content shadow-lg rounded-3 text-center">

            <div class="modal-header text-white border-0"
                 style="background-color:purple;">
                <h5 class="modal-title w-100">
                    Dispute Submitted Successfully
                </h5>
                <button type="button" class="btn-close btn-close-white"
                        data-bs-dismiss="modal"></button>
            </div>

            <div class="modal-body">
                <img src="https://cdn-icons-png.flaticon.com/512/845/845646.png"
                     width="80" class="mb-3" />

                <h6 class="fw-semibold">
                    Your dispute has been submitted successfully!
                </h6>

                <button type="button" class="btn text-white w-100"
                        style="background-color:purple;"
                        data-bs-dismiss="modal">
                    OK
                </button>
            </div>

        </div>
    </div>
</div>
    <script>
    function clearDisputeForm() {

        // Clear text inputs
        document.getElementById('<%= txtDisputeType.ClientID %>').value = '';
        document.getElementById('<%= txtTransactionId.ClientID %>').value = '';
        document.getElementById('<%= txtDescription.ClientID %>').value = '';

        // Reset dropdown
        document.getElementById('<%= ddlUserId.ClientID %>').selectedIndex = 0;

        // Clear file upload
        document.getElementById('<%= fuProof.ClientID %>').value = '';

        // Clear messages
        document.getElementById('<%= lblFileError.ClientID %>').innerHTML = '';
        document.getElementById('<%= Label1.ClientID %>').innerHTML = '';
    }
    </script>

    	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</asp:Content>
