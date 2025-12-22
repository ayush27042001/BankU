<%@ Page Title="" Language="C#" MasterPageFile="~/Neox.Master" AutoEventWireup="true" CodeBehind="TransactionDone.aspx.cs" Inherits="NeoXPayout.TransactionDone" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <hr />
    <!-- start: page header area -->
		<div class="px-xl-5 px-lg-4 px-3 py-3 page-body">
    <div class="row">
        <div class="col-md-12">

            <!-- Transaction Success Panel -->
            <asp:Panel ID="pnlSuccess" runat="server" Visible="false">
                <div class="card mb-4">
                    <div class="card-header py-3 bg-transparent border-bottom-0">
                        <h6 class="card-title mb-0"><strong>Transaction Successful</strong></h6>
                    </div>
                    <div class="card-body card-main-one">
                        <div class="row">
                            <div class="mb-3 col-md-12 col-12">
                                <p style="text-align:center"><img src="success.gif" /></p>
                            </div>
                            <div class="mb-3 col-md-12 col-12 text-center">
                                <a href="Dashboard.aspx" class="btn btn-primary">Go to Dashboard</a>
                            </div>
                        </div>
                    </div>
                </div>
            </asp:Panel>

            <!-- Transaction Failed Panel -->
            <asp:Panel ID="pnlFailed" runat="server" Visible="false">
                <div class="card mb-4">
                    <div class="card-header py-3 bg-transparent border-bottom-0">
                        <h6 class="card-title mb-0"><strong>Transaction Failed</strong></h6>
                    </div>
                    <div class="card-body card-main-one">
                        <div class="row">
                            <div class="mb-3 col-md-12 col-12">
                                <p style="text-align:center"><img src="Failed.gif" /></p>
                            </div>
                             <div class="mb-3 col-md-12 col-12 text-center">
                                <a href="Dashboard.aspx" class="btn btn-secondary">Back to Dashboard</a>
                            </div>
                        </div>
                    </div>
                </div>
            </asp:Panel>

        </div>
    </div>
</div>
<script>
if (window.top !== window.self) {
    // If loaded inside iframe, break out to full window
    window.top.location.href = window.location.href;
}
</script>

</asp:Content>
