<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/NeoxAdmin.Master" AutoEventWireup="true" CodeBehind="ViewAgreement.aspx.cs" Inherits="NeoXPayout.Admin.ViewAgreement" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="../assets/vendor/dataTables.min.css">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <hr />
<div class="px-xl-5 px-lg-4 px-3 py-3 page-body">
<h2 class="fw-bold mb-4 mt-2 pb-2 border-bottom" style="color:#4a4a4a;">
    <i class="bi bi-receipt"></i> Agreement List
</h2>
    <div class="row">
        <div class="col-12">
            <div class="border p-4 rounded-2 rounded-4">                            
                <div class="1">
                    <asp:Label runat="server" ID="lblmsg" CssClass="text-danger "></asp:Label>
                <table
                    class="table align-middle table-hover dataTable table-body" >
                    <thead>
                       <tr class="small text-uppercase">
                                                 
                            <th>Agreement Id</th>
                            <th>User Id</th>             
                            <th>Type</th>     
                            <th>File Path</th>
                            <th>Created At</th>                                 
                            <th>Status</th>                      
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <asp:Repeater runat="server" ID="rptProduct" OnItemCommand="rptProduct_ItemCommand">
                        <ItemTemplate>
                                <tr>
                                    <td><%# Eval("AgreementId") %></td>
                                    <td><%# Eval("UserId") %></td>   
                                    <td><%# Eval("AgreementType") %></td>
                                    <td><%# Eval("FilePath") %></td>   
                                    <td data-order='<%# Eval("CreatedAt","{0:yyyyMMdd}") %>'><%# Eval("CreatedAt", "{0:dd/MM/yyyy hh:mm tt}") %></td> 
                                    <td 
                                        style='<%# 
                                            Eval("Status").ToString() == "Complete" 
                                            ? "color:#155724;padding:1px 8px;border-radius:20px;text-align:center;font-weight:bold;display:inline-block;" 
                                            : "color:#d80000;padding:1px 8px;border-radius:20px;text-align:center;font-weight:bold;display:inline-block;" 
                                        %>'>
                                        <%# Eval("Status") %>
                                   </td> 
                                   <td>
                                         <asp:LinkButton ID="btnDelete" 
                                            runat="server" 
                                            CssClass="btn btn-sm btn-danger ms-1"
                                            CommandName="DeleteRecord"
                                            CommandArgument='<%# Eval("Id") %>'
                                            OnClientClick="return confirm('Are you sure you want to delete this record?');">
                                            <i class="fa fa-trash"></i> Delete
                                        </asp:LinkButton>
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
