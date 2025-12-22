<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/NeoxAdmin.Master" AutoEventWireup="true" CodeBehind="APICat.aspx.cs" Inherits="NeoXPayout.Admin.APICat" %>
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
.btn-purple 
{
  background-color: #6e007c;
  color: #fff;
  border: none;
}
.btn-purple:hover 
{
  background-color: #550063;
  color: #fff;
}
.text-purple 
{
  color: #6e007c;
}

</style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <!-- Heading with margin -->
<h3 class="mt-4 mb-3 fw-bold" style="color:#2c3e50; font-family:'Segoe UI', Tahoma, sans-serif; margin-left:20px;">
  ACTIVE API CATEGORY
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

<div class="table-responsive" style="margin-left:20px; margin-right:20px; margin-top:20px;border-radius:7px; overflow-x:auto; ">
    <asp:GridView ID="gvRequests" runat="server" AutoGenerateColumns="False" DataKeyNames="Id"
        CssClass="table table-striped table-bordered table-hover align-middle"
        OnRowCommand="gvRequests_RowCommand">
        <Columns>
            <asp:BoundField DataField="Id" HeaderText="Id" />
            <asp:BoundField DataField="Category" HeaderText="Api Category" />           
            <asp:BoundField DataField="Status" HeaderText="Status" />

            <asp:TemplateField HeaderText="Update Status">
                <HeaderStyle />
                <ItemStyle />
                <ItemTemplate>
                    <div class="d-flex gap-2">
                        <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-select form-select-sm">
                            <asp:ListItem Value="Active">Active</asp:ListItem>
                            <asp:ListItem Value="Inactive">Inactive</asp:ListItem>
                           
                        </asp:DropDownList>

                        <asp:Button ID="btnUpdate" runat="server" Text="Update" CommandName="UpdateStatus"
                            CommandArgument='<%# Eval("Id") %>' CssClass="btn btn-sm px-3" style="background-color:#6e007c; color:white" />
                    </div>
                </ItemTemplate>
            </asp:TemplateField>
             <asp:TemplateField HeaderText="Actions">
                <ItemTemplate>
                    <div class="d-flex gap-2">
                        <asp:Button ID="btnEdit" runat="server" Text="Edit" 
                            CommandName="EditRow" 
                            CommandArgument='<%# Eval("Id") %>'
                            CssClass="btn btn-warning btn-sm" />

                        <asp:Button ID="btnDelete" runat="server" Text="Delete" 
                            CommandName="DeleteRow" 
                            CommandArgument='<%# Eval("Id") %>'
                            CssClass="btn btn-danger btn-sm" />
                    </div>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
</div>


<div class="modal fade" id="EditAPI" tabindex="-1" aria-labelledby="EditAPILabel" aria-hidden="true" data-bs-backdrop="static" data-bs-keyboard="false">
  <div class="modal-dialog modal-dialog-centered modal-lg"> <!-- wider modal -->
    <div class="modal-content shadow-lg rounded-3">

      <!-- 🔹 Modal Header with Title + Close Button -->
      <div class="modal-header bg-light border-bottom">
        <h5 class="modal-title fw-bold text-purple" id="EditAPILabel">
          <i class="bi bi-pencil-square me-2"></i> Edit API
        </h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>

      <!-- 🔹 Modal Body -->
      <div class="modal-body">
        <asp:HiddenField runat="server" ID="hdnAPIId" />
        <asp:Label runat="server" ID="Label1" CssClass="text-success"></asp:Label>

        <div class="row g-3">
          <div class="col-md-12">
            <label class="form-label fw-semibold">API Category</label>
            <asp:TextBox ID="txtCategory" CssClass="form-control" runat="server" Placeholder="Enter API Name"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvApiName" runat="server" ControlToValidate="txtCategory" ValidationGroup="EditApi" ErrorMessage="API Name is required" CssClass="text-danger small" Display="Dynamic" />
          </div>

        </div>
      </div>

      <!-- 🔹 Modal Footer -->
      <div class="modal-footer d-flex justify-content-between">
        <asp:LinkButton ID="btnEdit" runat="server" CssClass="btn btn-purple" ValidationGroup="EditApi" OnClick="btnEdit_Click">
          <i class="bi bi-check-circle me-1"></i> Update
        </asp:LinkButton>
        <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
          <i class="bi bi-x-circle me-1"></i> Cancel
        </button>
      </div>

    </div>
  </div>
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
            var statusCell = row.cells[2]?.innerText.toLowerCase(); // 3th column index
            row.style.display = filterValue === "" || statusCell === filterValue ? "" : "none";
        });
    });
</script>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</asp:Content>
