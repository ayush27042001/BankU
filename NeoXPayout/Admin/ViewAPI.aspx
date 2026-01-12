<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/NeoxAdmin.Master" AutoEventWireup="true" CodeBehind="ViewAPI.aspx.cs" Inherits="NeoXPayout.Admin.ViewAPI" %>
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
  ACTIVE API 
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

    <asp:DropDownList ID="APICategoryFilter" style="max-width:200px;" CssClass="form-select" runat="server">

    </asp:DropDownList>



</div>

<div class="table-responsive" style="margin-left:20px; margin-right:20px; margin-top:20px;border-radius:7px; overflow-x:auto; ">
    <asp:GridView ID="gvRequests" runat="server" AutoGenerateColumns="False" DataKeyNames="Id"
        CssClass="table table-striped table-bordered table-hover align-middle"
        OnRowCommand="gvRequests_RowCommand">
        <Columns>
            <asp:BoundField DataField="Id" HeaderText="Id" />
            <asp:BoundField DataField="ApiName" HeaderText="Api Name" />
            <asp:BoundField DataField="ApiDesc" HeaderText="Description" />
            <asp:BoundField DataField="Amount" HeaderText="Amount" />
            <asp:BoundField DataField="Category" HeaderText="Category" />
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
            <label class="form-label fw-semibold">API Name</label>
            <asp:TextBox ID="txtAPIname" CssClass="form-control" runat="server" Placeholder="Enter API Name"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvApiName" runat="server" ControlToValidate="txtAPIname" ValidationGroup="EditApi" ErrorMessage="API Name is required" CssClass="text-danger small" Display="Dynamic" />
          </div>

          <div class="col-md-12">
            <label class="form-label fw-semibold">API Category</label>
            <asp:DropDownList ID="ddlCategory" CssClass="form-select" runat="server"></asp:DropDownList>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="ddlCategory" ValidationGroup="EditApi" InitialValue="" ErrorMessage="API Category is required" CssClass="text-danger small" Display="Dynamic" />
          </div>

          <div class="col-md-12">
            <label class="form-label fw-semibold">API Description</label>
            <asp:TextBox ID="txtDisc" CssClass="form-control" runat="server" TextMode="MultiLine" Rows="3" Placeholder="Enter API Description"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvApiDesc" runat="server" ControlToValidate="txtDisc" ValidationGroup="EditApi" ErrorMessage="API Description is required" CssClass="text-danger small" Display="Dynamic" />
          </div>

          <div class="col-md-12">
            <label class="form-label fw-semibold">API Icon <small class="text-muted">(less than 10 kb, 60×60px)</small></label>
            <asp:FileUpload ID="fuApiIcon" runat="server" CssClass="form-control" />

             <!-- 🔹 Show existing icon -->
             <asp:Image ID="imgApiIcon" runat="server" CssClass="img-thumbnail mb-2" Width="60" Height="60" />

            <asp:Label ID="lblFileError" runat="server" ForeColor="Red"></asp:Label>
           <%-- <asp:RequiredFieldValidator ID="rfvApiIcon" runat="server" ControlToValidate="fuApiIcon" ValidationGroup="EditApi" ErrorMessage="API Icon is required" CssClass="text-danger small" Display="Dynamic" />--%>
          </div>

          <div class="col-md-12">
            <label class="form-label fw-semibold">API Price</label>
            <asp:TextBox ID="txtPrice" CssClass="form-control" runat="server" Placeholder="Enter API Price"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvApiPrice" runat="server" ControlToValidate="txtPrice" ValidationGroup="EditApi" ErrorMessage="API Price is required" CssClass="text-danger small" Display="Dynamic" />
            <asp:RegularExpressionValidator ID="revApiPrice" runat="server" ControlToValidate="txtPrice" ValidationGroup="EditApi" ValidationExpression="^\d+(\.\d{1,2})?$" ErrorMessage="Enter a valid price (e.g., 99.99)" CssClass="text-danger small" Display="Dynamic" />
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
    document.addEventListener("DOMContentLoaded", function () {

        const gridSelector = "#<%= gvRequests.ClientID %>";

    function applyFilters() {
        const searchText = (document.getElementById("searchBox")?.value || "").toLowerCase();
        const statusValue = (document.getElementById("statusFilter")?.value || "").toLowerCase();
        const categoryValue = (document.getElementById("<%= APICategoryFilter.ClientID %>")?.value || "").toLowerCase();

        const rows = document.querySelectorAll(gridSelector + " tr");

        rows.forEach(function (row) {

            if (row.querySelectorAll("td").length === 0) {
                row.style.display = "";
                return;
            }

            const rowText = row.innerText.toLowerCase();
            const statusCell = row.cells[5]?.innerText.trim().toLowerCase() || "";
            const categoryCell = row.cells[4]?.innerText.trim().toLowerCase() || "";

            const searchMatch = rowText.includes(searchText);
            const statusMatch = statusValue === "" || statusCell === statusValue;
            const categoryMatch = categoryValue === "" || categoryCell === categoryValue;

            row.style.display = (searchMatch && statusMatch && categoryMatch) ? "" : "none";
        });
    }

    document.getElementById("searchBox")?.addEventListener("keyup", applyFilters);

    document.getElementById("statusFilter")?.addEventListener("change", applyFilters);

    document.getElementById("<%= APICategoryFilter.ClientID %>")?.addEventListener("change", applyFilters);
});
</script>

	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</asp:Content>