<%@ Page Title="" Language="C#" MasterPageFile="~/APIDocument/developer.Master" AutoEventWireup="true" CodeBehind="Document.aspx.cs" Inherits="NeoXPayout.APIDocument.Document" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<%--    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">--%>
<style>
.col-md-4 
{
  display: flex;            
  flex-direction: column;  
}
BankU-Badge
{
    background-color:purple;
    color:white;
    border-radius:5px
}
</style>

<%--    table fix row and column --%>
    <style>
table {
    width: 100%;
    border-collapse: collapse;
    font-family: "Segoe UI", Arial, sans-serif;
}

table, th, td {
    border: 1px solid #ddd;
}

th {
    background-color: #f1f1f1;
    font-weight: 600;
    text-align: left;
    padding: 10px;
}

td {
    padding: 10px;
}

/* Zebra rows */
tr:nth-child(even) {
    background-color: #f9f9f9;
}
</style>
<%--    <style>
table {
    width: 100%;
    border-collapse: collapse;
}

table, th, td {
    border: 1px solid #ddd;
}

th, td {
    padding: 8px;
}
</style>--%>

  <%--  end--%>

   <%-- request and response css --%>
    <style>
 .code-container {
    position: relative;
    padding: 10px;
    background: #f2f0f0;
    border-radius: 6px;
    margin-bottom: 20px; /* spacing between multiple blocks */
}

.code-block pre {
    background: #1e1e1e;
    color: #d4d4d4;
    padding: 15px;
    border-radius: 6px;
    max-height: 450px;       /* taller scrollable block */
    overflow-y: auto;        /* vertical scroll */
    overflow-x: auto;        /* horizontal scroll for long lines */
    white-space: pre;        /* preserve exact formatting */
    text-align: left;        /* left-aligned text */
    font-family: Consolas, monospace; 
    font-size: 14px;
    line-height: 1.5;        /* readability */
    scroll-behavior: smooth; /* smooth scrolling */
}

.copy-btn {
    position: absolute;
    top: 10px;
    right: 10px;
    border: none;
    background: #007bff;
    color: white;
    font-size: 13px;
    padding: 5px 10px;
    border-radius: 4px;
    cursor: pointer;
}

.copy-btn:hover {
    background: #0056b3;
}
 
    </style>
   <%-- end--%>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
   <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true" />

    <div class="container text-center py-5" style="max-width: 900px;">
       
        <h3 class="fw-bold mb-4" style="font-size:2rem; color:purple">
            Welcome to the BankU Developer<br /> Documentation
        </h3>

        <p class="lead text-secondary mb-4" style="font-size:1.1rem; line-height:1.6;">
            The BankU Developer Documentation provides a comprehensive resource for developers
            seeking to integrate and optimize BankU’s solutions. Within this documentation, you
            will find detailed API references, step-by-step setup guides, and integration instructions,
            all crafted to ensure a seamless development experience.
        </p>

      
        <button type="button" class="btn btn-light border shadow-sm px-4 py-2 mb-5">
            <i class="bi bi-search"></i> Search
        </button>
    </div>

<div style="height:4px; background-color:#800080; width:100%;"></div>




    <!-- Bottom Navigation Tabs -->
  <div class="pt-3 pb-3 bg-white">
  <div class="container"  style="max-width:1300px">

    <!-- Nav tabs -->
    <ul class="nav nav-tabs justify-content-center flex-wrap sticky-top bg-white shadow-sm" id="myTab" role="tablist">
      <li class="nav-item" role="presentation">
        <button class="nav-link active" id="home-tab" data-bs-toggle="tab" data-bs-target="#home"
          type="button" role="tab" aria-controls="home" aria-selected="true">
          <i class="bi bi-house-door"></i> Home
        </button>
      </li>
      <li class="nav-item" role="presentation">
        <button class="nav-link" id="guides-tab" data-bs-toggle="tab" data-bs-target="#guides"
          type="button" role="tab" aria-controls="guides" aria-selected="false">
          <i class="bi bi-book"></i> Guides
        </button>
      </li>
      <li class="nav-item" role="presentation">
        <button class="nav-link" id="api-tab" data-bs-toggle="tab" data-bs-target="#api"
          type="button" role="tab" aria-controls="api" aria-selected="false">
          <i class="bi bi-code-slash"></i> API Reference
        </button>
      </li>
      <li class="nav-item" role="presentation">
        <button class="nav-link" id="changelog-tab" data-bs-toggle="tab" data-bs-target="#changelog"
          type="button" role="tab" aria-controls="changelog" aria-selected="false">
          <i class="bi bi-megaphone"></i> Changelog
        </button>
      </li>
    </ul>

    <!-- Tab panes -->
    <div class="tab-content pt-4" id="myTabContent">

     <div class="tab-pane fade show active" id="home" role="tabpanel" aria-labelledby="home-tab">
      <div class="container py-4">
        <div class="row">
      
          <!-- Jumpstart -->
         <%-- <div class="col-md-4 mb-4">
            <h6 class="fw-bold border-bottom pb-1" style="color:purple">Jumpstart</h6>
            <ul class="list-unstyled">
              <li><a href="#" class="text-dark text-decoration-none" onclick="openApiTab('jumpstart-overview')">Overview</a></li>
            </ul>
          </div>--%>

          <!-- AI & ML -->
             <asp:Repeater ID="Repeater1" runat="server" OnItemDataBound="Repeater1_ItemDataBound" >
                    <ItemTemplate>
            <div class="col-md-4 mb-4">
              <h6 class="fw-bold border-bottom pb-1" style="color:purple"><%# Eval("Category") %></h6>
              <ul class="list-unstyled">
                  <asp:Repeater ID="apiname" runat="server">
                      <ItemTemplate>
                <li class="d-flex justify-content-between align-items-center">

                    <a href="javascript:void(0);" 
   class="text-dark text-decoration-none"
   onclick="GetAPIDetail(<%# Eval("Id") %>); openApiTab();">
   <%# Eval("APIName") %>
