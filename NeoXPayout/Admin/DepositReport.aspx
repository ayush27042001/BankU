<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/NeoxAdmin.Master" AutoEventWireup="true" CodeBehind="DepositReport.aspx.cs" Inherits="NeoXPayout.Admin.DepositReport" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <hr />
        <div class="px-xl-5 px-lg-4 px-3 py-3 page-body">
                    <div class="row">
                         <div class="col-12">
                              <div class="border p-4 rounded-2 rounded-4">
                                   <div class="calendar-tab pb-4" style="--dynamic-color: var(--primary-color)">
                                        <div class="row">
                                            <div class="col-md-2">
                                                <asp:TextBox ID="txtfrom" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox></div>

                                            <div class="col-md-2"><asp:TextBox ID="txtto" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox></div>
                                            
                                              <div class="col-md-2">
                                                <asp:TextBox ID="txtUser" runat="server" CssClass="form-control" placeholder="Enter User Id" MaxLength="4"></asp:TextBox></div>

                                            <div class="col-md-3">
                                                <asp:DropDownList ID="ddlServiceName" runat="server" CssClass="form-select">
                                                    <asp:ListItem Text="All Services" Value=""></asp:ListItem>
                                                    <asp:ListItem Text="ELECTRICITY" Value="ELECTRICITY" Selected="True"></asp:ListItem>
                                                    <asp:ListItem Text="RECHARGE" Value="Recharge"></asp:ListItem>
                                                    <asp:ListItem Text="FASTAG" Value="FASTAG"></asp:ListItem>
                                                    <asp:ListItem Text="WATER" Value="WATER"></asp:ListItem>
                                                    <asp:ListItem Text="GAS" Value="GAS"></asp:ListItem>
                                                </asp:DropDownList>
                                            </div>
                                            <div class="col-md-3"><asp:LinkButton ID="LinkButton1" runat="server" class="btn" style="background-color:purple; color: white" OnClick="LinkButton1_Click">Search</asp:LinkButton></div>
                                        <asp:Label runat="server" CssClass="text-danger" ID="Label1"></asp:Label>
                                        </div>
                                   </div>
                                   <table
                                        class="table align-middle table-hover dataTable table-body table-responsive w-100">
                                        <thead>
                                             <tr class="small text-muted text-uppercase">
                                                 
                            <th>User Name</th>
                            <th>AccountNo</th>
                            <th>IFSCCode</th>
                            <th>Amount</th>
                            <th>Txn Date</th>
                            <th>Surcharge</th>
                            <th>Commission</th>
                            <th>TotalCost</th>
                            <th>New Balance</th>
                            <th>Status</th>
                            <th>Service Name</th>
                            <th>Operator Name</th>
                           
                                             </tr>
                                        </thead>
                                        <tbody>
                     <asp:Repeater runat="server" ID="rptProduct">
                      <ItemTemplate>
                          <tr class="row-selectable">
                              <td><%# Eval("UserName") %></td>
                            <td><%# Eval("AccountNo") %></td>
                            <td><%# Eval("IFSCCode") %></td>
                            <td>₹<%#string.Format("{0:n2}",Eval("Amount")) %></td>
                            <td><%# Eval("TxnDate") %></td>
                            <td>₹<%#string.Format("{0:n2}",Eval("Surcharge")) %></td>
                            <td>₹<%#string.Format("{0:n2}",Eval("Commission")) %></td>
                            <td>₹<%#string.Format("{0:n2}",Eval("TotalCost")) %></td>
                            <td>₹<%#string.Format("{0:n2}",Eval("NewBal")) %></td>
                            <td><%# Eval("Status") %></td>
                            <td><%# Eval("ServiceName") %></td>
                            <td><%# Eval("OperatorName") %></td>
                            
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