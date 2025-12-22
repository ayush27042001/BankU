<%@ Page Title="" Language="C#" MasterPageFile="~/Neox.Master" AutoEventWireup="true" CodeBehind="MPIN.aspx.cs" Inherits="NeoXPayout.MPIN" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
   
    body {
        background-color: white !important;
    }

    #pageContent {
        filter: blur(6px);  
        pointer-events: none; 
        user-select: none;   
    }

    .modal {
        filter: none !important;
    }
</style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Hidden actual page content -->
    <div id="pageContent">
        <!-- Your real content here -->
    </div>

    <!-- MPIN Modal -->
    <div class="modal fade show" id="mpinModal1" tabindex="-1" aria-labelledby="mpinModalLabel" aria-hidden="true" 
     data-bs-backdrop="static" data-bs-keyboard="false" style="display:block;">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content shadow-lg border-0 rounded-3" style="max-width:420px; margin:auto;">
            <div class="modal-header border-0 d-block text-center">
                  <img src="BankULogo1.png" alt="BankU Logo" 
               style="height:60px; width:auto; margin-bottom:12px;" />
             <h5 class="mt-2 mb-0 fw-semibold mb-3" id="mpinModalLabel">
                Hey <asp:Label ID="fullname" runat="server" CssClass="fw-semibold"></asp:Label>!
             </h5>
                <p class="text-muted small mb-0">
                    Your screen was locked because of inactivity <br />
                    to protect your account.
                </p>
            </div>
            <div class="modal-body text-center">
                <label class="fw-semibold mb-3">Enter BankU MPIN</label>

                <!-- Styled PIN input (4 boxes) -->
                <div class="d-flex justify-content-center gap-2 mb-3">
                    <asp:TextBox ID="txtMPIN" runat="server" CssClass="form-control text-center fw-bold"
                        TextMode="Password" MaxLength="4"
                        autocomplete="off" autocorrect="off" autocapitalize="off" spellcheck="false"
                         oninput="this.value = this.value.replace(/[^0-9]/g, '')"
                        Style="width:90%; font-size:24px; letter-spacing:12px; border:2px solid #5A2D82; border-radius:8px;">
                    </asp:TextBox>                   
                </div>

                <div class="text-center mb-3">
                    <asp:RequiredFieldValidator ID="rfvMPIN" runat="server"
                        ControlToValidate="txtMPIN"
                        ErrorMessage="⚠ Please enter your MPIN"
                        CssClass="text-danger small fw-semibold"
                        Display="Dynamic"
                        ValidationGroup="UnlockGroup">
                    </asp:RequiredFieldValidator>
                </div>

               <div class="d-flex justify-content-center mb-3" style="width:80%; margin:auto;">
                    <asp:Button ID="btnSubmitMPIN" runat="server" 
                        CssClass="btn px-5 py-2 fw-semibold text-white"
                        Style="background-color:#5A2D82; border-radius:8px;" 
                        Text="Unlock" OnClick="btnSubmitMPIN_Click" ValidationGroup="UnlockGroup"/>
                </div>
               <asp:Label runat="server" ID="lblError"></asp:Label>
            </div>
            <div class="modal-footer border-0 d-block text-center">
                <hr />
                <a href="#" class="text-decoration-none fw-semibold" style="color:#5A2D82;">
                    Unlock using Password
                </a>
            </div>
        </div>
    </div>
</div>

</asp:Content>
