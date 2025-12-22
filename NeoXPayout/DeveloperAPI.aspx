<%@ Page Title="" Language="C#" MasterPageFile="~/Neox.Master" AutoEventWireup="true" CodeBehind="DeveloperAPI.aspx.cs" Inherits="NeoXPayout.DeveloperAPI" %>
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
      box-shadow: 0 4px 12px rgba(0,0,0,0.05);
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

    /* Card Grid */
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
      box-shadow: 0 4px 14px rgba(0,0,0,0.05);
      display: flex;
      flex-direction: column;
      gap: 14px;
      transition: all 0.3s ease;
    }

     .bku-card:hover {
      transform: translateY(-4px);
      box-shadow: 0 6px 18px rgba(0,0,0,0.08);
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

    /* Sidebar */
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

    input, textarea {
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


  <!-- Header -->
  <div class="bku-main-header" style="margin-left:10px">
    <div class="bku-left-header">
      <h2>API Suite</h2>
      <div class="bku-dropdown">
          <asp:DropDownList runat="server" ID="ddlCategory" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlCategory_SelectedIndexChanged">
   
         
          </asp:DropDownList>
      </div>
    </div>
    <div class="bku-right-header">
      <button type="button" class="bku-outline-btn">👨‍💻 developers@banku.co.in</button>
         <button type="button" class="bku-primary-btn" 
            onclick="document.getElementById('CredentialsBackdrop').style.display='flex'">
            Credentials
        </button>
    </div>
  </div>
<%--<div style="text-align: right; margin-bottom: 10px; margin-right:20px">
    <a href="AddAPI.aspx" class="bku-primary-btn">Add API</a>
</div>--%>

         
<asp:Repeater ID="rptCategory" runat="server">
    <ItemTemplate>
        <h2 style="margin-left:20px; margin-top:10px"><b><%# Eval("Category") %></b></h2>
        <br>
        <div class="bku-card-grid" style="margin-left:10px">
            <asp:Repeater ID="rptAPIList" runat="server" DataSource='<%# Eval("APIs") %>'>
                <ItemTemplate>
                    <div class="bku-card" data-api-title="<%# Eval("ApiName") %>">
                        <div class="status-badge" style="display: none;">
                            <span class="status-dot"></span> <%# Eval("Status") %>
                        </div>

                        <%-- Dynamic icon --%>
                        <div class="bku-card-icon">
                            <img src="<%# ResolveUrl(Eval("ApiIcon").ToString()) %>" width="40" height="40" />
                        </div>

                        <div class="bku-card-title"><%# Eval("ApiName") %></div>
                        <div class="bku-card-desc"><%# Eval("ApiDesc") %></div>
                        <button class="bku-activate-btn" 
                                data-api="<%# Eval("ApiName") %>"  
                                data-api-description="<%# Eval("ApiDesc") %>" 
                                type="button" 
                                onclick="openSidebar('<%# Eval("ApiName") %>', this.dataset.apiDescription)">
                            Activate
                        </button>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </ItemTemplate>
</asp:Repeater>

<br /> 
<br /> 
<br /> 


<!-- Sidebar -->
<div class="bku-sidebar" id="sidebar">
<button class="bku-close-btn" type="button" onclick="closeSidebar()">&times;</button>
<h3 id="sidebar-title">Face Comparison</h3>
<p  id="sidebar-description" style="margin-bottom: 10px; color: #555;">Determine the similarity of a face against another in real-time.</p>

<div class="bku-alert-box">
    <strong>⚠️ Attention!</strong><br>
    Sandbox environment is not available for this API.<br>
    <span style="font-weight: bold; color: #d63384;">💰 Price:- ₹50.00 plus gst </span><br />
     <span style="font-weight: bold; color: #d63384;">Sub total:- ₹59.00</span><br />
      <small style="color: red; font-weight: 500;">
        Note: If your request is rejected, the amount will not be refunded.
      </small>
</div>
    <input type="hidden" id="selected-api-title" name="selected-api-title" />
    <asp:Label runat="server" ID="lblerror" CssClass="text-danger"></asp:Label>
    <label for="website-url">Website App URL</label>
    <asp:TextBox id="txtWebsiteUrl" placeholder="Enter your website URL"  runat="server"></asp:TextBox>
    <asp:RequiredFieldValidator ID="rfvWebsiteUrl" runat="server"
        ControlToValidate="txtWebsiteUrl"
        ErrorMessage="Website URL is required."
        Display="Dynamic"
        CssClass="text-danger" 
        ValidationGroup="APIRequest"/>

<label for="use-case">API Use Case</label>
    <asp:TextBox ID="txtUseCase" runat="server" TextMode="MultiLine" placeholder="Describe how you plan to use the API" rows="4" CssClass="form-control" />
    <asp:RequiredFieldValidator ID="rfvUseCase" runat="server"
        ControlToValidate="txtUseCase"
        ErrorMessage="API Use Case is required."
        Display="Dynamic"
        CssClass="text-danger" 
        ValidationGroup="APIRequest"/>

<div class="bku-sidebar-footer">
    <button type="button" id="request-activation-btn"  ValidationGroup="APIRequest">Request Activation</button>
    <asp:LinkButton ID="lnkSaveToDB" runat="server" OnClick="lnkSaveToDB_Click" Style="display:none;"></asp:LinkButton>
<a href="https://app.banku.co.in/Apidocument/Document.aspx">View API Documentation</a>
</div>

</div>


<!-- Setting Drawer -->
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
      <span style="color: purple; font-weight: bold;">&#9432; Attention!</span>
      <span style="font-size: 14px; color: #555;">Access Control is not applicable for Sandbox.</span>
    </div>

    <!-- Approved IP Section -->
    <div style="margin-bottom: 12px; font-weight: bold; font-size: 14px; color: #222;">IP Addresses Whitelist</div>
        <asp:RequiredFieldValidator ID="rfvIP" runat="server" ControlToValidate="txtIP" ValidationGroup="IP" ForeColor="Red" Display="Dynamic" ErrorMessage="Please Enter IP"></asp:RequiredFieldValidator>
        <asp:RegularExpressionValidator 
            ID="revIP" 
            runat="server" 
            ControlToValidate="txtIP"
            ValidationGroup="IP"
            ForeColor="Red"
            Display="Dynamic"
            ErrorMessage="Please enter a valid IP address"
            ValidationExpression="^((\d{1,3}\.){3}\d{1,3}|(([0-9A-Fa-f]{1,4}:){7}[0-9A-Fa-f]{1,4}))$">
        </asp:RegularExpressionValidator>

      <div style="display: flex; gap: 8px; margin-bottom: 8px;">
      
        <asp:TextBox runat="server" ID="txtIP"  placeholder="IP Address" style="flex: 1; border: 1px solid #ccc; border-radius: 8px; padding: 10px; font-size: 14px;"></asp:TextBox>
     
        <asp:LinkButton runat="server" ID="btnAddIP" OnClick="btnAddIP_Click" ValidationGroup="IP" style="background-color:purple; color: white; border: none; border-radius: 8px; padding: 8px 20px; font-weight: bold; cursor: pointer; text-decoration:none;">ADD</asp:LinkButton>
    </div>
    <div style="font-size: 12px; color: #666; margin-bottom: 24px;">
      Both IPv4 and IPv6 addresses along with range are supported
    </div>

         <!-- Approved Callback Section -->
    <div style="margin-bottom: 12px; font-weight: bold; font-size: 14px; color: #222;">CallBack Whitelist</div>
       <asp:RequiredFieldValidator ID="rfvCallBack" runat="server" ControlToValidate="txtCallBack" ValidationGroup="Callback" ForeColor="Red" Display="Dynamic" ErrorMessage="Please Enter CallBack"></asp:RequiredFieldValidator>
    <asp:RegularExpressionValidator 
    ID="revCallbackUrl" runat="server" ControlToValidate="txtCallBack" ValidationGroup="Callback" Display="Dynamic" ForeColor="Red" ErrorMessage="Please enter a valid URL."
    ValidationExpression="^(https?:\/\/)?([\w\-]+\.)+[\w\-]+(\/[\w\-.,@?^=%&amp;:/~+#]*)?$">
</asp:RegularExpressionValidator>

      <div style="display: flex; gap: 8px; margin-bottom: 8px;">
      
        <asp:TextBox runat="server" ID="txtCallBack"  placeholder="CallBack" style="flex: 1; border: 1px solid #ccc; border-radius: 8px; padding: 10px; font-size: 14px;"></asp:TextBox>
      
        <asp:LinkButton runat="server" ID="btnAddCallback" OnClick="btnAddCallback_Click" ValidationGroup="Callback" style="background-color:purple; color: white; border: none; border-radius: 8px; padding: 8px 20px; font-weight: bold; cursor: pointer; text-decoration:none;">ADD</asp:LinkButton>
    </div>
    

    <!-- Saved IP -->
    <div style="margin-bottom: 6px; font-weight: bold; font-size: 14px; color: #222;">Saved IP Address</div>
    <asp:Label runat="server" id="lblIP" style="display: flex; align-items: center; gap: 6px; font-size: 14px; color: #000;">
    </asp:Label>

      <!-- Saved Callback -->
    <div style="margin-bottom: 6px; margin-top:10px; font-weight: bold; font-size: 14px; color: #222;">Saved CallBack</div>
    <asp:Label runat="server" id="lblCallback" style="display: flex; align-items: center; gap: 6px; font-size: 14px; color: #000;">
    </asp:Label>


        <%--<span style="cursor: pointer; color: #999;">🗑</span>--%>
    <!-- Footer link -->
    <div style="position: absolute; bottom: 16px; left: 0; right: 0; text-align: center;">
      <a href="https://app.banku.co.in/Apidocument/Document.aspx" style="color: purple; font-size: 14px; text-decoration: none;">&#128279; View API Documentation</a>
    </div>

  </div>
</div>


<div id="CredentialsBackdrop" style="position: fixed; top: 0; right: 0; width: 100%; height: 100%;
     background: rgba(0, 0, 0, 0.5); z-index: 9998; display: none; align-items: flex-start; justify-content: flex-end;">

  <div style="background: #fff; width: 420px; height: 100vh; box-shadow: -2px 0 12px rgba(0,0,0,0.15); padding: 24px; position: relative; overflow-y:auto;">

    <!-- Header -->
    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 24px; ">
      <h2 style="margin: 0; font-size: 20px; font-weight: 600;  color:purple">Credentials</h2>
      <button onclick="document.getElementById('CredentialsBackdrop').style.display='none'" type="button"
        style="background: transparent; border: none; font-size: 28px; line-height: 1; cursor:pointer;">&times;</button>

    </div>
     
    <!-- Client ID -->
    <div style="margin-bottom: 20px;">
      <label style="font-weight: 600; display:block; margin-bottom: 6px; font-size: 14px;">Client ID</label>
      <asp:label runat="server" ID="lblKey"
             style="width:100%; padding:10px; border:1px solid #ddd; border-radius:6px; font-size:14px; background:#f9f9f9;"></asp:label>
    </div>

    <!-- Encryption Key -->
    <div style="margin-bottom: 20px;">
      <label style="font-weight: 600; display:block; margin-bottom: 6px; font-size: 14px;">Client Mobile Number</label>
      <asp:label runat="server" ID="lblnumber"
             style="width:100%; padding:10px; border:1px solid #ddd; border-radius:6px; font-size:14px; background:#f9f9f9;"></asp:label>
    </div>

    <!-- Client Secret -->
    <%--<div style="margin-bottom: 20px;">
      <label style="font-weight: 600; display:block; margin-bottom: 6px; font-size: 14px;">Client Secret</label>
      <div style="display:flex; gap:10px;">
        <button id="sandboxBtn"  onclick="selectMode('sandbox')"  title="Existing sandbox Client Secret Will stop authentication" style="flex:1; background:#FFB74D; color:#fff; border:none; border-radius:6px; padding:8px 12px; font-size:14px; cursor:pointer;" type="button">Sandbox</button>
        <button id="productionBtn" onclick="selectMode('production')" title="Existing production Client Secret Will stop authenticating!" style="flex:1; background:#f2f2f2; color:#333; border:none; border-radius:6px; padding:8px 12px; font-size:14px; cursor:pointer;" type="button">Production</button>
      </div>
    </div>--%>

    <!-- Key Verification -->
    <%--<div style="margin-bottom: 20px;">
      <label style="font-weight: 600; display:block; margin-bottom: 6px; font-size: 14px;">Key Verification</label>
      <div style="display:flex; align-items:center; gap:10px;">
        <input type="text" placeholder="Verify Secret Key"
               style="flex:1; padding:10px; border:1px solid #ddd; border-radius:6px; font-size:14px;">
        <button style="background:#4A4EE0; color:#fff; border:none; border-radius:6px; padding:8px 16px; font-size:14px; cursor:pointer; margin-top:-15px" type="button">Done</button>
      </div>
    </div>--%>


    <!-- Footer -->
    <div style="position: absolute; bottom: 20px; left: 0; right: 0; text-align: center;">
        <button type="button" style="color:#4A4EE0; font-size: 14px;background-color:white; text-decoration:none;border:none" onclick="document.getElementById('Webhook').style.display='flex'">Webhook Setup</button>
    </div>

  </div>
</div>

<div id="Webhook" style="position: fixed; top: 0; right: 0; width: 100%; height: 100%;
     background: rgba(0, 0, 0, 0.5); z-index: 9998; display: none; align-items: flex-start; justify-content: flex-end;">

  <div style="background: #fff; width: 420px; height: 100vh; box-shadow: -2px 0 12px rgba(0,0,0,0.15); padding: 24px; position: relative; overflow-y:auto;">

    <!-- Header -->
    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 24px; ">
      <h2 style="margin: 0; font-size: 20px; font-weight: 600;">Webhook</h2>
      <button onclick="document.getElementById('Webhook').style.display='none'" type="button"
        style="background: transparent; border: none; font-size: 28px; line-height: 1; cursor:pointer;">&times;</button>
    </div>

       <!-- Revoke Secret Key -->
    <div style="margin-bottom: 20px;">
        <p style="margin-top:10px; font-size:14px; text-decoration:none;">Simply pause your payments at any time and resume whenever you're ready. We will keep your account information secure, preserving your benefits until you resume your services.</p>
        <asp:TextBox runat="server" ID="txturl" TextMode="MultiLine"  placeholder="URL" Rows="4" ></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ValidationGroup="Url" ErrorMessage="URL is Required" ControlToValidate="txturl" Display="Dynamic" SetFocusOnError="True" ForeColor="Red"></asp:RequiredFieldValidator>
    </div>
   <div style="margin-bottom: 20px; text-align: center;">
       <asp:LinkButton runat="server" ID="btnurl" ValidationGroup="Url"
          style="background-color:#4A4EE0; color:#fff; font-size: 14px; text-decoration:none;  padding: 10px 20px; border: none; border-radius: 8px; cursor: pointer; font-weight: 600;box-shadow: 0 4px 6px rgba(0,0,0,0.1);">Proceed</asp:LinkButton>
   </div>

      <!-- Footer -->
   <%-- <div style="position: absolute; bottom: 20px; left: 0; right: 0; text-align: center;">
        <button type="button" style="color:#4A4EE0; font-size: 14px;background-color:white; text-decoration:none;border:none">Proceed</button>
    </div>--%>
  </div>
</div>

<div class="modal fade" id="successModal" tabindex="-1" aria-labelledby="successModalLabel" aria-hidden="true"
        data-bs-backdrop="static" data-bs-keyboard="false">
    <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content shadow-lg rounded-3 text-center">
      
        <!-- Modal Header -->
        <div class="modal-header bg-success text-white border-0">
        <%--<h5 >Transaction Successful</h5>--%>
            <asp:Label runat="server" class="modal-title w-100" id="successModalLabel"></asp:Label>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
        </div>
      
        <!-- Modal Body -->
        <div class="modal-body">
        <img src="https://cdn-icons-png.flaticon.com/512/845/845646.png" 
                alt="Success" class="mb-3" width="80" height="80" />
            <asp:Label CssClass="fw-semibold" ID="lblSuccessMsg" runat="server"></asp:Label>
           
        <button type="button" class="btn btn-success w-100" data-bs-dismiss="modal">OK</button>
        </div>
      
    </div>
    </div>
</div>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<%--<script>
    function selectMode(mode) {
        const sandboxBtn = document.getElementById("sandboxBtn");
        const productionBtn = document.getElementById("productionBtn");

        if (mode === "sandbox") {
            sandboxBtn.style.background = "#FFB74D";
            sandboxBtn.style.color = "#fff";
            productionBtn.style.background = "#f2f2f2";
            productionBtn.style.color = "#333";
        } else {
            productionBtn.style.background = "#4CAF50"; 
            productionBtn.style.color = "#fff";
            sandboxBtn.style.background = "#f2f2f2";
            sandboxBtn.style.color = "#333";
        }
    }
</script>--%>

  <script>
      let currentActivateButton = null;

      document.addEventListener("DOMContentLoaded", function () {
          const activateButtons = document.querySelectorAll(".bku-activate-btn");
          const requestButton = document.getElementById("request-activation-btn");

          activateButtons.forEach(btn => {
              btn.addEventListener("click", function () {
                  currentActivateButton = this;
                  const title = this.closest(".bku-card").querySelector(".bku-card-title").innerText;
                  const description = this.dataset.apiDescription; 
                  openSidebar(title, description);
              });
          });

          // Handle Request Activation
          requestButton.addEventListener("click", function () {
              const websiteInput = document.getElementById("<%= txtWebsiteUrl.ClientID %>");
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

      function openSidebar(title, description) {
        
          document.getElementById("sidebar-title").innerText = title;
          document.getElementById("sidebar").classList.add("active");
          document.getElementById("sidebar-description").innerText = description;
          document.getElementById("selected-api-title").value = title;

         
          document.getElementById("<%= txtWebsiteUrl.ClientID %>").value = "";
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
            const card = document.querySelector(`.bku-card[data-api-title="${api.Title}"]`);
            const btn = document.querySelector(`button[data-api="${api.Title}"]`);
            if (!card || !btn) return;

            if (api.Status === "Processing") {
                btn.innerHTML = `<span class="spinner">⏳</span> Processing...`;
                btn.disabled = true;
                btn.style.backgroundColor = "#ffffff";
                btn.style.color = "orange";
            } else if (api.Status === "Approved") {
                btn.innerHTML = `Settings`;
                btn.disabled = false;
                btn.style.backgroundColor = "#e0f7fa";
                btn.style.color = "green";

                // Show the status badge
                const badge = card.querySelector(".status-badge");
                if (badge) {
                    badge.style.display = "flex";
                }

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

        document.getElementById('bankuSetting').style.display = "flex";
    }
</script>



</asp:Content>
