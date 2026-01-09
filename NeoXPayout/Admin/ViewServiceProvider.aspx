<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/NeoxAdmin.Master" AutoEventWireup="true" CodeBehind="ViewServiceProvider.aspx.cs" Inherits="NeoXPayout.Admin.ViewServiceProvider" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<style>
.truncate-text {
    display: inline-block;
    max-width: 200px;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
    vertical-align: middle;
}
.copy-btn {
    font-size: 14px;
    border: none;
    background: none;
    cursor: pointer;
}
</style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
 <!-- Heading -->
<h3 class="mt-4 mb-3 fw-bold" 
    style="color:#2c3e50; font-family:'Segoe UI', Tahoma, sans-serif; margin-left:20px;">
    View Service Provider
</h3>
<asp:Label ID="lblMessage" runat="server" 
    CssClass="ms-3 mb-3 d-block fw-semibold" 
    ForeColor="Gray">
</asp:Label>

<div class="d-flex flex-wrap gap-3 align-items-center mb-3" style="margin-left:20px; margin-right:20px;">
  
    <input type="text" id="searchBox" class="form-control" 
           placeholder="🔍 Search requests..." 
           style="max-width:300px;" />

    <select id="statusFilter" class="form-select" style="max-width:200px;">
        <option value="">All Status</option>
        <option value="Active">Active</option>
        <option value="Inactive">Inactive</option>     
    </select>
</div>


<div class="table-responsive" style="margin-left:20px; margin-right:20px; margin-top:20px;border-radius:7px">
    <asp:GridView ID="gvRequests" runat="server"
    AutoGenerateColumns="False"
    DataKeyNames="Id"
    CssClass="table table-striped table-bordered table-hover align-middle"
    OnRowEditing="gvRequests_RowEditing"
    OnRowDeleting="gvRequests_RowDeleting"
    OnRowUpdating="gvRequests_RowUpdating"
    OnRowCancelingEdit="gvRequests_RowCancelingEdit">
    <Columns>

        <asp:BoundField DataField="Id" HeaderText="ID" ReadOnly="true" />

        <asp:TemplateField HeaderText="Service Code">
            <ItemTemplate>
                <%# Eval("ServiceCode") %>
            </ItemTemplate>
            <EditItemTemplate>
                <asp:TextBox ID="txtServiceCode" runat="server"
                    Text='<%# Bind("ServiceCode") %>' CssClass="form-control form-control-sm" />
            </EditItemTemplate>
        </asp:TemplateField>

        <asp:TemplateField HeaderText="Provider Code">
            <ItemTemplate>
                <%# Eval("ProviderCode") %>
            </ItemTemplate>
            <EditItemTemplate>
                <asp:TextBox ID="txtProviderCode" runat="server"
                    Text='<%# Bind("ProviderCode") %>' CssClass="form-control form-control-sm" />
            </EditItemTemplate>
        </asp:TemplateField>

        <asp:TemplateField HeaderText="Status">
            <ItemTemplate>
                <%# Convert.ToBoolean(Eval("IsEnabled")) ? "Active" : "Inactive" %>
            </ItemTemplate>
            <EditItemTemplate>
                <asp:DropDownList ID="ddlIsEnabled" runat="server" CssClass="form-select form-select-sm">
                    <asp:ListItem Value="true">Active</asp:ListItem>
                    <asp:ListItem Value="false">Inactive</asp:ListItem>
                </asp:DropDownList>
            </EditItemTemplate>
        </asp:TemplateField>

       
        <asp:CommandField ShowEditButton="true"  ShowDeleteButton="true"
            EditText="Edit"
            UpdateText="Save"
            CancelText="Cancel"
            DeleteText="Delete"
            ControlStyle-CssClass="btn btn-sm btn-primary" ControlStyle-BackColor="purple" />
        
    </Columns>
</asp:GridView>

</div>

<!-- JS for Search + Filter + Copy -->
<script>
    // Copy Button Click
    document.addEventListener("click", function (e) {
        const copyButton = e.target.closest(".copy-btn");
        if (copyButton) {
            const textToCopy = copyButton.getAttribute("data-text");
            navigator.clipboard.writeText(textToCopy).then(() => {
                alert("Copied!");
            });
        }
    });

    // Search Box Filter
    document.getElementById("searchBox").addEventListener("keyup", function () {
        var searchText = this.value.toLowerCase();
        var rows = document.querySelectorAll("#<%= gvRequests.ClientID %> tbody tr");

        rows.forEach(function (row) {
            var rowText = row.innerText.toLowerCase();
            row.style.display = rowText.includes(searchText) ? "" : "none";
        });
    });

    // Status Dropdown Filter
    document.getElementById("statusFilter").addEventListener("change", function () {
        var filterValue = this.value.toLowerCase();
        var rows = document.querySelectorAll("#<%= gvRequests.ClientID %> tbody tr");

        rows.forEach(function (row) {
            var statusCell = row.cells[3]?.innerText.toLowerCase(); // 4th column index
            row.style.display = filterValue === "" || statusCell === filterValue ? "" : "none";
        });
    });
</script>


</asp:Content>