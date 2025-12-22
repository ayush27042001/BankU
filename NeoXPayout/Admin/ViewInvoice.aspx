<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/NeoxAdmin.Master" AutoEventWireup="true" CodeBehind="ViewInvoice.aspx.cs" Inherits="NeoXPayout.Admin.ViewInvoice" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="../assets/vendor/dataTables.min.css">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<hr />
<div class="px-xl-5 px-lg-4 px-3 py-3 page-body">
<h2 class="fw-bold mb-4 mt-2 pb-2 border-bottom" style="color:#4a4a4a;">
    <i class="bi bi-receipt"></i> Invoice List
</h2>
    <div class="row">
        <div class="col-12">
            <div class="border p-4 rounded-2 rounded-4">                            
                <div class="1">
                <table
                    class="table align-middle table-hover dataTable table-body" >
                    <thead>
                       <tr class="small text-uppercase">
                                                 
                            <th>Invoice Id</th>
                            <th>User Id</th>             
                            <th>Start Date</th>
                            <th>End Date</th>
                            <th>Created At</th>                          
                            <th>File Path</th>
                            <th>Type</th>
                            <th>Status</th>                      
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <asp:Repeater runat="server" ID="rptProduct">
                        <ItemTemplate>
                                <tr>
                                    <td><%# Eval("InvoiceId") %></td>
                                    <td><%# Eval("UserId") %></td>   
                                    <td><%# Eval("StartDate") %></td>
                                    <td><%# Eval("EndDate") %></td>
                                    <td><%# Eval("CreatedAt", "{0:dd/MM/yyyy hh:mm tt}") %></td> 
                                    <td><%# Eval("FilePath") %></td>                         
                                    <td><%# Eval("InvoiceType") %></td>
                                    <td 
                                        style='<%# 
                                            Eval("Status").ToString() == "Complete" 
                                            ? "color:#155724;padding:1px 8px;border-radius:20px;text-align:center;font-weight:bold;display:inline-block;" 
                                            : "color:#d80000;padding:1px 8px;border-radius:20px;text-align:center;font-weight:bold;display:inline-block;" 
                                        %>'>
                                        <%# Eval("Status") %>
                                   </td> 
                                   <td>
                                        <a href='EditInvoice.aspx?Id=<%# Eval("Id") %>' class="btn btn-sm " style="background-color:purple; color:white">
                                            <i class="fa fa-edit"></i> Edit
                                        </a>
                                   </td>

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
</asp:Content>

