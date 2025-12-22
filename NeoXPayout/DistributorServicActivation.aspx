<%@ Page Title="" Language="C#" MasterPageFile="~/Neox.Master" AutoEventWireup="true" CodeBehind="DistributorServicActivation.aspx.cs" Inherits="NeoXPayout.DistributorServicActivation" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
   <style>
    :root {
      --purple: #6e007c;
      --bg: #f9fafb;
      --text-dark: #1f2937;
      --text-light: #6b7280;
      --card-bg: #ffffff;
    }

    * {
      box-sizing: border-box;
      margin: 0;
      padding: 0;
      font-family: 'Inter', sans-serif;
    }

    .bku-main-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin: 20px 0;
      padding: 20px;
      background-color: var(--card-bg);
      border-radius: 16px;
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
    }

    .bku-left-header {
      display: flex;
      align-items: center;
      gap: 20px;
    }

    .bku-left-header h2 {
      font-size: 1.5rem;
      font-weight: 600;
      color: var(--text-dark);
    }

    .bku-dropdown select {
      padding: 10px 14px;
      border-radius: 10px;
      border: 1px solid #e5e7eb;
      font-size: 14px;
      background-color: white;
      cursor: pointer;
    }

    .bku-right-header {
      display: flex;
      gap: 10px;
    }

    .bku-outline-btn {
      display: flex;
      align-items: center;
      gap: 6px;
      padding: 10px 14px;
      border: 1px solid #d1d5db;
      border-radius: 10px;
      background-color: white;
      color: var(--text-dark);
      font-size: 14px;
      cursor: pointer;
      transition: all 0.2s ease-in-out;
    }

    .bku-outline-btn:hover {
      background-color: #f3f4f6;
    }

    .bku-primary-btn {
      padding: 10px 16px;
      background-color: var(--purple);
      color: white;
      border: none;
      border-radius: 10px;
      font-weight: 600;
      cursor: pointer;
      font-size: 14px;
      transition: all 0.2s ease-in-out;
    }

    .bku-primary-btn:hover {
      background-color: #6e007c;
    }

    .bku-card-grid {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(260px, 1fr));
      gap: 24px;
      margin-top: 4px;
    }

    .bku-card {
      background: var(--card-bg);
      border-radius: 16px;
      padding: 24px;
      box-shadow: 0 4px 14px rgba(0, 0, 0, 0.05);
      display: flex;
      flex-direction: column;
      gap: 14px;
      transition: all 0.3s ease;
    }

    .bku-card:hover {
      transform: translateY(-4px);
      box-shadow: 0 6px 18px rgba(0, 0, 0, 0.08);
    }

    .bku-card-icon {
      background-color: #ede9fe;
      color: var(--purple);
      border-radius: 10px;
      width: 44px;
      height: 44px;
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 20px;
    }

    .bku-card-title {
      font-size: 1.1rem;
      font-weight: 600;
      color: var(--text-dark);
    }

    .bku-card-desc {
      font-size: 0.9rem;
      color: var(--text-light);
    }

    .bku-activate-btn {
      align-self: flex-end;
      background-color: var(--purple);
      color: white;
      border: none;
      padding: 8px 16px;
      border-radius: 8px;
      font-size: 14px;
      cursor: pointer;
      transition: background 0.2s ease;
    }

    .bku-activate-btn:hover {
      background-color: #6e007c;
    }

    .bku-sidebar {
      position: fixed;
      top: 120px;
      right: -420px;
      width: 360px;
      height: calc(100% - 80px);
      background-color: #ffffff;
      box-shadow: -2px 0 16px rgba(0, 0, 0, 0.1);
      transition: right 0.3s ease-in-out;
      padding: 24px;
      z-index: 999;
      overflow-y: auto;
      border-radius: 16px 0 0 16px;
    }

    .bku-sidebar.active {
      right: 0;
    }

    .bku-sidebar h3 {
      margin-bottom: 10px;
      color: var(--purple);
      font-size: 1.2rem;
    }

    .bku-close-btn {
      position: absolute;
      top: 16px;
      right: 20px;
      background: none;
      border: none;
      font-size: 22px;
      cursor: pointer;
      color: var(--text-dark);
    }

    .bku-alert-box {
      background-color: #eef2ff;
      border-left: 4px solid var(--purple);
      padding: 10px 12px;
      border-radius: 8px;
      margin-bottom: 20px;
      font-size: 14px;
      color: #333;
    }

    label {
      font-weight: 600;
      margin-bottom: 6px;
      display: block;
      font-size: 14px;
    }

    input {
      width: 100%;
      padding: 10px;
      margin-bottom: 16px;
      border: 1px solid #d1d5db;
      border-radius: 8px;
      font-size: 14px;
    }

    .bku-sidebar-footer {
      margin-top: 20px;
    }

    .bku-sidebar-footer button {
      width: 100%;
      padding: 12px;
      background-color: var(--purple);
      color: white;
      border: none;
      border-radius: 10px;
      cursor: pointer;
      font-size: 15px;
      font-weight: 600;
    }

    .bku-sidebar-footer a {
      color: var(--purple);
      text-decoration: underline;
      display: block;
      margin-top: 12px;
      text-align: center;
      font-size: 14px;
    }

     .spinner {
  display: inline-block;
  animation: spin-stop 3s ease-in-out infinite;
}

