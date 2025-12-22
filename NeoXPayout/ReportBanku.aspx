<%@ Page Title="" Language="C#" MasterPageFile="~/Neox.Master" AutoEventWireup="true" CodeBehind="ReportBanku.aspx.cs" Inherits="NeoXPayout.ReportBanku" %>
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
                                                <asp:TextBox ID="txtfrom" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox></div>
                                            <div class="col-md-2"><asp:TextBox ID="txtto" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox></div>
                                            <div class="col-md-3">
                                                <asp:DropDownList ID="ddlServiceName" runat="server" CssClass="form-select">
                                                    <asp:ListItem Text="All Services" Value=""></asp:ListItem>
                                                    <asp:ListItem Text="ELECTRICITY" Value="ELECTRICITY" Selected="True"></asp:ListItem>
                                                    <asp:ListItem Text="RECHARGE" Value="RECHARGE"></asp:ListItem>
                                                    <asp:ListItem Text="FASTAG" Value="FASTAG"></asp:ListItem>
                                                    <asp:ListItem Text="WATER" Value="WATER"></asp:ListItem>
                                                    <asp:ListItem Text="GAS" Value="GAS"></asp:ListItem>
                                                </asp:DropDownList>
                                            </div>
                                            <div class="col-md-3"><asp:LinkButton ID="LinkButton1" runat="server" class="btn btn-primary" OnClick="LinkButton1_Click">Search</asp:LinkButton></div>
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
                            <th>Download</th>
                           
                                             </tr>
                                        </thead>
                                        <tbody>
                  <asp:Repeater ID="rptProduct" runat="server" OnItemCommand="rptProduct_ItemCommand">

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
                             <td><asp:LinkButton ID="btnDownload" runat="server" CssClass="btn btn-primary btn-sm"
                                CommandName="ShowDetails"
                                CommandArgument='<%# Eval("AccountNo") + "|" + Eval("IFSCCode") + "|" + Eval("Amount") + "|" + Eval("TxnDate") + "|" + Eval("Surcharge") + "|" + Eval("Commission") + "|" + Eval("TotalCost") + "|" + Eval("NewBal") + "|" + Eval("Status") + "|" + Eval("ServiceName") + "|" + Eval("OperatorName") + "|" + Eval("UserName") %>'>
                                Download
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

    <!-- Invoice Modal -->
<div class="modal fade" id="PayModal" tabindex="-1" aria-labelledby="PayModalLabel" aria-hidden="true" data-bs-backdrop="static" data-bs-keyboard="false">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content mt-4 mb-4 p-4" id="printArea">

            <!-- Modal Header -->
            <div class="modal-header border-bottom-0">
                <h5 class="modal-title fw-bold text-uppercase text-dark">Transaction Invoice</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>

            <!-- Invoice Header with Logo -->
            <div class="d-flex justify-content-between align-items-center mb-3">
                <div class="d-flex align-items-center">
                    <img src="bankulogo.png" alt="BankU Logo" style="height:30px; margin-right: 10px;" />
                </div>
                <asp:Label ID="lblheader" runat="server" CssClass="modal-title fw-bold fs-4 text-uppercase text-dark"></asp:Label>
            </div>

            <!-- Modal Body -->
            <div class="modal-body">

                <!-- Bill To Section -->
                <div class="d-flex justify-content-between mb-4 border-bottom pb-3">
                    <div>
                        <h6 class="fw-bold mb-1">Bill to</h6>
                        <div><asp:Label ID="payName" runat="server" CssClass="text-dark fw-semibold" /></div>
                        <div><asp:Label ID="payMobile" runat="server" CssClass="text-muted" /></div>
                        <div><asp:Label ID="payOperator" runat="server" CssClass="text-muted" /></div>
                    </div>
                    <div class="text-end">
                        <div><strong>Date:</strong> <asp:Label ID="payDate" runat="server" /></div>
                        <div><strong>Status:</strong> <asp:Label ID="LabelTxnStatus" runat="server" CssClass="fw-bold text-success" /></div>
                    </div>
                </div>

                <!-- Bill Details Table -->
                <div class="table-responsive mb-4">
                    <table class="table table-bordered">
                        <thead class="table-light">
                            <tr>
                                <th>Description</th>
                                <th>Rate</th>
                                <th>Total</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>Bank Transaction</td>
                                <td>₹<asp:Label ID="payAmount" runat="server" /></td>
                                <td>₹<asp:Label ID="Label4" runat="server" /></td>
                            </tr>
                        </tbody>
                    </table>
                </div>

                <!-- Summary Section -->
                <div class="d-flex justify-content-end mb-3">
                    <table class="table table-bordered w-auto mb-0">
                        <tr>
                            <td><strong>Commission</strong></td>
                            <td>₹<asp:Label ID="payCommission" runat="server" /></td>
                        </tr>
                        <tr>
                            <td><strong>Total</strong></td>
                            <td class="fw-bold text-success">₹<asp:Label ID="Label5" runat="server" /></td>
                        </tr>
                    </table>
                </div>

                <!-- Extra Info -->
                <div class="mt-4">
                    <p><strong>Account Number:</strong> <asp:Label ID="payAccount" runat="server" CssClass="fw-semibold" /></p>
                    <p><strong>Current Balance:</strong> <asp:Label ID="payCurrBal" runat="server" CssClass="fw-semibold" /></p>
                </div>

                <!-- Authorized Sign -->
                <div class="mt-5 d-flex justify-content-end">
                    <div class="text-end">
                        <div class="border-top pt-2">Authorized Sign</div>
                    </div>
                </div>

                <!-- Final Message -->
                <div class="text-center mt-4">
                    <asp:Label ID="Label12" runat="server" CssClass="fw-bold fs-6 text-success"></asp:Label>
                </div>
            </div>

            <!-- Modal Footer -->
            <div class="modal-footer no-print">
                <asp:LinkButton ID="btnPrint" runat="server" CssClass="btn btn-success" OnClientClick="printReceipt(); return false;">Print</asp:LinkButton>
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
            </div>

        </div>
    </div>
</div>


<script>
    function printReceipt() {
        var printContent = document.getElementById('printArea').innerHTML;
        var win = window.open('', '_blank');

        win.document.write(`
        <html>
            <head>
                <title>Print Receipt</title>
                <!-- Include Bootstrap CSS for print layout -->
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
                <style>
                    body { font-family: Arial, sans-serif; padding: 20px; }
                    .no-print { display: none; }
                </style>
            </head>
            <body onload="window.print(); window.close();">
                ${printContent}
            </body>
        </html>
    `);
        win.document.close();
    }

</script>
 
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
 
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</asp:Content>
