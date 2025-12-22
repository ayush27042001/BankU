<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/NeoxAdmin.Master" AutoEventWireup="true" CodeBehind="Margin.aspx.cs" Inherits="NeoXPayout.Admin.Margin" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
   <style>
    /* Gradient Header Purple + Orange */
    .header-bar {
      background: Purple;color:#fff;
      color: #fff;
      padding: 10px;
      font-weight: 600;
      border-radius: 8px 8px 0 0;
    }
    .table-card {
      border: 1px solid #ddd;
      border-radius: 8px;
      overflow: hidden;
    }
    .table thead th {
      background: Purple;color:#fff;
      color: #fff;
      margin-top:20px;
      text-align: center;
      font-weight: 600;
      white-space: nowrap;   
    }
    .table td {
      white-space: nowrap;   
      text-align: center;
    }
    .table-responsive {
      overflow-x: auto;  
    }
    .form-control {
      text-align: center;
      min-width: 100px; 
    }
    .btn-edit {
      background: purple;color:#fff;
      color: #fff;
      border-radius: 5px;
      border: none;
      padding: 5px 10px;
    }
    .btn-edit:hover {
      opacity: 0.9;
    }
  </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <hr />

<div class="p-3 bg-light">
 
  <div class="mb-3">
    <div class="header-bar d-flex align-items-center">
      <span class="me-2">🔍</span> Filter
    </div>
    <input type="text" id="filterInput" class="form-control mt-2" placeholder="Type a keyword...">
  </div>


  <div class="table-card">
    <div class="header-bar">
      Manage Margin (Total Records: <span id="totalRecords">54</span>)
    </div>
    <div class="table-responsive">
      <table class="table table-bordered align-middle mb-0" id="marginTable">
        <thead>
          <tr>
            <th>Sr No</th>
            <th>Service Name</th>
            <th>Operator Name</th>
            <th>Distributor Share</th>
            <th>Retailer Share</th>
            <th>Commission Type</th>
            <th>Update</th>
               <th>Delete</th>
          </tr>
        </thead>
        <tbody>
          <asp:Repeater ID="rptMargin" runat="server" OnItemCommand="rptMargin_ItemCommand">
            <ItemTemplate>
              <tr>
                <td><%# Container.ItemIndex + 1 %></td>
                <td><%# Eval("ServiceName") %></td>
                <td><%# Eval("OperatorName") %></td>
                <td>
                  <asp:TextBox ID="txtIPShare" runat="server" Text='<%# Eval("IPShare") %>' CssClass="form-control"></asp:TextBox>
                </td>
                <td>
                  <asp:TextBox ID="txtWLShare" runat="server" Text='<%# Eval("WLShare") %>' CssClass="form-control"></asp:TextBox>
                </td>
                <td>
                  <asp:TextBox ID="txtCommType" runat="server" Text='<%# Eval("CommissionType") %>' CssClass="form-control"></asp:TextBox>
                </td>
                <td class="text-center">
                  <asp:Button ID="btnUpdate" runat="server" CommandName="UpdateMargin" CommandArgument='<%# Eval("Id") %>' Text="✏" />
                </td>
                <td class="text-center">
                <asp:LinkButton 
                    runat="server" 
                    ID="btnDelete" 
                    CssClass="btn"
                    Style="background-color:purple; color:white"
                    CommandName="DeleteMargin" 
                    CommandArgument='<%# Eval("Id") %>' 
                    Text="🗑" 
                    OnClientClick="return confirm('Are you sure you want to delete this margin?');">
                </asp:LinkButton>
            </td>

              </tr>
            </ItemTemplate>
          </asp:Repeater>
        </tbody>
      </table>
    </div>
    <!-- Pagination -->
    <div class="d-flex justify-content-end p-2">
      <nav>
        <ul class="pagination pagination-sm mb-0" id="pagination">
          <!-- JS se buttons update honge -->
        </ul>
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

            applyFilter(); // initial filter (no keyword)
        }

        function renderPagination(filteredRows) {
            const totalPages = Math.ceil(filteredRows.length / pageSize);
            const pagination = document.getElementById("pagination");
            pagination.innerHTML = "";

            // Previous
            pagination.innerHTML += `
      <li class="page-item ${currentPage === 1 ? "disabled" : ""}">
        <a class="page-link" href="#" onclick="changePage(${currentPage - 1})">Previous</a>
      </li>
    `;

            // Page numbers
            for (let i = 1; i <= totalPages; i++) {
                pagination.innerHTML += `
        <li class="page-item ${currentPage === i ? "active" : ""}">
          <a class="page-link" href="#" onclick="changePage(${i})">${i}</a>
        </li>
      `;
            }

            // Next
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
            applyFilter(); // re-render with filter
        }

        function applyFilter() {
            const keyword = document.getElementById("filterInput").value.toLowerCase();
            const filteredRows = rows.filter(row =>
                row.innerText.toLowerCase().includes(keyword)
            );

            // hide all
            rows.forEach(row => row.style.display = "none");

            // show only current page rows
            const start = (currentPage - 1) * pageSize;
            const end = start + pageSize;
            filteredRows.slice(start, end).forEach(row => row.style.display = "");

            // update total records
            document.getElementById("totalRecords").innerText = filteredRows.length;

            renderPagination(filteredRows);
        }

        // Filter event
        document.getElementById("filterInput").addEventListener("keyup", function () {
            currentPage = 1; // reset to first page
            applyFilter();
        });

        // Init
        document.addEventListener("DOMContentLoaded", renderTable);
    </script>
</asp:Content>
