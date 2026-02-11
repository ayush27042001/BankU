<%@ Page Title="" Language="C#" MasterPageFile="~/RMPanel/RmPanel.Master" AutoEventWireup="true" CodeBehind="DashboardRm.aspx.cs" Inherits="NeoXPayout.RMPanel.DashboardRm" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<style>
.card h2 {
    font-size: 32px;
    font-weight: 700;
    margin: 0;
}
</style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="px-xl-5 px-lg-4 px-3 py-3 page-body">
    <div class="row g-3 mb-3">
        <!-- Total Transactions -->
        <div class="col-md-6 col-lg-3 col-xl-3">
            <div class="card h-100 shadow-sm">
                <div class="card-header">
                    <h6 class="card-title mb-0">Total Transactions</h6>
                </div>
                <div class="card-body">
                    <h2 class="fw-bold">₹<asp:Label ID="lblTotalTxn" runat="server"></asp:Label></h2>
                </div>
            </div>
        </div>

        <!-- Total Users -->
        <div class="col-md-6 col-lg-3 col-xl-3">
            <div class="card h-100 shadow-sm">
                <div class="card-header">
                    <h6 class="card-title mb-0">User Under Rm</h6>
                </div>
                <div class="card-body">
                    <h2 class="fw-bold"><asp:Label ID="lblUsers" runat="server"></asp:Label></h2>
                </div>
            </div>
        </div>       
    </div>
        </div>
</asp:Content>
