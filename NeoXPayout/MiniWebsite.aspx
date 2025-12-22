<%@ Page Title="" Language="C#" MasterPageFile="~/Neox.Master" AutoEventWireup="true" CodeBehind="MiniWebsite.aspx.cs" Inherits="NeoXPayout.MiniWebsite" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
	 <hr />    
	    
		<div class="px-xl-5 px-lg-4 px-3 py-3 page-body">
  <div class="row">

    <div class="col-md-12">

      <!-- Company Information -->
      <div class="card shadow-lg border-0 rounded-4 mb-4">
        <div class="card-header  text-white rounded-top-4" style="background-color: purple">
          <h6 class="mb-0"><i class="bi bi-building me-2"></i>Company Information</h6>
            <!-- Previous Logs Button -->
        <button class="btn btn-light btn-sm shadow-sm" type="button" onclick="openLogsSidebar()">
            <i class="bi bi-clock-history me-1"></i> Previous Logs
        </button>
        </div>
        <div class="card-body">
          <div class="row g-3">
            <div class="col-md-6">
              <label class="form-label">Company Name</label>
             <asp:TextBox ID="txtCompanyName" runat="server" CssClass="form-control" />
                <asp:RequiredFieldValidator ID="rfvCompanyName" runat="server" 
            ControlToValidate="txtCompanyName" ErrorMessage="* Required" 
            ForeColor="Red" Display="Dynamic" ValidationGroup="CompanyForm" />
            </div>

            <div class="col-md-6">
              <label class="form-label">Company Number</label>
             <asp:TextBox ID="txtCompanyNumber" runat="server" CssClass="form-control" />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
            ControlToValidate="txtCompanyNumber" ErrorMessage="* Required" 
            ForeColor="Red" Display="Dynamic" ValidationGroup="CompanyForm" />
            </div>

            <div class="col-md-6">
              <label class="form-label">Company Email</label>
             <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" />
                <asp:RequiredFieldValidator ID="rfvEmail" runat="server" 
            ControlToValidate="txtEmail" ErrorMessage="* Required" 
            ForeColor="Red" Display="Dynamic" ValidationGroup="CompanyForm" />
            </div>

            <div class="col-md-6">
              <label class="form-label">Location</label>
              <asp:TextBox ID="txtLocation" runat="server" CssClass="form-control" />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
            ControlToValidate="txtLocation" ErrorMessage="* Required" 
            ForeColor="Red" Display="Dynamic" ValidationGroup="CompanyForm" />
            </div>

            <div class="col-md-6">
              <label class="form-label">Upload Logo</label>
              <asp:FileUpload ID="fuLogo" runat="server" CssClass="form-control" />
                <asp:RequiredFieldValidator ID="rfvLogo" runat="server" 
            ControlToValidate="fuLogo" InitialValue="" ErrorMessage="* Required" 
            ForeColor="Red" Display="Dynamic" ValidationGroup="CompanyForm" />
            </div>

            <div class="col-md-6">
              <label class="form-label">About Us</label>
              <asp:TextBox ID="txtAboutUs" runat="server" CssClass="form-control" TextMode="MultiLine" />
                <asp:RequiredFieldValidator ID="rfvAbout" runat="server" 
            ControlToValidate="txtAboutUs" ErrorMessage="* Required" 
            ForeColor="Red" Display="Dynamic" ValidationGroup="CompanyForm" />
            </div>
          </div>
        </div>
      </div>

      <!-- Social Media -->
      <div class="card shadow-lg border-0 rounded-4 mb-4">
        <div class="card-header text-white rounded-top-4" style="background-color:orange">
          <h6 class="mb-0"><i class="bi bi-share me-2"></i>Social Media Links</h6>
        </div>
        <div class="card-body">
          <div class="row g-3">
            <div class="col-md-6">
              <label class="form-label">Facebook</label>
              <asp:TextBox ID="txtFacebook" runat="server" CssClass="form-control" />
                 <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
            ControlToValidate="txtFacebook" ErrorMessage="* Required" 
            ForeColor="Red" Display="Dynamic" ValidationGroup="CompanyForm" />
            </div>
            <div class="col-md-6">
              <label class="form-label">Twitter</label>
              <asp:TextBox ID="txtTwitter" runat="server" CssClass="form-control" />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" 
            ControlToValidate="txtTwitter" ErrorMessage="* Required" 
            ForeColor="Red" Display="Dynamic" ValidationGroup="CompanyForm" />
            </div>
            <div class="col-md-6">
              <label class="form-label">Instagram</label>
              <asp:TextBox ID="txtInstagram" runat="server" CssClass="form-control" />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" 
            ControlToValidate="txtInstagram" ErrorMessage="* Required" 
            ForeColor="Red" Display="Dynamic" ValidationGroup="CompanyForm" />
            </div>
            <div class="col-md-6">
              <label class="form-label">LinkedIn</label>
              <asp:TextBox ID="txtLinkedIn" runat="server" CssClass="form-control" />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" 
            ControlToValidate="txtLinkedIn" ErrorMessage="* Required" 
            ForeColor="Red" Display="Dynamic" ValidationGroup="CompanyForm" />
            </div>
          </div>
        </div>
      </div>

      <!-- Gallery -->
      <div class="card shadow-lg border-0 rounded-4 mb-4">
        <div class="card-header text-white rounded-top-4" style="background-color:mediumpurple">
          <h6 class="mb-0"><i class="bi bi-images me-2"></i>Gallery Images</h6>
        </div>
        <div class="card-body">
          <div class="row g-3">
            <div class="col-md-6">
              <asp:FileUpload ID="fuGallery1" runat="server" CssClass="form-control" />
                 <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" 
                  ControlToValidate="fuGallery1" InitialValue="" ErrorMessage="* Required" 
                  ForeColor="Red" Display="Dynamic" ValidationGroup="CompanyForm" />
            </div>
            <div class="col-md-6">
              <asp:FileUpload ID="fuGallery2" runat="server" CssClass="form-control" />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" 
            ControlToValidate="fuGallery2" InitialValue="" ErrorMessage="* Required" 
            ForeColor="Red" Display="Dynamic" ValidationGroup="CompanyForm" />
            </div>
            <div class="col-md-6">
              <asp:FileUpload ID="fuGallery3" runat="server" CssClass="form-control" />
                 <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" 
            ControlToValidate="fuGallery3" InitialValue="" ErrorMessage="* Required" 
            ForeColor="Red" Display="Dynamic" ValidationGroup="CompanyForm" />
            </div>
            <div class="col-md-6">
              <asp:FileUpload ID="fuGallery4" runat="server" CssClass="form-control" />
                 <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" 
            ControlToValidate="fuGallery4" InitialValue="" ErrorMessage="* Required" 
            ForeColor="Red" Display="Dynamic" ValidationGroup="CompanyForm" />
            </div>
          </div>
        </div>
      </div>

      <!-- Actions -->
      <div class="d-flex justify-content-end gap-2">
         <asp:LinkButton runat="server" ID="btnSave" class="btn px-4 text-white"
      style="background-color: purple" OnClick="btnSave_Click" 
      ValidationGroup="CompanyForm">Save</asp:LinkButton>
      
        <button class="btn btn-outline-secondary px-4">Cancel</button>
      </div>

    </div>
  </div>
