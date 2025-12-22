<%@ Page Title="" Language="C#" MasterPageFile="~/Neox.Master" AutoEventWireup="true" CodeBehind="Invoice.aspx.cs" Inherits="NeoXPayout.Invoice" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="../assets/vendor/dataTables.min.css">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <hr />
<div class="px-xl-5 px-lg-4 px-3 py-3 page-body">
<h2 class="fw-bold mb-4 mt-2 pb-2 border-bottom" style="color:#4a4a4a;">
    <i class="bi bi-receipt"></i> Invoice
</h2>
    <div class="row">
        <div class="col-12">
            <div class="border p-4 rounded-2 rounded-4">                            
                <div class="1">
                <table
                    class="table align-middle table-hover dataTable table-body" >
                    <thead style="background-color:#F5F6FA">
                       <tr class="small text-uppercase">
                                                 
                            <th>Invoice Id</th>
                            <th>Created At</th>        
                            <th>Type</th>
                             <th>File Path</th>
                            <th>Start Date</th>
                            <th>End Date</th>
                                          
                             
                        </tr>
                    </thead>
                    <tbody>
                        <asp:Repeater runat="server" ID="rptProduct">
                        <ItemTemplate>
                                <tr>
                                    <td><%# Eval("InvoiceId") %></td>      
                                     <td><%# Eval("CreatedAt", "{0:dd/MM/yyyy hh:mm tt}") %></td>
                                     <td><%# Eval("InvoiceType") %></td>
                                    <td>
                                        <a  href="javascript:void(0)" 
                                            class="downloadFile text-primary" 
                                            data-file='<%# ResolveUrl(Eval("FilePath").ToString()) %>' 
                                            style="font-size:18px; text-decoration:none;">
                                            <i class="fa fa-download" style="color:purple"></i>
                                        </a>
                                    </td>
                                    <td data-order='<%# Eval("StartDate","{0:yyyyMMdd}") %>'><%# Eval("StartDate") %></td>
                                    <td data-order='<%# Eval("EndDate","{0:yyyyMMdd}") %>'><%# Eval("EndDate") %></td>
                                    
                                   
                                    
                   
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
            document.querySelectorAll(".downloadFile").forEach(function (btn) {
                btn.addEventListener("click", function () {
                    const fileUrl = this.getAttribute("data-file");

                    if (!fileUrl) {
                        alert("File not found!");
                        return;
                    }

                    // Create invisible link and trigger click
                    const link = document.createElement("a");
                    link.href = fileUrl;
                    link.download = fileUrl.split('/').pop();
                    document.body.appendChild(link);
                    link.click();
                    document.body.removeChild(link);
                });
            });
        });
    </script>

</asp:Content>