@keyframes spin-stop {
  0%   { transform: rotate(0deg); }
  45%  { transform: rotate(180deg); }
  55%  { transform: rotate(180deg); } /* pause */
  100% { transform: rotate(360deg); }
}

.status-badge {
  position: absolute;
  top: 10px;
  right: 10px;
  background-color: #f1f3f9;
  color: #2e3a59;
  padding: 4px 10px;
  border-radius: 999px;
  font-size: 13px;
  display: flex;
  align-items: center;
  font-weight: 500;
  box-shadow: 0 1px 3px rgba(0,0,0,0.1);
}

.status-dot {
  height: 10px;
  width: 10px;
  background-color: #34a853;
  border-radius: 50%;
  display: inline-block;
  margin-right: 6px;
}

.bku-card {
  position: relative; /* Needed to anchor the badge */
}


  </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<br />

  <!-- Card Grid -->
  <div class="bku-card-grid" style="margin-left:10px">
    <div class="bku-card" data-api-title="Distributor for BankU Seva Kendra">
        <div class="status-badge" style="display: none;">
            <span class="status-dot"></span> Active
          </div>
      <div class="bku-card-icon">👥</div>
      <div class="bku-card-title">Distributor for BankU Seva Kendra</div>
      <div class="bku-card-desc">Become a BankU Seva Kendra Distributor...</div>
      <button class="bku-activate-btn" data-api="Distributor for BankU Seva Kendra" type="button">Activate</button>
    </div>

    <div class="bku-card" data-api-title="Distributor for Soundbox & Pos">
        <div class="status-badge" style="display: none;">
            <span class="status-dot"></span> Active
          </div>
      <div class="bku-card-icon">💳</div>
      <div class="bku-card-title">Distributor for Soundbox & Pos</div>
      <div class="bku-card-desc">Become a Distributor for Soundbox & POS machines...</div>
      <button class="bku-activate-btn" data-api="Distributor for Soundbox & Pos" type="button" >Activate</button>
    </div>

    <div class="bku-card" data-api-title="API Reseller Associate">
        <div class="status-badge" style="display: none;">
            <span class="status-dot"></span> Active
          </div>
      <div class="bku-card-icon">🔌</div>
      <div class="bku-card-title">API Reseller Associate</div>
      <div class="bku-card-desc">Become an API Reseller Partner with BankU India...</div>
      <button class="bku-activate-btn" data-api="API Reseller Associate" type="button" >Activate</button>
    </div>

    <%--<div class="bku-card" data-api-title="Verification FI Agency">
        <div class="status-badge" style="display: none;">
            <span class="status-dot"></span> Active
          </div>
      <div class="bku-card-icon">🔌</div>
      <div class="bku-card-title">Verification FI Agency</div>
      <div class="bku-card-desc">Field partner that verifies customer documents...</div>
      <button class="bku-activate-btn" data-api="Verification FI Agency" type="button" >Activate</button>
    </div>

    <div class="bku-card" data-api-title="Recovery Agency">
        <div class="status-badge" style="display: none;">
            <span class="status-dot"></span> Active
          </div>
      <div class="bku-card-icon">🔌</div>
      <div class="bku-card-title">Recovery Agency</div>
      <div class="bku-card-desc">Responsible for recovering pending dues...</div>
      <button class="bku-activate-btn" data-api="Recovery Agency" type="button" >Activate</button>
    </div>--%>

    <div class="bku-card" data-api-title="State Level Branch Associate">
        <div class="status-badge" style="display: none;">
            <span class="status-dot"></span> Active
          </div>
      <div class="bku-card-icon">🔌</div>
      <div class="bku-card-title">State Level Branch Associate</div>
      <div class="bku-card-desc">Manages regional presence and recovery support...</div>
      <button class="bku-activate-btn" data-api="State Level Branch Associate" type="button" >Activate</button>
    </div>
  </div>

  <div class="bku-sidebar" id="sidebar" >
    <button class="bku-close-btn" type="button" onclick="closeSidebar()">&times;</button>
    <h3 id="sidebar-title"></h3>
    <p style="margin-bottom: 10px; color: #555;">One-time non-refundable fee for joining BankU Distributor & API Reseller.</p>

    <div class="bku-alert-box">
      <strong>⚠️ Attention!</strong><br />
      ₹ 10,000 + 18% GST <br />
      <b>Sub Total:-</b> 11,900.00 <span style="font-size: x-small;">non-refundable fee</span>
    </div>

      <input type="hidden" id="selected-api-title" name="selected-api-title" />

    <label for="bku-website-url">Team Size</label>
   
     
      <asp:TextBox ID="txtUseCase" runat="server" placeholder="Enter your team size" CssClass="form-control" />
      <asp:RequiredFieldValidator ID="rfvUseCase" runat="server"
            ControlToValidate="txtUseCase"
            ErrorMessage="Team Size is required."
            Display="Dynamic"
            CssClass="text-danger" 
           ValidationGroup="APIRequest"/>

    <div class="bku-sidebar-footer">
      <button type="button" id="request-activation-btn"  ValidationGroup="APIRequest">Request Activation</button>
        <asp:LinkButton ID="lnkSaveToDB" runat="server"  OnClick="lnkSaveToDB_Click" Style="display:none;"></asp:LinkButton>
      <a href="#">View Business Model</a>
    </div>
  </div>