</a>

    <%--              <a href="javascript:void(0);" 
   class="text-dark text-decoration-none"
   onclick="GetAPIDetail(<%# Eval("Id") %>);">
   <%# Eval("APIName") %>
</a>--%>
                  <span class='badge <%# Eval("APIType").ToString().ToLower() == "get" ? "bg-success" : "bg-primary" %> small'>
    <%# Eval("APIType") %>
</span>
                </li>
                          </ItemTemplate>

              </asp:Repeater>

                   
                    

             
              </ul>
            </div>
                  </ItemTemplate>
                 </asp:Repeater>
        

        </div>
      </div>
    </div>


      <div class="tab-pane fade" id="guides" role="tabpanel" aria-labelledby="guides-tab" >
      <div class="container-fluid">
        <div class="row">
      
          <!-- Sidebar Nav -->
           
          <div class="col-md-4 col-lg-3 bg-light border-end vh-100 overflow-auto p-3" style="position: sticky; top: 0;">
              <h6 class="text-uppercase fw-bold small mb-3">Documentation</h6>
              <ul class="nav flex-column mb-4" id="guidesSidebar" role="tablist">
                <li class="nav-item">
                  <a class="nav-link active" id="getting-started-tab" style="color:purple" data-bs-toggle="tab" href="#getting-started" role="tab" aria-controls="getting-started" aria-selected="true">
                    Getting Started with BankU
                  </a>
                </li>
                <li class="nav-item">
                  <a class="nav-link" id="webhooks-tab" style="color:purple" data-bs-toggle="tab" href="#webhooks" role="tab" aria-controls="webhooks" aria-selected="false">
                    Webhooks
                  </a>
                </li>

                <h6 class="text-uppercase fw-bold small mb-3 mt-3">Knowledge Base</h6>
                <li class="nav-item">
                  <a class="nav-link" id="integration-credentials-tab" style="color:purple" data-bs-toggle="tab" href="#integration-credentials" role="tab" aria-controls="integration-credentials" aria-selected="false">
                    Integration Credentials
                  </a>
                </li>

                <h6 class="text-uppercase fw-bold small mb-3 mt-3">AEPS FAQ</h6>
                <li class="nav-item">
                  <a class="nav-link" id="aeps1-tab" data-bs-toggle="tab" href="#aeps1" style="color:purple" role="tab" aria-controls="aeps1" aria-selected="false">
                    Is AePS Daily 2FA chargeable?
                  </a>
                </li>
                <li class="nav-item">
                  <a class="nav-link" id="aeps2-tab" data-bs-toggle="tab" href="#aeps2" style="color:purple" role="tab" aria-controls="aeps2" aria-selected="false">
                    Validity of daily 2FA biometric authentication
                  </a>
                </li>
                <li class="nav-item">
                  <a class="nav-link" id="aeps3-tab" data-bs-toggle="tab" href="#aeps3" style="color:purple" role="tab" aria-controls="aeps3" aria-selected="false">
                    Is it mandatory to perform 2FA login before cash withdrawal?
                  </a>
                </li>
              </ul>
            </div>


          <!-- Right Side Content -->
          <div class="col-md-8 col-lg-9 p-4">
            <div class="tab-content">
              <div class="tab-pane fade show active" id="getting-started" role="tabpanel" aria-labelledby="getting-started-tab">
                <h2>Getting Started with BankU</h2>
                <p>This page will help you get started with BankU.</p>
              </div>

              <div class="tab-pane fade" id="webhooks" role="tabpanel" aria-labelledby="webhooks-tab">
                <h2>Webhooks</h2>
                <p>Webhooks are server callbacks to your server from Instantpay. Webhooks are event-based and are sent when specific events related to the transaction happen.</p>
                  <hr />
                    <h3 style="margin-top:30px">Configuration Steps</h3>
                   <p>The Webhook is called after the transaction has been done. It reports the status of the transaction. In case of a pending transaction, final result of the transaction will also be reported on this Webhook once it is settled.<br />

                Step 1 -Please create a URL at your end on which we will hit a GET request with transaction parameters.<br />

                Step 2- Then login to Instantpay portal and Go to Developer APIs ➡️ Credentials and then click on Setup Webhook and enter the Webhook URL.<br />

                Step 3- For every callback, we expect a specific in response to the callback. The request and response structure is mentioned below.<br /></p>

                   <h3 style="margin-top:30px">Request Structure</h3>
                   <div class="card" style="padding:8px; background-color:#f2f0f0">                     
                        <div class="code-block">
                            <asp:Label runat="server" ID="lblWebhookLink"></asp:Label>
                         <%--   https://<your-webhook-url>?ipay_id=ipay_id&agent_id=agent_id&opr_id=opr_id&status=status&res_code=res_code&res_msg=res_msg&txn_mode=txn_mode--%>
                        </div>
                   </div>
                  <h3 style="margin-top:30px">Request Parameters</h3>
                  <div> 
                      <asp:Label runat="server" ID="lblWebhookPara"></asp:Label>
                   <%--  <table class="table table-bordered table-striped">
                      <thead class="table-light">
                        <tr>
                          <th>Params</th>
                          <th>Description</th>
                        </tr>
                      </thead>
                      <tbody>
                        <tr>
                          <td>ipay_id</td>
                          <td>Unique transaction id generated in Instantpay's system</td>
                        </tr>
                        <tr>
                          <td>agent_id</td>
                          <td>Unique transaction id given by the client at the time of transaction</td>
                        </tr>
                        <tr>
                          <td>opr_id</td>
                          <td>Uniques transaction id from the service provider</td>
                        </tr>
                        <tr>
                          <td>status</td>
                          <td>Status of the transaction. Possible values are SUCCESS, PENDING or REFUND</td>
                        </tr>
                        <tr>
                          <td>res_code</td>
                          <td>Response Code</td>
                        </tr>
                        <tr>
                          <td>res_msg</td>
                          <td>Response Message</td>
                        </tr>
                        <tr>
                          <td>txn_mode</td>
                          <td>Possible values are DR for Debit from user wallet and CR for Credit in user wallet.</td>
                        </tr>
                      </tbody>
                    </table>--%>
                 </div>
              </div>

              <div class="tab-pane fade" id="integration-credentials" role="tabpanel" aria-labelledby="integration-credentials-tab">
                <h2>Integration Credentials</h2>
                <p>Integration content area.</p>
              </div>
              <div class="tab-pane fade" id="aeps1" role="tabpanel" aria-labelledby="aeps1-tab">
                <h2>AePS Daily 2FA</h2>
                <p>Explanation here.</p>
              </div>
              <div class="tab-pane fade" id="aeps2" role="tabpanel" aria-labelledby="aeps2-tab">
                <h2>Validity of daily 2FA biometric authentication</h2>
                <p>Explanation here.</p>
              </div>
              <div class="tab-pane fade" id="aeps3" role="tabpanel" aria-labelledby="aeps3-tab">
                <h2>2FA Login before cash withdrawal</h2>
                <p>Explanation here.</p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>


      <div class="tab-pane fade show " id="api" role="tabpanel" aria-labelledby="api-tab">
          <div class="container-fluid">
            <div class="row">

           <!-- Sidebar Nav -->
