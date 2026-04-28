<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/NeoxAdmin.Master" AutoEventWireup="true" CodeBehind="ViewUserBanku.aspx.cs" Inherits="NeoXPayout.Admin.ViewUser" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<link rel="stylesheet" href="../assets/vendor/dataTables.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
<style>
.banku-stat-card {
    border-radius: 18px;
    padding: 22px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    color: white;
    box-shadow: 0 8px 25px rgba(0,0,0,0.08);
    transition: .3s ease;
    min-height: 120px;
}

.banku-stat-card:hover {
    transform: translateY(-4px);
}

.banku-stat-card p {
    margin: 0;
    font-size: 15px;
    opacity: .9;
    font-weight: 500;
}

.banku-stat-card h3 {
    margin-top: 8px;
    font-size: 30px;
    font-weight: 700;
}

.banku-stat-card i {
    font-size: 34px;
    opacity: .85;
}

.seva-card {
    background: linear-gradient(135deg, #4f46e5, #6366f1);
}

.business-card {
    background: linear-gradient(135deg, #0f766e, #14b8a6);
}

.distributor-card {
    background: linear-gradient(135deg, #7c3aed, #a855f7);
}

.warning-card {
    background: linear-gradient(135deg, #f59e0b, #fbbf24);
}

.review-card {
    background: linear-gradient(135deg, #3b82f6, #60a5fa);
}

.success-card {
    background: linear-gradient(135deg, #10b981, #34d399);
}

.danger-card {
    background: linear-gradient(135deg, #ef4444, #f87171);
}
.banku-stat-card {
    border-radius: 20px;
    padding: 22px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    color: white;
    cursor: pointer;
    position: relative;
    overflow: hidden;


    backdrop-filter: blur(10px);


    box-shadow: 0 8px 25px rgba(0,0,0,0.08);

    transition: all 0.3s ease;
}


.banku-stat-card::before {
    content: "";
    position: absolute;
    top: 0;
    left: -100%;
    width: 100%;
    height: 100%;
    background: linear-gradient(120deg, transparent, rgba(255,255,255,0.3), transparent);
    transition: 0.5s;
}

.banku-stat-card:hover::before {
    left: 100%;
}
.banku-stat-card:hover {
    transform: translateY(-6px) scale(1.02);
    box-shadow: 0 15px 35px rgba(0,0,0,0.15);
}
.banku-stat-card.active {
    transform: scale(1.05);
    border: 2px solid #fff;

    /* glow effect */
    box-shadow: 
        0 0 0 3px rgba(255,255,255,0.3),
        0 10px 30px rgba(0,0,0,0.2);
}
.banku-stat-card p {
    margin: 0;
    font-size: 14px;
    opacity: 0.85;
    letter-spacing: 0.5px;
}

.banku-stat-card h3 {
    margin-top: 6px;
    font-size: 32px;
    font-weight: 800;
}

.banku-stat-card i {
    font-size: 36px;
    opacity: 0.9;
    transition: transform 0.3s ease;
}

.banku-stat-card:hover i {
    transform: scale(1.2) rotate(5deg);
}
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <hr />
    <h3 class="mt-4 mb-3 fw-bold" style="color:#2c3e50; font-family:'Segoe UI', Tahoma, sans-serif; margin-left:20px;">
  View User
</h3>

    
<div class="px-xl-5 px-lg-4 px-3 py-3 page-body">

    <div class="row mb-4 g-3" id="accountStats">

    <div class="col-md-4">
        <div class="banku-stat-card seva-card" onclick="applyFilter('account','BankU Seva Kendra')">
            <div>
                <p>BankU Seva Kendra</p>
              <h3 id="sevaCount" runat="server">0</h3>
            </div>
            <i class="fas fa-university"></i>
        </div>
    </div>

    <div class="col-md-4">
        <div class="banku-stat-card business-card" onclick="applyFilter('account','Business & APIs')">
            <div>
                <p>Business & APIs</p>
               <h3 id="businessCount" runat="server">0</h3>
            </div>
            <i class="fas fa-briefcase"></i>
        </div>
    </div>

    <div class="col-md-4">
        <div class="banku-stat-card distributor-card" onclick="applyFilter('account','Distributor')">
            <div>
                <p>Distributor</p>
                <h3 id="distributorCount" runat="server">0</h3>
            </div>
            <i class="fas fa-network-wired"></i>
        </div>
    </div>

</div>
    <div class="row mb-4 g-3" id="kycStats" >

    <div class="col-md-3">
        <div class="banku-stat-card warning-card" onclick="applyFilter('kyc','Pending')">
            <div>
                <p>KYC Pending</p>
                <h3 id="pendingCount" runat="server">0</h3>
            </div>
            <i class="fas fa-clock"></i>
        </div>
    </div>

    <div class="col-md-3">
        <div class="banku-stat-card review-card" onclick="applyFilter('kyc','Review')">
            <div>
                <p>KYC Review</p>
                <h3 id="reviewCount" runat="server">0</h3>
            </div>
            <i class="fas fa-search"></i>
        </div>
    </div>

    <div class="col-md-3">
        <div class="banku-stat-card success-card" onclick="applyFilter('kyc','Approved')">
            <div>
                <p>KYC Approved</p>
                <h3 id="approvedCount" runat="server">0</h3>
            </div>
            <i class="fas fa-check-circle"></i>
        </div>
    </div>

    <div class="col-md-3">
        <div class="banku-stat-card danger-card" onclick="applyFilter('kyc','Rejected')">
            <div>
                <p>KYC Rejected</p>
                <h3 id="rejectedCount" runat="server">0</h3>
            </div>
            <i class="fas fa-times-circle"></i>
        </div>
    </div>

</div>

    

    <div class="row">
        <div class="col-md-4">
       
    </div>
        <div class="col-12">
            <div class="border p-4 rounded-2 rounded-4">    
             
            <div class="d-flex justify-content-end mb-3">
               <%-- <select id="accountTypeFilter" class="form-select" style="max-width:200px">
                    <option value="">All Account Types</option>
                    <option value="BankU Seva Kendra">BankU Seva Kendra</option>
                    <option value="Business & APIs">Business & APIs</option>
                    <option value="Distributor">Distributor</option>
                </select>--%>
                <button class="btn btn-secondary ms-2" type="button" onclick="resetFilter()">Reset</button>
            </div>
              
                <div class="1">
                <table
                    class="table align-middle table-hover dataTable table-body" >
                    <thead>
                       <tr class="small text-uppercase">
                                                 
                            <th>Id</th>
                            <th>FullName</th>
                            <th>MobileNo</th>
                            <th>EmailId</th>                          
                            <th>Reqdate</th>
                            <th>Status</th>
                            <th>Account Type</th>
                            <th>MPIN</th>
                              <th>KycStatus</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <asp:Repeater runat="server" ID="rptProduct">
                        <ItemTemplate>
                                <tr>
                                    <td><%# Eval("RegistrationId") %></td>
                                    <td><%# Eval("FullName") %></td>
                                    <td><%# Eval("MobileNo") %></td>
                                    <td><%# Eval("Email") %></td>                         
                                    <td><%# Eval("RegDate", "{0:dd/MM/yyyy hh:mm tt}") %></td> 
                                   <td 
                                    style='<%# 
                                        Eval("RegistrationStatus").ToString() == "Done" 
                                        ? "color:#155724;padding:1px 8px;border-radius:20px;text-align:center;font-weight:bold;display:inline-block;" 
                                        : "color:#d80000;padding:1px 8px;border-radius:20px;text-align:center;font-weight:bold;display:inline-block;" 
                                    %>'>
                                    <%# Eval("RegistrationStatus") %>
                                </td>
 
                                    <td><%# Eval("AccountType") %></td>
                                    <td><%# Eval("MPIN") %></td>
                                <td>
                                <span style='<%# 
                                    Convert.ToString(Eval("KycStatus")).ToLower() == "approved" ? "color:green;font-weight:bold;" :
                                    Convert.ToString(Eval("KycStatus")).ToLower() == "rejected" ? "color:red;font-weight:bold;" :
                                    "color:orange;font-weight:bold;" %>'>
        
                                    <%# string.IsNullOrWhiteSpace(Convert.ToString(Eval("KycStatus"))) ? "Pending" : Eval("KycStatus") %>
                                </span>
                            </td>
                                    <td><a href="ViewKyc.aspx?id=<%# Eval("RegistrationId") %>" class="btn btn-danger">View Kyc</a></td>                           
                                </tr>
                        </ItemTemplate>
                        </asp:Repeater>                                         
                    </tbody>
          </table>
        </div>
      </div>
    </div>
  </div>
 </div>
    <script>
//document.addEventListener("DOMContentLoaded", function () {

//    const filter = document.getElementById("accountTypeFilter");
//    const rows = document.querySelectorAll("table tbody tr");

//    filter.addEventListener("change", function () {
//        const filterValue = this.value.toLowerCase();

//        rows.forEach(function (row) {

//            if (row.querySelectorAll("td").length === 0) {
//                row.style.display = "";
//                return;
//            }
//            const accountType = row.cells[6]?.innerText.trim().toLowerCase();

//            row.style.display =
//                filterValue === "" || accountType === filterValue
//                    ? ""
//                    : "none";
//        });
//    });

//});
    </script>

<script>
    //document.addEventListener("DOMContentLoaded", function () {

    //    const filter = document.getElementById("accountTypeFilter");
    //    const rows = document.querySelectorAll("table tbody tr");

    //    function updateStats() {

    //        let pending = 0, review = 0, approved = 0, rejected = 0;
    //        let seva = 0, business = 0, distributor = 0;

    //        rows.forEach(function (row) {

    //            if (row.style.display === "none") return;

    //            let kycStatus = row.cells[8]?.innerText.trim().toLowerCase();
    //            let accountType = row.cells[6]?.innerText.trim().toLowerCase();

    //            // KYC COUNTS
    //            if (!kycStatus || kycStatus === "pending")
    //                pending++;
    //            else if (kycStatus === "review")
    //                review++;
    //            else if (kycStatus === "approved")
    //                approved++;
    //            else if (kycStatus === "rejected")
    //                rejected++;

    //            // ACCOUNT TYPE COUNTS
    //            if (accountType === "banku seva kendra")
    //                seva++;
    //            else if (accountType === "business & apis")
    //                business++;
    //            else if (accountType === "distributor")
    //                distributor++;
    //        });

    //        // KYC
    //        document.getElementById("pendingCount").innerText = pending;
    //        document.getElementById("reviewCount").innerText = review;
    //        document.getElementById("approvedCount").innerText = approved;
    //        document.getElementById("rejectedCount").innerText = rejected;

    //        // ACCOUNT
    //        document.getElementById("sevaCount").innerText = seva;
    //        document.getElementById("businessCount").innerText = business;
    //        document.getElementById("distributorCount").innerText = distributor;
    //    }

    //    filter.addEventListener("change", function () {

    //        const filterValue = this.value.toLowerCase();

    //        rows.forEach(function (row) {

    //            const accountType = row.cells[6]?.innerText.trim().toLowerCase();

    //            row.style.display =
    //                filterValue === "" || accountType === filterValue
    //                    ? ""
    //                    : "none";
    //        });

    //        updateStats();
    //    });

    //    updateStats();
    //});
</script>
<script>
    document.addEventListener("DOMContentLoaded", function () {

        const params = new URLSearchParams(window.location.search);
        const type = params.get("type");
        const value = params.get("value");

        if (!type || !value) return;

        // remove active from all
        document.querySelectorAll(".banku-stat-card").forEach(c => c.classList.remove("active"));

        // match and highlight
        if (type === "account") {

            if (value === "BankU Seva Kendra")
                document.querySelector(".seva-card")?.classList.add("active");

            else if (value === "Business & APIs")
                document.querySelector(".business-card")?.classList.add("active");

            else if (value === "Distributor")
                document.querySelector(".distributor-card")?.classList.add("active");
        }

        if (type === "kyc") {

            if (value === "Pending")
                document.querySelector(".warning-card")?.classList.add("active");

            else if (value === "Review")
                document.querySelector(".review-card")?.classList.add("active");

            else if (value === "Approved")
                document.querySelector(".success-card")?.classList.add("active");

            else if (value === "Rejected")
                document.querySelector(".danger-card")?.classList.add("active");
        }

    });

    function applyFilter(type, value) {
        const url = new URL(window.location.href);
        document.querySelectorAll(".banku-stat-card")
            .forEach(c => c.classList.remove("active"));

        event.currentTarget.classList.add("active");

        url.searchParams.set("type", type);
        url.searchParams.set("value", value);

        // reset pagination if you add later
        url.searchParams.set("page", "1");

        window.location.href = url.toString();
    }
    function resetFilter() {
        const url = new URL(window.location.href);

        url.searchParams.delete("type");
        url.searchParams.delete("value");
        url.searchParams.delete("page");

        window.location.href = url.pathname;
    }
</script>

</asp:Content>

