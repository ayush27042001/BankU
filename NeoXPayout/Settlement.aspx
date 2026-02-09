<%@ Page Title="" Language="C#" MasterPageFile="~/Neox.Master" AutoEventWireup="true" CodeBehind="Settlement.aspx.cs" Inherits="NeoXPayout.Settlement" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .modern-thead {
    background: #F5F6FA;
    color: #6B7280;
}

.modern-table tbody tr {
    border-bottom: 1px solid #EEF0F5;
    transition: all 0.2s ease;
}

.modern-table tbody tr:hover {
    background: #F9FAFB;
   
}

.row-selectable {
    cursor: pointer;
}

.badge {
    font-size: 0.75rem;
    padding: 6px 12px;
}

.font-monospace {
    font-family: ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, monospace;
}

    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
  <hr />

<!-- start: page body area -->
        <div class="px-xl-5 px-lg-4 px-3 py-3 page-body">
            <div class="row align-items-center mb-3">
                <div class="col-md-6">
                    <h5 class="mb-0 fw-semibold">Statement History</h5>
                    <small class="text-muted">View your Statement details</small>
                </div>
                <div class="col-md-6 text-end">
                    <button class="btn btn-sm"
                            style="background-color:purple;color:white"
                            onclick="downloadTable()">
                        ⬇ Download CSV
                    </button>
                </div>
            </div>
                    <div class="row">
                         <div class="col-12">
                              <div class="border p-4 rounded-2 rounded-4">
                                   <div class="calendar-tab pb-4" style="--dynamic-color: var(--primary-color)">
                                        <div class="row">
                                             <div class="col-md-2 ms-0">
                                               <input id="searchBox" type="text"   onkeydown="if(event.key === 'Enter'){ event.preventDefault(); }"  class="form-control " placeholder="Search Keyword" style="max-width: 200px;" />
                                           </div>
                                            <div class="col-md-2">
                                                <asp:TextBox ID="txtfrom" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                                            </div>
                                            <div class="col-md-1">
                                                <asp:LinkButton ID="LinkButton1" runat="server" class="btn" style="background-color:purple; color: white" OnClick="LinkButton1_Click">Search</asp:LinkButton>
                                            </div>
                                             <div class="col-md-2">
                                                <asp:LinkButton ID="btnReset" runat="server" CssClass="btn btn-secondary"
                                                    OnClick="btnReset_Click">Reset</asp:LinkButton>
                                            </div>

                                            <asp:Label runat="server" CssClass="text-danger" ID="Label1"></asp:Label>
                                        </div>
                                   </div>
                                  <div class="table-responsive rounded-4 shadow-sm bg-white">
    <table id="payoutTable"
           class="table table-borderless align-middle mb-0 modern-table w-100">

        <thead class="modern-thead">
            <tr class="small text-uppercase fw-semibold">
                <th>#</th>
                <th>Service</th>
                <th>Operator</th>
                <th>Amount</th>
                <th>Account No</th>
                <th>Txn ID</th>
                <th>Ref ID</th>
                <th>Status</th>
                <th>Date</th>
            </tr>
        </thead>

        <tbody>
            <asp:Repeater runat="server" ID="rptProduct">
                <ItemTemplate>
                    <tr class="row-selectable">
                        <td class="text-muted"><%# Container.ItemIndex + 1 %></td>

                        <td class="fw-medium">
                            <%# Eval("ServiceName") %>
                        </td>

                        <td class="text-muted">
                            <%# Eval("OperatorName") %>
                        </td>

                        <td class="fw-semibold text-primary">
                            ₹<%# string.Format("{0:n2}", Eval("Amount")) %>
                        </td>

                        <td class="font-monospace">
                            <%# Eval("AccountNo") %>
                        </td>

                        <td class="font-monospace text-muted">
                            <%# Eval("TransactionID") %>
                        </td>

                        <td class="font-monospace text-muted">
                            <%# Eval("BRID") %>
                        </td>

                        <td>
                            <span class="badge rounded-pill
                                <%# Eval("Status").ToString() == "SUCCESS" ? "bg-success-subtle text-success" :
                                    Eval("Status").ToString() == "FAILED" ? "bg-danger-subtle text-danger" :
                                    "bg-warning-subtle text-warning" %>">
                                <%# Eval("Status") %>
                            </span>
                        </td>

                        <td data-order='<%# Eval("TxnDate","{0:yyyyMMdd}") %>'>
                            <%# Eval("TxnDate","{0:dd MMM yyyy}") %>
                        </td>
                    </tr>
                </ItemTemplate>
            </asp:Repeater>
        </tbody>
    </table>
