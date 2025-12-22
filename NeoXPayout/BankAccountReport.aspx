<%@ Page Title="" Language="C#" MasterPageFile="~/Neox.Master" AutoEventWireup="true" CodeBehind="BankAccountReport.aspx.cs" Inherits="NeoXPayout.BankAccountReport" %>
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
                                       <div class="row align-items-center">
                                        <div class="col-md-2">
                                            <asp:TextBox ID="txtfrom" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                                        </div>
                                        <div class="col-md-2">
                                            <asp:TextBox ID="txtto" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                                        </div>
                                        <div class="col-md-3">
                                            <asp:DropDownList ID="ddlServiceName" runat="server" CssClass="form-select">
                                                <%--<asp:ListItem Text="All Services" Value=""></asp:ListItem>--%>
                                                <asp:ListItem Text="ELECTRICITY" Value="ELECTRICITY" Selected="True"></asp:ListItem>
                                                <asp:ListItem Text="RECHARGE" Value="RECHARGE"></asp:ListItem>
                                                <asp:ListItem Text="FASTAG" Value="FASTAG"></asp:ListItem>
                                                <asp:ListItem Text="WATER" Value="WATER"></asp:ListItem>
                                                <asp:ListItem Text="GAS" Value="GAS"></asp:ListItem>
                                            </asp:DropDownList>
                                        </div>
                                        <div class="col-md-3">
                                            <asp:LinkButton ID="LinkButton1" runat="server" CssClass="btn btn-primary">Search</asp:LinkButton>
                                        </div>

                                        <div class="col-md-2 text-end">
                                            <asp:LinkButton ID="btnAddAcc" runat="server" CssClass="btn btn-success" data-bs-toggle="modal" data-bs-target="#AddBeneficiary">
                                                Add Account
                                            </asp:LinkButton>
                                        </div>

                                        <div class="col-12 mt-2">
                                            <asp:Label runat="server" CssClass="text-danger" ID="Label1"></asp:Label>
                                        </div>
                                    </div>

                                   </div>
                                  <h5 class="mb-3">Beneficiary Details</h5>
                                    <table class="table align-middle table-hover dataTable table-body table-responsive w-100">
                        <thead style="background-color:#F5F6FA">
                            <tr class="small text-muted text-uppercase">
                                <th>Beneficiary Name</th>
                                <th>AccountNo</th>
                                <th>IFSCCode</th>
                                <th>Branch Name</th>
                                <th>Txn Date</th>
                                <th>New Balance</th>
                                <th>Status</th>
                                <th>Service Name</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr class="row-selectable">
                                <td>Sachin Kumar</td>
                                <td>123456789012</td>
                                <td>SBIN0001234</td>
                                <td>Connaught Place</td>
                                <td>24/01/2002</td> 
                                <td>₹25,000</td>
                                <td>Success</td>
                                <td>IMPS</td>
                            </tr>
                            <tr class="row-selectable">
                                <td>Ravi Mehta</td>
                                <td>987654321098</td>
                                <td>HDFC0004567</td>
                                <td>MG Road</td>
                                <td>18/06/2025</td>
                                <td>₹52,300</td>
                                <td>Pending</td>
                                <td>NEFT</td>
                            </tr>
                        </tbody>
                    </table>
                              </div>
                         </div>
                    </div>

               </div>
<div class="modal fade" id="AddBeneficiary" tabindex="-1" aria-labelledby="editModalLabel" aria-hidden="true"
   data-bs-backdrop="static" data-bs-keyboard="false"    >

<div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content mt-4 mb-4 p-4">

<!-- Modal Body -->
            <div class="modal-body">
                    <!-- Modal Header -->
                    <div class="modal-header">
                        <asp:Label ID="Label5" CssClass="modal-title text-danger" runat="server"></asp:Label>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>

                    <div class="card shadow-sm border rounded p-4 mb-4">
                        <h5 class="card-title text-center mb-4 fw-bold text-uppercase">Add Beneficiary</h5>

                        <div class="mb-3 row">
                            <label for="txtAcc" class="col-sm-4 col-form-label fw-semibold">Account Number</label>
                            <div class="col-sm-8">
                                <asp:TextBox ID="txtAcc" runat="server" CssClass="form-control" MaxLength="20" placeholder="Enter Account Number"></asp:TextBox>
                            </div>
                        </div>

                        <div class="mb-3 row">
                            <label for="txtBen" class="col-sm-4 col-form-label fw-semibold">Beneficiary Number</label>
                            <div class="col-sm-8">
                                <asp:TextBox ID="txtBen" runat="server" CssClass="form-control" MaxLength="20" placeholder="Enter Beneficiary Number"></asp:TextBox>
                            </div>
                        </div>

                        <div class="mb-3 row">
                            <label for="txtIFSC" class="col-sm-4 col-form-label fw-semibold">IFSC Code</label>
                            <div class="col-sm-8">
                                <asp:TextBox ID="txtIFSC" runat="server" CssClass="form-control text-uppercase" MaxLength="11" placeholder="Enter IFSC Code"></asp:TextBox>
                            </div>
                        </div>

                        <div class="mb-3 row">
                            <label for="txtBranchName" class="col-sm-4 col-form-label fw-semibold">Branch Name</label>
                            <div class="col-sm-8">
                                <asp:TextBox ID="txtBranchName" runat="server" CssClass="form-control" MaxLength="100" placeholder="Enter Branch Name"></asp:TextBox>
                            </div>
                        </div>

                 <%-- <div class="mb-3 row">
                            <label for="txtAmount" class="col-sm-4 col-form-label fw-semibold">Amount</label>
                            <div class="col-sm-8">
                                <asp:TextBox ID="txtAmount" runat="server" CssClass="form-control" placeholder="Enter Amount" TextMode="Number"></asp:TextBox>
                            </div>
                        </div>--%>

                        <!-- Buttons -->
                        <div class="text-center mt-4">
                            <asp:LinkButton ID="btnAddBenn" runat="server" Text="Add Account" CssClass="btn btn-primary me-2"></asp:LinkButton>
                          
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        </div>
                    </div>
                </div>
   

        </div>
    </div>
</div>
</asp:Content>
