<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/NeoxAdmin.Master" AutoEventWireup="true" CodeBehind="UserLog.aspx.cs" Inherits="NeoXPayout.Admin.UserLog" %>
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
.pagination-container {
    padding:10px;
    text-align:center;
}

.pagination-container table {
    display:inline-block;
}

.pagination-container a, 
.pagination-container span {
    margin:2px;
    padding:6px 12px;
    border:1px solid #dee2e6;
    border-radius:5px;
    text-decoration:none;
    color:#0d6efd;
    font-weight:500;
}

.pagination-container span {  /* active page */
    background:#0d6efd;
    color:white;
}
.pagination-container a:hover {
    background:#e9ecef;
}

</style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

 <!-- Heading -->
<h3 class="mt-4 mb-3 fw-bold" 
    style="color:#2c3e50; font-family:'Segoe UI', Tahoma, sans-serif; margin-left:20px;">
    User Logins
</h3>
<asp:Label ID="lblMessage" runat="server" 
    CssClass="ms-3 mb-3 d-block fw-semibold" 
    ForeColor="Gray">
</asp:Label>

<div class="d-flex flex-wrap gap-3 align-items-center mb-3" style="margin-left:20px; margin-right:20px;">
    
    <input type="text" id="searchBox" class="form-control" 
           placeholder="🔍 Search requests..." style="max-width:200px;" />

    <input type="date" id="fromDate" class="form-control" style="max-width:170px;" />

<asp:LinkButton ID="btnSearchDate" runat="server" CssClass="btn"
    Text="Filter Date" OnClick="btnSearchDate_Click" style="background-color:purple; color:white" />
    <asp:LinkButton ID="btnClearDate" runat="server" CssClass="btn btn-secondary"
    Text="All" OnClick="btnClearDate_Click" />

</div>



<div class="table-responsive" style="margin-left:20px; margin-right:20px; margin-top:20px;border-radius:7px">
<asp:GridView ID="gvRequests" runat="server" AutoGenerateColumns="False" DataKeyNames="ID"
    CssClass="table table-striped table-bordered table-hover align-middle"
    AllowPaging="True" PageSize="10"
    OnPageIndexChanging="gvRequests_PageIndexChanging"
      OnRowDataBound="gvRequests_RowDataBound"
    PagerStyle-CssClass="pagination-container"
    PagerSettings-Mode="Numeric" PagerSettings-Position="Bottom">

        <Columns>
            <asp:BoundField DataField="Id" HeaderText="ID" />
            <asp:BoundField DataField="UserID" HeaderText="Mobile No." />
            <asp:BoundField DataField="IPAddress" HeaderText="IPAddress" />
            <asp:BoundField DataField="CreatedAt" HeaderText="CreatedAt" />
            <asp:BoundField DataField="UserType" HeaderText="Type" />

        </Columns>
    </asp:GridView>
</div>


<script>
    var gridId = "<%= gvRequests.ClientID %>";
    var gridSelector = "#" + gridId + " tbody tr";

    document.getElementById("searchBox").addEventListener("keyup", function () {
        var searchText = this.value.toLowerCase();
        var rows = document.querySelectorAll(gridSelector);

        rows.forEach(function (row) {
            var rowText = row.innerText.toLowerCase();
            row.style.display = rowText.includes(searchText) ? "" : "none";
        });
    });
</script>



</asp:Content>

