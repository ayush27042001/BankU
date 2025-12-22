<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/NeoxAdmin.Master" AutoEventWireup="true" CodeBehind="ViewProduct.aspx.cs" Inherits="NeoXPayout.Admin.ViewProduct" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
       <hr />
    <h3 class="mt-4 mb-3 fw-bold" style="color:#2c3e50; font-family:'Segoe UI', Tahoma, sans-serif; margin-left:20px;">
  All Product 
</h3>
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
                            <th>Product Name</th>
                            <th>Description</th>
                            <th>Amount</th>                          
                            <th>Model</th>
                            <th>Status</th>   
                            <th>Action</th> 
                        </tr>
                    </thead>
                    <tbody>
                        <asp:Repeater runat="server" ID="rptProduct">
                        <ItemTemplate>
                                <tr >
                                    <td><%# Eval("Id") %></td>
                                    <td><%# Eval("ProductName") %></td>
                                    <td><%# Eval("ProductDesc") %></td>
                                    <td><%# Eval("Amount") %></td>                         
                                  
                                    <td><%# Eval("Model") %></td>
                                    <td><%# Eval("Status") %></td>
                                 <%--   <td><a href="#" class="btn btn-danger">Edit</a></td>--%>
                                    <td><a href="EditProduct.aspx?id=<%# Eval("Id") %>" class="btn btn-danger">Edit</a></td>                           
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