</div>

                                   <nav class="mt-3">
                    <ul class="pagination justify-content-end" id="payoutPagination"></ul>
                </nav>
                              </div>
                         </div>
                    </div>

               </div>
<script>
    document.getElementById("searchBox").addEventListener("keydown", function (e) {
        if (e.key === "Enter") {
            e.preventDefault(); // stop postback
        }
    });
    const rowsPerPage = 10;
    const table = document.getElementById("payoutTable");
    const tbody = table.querySelector("tbody");
    let allRows = Array.from(tbody.querySelectorAll("tr"));
    const pagination = document.getElementById("payoutPagination");

    let filteredRows = [...allRows];
    let currentPage = 1;

    function showPage(page) {
        const totalPages = Math.ceil(filteredRows.length / rowsPerPage);
        if (page < 1 || page > totalPages) return;

        currentPage = page;

        allRows.forEach(r => r.style.display = "none");

        filteredRows.forEach((row, index) => {
            if (
                index >= (page - 1) * rowsPerPage &&
                index < page * rowsPerPage
            ) {
                row.style.display = "";
            }
        });

        updatePagination(totalPages);
    }

    function updatePagination(totalPages) {
        pagination.innerHTML = "";

        const maxVisiblePages = 3;

        const createBtn = (text, page, disabled = false, active = false) => {
            const li = document.createElement("li");
            li.className = "page-item";
            if (disabled) li.classList.add("disabled");
            if (active) li.classList.add("active");

            const a = document.createElement("a");
            a.className = "page-link";
            a.href = "#";
            a.innerText = text;

            a.onclick = e => {
                e.preventDefault();
                if (!disabled && page) showPage(page);
            };

            li.appendChild(a);
            return li;
        };

        // Prev
        pagination.appendChild(
            createBtn("Prev", currentPage - 1, currentPage === 1)
        );

        // Calculate window
        let start = Math.max(1, currentPage - 1);
        let end = Math.min(totalPages, start + maxVisiblePages - 1);

        if (end - start < maxVisiblePages - 1) {
            start = Math.max(1, end - maxVisiblePages + 1);
        }

        // First page + dots
        if (start > 1) {
            pagination.appendChild(createBtn(1, 1));
            pagination.appendChild(createBtn("...", null, true));
        }

        // Page numbers (max 3)
        for (let i = start; i <= end; i++) {
            pagination.appendChild(
                createBtn(i, i, false, i === currentPage)
            );
        }

        // Last page + dots
        if (end < totalPages) {
            pagination.appendChild(createBtn("...", null, true));
            pagination.appendChild(createBtn(totalPages, totalPages));
        }

        // Next
        pagination.appendChild(
            createBtn("Next", currentPage + 1, currentPage === totalPages)
        );
    }

    // 🔍 SEARCH FILTER
    function applyFilters() {
        const searchValue = document
            .getElementById("searchBox")
            .value
            .toLowerCase();

        filteredRows = allRows.filter(row =>
            row.innerText.toLowerCase().includes(searchValue)
        );

        currentPage = 1;
        showPage(currentPage);
    }

    document
        .getElementById("searchBox")
        .addEventListener("input", applyFilters);

    // Initial load
    showPage(1);



        // --- Download CSV ---
        function downloadTable() {
            let table = document.getElementById("payoutTable");
            let rows = table.querySelectorAll("tr");
            let csv = [];

            rows.forEach(row => {
                if (row.classList.contains("details-row")) return;
                let cols = row.querySelectorAll("th, td");
                let rowData = [];
                cols.forEach(col => {
                    let text = col.innerText.replace(/\n/g, " ").trim();
                    if (text.includes(",") || text.includes('"')) {
                        text = '"' + text.replace(/"/g, '""') + '"';
                    }
                    rowData.push(text);
                });
                csv.push(rowData.join(","));
            });

            let csvContent = "data:text/csv;charset=utf-8," + encodeURIComponent(csv.join("\n"));
            let a = document.createElement("a");
            a.href = csvContent;
            a.download = "BankU_Settlement_Report.csv";
            document.body.appendChild(a);
            a.click();
            document.body.removeChild(a);
        }
</script>
</asp:Content>

