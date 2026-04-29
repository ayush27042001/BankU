<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/NeoxAdmin.Master" AutoEventWireup="true" CodeBehind="KycApprovalLog.aspx.cs" Inherits="NeoXPayout.Admin.KycApprovalLog" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
.banku-header{
    background: linear-gradient(135deg,#4b0082,#7b2cbf);
    border-radius: 18px 18px 0 0;
    padding:18px;
}

.banku-search{
    border-radius:12px;
    padding:12px;
}

.banku-table{
    border-collapse: separate;
    border-spacing: 0 12px;
}

.banku-table thead th{
    background:#f8f9fa;
    padding:15px;
    font-weight:600;
    border:none;
}

.banku-table tbody tr{
    background:white;
    box-shadow:0 4px 10px rgba(0,0,0,.04);
    border-radius:12px;
    transition:.3s;
}

.banku-table tbody tr:hover{
    transform:translateY(-2px);
}

.banku-table td{
    padding:18px;
    border:none;
    vertical-align:middle;
}

.pagination li{
    cursor:pointer;
}
.pagination .page-item.active .page-link {
    background: #4f46e5;
    border-color: #4f46e5;
    color: #fff;
    font-weight: bold;
}

.pagination .page-link {
    border-radius: 8px;
    margin: 0 4px;
    cursor: pointer;
    transition: 0.2s;
}

.pagination .page-link:hover {
    background: #eef2ff;
}

.pagination .page-item.disabled .page-link {
    opacity: 0.5;
    pointer-events: none;
}
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
<div class="container-fluid mt-4">

    <div class="card shadow-lg border-0 rounded-4">

        <div class="card-header banku-header">
            <h4 class="mb-0 text-white">KYC Approval Logs</h4>
        </div>

        <div class="card-body">

            <div class="row mb-3">
                <div class="col-md-4">
                    <input type="text" id="searchInput" class="form-control banku-search" placeholder="Search anything..." />
                </div>
            </div>

            <div class="table-responsive">

                <table class="table banku-table align-middle" id="logTable">

                    <thead>
                        <tr>
                            <th>#</th>
                            <th>User ID</th>
                            <th>Admin Name</th>
                             <th>Admin Id</th>
                            <th>Old Status</th>
                            <th>New Status</th>
                            <th>Approved Date</th>
                        </tr>
                    </thead>

                    <tbody>
                        <asp:Repeater ID="rptLogs" runat="server">
                            <ItemTemplate>
                                <tr>
                                    <td><%# Container.ItemIndex + 1 %></td>
                                    <td><%# Eval("RegistrationId") %></td>
                                    <td><%# Eval("AdminName") %></td>
                                     <td><%# Eval("AdminId") %></td>
                                    <td>
                                        <span class="badge bg-secondary">
                                            <%# Eval("OldStatus") %>
                                        </span>
                                    </td>
                                    <td>
                                       <span class='badge 
                                        <%# Eval("NewStatus").ToString()=="Approved" ? "bg-success" :
                                            Eval("NewStatus").ToString()=="Rejected" ? "bg-danger" :
                                            Eval("NewStatus").ToString()=="Review" ? "bg-warning text-dark" :
                                            "bg-primary" %>'>
                                            <%# Eval("NewStatus") %>
                                        </span>
                                    </td>
                                    <td><%# Eval("ApprovedDate","{0:dd MMM yyyy hh:mm tt}") %></td>
                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>
                    </tbody>

                </table>

            </div>

            <nav>
                <ul class="pagination justify-content-end mt-3" id="pagination"></ul>
            </nav>

        </div>

    </div>

</div>

<script>
document.addEventListener("DOMContentLoaded", function () {

    const rowsPerPage = 10;
    const table = document.getElementById("logTable");
    const rows = table.querySelectorAll("tbody tr");
    const pagination = document.getElementById("pagination");
    const searchInput = document.getElementById("searchInput");

    let currentPage = 1;

    function displayRows() {

        let filteredRows = Array.from(rows).filter(row =>
            row.innerText.toLowerCase().includes(searchInput.value.toLowerCase())
        );

        rows.forEach(row => row.style.display = "none");

        filteredRows.forEach((row, index) => {
            if (index >= (currentPage - 1) * rowsPerPage &&
                index < currentPage * rowsPerPage)
                row.style.display = "";
        });

        setupPagination(filteredRows.length);
    }

    function setupPagination(totalRows) {

        pagination.innerHTML = "";

        let pageCount = Math.ceil(totalRows / rowsPerPage);

        for (let i = 1; i <= pageCount; i++) {

            let li = document.createElement("li");
            li.classList.add("page-item");

            li.innerHTML =
                `<a class="page-link">${i}</a>`;

            li.onclick = function () {
                currentPage = i;
                displayRows();
            };

            pagination.appendChild(li);
        }
    }

    searchInput.addEventListener("keyup", function () {
        currentPage = 1;
        displayRows();
    });

    displayRows();

});
    document.addEventListener("DOMContentLoaded", function () {

        const rowsPerPage = 10;
        const table = document.getElementById("logTable");
        const rows = table.querySelectorAll("tbody tr");
        const pagination = document.getElementById("pagination");
        const searchInput = document.getElementById("searchInput");

        let currentPage = 1;

        function getFilteredRows() {
            return Array.from(rows).filter(row =>
                row.innerText.toLowerCase().includes(searchInput.value.toLowerCase())
            );
        }

        function displayRows() {

            const filteredRows = getFilteredRows();

            rows.forEach(row => row.style.display = "none");

            filteredRows.forEach((row, index) => {
                if (index >= (currentPage - 1) * rowsPerPage &&
                    index < currentPage * rowsPerPage)
                    row.style.display = "";
            });

            setupPagination(filteredRows.length);
        }

        function setupPagination(totalRows) {

            pagination.innerHTML = "";
            let pageCount = Math.ceil(totalRows / rowsPerPage);

            if (pageCount === 0) return;

            let prev = document.createElement("li");
            prev.className = "page-item " + (currentPage === 1 ? "disabled" : "");
            prev.innerHTML = `<a class="page-link">«</a>`;
            prev.onclick = () => {
                if (currentPage > 1) {
                    currentPage--;
                    displayRows();
                }
            };
            pagination.appendChild(prev);

            let start = Math.max(1, currentPage - 1);
            let end = Math.min(pageCount, start + 2);

            if (end - start < 2) {
                start = Math.max(1, end - 2);
            }

            for (let i = start; i <= end; i++) {

                let li = document.createElement("li");
                li.className = "page-item " + (i === currentPage ? "active" : "");

                li.innerHTML = `<a class="page-link">${i}</a>`;

                li.onclick = function () {
                    currentPage = i;
                    displayRows();
                };

                pagination.appendChild(li);
            }
            let next = document.createElement("li");
            next.className = "page-item " + (currentPage === pageCount ? "disabled" : "");
            next.innerHTML = `<a class="page-link">»</a>`;
            next.onclick = () => {
                if (currentPage < pageCount) {
                    currentPage++;
                    displayRows();
                }
            };
            pagination.appendChild(next);
        }

        searchInput.addEventListener("keyup", function () {
            currentPage = 1;
            displayRows();
        });

        displayRows();
    });
</script>

</asp:Content>
