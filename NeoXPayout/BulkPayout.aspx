<%@ Page Title="" Language="C#" MasterPageFile="~/Neox.Master" AutoEventWireup="true" CodeBehind="BulkPayout.aspx.cs" Inherits="NeoXPayout.BulkPayout" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
       <style>
    body {
        font-family: Arial, sans-serif;
    }
    .hero-section {
        background: #fff;
        min-height: 100vh;
        display: flex;
        align-items: center;
    }


    .hero-left h1 {
        font-weight: bold;
        font-size: 2.5rem;
    }
    .hero-left p {
        color: #6c757d;
        font-size: 1.1rem;
    }
    .feature-icon {
        font-size: 2rem;
        color: #0052cc;
    }
    .hero-right {
        background: linear-gradient(180deg, #06142F, #091d3b);
        color: #fff;
        display: flex;
        align-items: center;
        justify-content: center;
        padding: 40px;
        border-radius: 10px;
    }
    .step-box {
        background: white;
        border-radius: 10px;
        padding: 20px;
        color: black;
        text-align: center;
        max-width: 250px;
        margin: auto;
    }
    .btn-primary {
        background-color: #6e007c;
        border: none;
    }
     btn btn-primary {
        background-color: #6e007c;
        border: none;
    }

    .sidebar {
        position: fixed;
        top: 0; left: 0;
        width: 300px;
        height: 100%;
        background: #f5f6fa;
        box-shadow: 2px 0 6px rgba(0,0,0,0.1);
        padding: 20px;
        display: block;
    }
    .close-sidebar {
        display: block;
        margin-bottom: 20px;
        cursor: pointer;
        font-size: 14px;
        color: #555;
    }
   .hero-section {
    background: #fff;
    display: flex;
    align-items: center;
    min-height: 100vh;
}

.hero-left h1 {
    font-size: 2.5rem;
    font-weight: bold;
}

.hero-left p {
    font-size: 1rem;
    color: #555;
}

.feature-icon {
    font-size: 2rem;
    color: #007bff;
}

/* Dashboard section */
.stats-row {
    display: flex;
    align-items: center;
    justify-content: space-between;
    background: white;
    padding: 10px 20px;
    border-radius: 8px;
    gap: 40px;
}

.stat {
    display: flex;
    flex-direction: column;
    text-align: left;
}

.stat .label {
    font-size: 0.8rem;
    color: #6c7a89;
    text-transform: uppercase;
    letter-spacing: 1px;
}

.stat .value {
    font-size: 1.5rem;
    font-weight: bold;
    color: #2c3e50;
    margin-top: 3px;
}



.bulk-btn:hover {
    background: #003ec1;
}
.bulk-btn {
    background: #6e007c;
    color: white;
    padding: 8px 15px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
}

.bulk-payout-container {
    display: flex;
    background: white;
    border-radius: 10px;
    overflow: hidden;
    border: 1px solid #eee;
}

.left-panel {
    width: 250px;
    border-right: 1px solid #f0f0f0;
    padding: 15px;
}

.search-box {
    display: flex;
    align-items: center;
    border: 1px solid #ddd;
    border-radius: 8px;
    padding: 5px 10px;
    background: white;
}

.search-box input {
    border: none;
    outline: none;
    flex: 1;
    font-size: 14px;
}

.search-box .icon {
    font-size: 16px;
    color: #555;
}

.no-data {
    text-align: center;
    color: #999;
    margin-top: 50px;
}

.right-panel {
    flex: 1;
    padding: 15px;
}

.filter-row {
    display: flex;
    align-items: center;
    gap: 10px;
    margin-bottom: 15px;
}

.status label {
    display: block;
    font-size: 11px;
    color: #6b6b6b;
    font-weight: bold;
    text-transform: uppercase;
    margin-bottom: 3px;
}

select {
    padding: 6px 10px;
    border-radius: 6px;
    border: 1px solid #ddd;
    background: white;
    font-size: 14px;
}

.btn-download {
    padding: 6px 12px;
    border: 1px solid #ddd;
    border-radius: 8px;
    background: white;
    cursor: pointer;
    font-size: 14px;
}

.bulk-table {
    width: 100%;
    border-collapse: collapse;
}

.bulk-table thead {
    background: #f8f9fb;
}

.bulk-table th, .bulk-table td {
    padding: 10px;
    text-align: left;
    font-size: 14px;
    color: #444;
}

.empty-row {
    text-align: center;
}

.empty-state {
    padding: 40px 0;
    color: #999;
}

.empty-state img {
    width: 120px;
    margin-bottom: 10px;
}

@media (max-width: 600px) {
    .stats-row {
        flex-direction: column;
        align-items: stretch;
        gap: 15px;
        padding: 15px;
    }

    .stat {
        flex-direction: row;
        justify-content: space-between;
        align-items: center;
    }

    .stat .label {
        font-size: 0.75rem;
        margin: 0;
    }

    .stat .value {
        font-size: 1.2rem;
        margin: 0;
    }

    /* Bulk payout button full width */
    .bulk-payout-btn {
        display: block;
        width: 100%;
        padding: 10px;
        text-align: center;
        background: #6e007c;
        color: white;
        font-weight: bold;
        border-radius: 6px;
        text-decoration: none;
    }

     /* Container ko column banado */
    .bulk-payout-container {
        flex-direction: column;
    }

    /* Left panel full width */
    .left-panel {
        width: 100%;
    }

    /* Right panel full width and stacked */
    .right-panel {
        width: 100%;
    }

    .filter-row .search-box.small {
        width: 100%;
        margin-bottom: 8px;
    }

    /* Download buttons ek row me */
    .download-buttons {
        display: flex;
        gap: 10px;
        width: 100%;
    }

    .download-buttons .btn-download {
        flex: 1; /* Equal width for both buttons */
    }


    /* Table full width below filters */
    .bulk-table {
        width: 100%;
    }

    .filter-row {
        display: flex;
        flex-wrap: wrap;
        gap: 10px;
    }

    /* Status & Select Filter ko half-half width dena */
    .filter-row .status,
    .filter-row .select-filter {
        flex: 1 1 calc(50% - 10px);
    }

    /* Dropdown full width apne box me */
    .filter-row select {
        width: 100%;
    }
}
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <hr />
    <div id="singlePayoutSection" class="container-fluid hero-section">
    <div class="row w-100">
        <!-- Left Side -->
        <div class="col-lg-6 hero-left p-5">
            <h1>Effortless Bulk Payouts for Businesses</h1>
            <p>Seamlessly process thousands of payouts with just a single file upload. No more manual processing!</p>
            <button id="initiateBulkUploadBtn" class="btn btn-primary" style="background-color: #6e007c;">Initiate Bulk Upload</button>

            <div class="row mt-5">
                <div class="col-6 mb-4">
                    <div class="feature-icon">⏱</div>
                    <p>Instant <br />24/7 Payouts</p>
                </div>
                <div class="col-6 mb-4">
                    <div class="feature-icon">🔗</div>
                    <p>Pay via Linked<br /> Bank Accounts</p>
                </div>
                <div class="col-6 mb-4">
                    <div class="feature-icon">💳</div>
                    <p>All Payment Modes</p>
                </div>
                <div class="col-6 mb-4">
                    <div class="feature-icon">🔄</div>
                    <p>Cancel, Pause, or Resume Payouts</p>
                </div>
                <div class="col-6 mb-4">
                    <div class="feature-icon">📅</div>
                    <p>No Cool-off Period</p>
                </div>
                <div class="col-6 mb-4">
                    <div class="feature-icon">📊</div>
                    <p>Get Real-time Insights</p>
                </div>
            </div>
        </div>
        
        <!-- Right Side -->
        <div class="col-lg-6 hero-right">
            <div class="text-center">
                <div class="mb-4 text-light">Drag and drop your bill<br><small>File Supported: CSV & XLSX</small></div>
                <div class="step-box shadow">
                    <h5 style="padding-left:50px">Bulk Payout</h5>
                    <input type="text" placeholder="₹ Amount" class="form-control mb-3">
                    <button class="btn btn-primary w-100">Pay</button>
                </div>
                <div class="mt-4 text-success fw-bold">✔ Transaction Success</div>
            </div>
        </div>
    </div>
</div>

<!-- Bulk payout section -->
<div class="dashboard" id="dashboard" style="display:none;margin-left:10px">
    <h3>Bulk Payout</h3>
    <div class="stats-row">
        <div class="stat">
            <span class="label">FILES UPLOADED</span>
            <span class="value">0</span>
        </div>
        <div class="stat">
            <span class="label">TOTAL PAYOUTS</span>
            <span class="value">0</span>
        </div>
        <div class="stat">
            <span class="label">PROCESSED PAYOUTS</span>
            <span class="value">0</span>
        </div>
        <div class="stat-btn">
             <button id="showReportingBtn" class="btn btn-primary" data-bs-toggle="offcanvas" data-bs-target="#bulkPayoutSidebar" style="background-color: #6e007c;">
        + Bulk Payout
    </button>
        </div>
    </div>

    <!-- Reporting Section Hidden by Default -->
    <div id="reportingSection" style="display:none;">
        <div class="bulk-payout-container">
            <div class="left-panel">
                <div class="search-box">
                    <input type="text" placeholder="Search">
                    <i class="icon">&#128269;</i>
                </div>
                <div class="no-data">No data found</div>
            </div>

            <div class="right-panel">
                <div class="filter-row">
                    <div class="status">
                        <select>
                            <option>Status</option>
                            <option>Pending</option>
                            <option>Completed</option>
                        </select>
                    </div>
                    <div class="select-filter">
                        <select>
                            <option>Select Filter</option>
                        </select>
                    </div>
                    <div class="search-box small">
                        <input type="text" placeholder="Search">
                        <i class="icon">&#128269;</i>
                    </div>
                    <div class="download-buttons">
                        <button class="btn-download">⬇ CSV</button>
                        <button class="btn-download">⬇ XLSX</button>
                    </div>
                </div>

                <table class="bulk-table">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Status</th>
                            <th>Beneficiary</th>
                            <th>Mode</th>
                            <th>Amount (₹)</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr class="empty-row">
                            <td colspan="5">
                                <div class="empty-state">
                                    <p>Your bulk payouts will appear here</p>
                                </div>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
    <!-- Offcanvas Sidebar -->
<div class="offcanvas offcanvas-end" tabindex="-1" id="bulkPayoutSidebar">
    <div class="offcanvas-header">
        <h5 class="offcanvas-title fw-bold">Bulk Payout</h5>
        <button type="button" class="btn-close" data-bs-dismiss="offcanvas"></button>
    </div>
    <div class="offcanvas-body">

        <!-- Alert -->
        <div class="alert alert-warning" role="alert" style="font-size:14px;">
            Bulk payouts via Current Account are active on your account. To activate bulk payouts via the Instantpay Business Account please write to 
            <a href="mailto:help@banku.co.in">help@banku.co.in</a> or get in touch with your Account Manager.
        </div>

        <!-- File Upload Box -->
        <div class="border border-primary border-dashed rounded p-4 text-center mb-4" style="border-style: dashed;">
            <div style="font-size:48px;">⬆️</div>
            <a href="#" class="d-block fw-semibold text-primary mt-2">Browse File</a>
            <small class="text-muted">File Supported (.xlsx, .csv)</small>
        </div>

        <!-- Download Template Buttons -->
        <div class="text-center mb-4">
            <p class="mb-2 fw-semibold">Download Template</p>
            <button class="btn btn-outline-secondary btn-sm me-2">⬇ CSV</button>
            <button class="btn btn-outline-secondary btn-sm">⬇ XLSX</button>
        </div>

        <!-- Notes -->
        <div>
            <p class="mb-1"><strong>Note:</strong></p>
            <ul class="mb-0" style="font-size:14px;">
                <li>The amount disbursed should be in rupees and should not be less than Rs 1.</li>
                <li>The file must be in the correct required format.</li>
                <li>The total payout should be less than the account balance.</li>
            </ul>
        </div>

    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.getElementById("initiateBulkUploadBtn").addEventListener("click", function (e) {
            e.preventDefault();
            // Hide single payout section
            document.getElementById("singlePayoutSection").style.display = "none";

            // Show dashboard
            document.getElementById("dashboard").style.display = "block";

            // Show reporting section directly
            document.getElementById("reportingSection").style.display = "block";
        });
    </script>

    <script>
        document.addEventListener("DOMContentLoaded", function () {
            var offcanvasElement = document.getElementById('bulkPayoutSidebar');
            var offcanvas = new bootstrap.Offcanvas(offcanvasElement);

            // Agar last time open tha to reload ke baad wapas open karo
            if (localStorage.getItem("bulkPayoutOpen") === "true") {
                offcanvas.show();
            }

            // Button click hone par state save karo
            document.getElementById('showReportingBtn').addEventListener('click', function () {
                localStorage.setItem("bulkPayoutOpen", "true");
            });

            // Close hone par state remove karo
            offcanvasElement.addEventListener('hidden.bs.offcanvas', function () {
                localStorage.removeItem("bulkPayoutOpen");
            });
        });
    </script>
</asp:Content>
