<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/NeoxAdmin.Master" AutoEventWireup="true" CodeBehind="EditDispute.aspx.cs" Inherits="NeoXPayout.Admin.EditDispute" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<style>
		  /* Buttons */
    .btn-purple {
        background-color: purple;
        border-color: var(--primary-purple);
        color: #fff;
        font-weight: 600;
        padding: 10px 20px;
        border-radius: 8px;
        transition: background-color 0.3s;
    }
    .btn-purple:hover {
        background-color: #5a35a5;
        border-color: #5a35a5;
    }

    /* Section titles */
    .section-title {
        font-size: 1.1rem;
        color: purple;
        font-weight: 600;
        border-bottom: 2px solid var(--light-purple);
        padding-bottom: 4px;
        margin-bottom: 16px;
    }
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <div class="px-xl-5 px-lg-4 px-3 py-3 page-body">
    <div class="row">
        <div class="col-md-12">

            <div class="card mb-4">
                <div class="card-header py-3 bg-transparent border-bottom-0">
                    <h6 class="card-title mb-0"><strong>Edit Dispute</strong></h6>
                    <asp:Label runat="server" ID="lblmessage" CssClass="text-success"></asp:Label>
                </div>

                <div class="card-body card-main-one">
                    <div class="row">

                        <!-- Dispute Type -->
                        <div class="mb-3 col-md-12">
                            <label class="col-form-label">Dispute Type</label>
                            <asp:TextBox ID="txtDisputeType" CssClass="form-control"
                                runat="server" Placeholder="Enter Dispute Type"></asp:TextBox>

                            <asp:RequiredFieldValidator runat="server"
                                ControlToValidate="txtDisputeType"
                                ValidationGroup="EditDispute"
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
                                ValidationGroup="EditDispute"
                                ErrorMessage="Transaction ID is required"
                                CssClass="text-danger" Display="Dynamic" />
                        </div>

                        <!-- User -->
                        <div class="mb-3 col-md-12">
                            <label class="col-form-label">User</label>
                            <asp:DropDownList ID="ddlUserId" CssClass="form-control"
                                runat="server" DataTextField="UserName"
                                DataValueField="UserId" AppendDataBoundItems="true">
                                <asp:ListItem Value="">-- Select User --</asp:ListItem>
                            </asp:DropDownList>

                            <asp:RequiredFieldValidator runat="server"
                                ControlToValidate="ddlUserId"
                                InitialValue=""
                                ValidationGroup="EditDispute"
                                ErrorMessage="User is required"
                                CssClass="text-danger" Display="Dynamic" />
                        </div>

                        <!-- Description -->
                        <div class="mb-3 col-md-12">
                            <label class="col-form-label">Dispute Description</label>
                            <asp:TextBox ID="txtDescription" runat="server"
                                CssClass="form-control" TextMode="MultiLine" Rows="4"
                                Placeholder="Describe the issue"></asp:TextBox>

                            <asp:RequiredFieldValidator runat="server"
                                ControlToValidate="txtDescription"
                                ValidationGroup="EditDispute"
                                ErrorMessage="Description is required"
                                CssClass="text-danger" Display="Dynamic" />
                        </div>

                        <!-- Status -->
                        <div class="mb-3 col-md-12">
                            <label class="col-form-label">Status</label>
                            <asp:DropDownList ID="ddlStatus" CssClass="form-control" runat="server">
                                <asp:ListItem Value="">-- Select Status --</asp:ListItem>
                                <asp:ListItem Value="Pending">Pending</asp:ListItem>
                                <asp:ListItem Value="Resolved">Resolved</asp:ListItem>
                                <asp:ListItem Value="Rejected">Rejected</asp:ListItem>
                            </asp:DropDownList>

                            <asp:RequiredFieldValidator runat="server"
                                ControlToValidate="ddlStatus"
                                InitialValue=""
                                ValidationGroup="EditDispute"
                                ErrorMessage="Status is required"
                                CssClass="text-danger" Display="Dynamic" />
                        </div>

                        <!-- Proof -->
                        <div class="mb-3 col-md-12">
                            <label class="col-form-label">Upload Proof (optional)</label>
                            <asp:FileUpload ID="fuProof" runat="server" CssClass="form-control" />
                            <asp:Label ID="lblFileError" runat="server" ForeColor="Red"></asp:Label>

                            <asp:HyperLink ID="hlCurrentFile" runat="server"
                                Target="_blank"
                                CssClass="text-primary d-block mt-2"
                                Visible="false" Style=" text-decoration:none">
                                View Current Proof
                            </asp:HyperLink>

                            <asp:HiddenField ID="hiddenOldFilePath" runat="server" />
                        </div>

                        <!-- Buttons -->
                        <div class="col-12">
                            <asp:LinkButton ID="btnUpdate" runat="server"
                                CssClass="btn text-white"
                                Style="background-color:purple"
                                ValidationGroup="EditDispute"
                                OnClick="btnUpdate_Click">
                                Update
                            </asp:LinkButton>

                            <asp:LinkButton ID="btnDelete" runat="server"
                                CssClass="btn btn-outline-danger ms-2"
                                OnClick="btnDelete_Click"
                                OnClientClick="return confirm('Are you sure you want to delete this dispute?');">
                                Delete
                            </asp:LinkButton>

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
     data-bs-backdrop="static">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content shadow-lg rounded-3 text-center">

            <div class="modal-header text-white border-0"
                 style="background-color:purple;">
                <h5 class="modal-title w-100">
                    Dispute Updated Successfully
                </h5>
                <button type="button" class="btn-close btn-close-white"
                        data-bs-dismiss="modal"></button>
            </div>

            <div class="modal-body">
                <img src="https://cdn-icons-png.flaticon.com/512/845/845646.png"
                     width="80" class="mb-3" />
                <h6 class="fw-semibold">
                    The dispute details have been updated successfully.
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


<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</asp:Content>