<style>
/* Sidebar Container */
#apiSidebar {
    padding-left: 0;
}

/* Category Heading */
#apiSidebar h6{
    color:#6c757d;
    font-size:12px;
    letter-spacing:1px;
    border-bottom:1px solid #e5e5e5;
    padding-bottom:5px;
}

/* API Links */
.api-item .nav-link{
    color:#444;
    font-size:14px;
    padding:8px 10px;
    border-radius:6px;
    transition:all .3s ease;
}

/* Hover Effect */
.api-item .nav-link:hover{
    background:#f3f0ff;
    color:#6f42c1;
    transform:translateX(4px);
}

/* Active API */
.api-item .nav-link.active{
    background:#dcbbde;
    
    color:white;
    font-weight:500;
}

/* Search box */
#txtSearchAPI{
    border-radius:20px;
    padding-left:15px;
}
</style>

                <script>
                    document.addEventListener("DOMContentLoaded", function () {

                        var links = document.querySelectorAll("#apiSidebar .nav-link");

                        links.forEach(function (link) {

                            link.addEventListener("click", function () {

                                links.forEach(function (l) {
                                    l.classList.remove("active");
                                });

                                this.classList.add("active");

                            });

                        });

                    });
                </script>

    
            <div class="col-md-4 col-lg-3 bg-light border-end vh-100 overflow-auto p-3" style="position: sticky; top: 0;">
    
    <!-- Search Bar -->
    <div class="mb-3">
        <input type="text" id="txtSearchAPI" class="form-control form-control-sm" placeholder="Search API..." onkeyup="filterAPIList()">
    </div>

    <ul class="nav flex-column mb-4" id="apiSidebar">
        <asp:Repeater ID="rptCategory" runat="server" OnItemDataBound="rptCategory_ItemDataBound">
            <ItemTemplate>
                <h6 class="text-uppercase fw-bold small mb-3 mt-3"><%# Eval("Category") %></h6>
                <ul class="nav flex-column">
                   <script>
                       window.onload = function () {
                           var firstApi = document.querySelector(".api-item a");
                           if (firstApi) {
                               firstApi.click();
                           }
                       };
                   </script>
                    <asp:Repeater ID="rptAPI" runat="server">
