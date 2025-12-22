<%@ Page Title="" Language="C#" MasterPageFile="~/Neox.Master" AutoEventWireup="true" CodeBehind="CreditCardBill.aspx.cs" Inherits="NeoXPayout.CreditCardBill" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
        <style>
    .form-icon-group {
        position: relative;
    }

    .form-icon-group .form-control {
        padding-left: 2.2rem !important; /* Creates space for the icon */
    }

    .form-icon {
        position: absolute;
        top: 50%;
        left: 10px;
        transform: translateY(-50%);
        color: #6c757d;
        font-size: 1rem;
        pointer-events: none;
    }
</style>
<style>
    @media print {
        .no-print {
            display: none !important;
        }
    }
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
          <hr />
       <div class="px-xl-6 px-lg-6  px-3 py-3 page-body">
                    <div class="row">
                         <div class="col-md-6 col-lg-12 col-xl-6">
                              <div class="card ">
                                   <div class="card-header border-bottom pb-0  ">
                                        <!--=== tab buttons ===-->
                                      <ul class="nav nav-pills nav-pills-underline justify-content-start mb-2" style="overflow-x:auto; white-space:nowrap;">
                                        <li class="nav-item ">
                                            <asp:LinkButton runat="server" ID="btnElectricity" CssClass="nav-link active"  CommandArgument="CreditCard">Credit Card Bill</asp:LinkButton>
                                        </li>                                  
                                     </ul>

                                        <!--=== dropdown tabs button ===-->
                                     
                                   </div>
                                   <div class="card-body ">
                                        <div class="tab-content" id="pills-tabContent">

                                             <!--=== Electric Bill ===-->
                                             <div class="tab-pane fade show active" id="pills-home" role="tabpanel"
                                                  aria-labelledby="pills-home-tab" tabindex="0">
                                              
                                                  <div class="table-responsive custom_scroll">
                                                       <!-- Table -->
                                                       
                                                    <div class="card-body card-main-one">
                                                        <div class="row">

                                                            <!-- Operator Dropdown -->
                                                           <div class="mb-2 col-md-12 col-12">
                                                            <label class="col-form-label" id="lblOperator" runat="server">Select Operator</label>
                                                            <asp:Label runat="server" ID="Operator" CssClass="text-danger" EnableViewState="false"></asp:Label>
                                                            <fieldset class="form-icon-group left-icon position-relative">
                                                                <asp:DropDownList ID="ddlOperator" runat="server" CssClass="form-control" style="width: 100%; padding: 6px; border-radius: 4px;">
                                                                    <asp:ListItem Text="Select" Value="" Selected="True"></asp:ListItem>
                                                                </asp:DropDownList>
                                                            </fieldset>
                                                        </div>


                                                            <!-- Account No -->
                                                           <div class="mb-2 col-md-12 col-12">
                                                                <label class="col-form-label">Card Number</label>
                                                                <fieldset class="form-icon-group">
                                                                    <asp:TextBox ID="txtCard" CssClass="form-control" runat="server" />
                                                                    <div class="form-icon">
                                                                        <i class="bi bi-credit-card"></i>
                                                                    </div>
                                                                </fieldset>
                                                            </div>

                                                            <!-- Mobile No -->
                                                            <div class="mb-2 col-md-12 col-12">
                                                                <label class="col-form-label">Mobile Number</label>
                                                                <fieldset class="form-icon-group left-icon position-relative">
                                                                    <asp:TextBox ID="txtMobile" CssClass="form-control" runat="server"></asp:TextBox>
                                                                    <div class="form-icon">
                                                                        <i class="bi bi-phone"></i>
                                                                    </div>
                                                                </fieldset>
                                                            </div>

                                                            <!-- Amount -->
                                                            <%--<div class="mb-2 col-md-12 col-12">
                                                                <label class="col-form-label mb-1">Amount</label>
                                                                
                                                                <fieldset class="form-icon-group left-icon position-relative">
                                                                    <asp:TextBox ID="TextBox13" CssClass="form-control" runat="server" ></asp:TextBox>
                                                                    <div class="form-icon">
                                                                        <i class="bi bi-cash-coin"></i>
                                                                    </div>
                                                                </fieldset>
                                                            </div>--%>

                                                            <!-- Submit Buttons -->
                                                            <div class="col-12">
                                                                
                                                                  <asp:LinkButton ID="LinkButton1" runat="server" CssClass="btn btn-primary" OnClick="LinkButton1_Click">
                                                                    Bill Fetch </asp:LinkButton>
                                                                <a href="CreditCardBill.aspx" class="btn btn-outline-secondary">Cancel</a>
                                                                <br />
                                                                <asp:Label ID="Label2" runat="server" Font-Bold="True" ForeColor="Red"></asp:Label>
                                                                <asp:Label ID="Label1" runat="server" Font-Bold="True" ForeColor="Red"></asp:Label>
                                                            </div>

                                                        </div>
                                                    </div>
                                                </div>       
                                             </div>
                                           
                                        </div>
                                   </div>
                              </div>
                         </div>
                         <div class="col-md-6 col-lg-12 col-xl-6">
                            <div class="card">
                                <div class="card-header">
                                    <h6 class="card-title mb-0">Credit Card Payment History</h6>
                                    <div class="card-action">
                                        <div>
                                            <a href="#" class="card-fullscreen" data-bs-toggle="tooltip" title="Card Full Screen">
                                                <svg class="svg-stroke" xmlns="http://www.w3.org/2000/svg"
                                                     width="20" height="20" viewBox="0 0 24 24" fill="none"
                                                     stroke="currentColor" stroke-linecap="round"
                                                     stroke-linejoin="round">
                                                    <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>
                                                    <path d="M21 12v3a1 1 0 0 1 -1 1h-16a1 1 0 0 1 -1 -1v-10a1 1 0 0 1 1 -1h9"></path>
                                                    <path d="M7 20l10 0"></path>
                                                    <path d="M9 16l0 4"></path>
                                                    <path d="M15 16l0 4"></path>
                                                    <path d="M17 4h4v4"></path>
                                                    <path d="M16 9l5 -5"></path>
                                                </svg>
                                            </a>
                                            
                                        </div>
                                    </div>
                                </div>
                             
                                <div class="card-body">
                                    <!-- Row Template -->
                                    <asp:Literal ID="litRechargeHistory" runat="server"></asp:Literal>
                                    <%--<div class="d-flex align-items-center mb-3">
                                        <img class="avatar rounded" src="assets/images/xs/HDFC.jpg" alt="">
                                        <div class="flex-fill ms-3">
                                            <div class="h6 mb-0">7988313165</div>
                                            <small class="text-muted">HDFC Bank Credit Card</small>
                                        </div>
                                        <div class="flex-end flex-column d-flex text-end">
                                            <small class="fw-medium" style="color:green;">₹20000.00</small>
                                            <small class="text-muted">Feb 05, 2024</small>
                                        </div>
                                    </div><hr />

                                    <div class="d-flex align-items-center mb-3">
                                        <img class="avatar rounded" src="assets/images/xs/ICICI.png" alt="">
                                        <div class="flex-fill ms-3">
                                            <div class="h6 mb-0">8897273823</div>
                                            <small class="text-muted">ICICI Bank Credit Card</small>
                                        </div>
                                        <div class="flex-end flex-column d-flex text-end">
                                            <small class="fw-medium" style="color:green;">₹29900.00</small>
                                            <small class="text-muted">March 15, 2024</small>
                                        </div>
                                    </div><hr />

                                    <div class="d-flex align-items-center mb-3">
                                        <img class="avatar rounded" src="assets/images/xs/SBI.jpg" alt="">
                                        <div class="flex-fill ms-3">
                                            <div class="h6 mb-0">8676793448</div>
                                            <small class="text-muted">State Bank of India (SBI) Credit Card</small>
                                        </div>
                                        <div class="flex-end flex-column d-flex text-end">
                                            <small class="fw-medium" style="color:green;">₹24900.00</small>
                                            <small class="text-muted">Feb 05, 2024</small>
                                        </div>
                                    </div><hr />
                                    <div class="d-flex align-items-center mb-3">
                                        <img class="avatar rounded" src="assets/images/xs/Axis.png" alt="">
                                        <div class="flex-fill ms-3">
                                            <div class="h6 mb-0">7988313165</div>
                                            <small class="text-muted">Axis Bank Credit Card</small>
                                        </div>
                                        <div class="flex-end flex-column d-flex text-end">
                                            <small class="fw-medium" style="color:green;">₹30000.00</small>
                                            <small class="text-muted">Feb 05, 2024</small>
                                        </div>
                                    </div><hr />
                                    <div class="d-flex align-items-center mb-3">
                                        <img class="avatar rounded" src="assets/images/xs/kotak.png" alt="">
                                        <div class="flex-fill ms-3">
                                            <div class="h6 mb-0">8897273823</div>
                                            <small class="text-muted">Kotak Mahindra Credit Card</small>
                                        </div>
                                        <div class="flex-end flex-column d-flex text-end">
                                            <small class="fw-medium" style="color:green;">₹10000.00</small>
                                            <small class="text-muted">May 25, 2025</small>
                                        </div>
                                    </div><hr />
                                    <div class="d-flex align-items-center mb-3">
                                        <img class="avatar rounded" src="assets/images/xs/HDFC.jpg" alt="">
                                        <div class="flex-fill ms-3">
                                            <div class="h6 mb-0">8676793448</div>
                                            <small class="text-muted">HDFC Bank Credit Card</small>
                                        </div>
                                        <div class="flex-end flex-column d-flex text-end">
                                            <small class="fw-medium" style="color:green;">₹57000.00</small>
                                            <small class="text-muted">April 13, 2024</small>
                                        </div>
                                    </div>--%>

                                    <a href="ReportBanku.aspx" class="mt-3 btn btn-grey-outline w-100 fw-medium">Show All</a>
                                </div>
                            </div>
                        </div>
                    </div>
               </div>


 <!-- Electricity Bill Modal -->
