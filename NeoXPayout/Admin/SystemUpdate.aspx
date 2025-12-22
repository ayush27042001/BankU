<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/NeoxAdmin.Master" AutoEventWireup="true" CodeBehind="SystemUpdate.aspx.cs" Inherits="NeoXPayout.Admin.SystemUpdate" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    .card {
      border-radius: 8px;
      overflow: hidden;
      box-shadow: 0px 2px 8px rgba(0,0,0,0.1);
    }
     .notification-header {
      background: linear-gradient(to right, #6a1b9a, #2e86ab);
      color: #fff;
      padding: 12px 16px;
      font-weight: 600;
      display: flex;
      justify-content: space-between;
      align-items: center;
    }
    .btn-add {
      background-color: #8e24aa;
      color: #fff;
      font-weight: 500;
      border-radius: 6px;
      border: none;
      padding: 6px 14px;
    }
    .btn-add:hover {
      background-color: #6a1b9a;
    }
    .modal-header {
      background-color: #6a1b9a;
      color: white;
    }
    .btn-close {
      filter: invert(1);
    }
    .btn-save {
      background-color: #6a1b9a;
      color: white;
    }
    .btn-save:hover {
      background-color: #4a126b;
      color: white;
    }
  </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <hr />
    <asp:HiddenField ID="hdnNotificationID" runat="server" />

        <div class="bg-light">
    <div class="container my-5">
        <div class="card shadow">
            <div class="notification-header d-flex justify-content-between align-items-center p-3">
                <span>🔔 Notifications (Total: <asp:Label ID="lblTotal" runat="server" />)</span>
                <!-- Button trigger modal -->
                <button type="button" class="btn btn-primary" onclick="openAddModal()">
                    + Add New Notification
                </button>
            </div>

            <!-- Table -->
            <div class="table-responsive">
                <asp:Repeater ID="rptNotifications" runat="server" OnItemCommand="rptNotifications_ItemCommand">
                    <HeaderTemplate>
                        <table class="table mb-0">
                            <thead style="background-color:rebeccapurple; color:white;">
                                <tr>
                                    <th>Sr No</th>
                                    <th>Notification Content</th>
                                    <th>Status</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <tr>
                            <td><%# Container.ItemIndex + 1 %></td>
                            <td><%# Eval("Content") %></td>
                            <td><strong><%# Eval("Status") %></strong></td>
                            <td>
                                <!-- Edit Button -->
                                <asp:LinkButton ID="lnkEdit" runat="server" CssClass="btn-add"
                                    CommandName="EditNotification" CommandArgument='<%# Eval("NotificationID") %>'>
                                    ✏️
                                </asp:LinkButton>

                                <!-- Delete Button -->
                                <asp:LinkButton ID="lnkDelete" runat="server" CssClass="btn-add" Style="margin-left:30px"
                                    CommandName="DeleteNotification" CommandArgument='<%# Eval("NotificationID") %>'
                                    OnClientClick="return confirm('Are you sure you want to delete this notification?');">
                                    🗑️
                                </asp:LinkButton >
                            </td>
                        </tr>
                    </ItemTemplate>
                    <FooterTemplate>
                            </tbody>
                        </table>
                    </FooterTemplate>
                </asp:Repeater>
            </div>
        </div>
    </div>
</div>

        <!-- Modal -->
        <div class="modal fade" id="testModal" tabindex="-1" aria-labelledby="testModalLabel" aria-hidden="true" data-bs-backdrop="static" data-bs-keyboard="false">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header bg-primary text-white">
                        <h5 class="modal-title" id="testModalLabel">🔔 Add / Edit Notification</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <asp:TextBox ID="txtContent" runat="server" CssClass="form-control mb-3" TextMode="MultiLine" Rows="3" placeholder="Enter notification content"></asp:TextBox>
                        <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-select">
                            <asp:ListItem Text="Active" />
                            <asp:ListItem Text="Inactive" />
                        </asp:DropDownList>
                    </div>
                    <div class="modal-footer">
                        <asp:Button ID="btnSave" runat="server" CssClass="btn btn-primary" Text="Save/Update" OnClick="btnSave_Click" />
                    </div>
                </div>
            </div>
        </div>
    <script>
        function openAddModal() {
            document.getElementById('<%= hdnNotificationID.ClientID %>').value = "";
            document.getElementById('<%= txtContent.ClientID %>').value = "";
            document.getElementById('<%= ddlStatus.ClientID %>').selectedIndex = 0;

            var myModal = new bootstrap.Modal(document.getElementById('testModal'));
            myModal.show();
        }

        function openEditModal() {
            var myModal = new bootstrap.Modal(document.getElementById('testModal'));
            myModal.show();
        }
    </script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</asp:Content>

