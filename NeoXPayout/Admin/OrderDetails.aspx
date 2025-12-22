<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/NeoxAdmin.Master" AutoEventWireup="true" CodeBehind="OrderDetails.aspx.cs" Inherits="NeoXPayout.Admin.OrderDetails" %>
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
        <!-- Heading with margin -->
<h3 class="mt-4 mb-3 fw-bold" style="color:#2c3e50; font-family:'Segoe UI', Tahoma, sans-serif; margin-left:20px;">
    Order Details
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
        <option value="Pending">Pending</option>
        <option value="Completed">Completed</option>
        <option value="Rejected">Rejected</option>
    </select>
</div>

<div class="table-responsive" style="margin-left:20px; margin-right:20px; margin-top:20px;border-radius:7px">
    <asp:GridView ID="gvRequests" runat="server" AutoGenerateColumns="False" DataKeyNames="Id"
        CssClass="table table-striped table-bordered table-hover align-middle"
        OnRowCommand="gvRequests_RowCommand">
        <Columns>
            <asp:BoundField DataField="Id" HeaderText="ID" />
            <asp:BoundField DataField="ProductName" HeaderText="Name" />
            <asp:BoundField DataField="ProductPrice" HeaderText="Price" />           
            <asp:BoundField DataField="Quantity" HeaderText="Quantity" />
            <asp:BoundField DataField="Total" HeaderText="Total" />
            <asp:BoundField DataField="Address" HeaderText="Address" />
            <asp:BoundField DataField="OrderId" HeaderText="OrderId" />
            <asp:BoundField DataField="Status" HeaderText="Status" />
            <asp:BoundField DataField="OrderDate" HeaderText="Order Date" />
            <asp:TemplateField HeaderText="Update Status">
                <HeaderStyle />
                <ItemStyle />
                <ItemTemplate>
                    <div class="d-flex gap-2">
                        <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-select form-select-sm">
                            <asp:ListItem Value="Pending">Pending</asp:ListItem>
                            <asp:ListItem Value="Completed">Completed</asp:ListItem>
                            <asp:ListItem Value="Rejected">Rejected</asp:ListItem>
                        </asp:DropDownList>

                        <asp:Button ID="btnUpdate" runat="server" Text="Update" CommandName="UpdateStatus"
                            CommandArgument='<%# Eval("Id") %>' CssClass="btn btn-sm px-3" style="background-color:#6e007c; color:white" />
                    </div>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
</div>
<script>

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
            var statusCell = row.cells[7]?.innerText.toLowerCase(); // 4th column index
            row.style.display = filterValue === "" || statusCell === filterValue ? "" : "none";
        });
    });
</script>
</asp:Content>