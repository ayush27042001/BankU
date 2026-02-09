<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/NeoxAdmin.Master" AutoEventWireup="true" CodeBehind="rmManagement.aspx.cs" Inherits="NeoXPayout.Admin.rmManagement" %>
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
   All Services
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
        <option value="Deactive">Deactive</option>
       
    </select>
</div>

<div class="table-responsive" style="margin-left:20px; margin-right:20px; margin-top:20px;border-radius:7px">
    <asp:GridView ID="gvRequests" runat="server" AutoGenerateColumns="False" DataKeyNames="RegistrationId" OnRowDataBound="gvRequests_RowDataBound"
        CssClass="table table-striped table-bordered table-hover align-middle"
        OnRowCommand="gvRequests_RowCommand">
        <Columns>
            <asp:BoundField DataField="RegistrationId" HeaderText="ID" />                     
            <asp:BoundField DataField="FullName" HeaderText="FullName" />  
            <asp:BoundField DataField="MobileNo" HeaderText="MobileNo" />
             <asp:BoundField DataField="RmId" HeaderText="RmId" />
            <asp:TemplateField HeaderText="Update Status">
                <HeaderStyle />
                <ItemStyle />
                <ItemTemplate>
                    <div class="d-flex gap-2">
                      <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-select form-select-sm">
                                               
                        </asp:DropDownList>       

                        <asp:Button ID="btnUpdate" runat="server" Text="Update" CommandName="UpdateStatus"
                            CommandArgument='<%# Eval("RegistrationId") %>' CssClass="btn btn-sm px-3" style="background-color:#6e007c; color:white" />
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
            var statusCell = row.cells[1]?.innerText.toLowerCase(); // 4th column index
            row.style.display = filterValue === "" || statusCell === filterValue ? "" : "none";
        });
    });
</script>
</asp:Content>