<!-- Account Statement Drawer -->
<div id="bankuSetting" style="position: fixed; top: 0; right: 0; width: 100%; height: 100%;
     background: rgba(0, 0, 0, 0.5); z-index: 9998; display: none; align-items: flex-start; justify-content: flex-end; font-family: Arial, sans-serif;">

  <div style="background: #fff; width: 500px; height: 100vh; box-shadow: -2px 0 12px rgba(0,0,0,0.15); padding: 24px; position: relative; overflow-y: auto;">
       
    <!-- Header -->
    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 24px;">
      <h2 style="margin: 0; font-size: 22px; font-weight: 700;">Account Statement</h2>
      <button onclick="document.getElementById('bankuSetting').style.display='none'" type="button"
        style="background: transparent; border: none; font-size: 28px; line-height: 1; cursor: pointer;">&times;</button>
    </div>

    <!-- Description -->
    <div style="display: flex; gap: 12px; margin-bottom: 20px;">
      <div style="background: #f4f6fb; padding: 12px; border-radius: 12px; display: flex; align-items: center; justify-content: center;">
        <span style="font-size: 24px;">₹</span>
      </div>
      <p style="margin: 0; color: #555; font-size: 14px; line-height: 1.5;">
        Fetch Statement of your BankU Business Wallet, Collect Orders and all other Bank Accounts 
        that you have linked with your BankU account.
      </p>
    </div>

    <!-- Info Alert -->
    <div style="border: 1px solid #d0e3ff; background: #f4f9ff; padding: 12px; border-radius: 8px; display: flex; gap: 8px; margin-bottom: 24px;">
      <span style="color: #0056d2; font-weight: bold;">&#9432; Attention!</span>
      <span style="font-size: 14px; color: #555;">Access Control is not applicable for Sandbox.</span>
    </div>

    <!-- Approved IP Section -->
    <div style="margin-bottom: 12px; font-weight: bold; font-size: 14px; color: #222;">Approved IP Addresses</div>
    <div style="display: flex; gap: 8px; margin-bottom: 8px;">
      <input type="text" placeholder="IP Address" style="flex: 1; border: 1px solid #ccc; border-radius: 8px; padding: 10px; font-size: 14px;">
      <button type="button" style="background: #0056d2; color: white; border: none; border-radius: 8px; padding: 0 20px; font-weight: bold; cursor: pointer;">ADD</button>
    </div>
    <div style="font-size: 12px; color: #666; margin-bottom: 24px;">
      Both IPv4 and IPv6 addresses along with range are supported
    </div>

    <!-- Saved IP -->
    <div style="margin-bottom: 6px; font-weight: bold; font-size: 14px; color: #222;">Saved IP Address</div>
    <div style="display: flex; align-items: center; gap: 6px; font-size: 14px; color: #000;">
      103.205.142.34 
      <span style="cursor: pointer; color: #999;">🗑</span>
    </div>

    <!-- Footer link -->
    <div style="position: absolute; bottom: 16px; left: 0; right: 0; text-align: center;">
      <a href="#" style="color: #0056d2; font-size: 14px; text-decoration: none;">&#128279; View API Documentation</a>
    </div>

  </div>