<ItemTemplate>
<li class="nav-item api-item">
<a href="javascript:void(0);" 
   class="nav-link text-purple"
   onclick="GetAPIDetail(<%# Eval("Id") %>); openApiTab();">
   <%# Eval("APIName") %>
</a>
</li>
</ItemTemplate>
</asp:Repeater>
                </ul>
            </ItemTemplate>
        </asp:Repeater>
    </ul>
</div>

<script>
    function filterAPIList() {
        const filter = document.getElementById('txtSearchAPI').value.toLowerCase();
        const items = document.querySelectorAll('.api-item');

        items.forEach(item => {
            const text = item.innerText.toLowerCase();
            if (text.includes(filter)) {
                item.style.display = '';
            } else {
                item.style.display = 'none';
            }
        });

        // Optional: hide category headers if all child APIs are hidden
        const categories = document.querySelectorAll('#apiSidebar > h6');
        categories.forEach(cat => {
            const siblingItems = [];
            let next = cat.nextElementSibling;
            if (next && next.tagName === 'UL') {
                next.querySelectorAll('.api-item').forEach(li => siblingItems.push(li));
            }
            const anyVisible = siblingItems.some(li => li.style.display !== 'none');
            cat.style.display = anyVisible ? '' : 'none';
        });
    }
</script>

<style>
.text-purple {
    color: purple !important;
}
</style>

              <!-- Right Side Content -->
              <div class="col-md-8 col-lg-9 p-4">
                  <div class="tab-content">
                 

                <div class="tab-pane fade" id="dynamic-content" role="tabpanel" aria-labelledby="Dynamic-tab" >
                  <h2><asp:Label runat="server" ID="lblName"></asp:Label></h2>
                   <p class="text-muted position-relative">
    <span class="badge bg-primary small">POST </span>
    <asp:Label runat="server" ID="lblLink"></asp:Label>
    <button type="button" class="copy-btn" onclick="copyText('<%= lblLink.ClientID %>', this)">
        📋 Copy
    </button>
</p>
                    
<script>
    function copyText(labelId, btn) {
        var lbl = document.getElementById(labelId);
        if (lbl) {
            navigator.clipboard.writeText(lbl.innerText).then(() => {
                const originalText = btn.innerText;
                btn.innerText = "Copied!";
                setTimeout(() => { btn.innerText = originalText; }, 1500);
            }).catch(err => {
                console.error('Copy failed', err);
            });
        }
    }
</script>

<style>
.text-muted {
    display: flex;
    align-items: center;
    gap: 8px; /* spacing between badge, label, button */
}

.copy-btn {
    border: none;
    background: #007bff;
    color: white;
    font-size: 12px;
    padding: 3px 8px;
    border-radius: 4px;
    cursor: pointer;
}

