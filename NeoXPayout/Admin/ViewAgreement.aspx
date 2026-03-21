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
                           <th>User Signed</th>
                            <th>Admin SignedPath</th>     
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

                                <!-- ORIGINAL FILE -->
                                <td>
                                    <asp:HyperLink runat="server"
                                        NavigateUrl='<%# Eval("FilePath") != DBNull.Value && !string.IsNullOrEmpty(Eval("FilePath").ToString()) 
                                            ? ResolveUrl(Eval("FilePath").ToString()) 
                                            : "#" %>'
                                        Target="_blank"
                                        CssClass='<%# Eval("FilePath") != DBNull.Value && !string.IsNullOrEmpty(Eval("FilePath").ToString()) 
                                            ? "btn btn-sm btn-primary" 
                                            : "btn btn-sm btn-secondary disabled" %>'>
                                        Download
                                    </asp:HyperLink>
                                </td>

                                <!-- DATE -->
                                <td data-order='<%# Eval("CreatedAt","{0:yyyyMMdd}") %>'>
                                    <%# Eval("CreatedAt", "{0:dd/MM/yyyy hh:mm tt}") %>
                                </td> 

                                <!-- STATUS -->
                                <td style='<%# Eval("Status").ToString() == "Approved" ? "color:#155724;padding:1px 8px;border-radius:20px;text-align:center;font-weight:bold;display:inline-block;" : "color:#d80000;padding:1px 8px;border-radius:20px;text-align:center;font-weight:bold;display:inline-block;" %>'>  
                                        <%# Eval("Status") %>        
                                </td> 

                                <!-- USER SIGNED -->
                                <td>
                                 <asp:HyperLink runat="server"
                                    NavigateUrl='<%# GetSignedUrl(Eval("UserSignedPath")) %>'
                                    Target="_blank"
                                    CssClass='<%# 
                                        (Eval("UserSignedPath") == null || Eval("UserSignedPath") == DBNull.Value || string.IsNullOrEmpty(Eval("UserSignedPath").ToString())) 
                                        ? "btn btn-sm btn-secondary disabled" 
                                        : "btn btn-sm btn-info" %>'>

                                    <%# 
                                        (Eval("UserSignedPath") == null || Eval("UserSignedPath") == DBNull.Value || string.IsNullOrEmpty(Eval("UserSignedPath").ToString())) 
                                        ? "Not Signed" 
                                        : "View Signed" %>

                                </asp:HyperLink>
                                </td>

                                <!-- ADMIN SIGNED -->
                                <td>
                                  <asp:HyperLink runat="server"
                                    NavigateUrl='<%# Eval("AdminSignedPath") != DBNull.Value && !string.IsNullOrEmpty(Eval("AdminSignedPath").ToString()) 
                                        ? ResolveUrl("/" + Eval("AdminSignedPath").ToString().Replace("~/","")) 
                                        : "#" %>'
                                    Target="_blank"
                                    CssClass='<%# Eval("AdminSignedPath") != DBNull.Value && !string.IsNullOrEmpty(Eval("AdminSignedPath").ToString()) 
                                        ? "btn btn-sm btn-success" 
                                        : "btn btn-sm btn-secondary disabled" %>'>
                                    <%# Eval("AdminSignedPath") != DBNull.Value && !string.IsNullOrEmpty(Eval("AdminSignedPath").ToString()) 
                                        ? "Download" 
                                        : "Not Approved" %>
                                </asp:HyperLink>
                                </td>

                                <!-- ACTION -->
                                <td>
                                    <!-- DELETE -->
                                    <asp:LinkButton ID="btnDelete" 
                                        runat="server" 
                                        CssClass="btn btn-sm btn-danger ms-1"
                                        CommandName="DeleteRecord"
                                        CommandArgument='<%# Eval("Id") %>'
                                        OnClientClick="return confirm('Delete this record?');">
                                        <i class="fa fa-trash"></i>
                                    </asp:LinkButton>

                                    <!-- APPROVE -->
                                    <asp:LinkButton ID="btnResign" 
                                        runat="server" 
                                        CssClass='<%# Eval("Status").ToString() == "Signed" 
                                            ? "btn btn-sm btn-success ms-1" 
                                            : "btn btn-sm btn-secondary ms-1 disabled" %>'
                                        Enabled='<%# Eval("Status").ToString() == "Signed" %>'
                                        CommandName="ReSign"
                                        CommandArgument='<%# Eval("AgreementId") %>'>
                                        <i class="fa fa-check"></i> 
                                        <%# Eval("Status").ToString() == "Signed" ? "Approve" : "Pending" %>
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