</div>


<script>
    let currentActivateButton = null;

    document.addEventListener("DOMContentLoaded", function () {
        const activateButtons = document.querySelectorAll(".bku-activate-btn");
        const requestButton = document.getElementById("request-activation-btn");


        activateButtons.forEach(btn => {
            btn.addEventListener("click", function () {
                currentActivateButton = this;
                const title = this.closest(".bku-card").querySelector(".bku-card-title").innerText;

                openSidebar(title);
            });
        });

        requestButton.addEventListener("click", function () {

            const useCaseInput = document.getElementById("<%= txtUseCase.ClientID %>");


            if (typeof (Page_ClientValidate) === "function") {
                if (!Page_ClientValidate("APIRequest")) {
                    return;
                }
            }

            if (currentActivateButton) {
                currentActivateButton.innerHTML = `<span class="spinner">⏳</span> Processing...`;
                currentActivateButton.style.backgroundColor = "#ffffff";
                currentActivateButton.style.color = "orange";
                currentActivateButton.disabled = true;
            }


            document.getElementById("<%= lnkSaveToDB.ClientID %>").click();
                closeSidebar();

          });
      });

      function openSidebar(title) {         
          document.getElementById("sidebar-title").innerText = title;
          document.getElementById("sidebar").classList.add("active");       
          document.getElementById("selected-api-title").value = title;         
        
          document.getElementById("<%= txtUseCase.ClientID %>").value = "";
      }

      function closeSidebar() {
          document.getElementById("sidebar").classList.remove("active");
      }
</script>
<script>
    function setApiStatusButtons(apiStatusList) {
        if (!Array.isArray(apiStatusList)) return;

        apiStatusList.forEach(api => {
            const card = Array.from(document.querySelectorAll('.bku-card'))
                .find(el => el.getAttribute('data-api-title').toLowerCase() === api.Title.toLowerCase());

            const btn = card ? card.querySelector(`button[data-api]`) : null;
            if (!card || !btn) return;

            if (api.Status === "Processing") {
                btn.innerHTML = `<span class="spinner">⏳</span> Processing...`;
                btn.disabled = true;
                btn.style.backgroundColor = "#ffffff";
                btn.style.color = "orange";
            }
            else if (api.Status === "Approved") {
                btn.innerHTML = `Settings`;
                btn.disabled = false;
                btn.style.backgroundColor = "#e0f7fa";
                btn.style.color = "green";

                const badge = card.querySelector(".status-badge");
                if (badge) badge.style.display = "flex";
                btn.onclick = () => openSettings(api.Title);
            }
            else if (api.Status === "Rejected") {
                btn.innerHTML = `Rejected`;
                btn.disabled = true;
                btn.style.backgroundColor = "#f8d7da"; // Light red
                btn.style.color = "#ffffff"; // White text
            }
        });
    }
    function openSettings(title) {
        // Optional: change modal title dynamically
        const modalTitle = document.querySelector("#bankuSetting h2");
        if (modalTitle) {
            modalTitle.textContent = title + " Settings";
        }

        // Show the modal

        document.getElementById('bankuSetting').style.display = "flex";
    }
</script>


</asp:Content>

