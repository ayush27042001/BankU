<%@ Page Title="" Language="C#" MasterPageFile="~/Neox.Master" AutoEventWireup="true" CodeBehind="Agreement.aspx.cs" Inherits="NeoXPayout.Agreement" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">

<style>
    /* Card styling */
    .agreement-card {
        background: #ffffff;
        border: 1px solid #eee;
        transition: all 0.3s ease;
        cursor: pointer;
    }

    /* Hover effect */
    .agreement-card:hover {
        transform: translateY(-6px);
        box-shadow: 0px 10px 25px rgba(0,0,0,0.12);
        border-color: purple;
    }

    .text-purple {
        color: purple !important;
    }

    .btn-purple {
        background: purple;
        color: white;
        font-weight: 600;
    }

    .btn-purple:hover {
        background: #5a0a5e;
        color: #fff;
    }

</style>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
   <hr />
<div class="px-xl-5 px-lg-4 px-3 py-3 page-body">
    <h2 class="fw-bold mb-4 mt-2 pb-2 border-bottom" style="color:#4a4a4a;">
        <i class="bi bi-receipt"></i> Agreements
    </h2>
    <asp:HiddenField runat="server" ID="hdnAadhaarRefId"/>
    <asp:Label runat="server" ID="lblmsg" CssClass="text-danger"></asp:Label>

    <!-- Card Grid -->
    <div class="row g-4">
        <asp:Repeater ID="rptProduct" runat="server" OnItemCommand="rptProduct_ItemCommand1"   OnItemDataBound="rptProduct_ItemDataBound">
            <ItemTemplate>
                <div class="col-md-4 col-12">
                    <div class="agreement-card shadow-sm rounded-4 p-4 h-100">

                        <h5 class="fw-bold mb-2 text-purple">
                            <i class="bi bi-file-earmark-text"></i> <%# Eval("AgreementType") %>
                        </h5>
                        <p class="mb-1"><strong>Agreement ID:</strong> <%# Eval("AgreementId") %></p>
                        <p class="mb-1"><strong>User ID:</strong> <%# Eval("UserId") %></p>
                        <p class="mb-1"><strong>File:</strong> <%# Eval("FilePath") %></p>
                        <p class="mb-3"><strong>Created:</strong> <%# Eval("CreatedAt", "{0:dd/MM/yyyy hh:mm tt}") %></p>
                        <asp:LinkButton runat="server"
                            CssClass="btn btn-purple w-100 rounded-pill mt-auto" 
                            ID="btnSignIn" 
                            CommandName="SignIn"
                            CommandArgument='<%# Eval("AgreementId") %>'>
                           <i class="bi bi-box-arrow-in-right"></i> Sign In
                        </asp:LinkButton>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>
</div>

    
<!-- OTP Modal -->
<div class="modal fade" id="otpModal" tabindex="-1" aria-labelledby="otpModalLabel" aria-hidden="true"
        data-bs-backdrop="static" data-bs-keyboard="false">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content rounded-4">

            <div class="modal-header">
                <h5 class="modal-title fw-bold" id="otpModalLabel">
                    <i class="bi bi-shield-lock text-purple"></i> Verify OTP
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>

            <div class="modal-body">

                <p class="text-muted mb-3">Enter the 6-digit OTP sent to your registered mobile number.</p>

                <div class="d-flex gap-2 justify-content-center">
                    <input type="text" maxlength="1" class="form-control otp-input text-center" />
                    <input type="text" maxlength="1" class="form-control otp-input text-center" />
                    <input type="text" maxlength="1" class="form-control otp-input text-center" />
                    <input type="text" maxlength="1" class="form-control otp-input text-center" />
                    <input type="text" maxlength="1" class="form-control otp-input text-center" />
                    <input type="text" maxlength="1" class="form-control otp-input text-center" />
                </div>

                <asp:HiddenField ID="hdnOtpValue" runat="server" />

              

            </div>

            <div class="modal-footer">
                <asp:Button runat="server" ID="btnVerifyOtp" CssClass="btn btn-purple w-100 rounded-pill"
                    Text="Verify OTP" OnClick="btnVerifyOtp_Click" />
            </div>

        </div>
    </div>
</div>

<script>
    // Auto-move to next input
    document.querySelectorAll('.otp-input').forEach((input, idx, arr) => {
        input.addEventListener('keyup', function (e) {
            if (e.key >= '0' && e.key <= '9') {
                if (idx < arr.length - 1) arr[idx + 1].focus();
            } else if (e.key === "Backspace") {
                if (idx > 0) arr[idx - 1].focus();
            }
        });
    });

    // Collect OTP before submit
    document.getElementById('<%= btnVerifyOtp.ClientID %>').addEventListener("click", function () {
        let otp = "";
        document.querySelectorAll(".otp-input").forEach(i => otp += i.value);
        document.getElementById('<%= hdnOtpValue.ClientID %>').value = otp;
    });
</script>

<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script> 
</asp:Content>
