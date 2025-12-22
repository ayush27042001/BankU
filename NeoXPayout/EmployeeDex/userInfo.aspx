<%@ Page Title="" Language="C#" MasterPageFile="~/EmployeeDex/EmployeeDex.Master" AutoEventWireup="true" CodeBehind="userInfo.aspx.cs" Inherits="NeoXPayout.EmployeeDex.userInfo" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="../assets/vendor/dataTables.min.css">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <hr />
<div class="px-xl-5 px-lg-4 px-3 py-3 page-body">
   
    <div class="row">
        <div class="col-12">
            <div class="border p-4 rounded-2 rounded-4">                            
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
                            <%--<th>Action</th>--%>
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
                                    <%--<td><a href="EditUser.aspx?id=<%# Eval("RegistrationId") %>" class="btn btn-danger">Edit</a></td>--%>                           
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
