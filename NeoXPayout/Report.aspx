<%@ Page Title="" Language="C#" MasterPageFile="~/Neox.Master" AutoEventWireup="true" CodeBehind="Report.aspx.cs" Inherits="NeoXPayout.Report" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <hr />
               <!-- start: page body area -->
               <div class="px-xl-5 px-lg-4 px-3 py-3 page-body">
                    <div class="row">
                         <div class="col-12">
                              <div class="border p-4 rounded-2 rounded-4">
                                   <div class="calendar-tab pb-4" style="--dynamic-color: var(--primary-color)">
                                        <div class="row">
                                            <div class="col-md-4">
                                                <asp:TextBox ID="txtfrom" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox></div>
                                            <div class="col-md-4"><asp:TextBox ID="txtto" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox></div>
                                            <div class="col-md-4"><asp:LinkButton ID="LinkButton1" runat="server" class="btn btn-primary" OnClick="LinkButton1_Click">Search</asp:LinkButton></div>
                                        </div>
                                   </div>
                                   <table
                                        class="table align-middle table-hover dataTable table-body table-responsive w-100">
                                        <thead>
                                             <tr class="small text-muted text-uppercase">
                                                 
                            <th>AccountDetails</th>
                            <th>AccountNo</th>
                            <th>IFSCCode</th>
                            <th>Amount</th>
                            <th>Charge</th>
                            <th>GST</th>
                            <th>TotalCost</th>
                            <th>Status</th>
                            <th>UTRNO</th>
                            <th>ClientRefid</th>
                            <th>ReqDate</th>
                                             </tr>
                                        </thead>
                                        <tbody>
                                            <asp:Repeater runat="server" ID="rptProduct">
                    <ItemTemplate>
                          <tr class="row-selectable">
                            <td><%# Eval("BeneName") %></td>
                            <td><%# Eval("AccountNo") %></td>
                            <td><%# Eval("IFSCCode") %></td>
                            <td>₹<%#string.Format("{0:n2}",Eval("Amount")) %></td>
                            <td>₹<%#string.Format("{0:n2}",Eval("Charge")) %></td>
                            <td>₹<%#string.Format("{0:n2}",Eval("GST")) %></td>
                            <td>₹<%#string.Format("{0:n2}",Eval("TotalCost")) %></td>
                            <td><%# Eval("Status") %></td>
                            <td><%# Eval("UTRNO") %></td>
                            <td><%# Eval("ClientRefid") %></td>
                            <td><%# Eval("ReqDate") %></td>
                          </tr>
                           </ItemTemplate>
                             </asp:Repeater>
                                            
                                        </tbody>
                                   </table>
                              </div>
                         </div>
                    </div>

               </div>
</asp:Content>
