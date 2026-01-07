<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/NeoxAdmin.Master" AutoEventWireup="true" CodeBehind="Complain.aspx.cs" Inherits="NeoXPayout.Admin.Complain" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container mt-4">

        <h4 class="mb-3 fw-bold" style="color:purple">
            <i class="bi bi-shield-exclamation"></i> User Complain Management 
        </h4>

        <asp:Label ID="lblMsg" runat="server" CssClass="text-success fw-semibold"></asp:Label>
        <asp:Label ID="lblError" runat="server" Visible="false" CssClass="text-danger fw-semibold">No Complain Found.</asp:Label>
        <div class="table-responsive">
            <table class="table table-bordered table-hover align-middle">
                <thead class=" text-center">
                    <tr>
                        <th style="background-color:lightgrey">#</th>
                        <th style="background-color:lightgrey">Transaction ID</th>
                         <th style="background-color:lightgrey">User ID</th>
                        <th style="background-color:lightgrey">Type</th>
                        <th style="background-color:lightgrey">Description</th>
                        <th style="background-color:lightgrey">Status</th>
                        <th style="background-color:lightgrey">Created On</th>
                        <th style="background-color:lightgrey">Action</th>
                    </tr>
                </thead>

                <tbody>
                    <asp:Repeater ID="rptDisputes" runat="server" OnItemCommand="rptDisputes_ItemCommand">
                        <ItemTemplate>
                            <tr>
                                <td class="text-center"><%# Container.ItemIndex + 1 %></td>
                                
                                <td><%# Eval("TransactionId") %></td>
                                  <td><%# Eval("UserId") %></td>
                                <td><%# Eval("Type") %></td>
                                <td style="max-width:250px;">
                                    <%# Eval("Description") %>
                                </td>

                                <td class="text-center">
                                    <span class="badge 
                                        <%# Eval("Status").ToString() == "Pending" ? "bg-warning text-dark" :
                                            Eval("Status").ToString() == "Resolved" ? "bg-success" :
                                            "bg-danger" %>">
                                        <%# Eval("Status") %>
                                    </span>
                                </td>

                                <td class="text-center">
                                    <%# Eval("CreatedAt", "{0:dd-MMM-yyyy}") %>
                                </td>

                                <td class="text-center">
                                    <asp:LinkButton ID="btnResolve"
                                        runat="server"
                                        CssClass="btn btn-sm btn-success"
                                        CommandName="Resolve"
                                        CommandArgument='<%# Eval("Id") %>'>
                                        Resolve
                                    </asp:LinkButton>

                                    <asp:LinkButton ID="btnReject"
                                        runat="server"
                                        CssClass="btn btn-sm btn-danger ms-1"
                                        CommandName="Reject"
                                        CommandArgument='<%# Eval("Id") %>'>
                                        Reject
                                    </asp:LinkButton>
                                </td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                </tbody>

            </table>
        </div>
    </div>
</asp:Content>
