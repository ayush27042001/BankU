<%@ Page Title="" Language="C#" MasterPageFile="~/Neox.Master" AutoEventWireup="true" CodeBehind="Settlement.aspx.cs" Inherits="NeoXPayout.Settlement" %>
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
                                            <div class="col-md-2">
                                                <asp:TextBox ID="txtfrom" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                                            </div>
                                            <div class="col-md-1">
                                                <asp:LinkButton ID="LinkButton1" runat="server" class="btn" style="background-color:purple; color: white" OnClick="LinkButton1_Click">Search</asp:LinkButton>
                                            </div>
                                             <div class="col-md-2">
                                                <asp:LinkButton ID="btnReset" runat="server" CssClass="btn btn-secondary"
                                                    OnClick="btnReset_Click">Reset</asp:LinkButton>
                                            </div>

                                            <asp:Label runat="server" CssClass="text-danger" ID="Label1"></asp:Label>
                                        </div>
                                   </div>
                                   <table
                                        class="table align-middle table-hover dataTable table-body table-responsive w-100">
                                        <thead style="background-color:#F5F6FA">
                                          <tr class="small text-muted text-uppercase">                                                 
                                            <th>ID</th>
                                            <th>User</th>
                                            <th>Service</th>
                                            <th>Amount</th>
                                            <th>Txn Date</th>
                                            <th>Operator Name</th>
                                            <th>Mobile No</th>
                                            <th>Status</th>                           
                                          </tr>
                                        </thead>
                                        <tbody>
                                         <asp:Repeater runat="server" ID="rptProduct">
                                          <ItemTemplate>
                                              <tr class="row-selectable">
                                                <td><%# Eval("TransID") %></td>
                                                <td><%# Eval("UserName") %></td>
                                                <td><%# Eval("ServiceName") %></td>
                                                <td>₹<%#string.Format("{0:n2}",Eval("Amount")) %></td>                          
                                                <td data-order='<%# Eval("TxnDate","{0:yyyyMMdd}") %>'><%# Eval("TxnDate") %></td>
                                                <td><%# Eval("OperatorName") %></td>
                                                <td><%# Eval("MobileNo") %></td>                
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

