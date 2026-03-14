<%@ Page Title="" Language="C#" MasterPageFile="~/Neox.Master" AutoEventWireup="true" CodeBehind="Pricing.aspx.cs" Inherits="NeoXPayout.Pricing" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
   <style>
.bg-purple{
    background:#6a0dad;
}

.card{
    border-radius:10px;
}

.table thead th{
    background:#212529;
    color:white;
    text-align:center;
    font-weight:600;
}

.table td{
    text-align:center;
    vertical-align:middle;
}

.table-hover tbody tr:hover{
    background:#f5f1ff;
}

.badge{
    font-size:12px;
    padding:6px 10px;
}

.share-value{
    color:#2e7d32;
    font-weight:600;
}

.table-responsive{
    max-height:600px;
}
  </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <hr />

<div class="container-fluid mt-3">

    <!-- Search Card -->
    <div class="card shadow-sm mb-3">
    <div class="card-body p-3">

        <div class="input-group">

            <span class="input-group-text text-white" style="background-color:purple">
                🔍 Search Commission
            </span>

            <input type="text"
                   id="filterInput"
                   class="form-control"
                   placeholder="Search service, operator, plan...">

        </div>

    </div>
</div>
   
    <!-- Table Card -->
    <div class="card shadow-sm">

     <div class="card-header d-flex justify-content-between align-items-center bg-purple ">
         <span class="fw-semibold text-purple">
            💰 Plan : <asp:Label ID="lblPlanName" runat="server"></asp:Label>
        </span>
    <span>Total Records: <b id="totalRecords">0</b></span>
</div>

        <div class="table-responsive">

            <table class="table table-hover table-bordered align-middle mb-0" id="marginTable">

                <thead class="table-dark sticky-top">

                    <tr>
                        <th>Sr</th>
                        <th>Plan</th>
                        <th>Service</th>
                        <th>Operator</th>
                        <th>From</th>
                        <th>To</th>
                        <th>Share</th>
                        <th>Type</th>
                    </tr>

                </thead>

                <tbody>

                    <asp:Repeater ID="rptMargin" runat="server">

                        <ItemTemplate>

                            <tr>

                                <td><%# Container.ItemIndex + 1 %></td>

                                <td>
                                    <span class="badge bg-primary">
                                        <%# Eval("PlanName") %>
                                    </span>
                                </td>

                                <td><%# Eval("ServiceId") %></td>

                                <td>
                                    <%# Eval("OperatorId") %>
                                </td>

                                <td>
                                    ₹ <%# Eval("FromAmount") %>
                                </td>

                                <td>
                                    ₹ <%# Eval("ToAmount") %>
                                </td>

                            <td class="share-value">
                                <%# Eval("CommissionType").ToString()=="2" 
                                    ? Eval("CommissionValue") + " %" 
                                    : "₹ " + Eval("CommissionValue") %>
                            </td>

                                <td>
                                    <span class="badge <%# Convert.ToInt32(Eval("CommissionType")) == 1 ? "bg-success" : "bg-warning text-dark" %>">
                                        <%# Convert.ToInt32(Eval("CommissionType")) == 1 ? "FLAT" : "PERCENT" %>
                                    </span>
                                </td>

                            </tr>

                        </ItemTemplate>

                    </asp:Repeater>

                </tbody>

            </table>

        </div>

        <!-- Pagination -->
        <div class="card-footer bg-white">
            <nav class="d-flex justify-content-end">
                <ul class="pagination pagination-sm mb-0" id="pagination"></ul>
            </nav>
        </div>

    </div>

</div>

  <!-- Bootstrap JS -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        const pageSize = 10;
        let currentPage = 1;
        let rows = [];

        function renderTable() {
            const table = document.getElementById("marginTable");
            rows = Array.from(table.querySelectorAll("tbody tr"));

            applyFilter(); 
        }

        function renderPagination(filteredRows) {
            const totalPages = Math.ceil(filteredRows.length / pageSize);
            const pagination = document.getElementById("pagination");
            pagination.innerHTML = "";

            pagination.innerHTML += `
              <li class="page-item ${currentPage === 1 ? "disabled" : ""}">
                <a class="page-link" href="#" onclick="changePage(${currentPage - 1})">Previous</a>
              </li>
            `;
   
            for (let i = 1; i <= totalPages; i++) {
                pagination.innerHTML += `
                <li class="page-item ${currentPage === i ? "active" : ""}">
                  <a class="page-link" href="#" onclick="changePage(${i})">${i}</a>
                </li>
              `;
            }

            pagination.innerHTML += `
              <li class="page-item ${currentPage === totalPages ? "disabled" : ""}">
                <a class="page-link" href="#" onclick="changePage(${currentPage + 1})">Next</a>
              </li>
            `;
        }

        function changePage(page) {
            const totalPages = Math.ceil(rows.length / pageSize);
            if (page < 1 || page > totalPages) return;
            currentPage = page;
            applyFilter(); 
        }

        function applyFilter() {
            const keyword = document.getElementById("filterInput").value.toLowerCase();
            const filteredRows = rows.filter(row =>
                row.innerText.toLowerCase().includes(keyword)
            );

            rows.forEach(row => row.style.display = "none");

           
            const start = (currentPage - 1) * pageSize;
            const end = start + pageSize;
            filteredRows.slice(start, end).forEach(row => row.style.display = "");

            document.getElementById("totalRecords").innerText = filteredRows.length;

            renderPagination(filteredRows);
        }

        document.getElementById("filterInput").addEventListener("keyup", function () {
            currentPage = 1;
            applyFilter();
        });

        document.addEventListener("DOMContentLoaded", renderTable);
    </script>

</asp:Content>
