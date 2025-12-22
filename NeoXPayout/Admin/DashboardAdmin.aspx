<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/NeoxAdmin.Master" AutoEventWireup="true" CodeBehind="DashboardAdmin.aspx.cs" Inherits="NeoXPayout.Admin.Dashboard" %>
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
    <hr />
   
<div class="px-xl-5 px-lg-4 px-3 py-3 page-body">
    <div class="row g-3 mb-3">

        <!-- Today Transaction Amount -->
        <div class="col-md-6 col-lg-3 col-xl-3">
            <div class="card h-100 shadow-sm">
                <div class="card-header">
                    <h6 class="card-title mb-0">Today Transaction</h6>
                </div>
                <div class="card-body">
                    <h2 class="fw-bold">₹<asp:Label ID="lblTodayAmount" runat="server"></asp:Label></h2>
                </div>
            </div>
        </div>

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
                    <h6 class="card-title mb-0">Total Users</h6>
                </div>
                <div class="card-body">
                    <h2 class="fw-bold"><asp:Label ID="lblUsers" runat="server"></asp:Label></h2>
                </div>
            </div>
        </div>

        <!-- Wallet / Revenue -->
        <div class="col-md-6 col-lg-3 col-xl-3">
            <div class="card h-100 shadow-sm">
                <div class="card-header">
                    <h6 class="card-title mb-0">Revenue</h6>
                </div>
                <div class="card-body">
                    <h2 class="fw-bold">₹<asp:Label ID="lblRevenue" runat="server"></asp:Label></h2>
                </div>
            </div>
        </div>

    </div>

    <!-- ============================
          CHARTS SECTION BELOW CARDS
         ============================ -->
    <div class="row g-3 mt-3">

        <!-- Left Chart -->
        <div class="col-md-6">
            <div class="card shadow-sm">
                <div class="card-header">
                    <h6 class="card-title mb-0">Transaction Trend</h6>
                </div>
                <div class="card-body">
                    <canvas id="chartTransaction"></canvas>
                </div>
            </div>
        </div>

        <!-- Right Chart -->
        <div class="col-md-6">
            <div class="card shadow-sm">
                <div class="card-header">
                    <h6 class="card-title mb-0">User Growth</h6>
                </div>
                <div class="card-body">
                    <canvas id="chartUsersGrowth"></canvas>
                </div>
            </div>
        </div>

    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script>
    // LOAD ON PAGEs
    window.onload = function () {
        loadDashboardCharts();
    };

    function loadDashboardCharts() {
        $.ajax({
            type: "POST",
            url: "DashboardAdmin.aspx/GetDashboardChartData",
            data: "{}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (res) {
                var data = res.d;

                // ======================== TRANSACTION TREND LINE CHART ========================
                new Chart(document.getElementById("chartTransaction"), {
                    type: "line",
                    data: {
                        labels: data.days,
                        datasets: [{
                            label: "Transactions",
                            data: data.transaction,
                            borderWidth: 2,
                            tension: 0.4,
                            borderColor: "purple"
                        }]
                    },
                    options: { plugins: { legend: { display: false } } }
                });

                // ================= USER GROWTH BAR CHART ==================
                new Chart(document.getElementById("chartUsersGrowth"), {
                    type: "bar",
                    data: {
                        labels: data.months,
                        datasets: [{
                            label: "New Users",
                            data: data.users,
                            backgroundColor: "purple"
                        }]
                    },
                    options: { plugins: { legend: { display: false } } }
                });
            }
        });
    }
</script>


</asp:Content>