<div class="modal fade" id="editModal" tabindex="-1" aria-labelledby="editModalLabel" aria-hidden="true"
     data-bs-backdrop="static" data-bs-keyboard="false">

    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content mt-4 mb-4 p-4">

<!-- Modal Body -->
            <div class="modal-body">
                  <!-- Modal Header -->
            <div class="modal-header">
              
                <asp:Label ID="editModalLabel" class="modal-title" runat="server" ></asp:Label> 
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
               <div class="card shadow-sm border rounded p-4 mb-4">
                    <h5 class="card-title text-center mb-4 fw-bold text-uppercase">Bill Summary</h5>

                   <div class="mb-2 d-flex justify-content-between border-bottom pb-1">
                        <span class="fw-semibold">Customer Name :</span>
                        <asp:Label ID="lblName" runat="server" CssClass="fw-bold text-dark"></asp:Label>
                    </div>

                    <div class="mb-2 d-flex justify-content-between border-bottom pb-1">
                        <span class="fw-semibold">Card Number :</span>
                        <asp:Label ID="lblNumber" runat="server" CssClass="fw-bold text-dark"></asp:Label>
                    </div>
                    <div class="mb-2 d-flex justify-content-between border-bottom pb-1">
                        <span class="fw-semibold">Mobile Number :</span>
                        <asp:Label ID="lblMobile" runat="server" CssClass="fw-bold text-dark"></asp:Label>
                    </div>

                    <div class="mb-2 d-flex justify-content-between border-bottom pb-1">
                        <span class="fw-semibold">Bill Amount :</span>
                        <asp:Label ID="lblBillAmount" runat="server" CssClass="fw-bold text-danger"></asp:Label>
                    </div>

                    <div class="mb-2 d-flex justify-content-between border-bottom pb-1">
                        <span class="fw-semibold">Bill Number :</span>
                        <asp:Label ID="lblBillNo" runat="server" CssClass="fw-bold text-success"></asp:Label>
                    </div>

                    <div class="mb-2 d-flex justify-content-between border-bottom pb-1">
                        <span class="fw-semibold">Req ID :</span>
                        <asp:Label ID="lblReqID" runat="server" CssClass="fw-bold text-dark"></asp:Label>
                    </div>           
                  
                   <div class="mb-2 d-flex justify-content-between border-bottom pb-1">
                        <span class="fw-semibold">Biller Response :</span>
                        <asp:Label ID="lblbillerResponse" runat="server" CssClass="fw-bold text-dark"></asp:Label>
                    </div>
                   
                    <div class="mb-2 d-flex justify-content-between border-bottom pb-1">
                        <span class="fw-semibold">Due Date :</span>
                        <asp:Label ID="lblDueDate" runat="server" CssClass="fw-bold text-dark"></asp:Label>
                    </div>

                    <div class="text-center">
                        <asp:Label ID="Label3" runat="server" CssClass="fw-bold fs-6 text-success"></asp:Label>
                    </div>
                     <!-- Modal Footer with Pay Now Button -->
            <div class="modal-footer">
                
                 <asp:LinkButton ID="btnPayNow" runat="server" CssClass="btn btn-success" OnClick="btnPayNow_Click">
                    Pay Now
                </asp:LinkButton>

                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
            </div>
                </div>

            </div>   

        </div>
    </div>