</div>

<div class="modal fade" id="successModal" tabindex="-1" aria-labelledby="successModalLabel" aria-hidden="true"
         data-bs-backdrop="static" data-bs-keyboard="false">
      <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content shadow-lg rounded-3 text-center">
      
          <!-- Modal Header -->
          <div class="modal-header bg-success text-white border-0">
            <h5 class="modal-title w-100" id="successModalLabel">Details saved successfully</h5>
            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
          </div>
      
          <!-- Modal Body -->
          <div class="modal-body">
            <img src="https://cdn-icons-png.flaticon.com/512/845/845646.png" 
                 alt="Success" class="mb-3" width="80" height="80" />
            <h6 class="fw-semibold">Your Details has been saved successfully!</h6>
            <%--<p class="text-muted mb-4">Reference ID: <span id="lblTxnId">#123456</span></p>--%>
           <%--   <asp:Button runat="server" ID="btnCancel" CssClass="btn btn-outline-secondary px-4"
      Text="Cancel" OnClick="btnCancel_Click" CausesValidation="false" />--%>
          </div>
      
        </div>
      </div>
    </div>

<!-- Sidebar for Previous Logs -->
<div id="logsSidebar" 
     style="position: fixed; top: 0; right: -350px; width: 350px; height: 100%; 
            background: #fff; border-left: 3px solid purple; 
            box-shadow: -4px 0 10px rgba(0,0,0,0.2); 
            z-index: 2000; transition: 0.3s; padding: 20px;">
    
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h5 class="mb-0">Previous Logs</h5>
        <button class="btn btn-sm btn-outline-secondary" type="button" onclick="closeLogsSidebar()">✕</button>
    </div>

   <div id="logsContent" style="max-height: 85vh; overflow-y: auto;">
    <asp:Repeater ID="rptLogs" runat="server">
        <HeaderTemplate></HeaderTemplate>
        <ItemTemplate>
            <div class="border-bottom pb-2 mb-2">
                <div><strong>Company:</strong> <%# Eval("CompanyName") %></div>
                <div><strong>Mobile:</strong> <%# Eval("CompanyNumber") %></div>
                <div><strong>Location:</strong> <%# Eval("Location") %></div>
                <div><strong>Date:</strong> <%# Convert.ToDateTime(Eval("CreatedAt")).ToString("dd-MMM-yyyy") %></div>
                <div><strong>Status:</strong> 
                    <span style='color:<%# Eval("status").ToString()=="Approved" ? "green" : "red" %>'>
                        <%# Eval("status") %>
                    </span>
                </div>
            </div>
        </ItemTemplate>
        <FooterTemplate></FooterTemplate>
    </asp:Repeater>

    <asp:Label ID="lblNoLogs" runat="server" Visible="false" Text="No logs found." ForeColor="Red"></asp:Label>
</div>

</div>
<script>
function openLogsSidebar() {
    document.getElementById("logsSidebar").style.right = "0";
}

function closeLogsSidebar() {
    document.getElementById("logsSidebar").style.right = "-350px";
}
</script>

	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</asp:Content>
