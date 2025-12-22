<%@ Page Title="" Language="C#" MasterPageFile="~/team/Team.Master" AutoEventWireup="true" CodeBehind="ViewNewUser.aspx.cs" Inherits="NeoXPayout.team.ViewNewUser" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <hr />
      <div class="px-xl-5 px-lg-4 px-3 py-2 page-header flex-wrap">
                    <ol class="breadcrumb mb-0 bg-transparent mb-3 mb-sm-0">
                         <li class="breadcrumb-item"><a class="text-muted" href="Default.aspx" title="home">Home</a></li>
                         <li class="breadcrumb-item active" aria-current="page" title="Balance">User Details</li>
                    </ol>
                  
               </div>
               <!-- start: page body area -->
               <div class="px-xl-5 px-lg-4 px-3 py-3 page-body">
                    <div class="row">
                         <div class="col-12">
                              <div class="border p-4 rounded-2 rounded-4">
                                <%--   <div class="calendar-tab pb-4" style="--dynamic-color: var(--primary-color)">
                                        <div class="row">
                                            <div class="col-md-4">
                                                <asp:TextBox ID="txtfrom" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox></div>
                                            <div class="col-md-4"><asp:TextBox ID="txtto" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox></div>
                                            <div class="col-md-4"><asp:LinkButton ID="LinkButton1" runat="server" class="btn btn-primary" OnClick="LinkButton1_Click">Search</asp:LinkButton></div>
                                        </div>
                                   </div>--%>
                                  <div class="1">
                                   <table
                                        class="table align-middle table-hover dataTable table-body" >
                                        <thead>
                                             <tr class="small text-uppercase">
                                                 
                            <th>CompanyName</th>
                            <th>FullName</th>
                            <th>MobileNo</th>
                            <th>EmailId</th>
                           
                            <th>Password</th>
                             <th>Status</th>
                            <th>Reqdate</th>
                            <th>Action</th>
                           
                                             </tr>
                                        </thead>
                                        <tbody>
                                            <asp:Repeater runat="server" ID="rptProduct">
                    <ItemTemplate>
                          <tr >
                              <td><%# Eval("CompanyName") %></td>
                            <td><%# Eval("FullName") %></td>
                            <td><%# Eval("MobileNo") %></td>
                              <td><%# Eval("EmailId") %></td>
                            
                              <td><%# Eval("Password") %></td>
                              <td><%# Eval("OnboardingStatus") %></td>
                              <td><%# Eval("RegDate") %></td>
                              <td> <a href="ManageUser.aspx?id=<%# Eval("UserID") %>" class="btn btn-success"><i class="fa fa-user"></i>View</a></td>
                          
                            
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
