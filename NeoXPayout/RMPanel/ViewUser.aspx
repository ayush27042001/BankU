<%@ Page Title="" Language="C#" MasterPageFile="~/RMPanel/RmPanel.Master" AutoEventWireup="true" CodeBehind="ViewUser.aspx.cs" Inherits="NeoXPayout.RMPanel.ViewUser" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="../assets/vendor/dataTables.min.css">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <hr />
    <h3 class="mt-4 mb-3 fw-bold" style="color:#2c3e50; font-family:'Segoe UI', Tahoma, sans-serif; margin-left:20px;">
  View User Under RM
</h3>
<div class="px-xl-5 px-lg-4 px-3 py-3 page-body">

    <div class="row">
        <div class="col-md-4">
       
    </div>
        <div class="col-12">
            <div class="border p-4 rounded-2 rounded-4">    
             
            <div class="d-flex justify-content-end mb-3">
                <select id="accountTypeFilter" class="form-select" style="max-width:200px">
                    <option value="">All Account Types</option>
                    <option value="BankU Seva Kendra">BankU Seva Kendra</option>
                    <option value="Business & APIs">Business & APIs</option>
                    <option value="Distributor">Distributor</option>
                </select>
            </div>
              
                <div class="1">
                <table
                    class="table align-middle table-hover dataTable table-body" >
                    <thead>
                       <tr class="small text-uppercase">
                                                 
                            <th>Id</th>
                            <th>FullName</th>
                            <th>MobileNo</th>
                            <th>EmailId</th>                          
                            <th>Reqdate</th>
                            <th>Status</th>
                            <th>Account Type</th>
                            <th>MPIN</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <asp:Repeater runat="server" ID="rptProduct">
                        <ItemTemplate>
                                <tr>
                                    <td><%# Eval("RegistrationId") %></td>
                                    <td><%# Eval("FullName") %></td>
                                    <td><%# Eval("MobileNo") %></td>
                                    <td><%# Eval("Email") %></td>                         
                                    <td><%# Eval("RegDate", "{0:dd/MM/yyyy hh:mm tt}") %></td> 
                                   <td 
                                    style='<%# 
                                        Eval("RegistrationStatus").ToString() == "Done" 
                                        ? "color:#155724;padding:1px 8px;border-radius:20px;text-align:center;font-weight:bold;display:inline-block;" 
                                        : "color:#d80000;padding:1px 8px;border-radius:20px;text-align:center;font-weight:bold;display:inline-block;" 
                                    %>'>
                                    <%# Eval("RegistrationStatus") %>
                                </td>
 
                                    <td><%# Eval("AccountType") %></td>
                                    <td><%# Eval("MPIN") %></td>
                                    <td><a href="ViewKyc.aspx?id=<%# Eval("RegistrationId") %>" class="btn btn-danger">View Kyc</a></td>                           
                                </tr>
                        </ItemTemplate>
                        </asp:Repeater>                                         
                    </tbody>
          </table>
        </div>
      </div>
    </div>
  </div>
 </div>
    <script>
document.addEventListener("DOMContentLoaded", function () {

    const filter = document.getElementById("accountTypeFilter");
    const rows = document.querySelectorAll("table tbody tr");

    filter.addEventListener("change", function () {
        const filterValue = this.value.toLowerCase();

        rows.forEach(function (row) {

            if (row.querySelectorAll("td").length === 0) {
                row.style.display = "";
                return;
            }
            const accountType = row.cells[6]?.innerText.trim().toLowerCase();

            row.style.display =
                filterValue === "" || accountType === filterValue
                    ? ""
                    : "none";
        });
    });

});
    </script>

</asp:Content>
