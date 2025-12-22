<%@ Page Title="" Language="C#" MasterPageFile="~/Neox.Master" AutoEventWireup="true" CodeBehind="depositreport.aspx.cs" Inherits="NeoXPayout.depositreport" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <hr />
      <div class="px-xl-5 px-lg-4 px-3 py-2 page-header flex-wrap">
                    <ol class="breadcrumb mb-0 bg-transparent mb-3 mb-sm-0">
                         <li class="breadcrumb-item"><a class="text-muted" href="Default.aspx" title="home">Home</a></li>
                         <li class="breadcrumb-item active" aria-current="page" title="Balance">Transation Report</li>
                    </ol>
                    <ul class="list-unstyled action  mb-0 row g-2">
                         <li class="col-sm-6 col-6">
                              <div>
                                   <input type="date" name="filter" class="form-control">
                              </div>
                         </li>
                         
                    </ul>
               </div>
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
                                        class="table align-middle table-hover  table-body table-responsive w-100">
                                        <thead>
                                             <tr class="small text-muted text-uppercase">
                                                 
                            <th>TxnId</th>
                            <th>Amount</th>
                            <th>ClientRefId</th>
                            <th>UTRNO</th>
                            <th>ReqDate</th>
                                                 <th>Status</th>
                            
                                             </tr>
                                        </thead>
                                        <tbody>
                                            <asp:Repeater runat="server" ID="rptProduct">
                    <ItemTemplate>
                          <tr class="row-selectable">
                            <td><%# Eval("TxnId") %></td>
                            <td>₹<%#string.Format("{0:n2}",Eval("Amount")) %></td>
                            <td><%# Eval("ClientRefId") %></td>
                            <td><%# Eval("UTRNO") %></td>
                            <td><%# Eval("ReqDate") %></td>
                              <td><%# Eval("Status") %></td>
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