</div>
     <asp:HiddenField ID="HiddenField1" runat="server" />
                <asp:HiddenField ID="HiddenField2" runat="server" />
                <asp:HiddenField ID="HiddenField3" runat="server" />
                <asp:HiddenField ID="HiddenField4" runat="server" />
                <asp:HiddenField ID="HiddenField5" runat="server" />
                <asp:HiddenField ID="HiddenField6" runat="server" />

<div class="modal fade" id="PayModal" tabindex="-1" aria-labelledby="editModalLabel" aria-hidden="true" data-bs-backdrop="static" data-bs-keyboard="false">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content mt-4 mb-4 p-4" id="printArea">

            <!-- Modal Header -->
            <div class="modal-header border-bottom-0">
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>

            <!-- Invoice Header with Logo and Title -->
            <div class="d-flex justify-content-between align-items-center mb-3">
                <div class="d-flex align-items-center">
                    <img src="bankulogo.png" alt="CompanyLogo" style="height:30px; margin-right: 10px;" />
                </div>
                <asp:Label ID="lblheader" runat="server" CssClass="modal-title fw-bold fs-4 text-uppercase text-dark"></asp:Label>
            </div>

            <!-- Modal Body -->
            <div class="modal-body">
                <!-- Header Info Section -->
                <div class="d-flex justify-content-between mb-4 border-bottom pb-3">
                    <div>
                        <h6 class="fw-bold mb-1">Bill to</h6>
                        <div><asp:Label ID="payName" runat="server" CssClass="text-dark fw-semibold"></asp:Label></div>
                        <div><asp:Label ID="payMobile" runat="server" CssClass="text-muted"></asp:Label></div>
                        <div><asp:Label ID="payOperator" runat="server" CssClass="text-muted"></asp:Label></div>
                    </div>
                    <div class="text-end">
                        <div><strong>Transaction ID:</strong> <asp:Label ID="PayTxnID" runat="server"></asp:Label></div>
                        <div><strong>Date:</strong> <asp:Label ID="payDate" runat="server"></asp:Label></div>
                    </div>
                </div>

                <!-- Bill Details Table -->
                <div class="table-responsive mb-4">
                    <table class="table table-bordered">
                        <thead class="table-light">
                            <tr>
                                <th>#</th>
                                <th>Description</th>
                                <th>Rate</th>
                                <th>Qty</th>
                                <th>Total</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>01</td>
                                <td>Recharge</td>
                                <td>₹<asp:Label ID="payAmount" runat="server"></asp:Label></td>
                                <td>1</td>
                                <td>₹<asp:Label ID="Label4" runat="server"></asp:Label></td>
                            </tr>
                        </tbody>
                    </table>
                </div>

                <!-- Summary Table -->
                <div class="d-flex justify-content-end mb-3">
                    <table class="table table-bordered w-auto mb-0">
                        <tr>
                            <td><strong>Commission</strong></td>
                            <td>₹<asp:Label ID="payCommission" runat="server"></asp:Label></td>
                        </tr>
                        <tr>
                            <td><strong>Tax</strong></td>
                            <td>0.00%</td>
                        </tr>
                        <tr>
                            <td><strong>Total</strong></td>
                            <td class="fw-bold text-success">₹<asp:Label ID="Label5" runat="server"></asp:Label></td>
                        </tr>
                    </table>
                </div>

                <!-- Extra Details -->
                <div class="mt-4">
                    <p><strong>Account Number:</strong> <asp:Label ID="payAccount" runat="server" CssClass="fw-semibold"></asp:Label></p>
                    <p><strong>Current Balance:</strong> <asp:Label ID="payCurrBal" runat="server" CssClass="fw-semibold"></asp:Label></p>
                </div>

                <!-- Authorized Sign -->
                <div class="mt-5 d-flex justify-content-end">
                    <div class="text-end">
                        <div class="border-top pt-2">Authorized Sign</div>
                    </div>
                </div>

                <!-- Optional Final Message -->
                <div class="text-center mt-4">
                    <asp:Label ID="Label12" runat="server" CssClass="fw-bold fs-6 text-success"></asp:Label>
                </div>
            </div>

            <!-- Footer Buttons -->
            <div class="modal-footer no-print">
                <asp:LinkButton ID="LinkButton2" runat="server" CssClass="btn btn-success" OnClientClick="printReceipt(); return false;">Print</asp:LinkButton>
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
                      <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
                    <style>
                        body { font-family: Arial, sans-serif; padding: 20px; }
                        .fw-bold { font-weight: bold; }
                        .text-dark { color: #000; }
                        .text-success { color: green; }
                        .text-danger { color: red; }
                        .text-center { text-align: center; }
                        .border-bottom { border-bottom: 1px solid #ccc; padding-bottom: 4px; margin-bottom: 6px; }
                        .mb-2 { margin-bottom: 0.5rem; }
                        .pb-1 { padding-bottom: 0.25rem; }
                        .card-title { font-size: 1.25rem; margin-bottom: 1rem; }
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
</asp:Content>