.copy-btn:hover {
    background: #0056b3;
}
</style>
                  <p>
                      <asp:Label runat="server" ID="lblDesc"></asp:Label>
                  </p>
                <!-- Header Parameters Table -->
                  <h4 class="mt-4">Header Parameters</h4>
                  <div class="table-responsive">
                    <asp:Label runat="server" ID="lblHeaderparam"></asp:Label>
                  </div>
              

                 <h4 class="mt-4">Request  Parameters</h4>        
                 <div class="table-responsive">
                     <asp:Label runat="server" ID="lblReqparam"></asp:Label>
                  </div>

<h4 class="mt-4">Sample Request</h4>
<div class="card code-container">

    <button type="button" class="copy-btn" onclick="copyText('lblSampleReq', this)">
        📋 Copy
    </button>

    <div class="code-block">
        <pre id="reqBlock"><asp:Label runat="server" ID="lblSampleReq" ClientIDMode="Static"></asp:Label></pre>
    </div>

</div>

                 <h4 class="mt-4">Response Parameters</h4>
                
                 <div class="table-responsive">
                     <asp:Label runat="server" ID="lblRespParam"></asp:Label>
                  </div>
 <h4 class="mt-4">Sample Response</h4>
<div class="card code-container">

    <button type="button" class="copy-btn" onclick="copyText('lblSampleResp', this)">
        📋 Copy
    </button>

    <div class="code-block">
        <pre id="respBlock"><asp:Label runat="server" ID="lblSampleResp" ClientIDMode="Static"></asp:Label></pre>
    </div>

</div>

                     </div>
                  </div>
                </div>


            </div>
          </div>
     </div>


      <div class="tab-pane fade" id="changelog" role="tabpanel" aria-labelledby="changelog-tab">
        <div style="margin-bottom:80px" > 
            <h4 style="color:purple">[Updated] UPI VPA Verification API</h4>
            <p class="small text-muted">September 18th, 2025 by Shahbaz Ali</p>
            <p>UPI VPA verification is now. With this API you can validate any UPI ID before sending any amount.</p>
       </div>

      <div style="margin-bottom:80px" > 
            <h4 style="color:purple">July 4th, 2024 by Shahbaz Ali</h4>
            <p class="small text-muted">September 18th, 2025 by Shahbaz Ali</p>
            <p>As per guidelines received from the Credit Card Network, all the merchants must include Source account details i.e senderDetails and Name in the Credit Card Bill Payment Request and these will be mandatory fields for Credit Card Bill Payment Transactions.</p>
       </div>
      <div style="margin-bottom:80px" > 
            <h4 style="color:purple">Change in NMT API</h4>
            <p class="small text-muted">July 4th, 2024 by Shahbaz Ali</p>
            <p>In Remittance(Nepal) now the partner need to onboard the outlet using the APIs instead of sending the physical form to BankU.</p>
       </div>
      </div>

    </div>

  </div>
</div>

<script type="text/javascript">
    function GetAPIDetail(apiId) {
        $.ajax({
            type: "POST",
            url: "Document.aspx/GetAPIDetail",   
            data: JSON.stringify({ apiId: apiId }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {
                var data = response.d;
                if (data) {
                    $("#<%= lblName.ClientID %>").text(data.APIName);
                        $("#<%= lblLink.ClientID %>").text(data.Link);
                        $("#<%= lblDesc.ClientID %>").text(data.Discription);
                        $("#<%= lblHeaderparam.ClientID %>").html(data.HeaderPara);
                        $("#<%= lblReqparam.ClientID %>").html(data.RequestPara);
                        $("#<%= lblSampleReq.ClientID %>").text(data.SampleReq);
                        $("#<%= lblRespParam.ClientID %>").html(data.ResponsePara);
                    $("#<%= lblSampleResp.ClientID %>").text(data.SampleResponse);

                    $('#dynamic-content').addClass('show active');
                }
            },
            error: function (xhr, status, error) {
                alert("Error: " + error);
            }
        });
    }
</script>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<script>
function openApiTab(tabId) {
  // 1. Activate the parent API Reference tab
  var apiTab = new bootstrap.Tab(document.querySelector('#api-tab'));
  apiTab.show();

  // 2. Activate the nested tab inside API Reference
  var nestedTab = new bootstrap.Tab(document.querySelector('#' + tabId + '-tab'));
  nestedTab.show();
}
</script>

    <script>
        function copyText(id, btn) {

            var text = document.getElementById(id).innerText;

            navigator.clipboard.writeText(text).then(function () {

                btn.innerHTML = "✔ Copied";

                setTimeout(function () {
                    btn.innerHTML = "📋 Copy";
                }, 2000);

            });

        }
    </script>

</asp:Content>

