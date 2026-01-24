<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ForgetMpin.aspx.cs" Inherits="NeoXPayout.ForgetMpin" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Forget MPIN</title>

    <!-- Meta tag for mobile responsiveness -->
    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />

    <style>
        body {
            background-color: white;
            margin: 0;
        }

        #pageContent {
            filter: blur(6px);
            pointer-events: none;
            user-select: none;
        }

        .modal-content {
            width: 100%;
        }

        .mpin-input {
            font-size: 14px;
            letter-spacing: 5px;
        }
.custom-forget-mpin-modal {
    max-width: 420px;  
    width: 92%;        
}

@media (max-width: 576px) {
    .custom-forget-mpin-modal {
        max-width: 95%;
    }
}

    </style>
</head>
<body>

<form id="form1" runat="server">

    <div id="pageContent"></div>

    <!-- ===== FORGET MPIN MODAL ===== -->
    <div class="modal fade show" id="forgetMpinModal" style="display:block;" data-bs-backdrop="static">
    <div class="modal-dialog modal-dialog-centered custom-forget-mpin-modal">
        <div class="modal-content shadow-lg border-0 rounded-3 mx-2">

            <div class="modal-header border-0 text-center d-block">
                <img src="BankULogo1.png" class="img-fluid mb-2" style="max-height:60px;" />
                <h5 class="mt-2 fw-semibold">Reset MPIN</h5>
                <p class="text-muted small mb-0">Create a new MPIN</p>
            </div>

            <div class="modal-body text-center px-3 px-sm-4">

                <asp:TextBox ID="txtNewMPIN" runat="server"
                    CssClass="form-control text-center fw-bold mb-3 mpin-input"
                    TextMode="Password" MaxLength="4"
                    oninput="this.value=this.value.replace(/[^0-9]/g,'')"
                    placeholder="New MPIN" />

                <asp:TextBox ID="txtConfirmMPIN" runat="server"
                    CssClass="form-control text-center fw-bold mb-4 mpin-input"
                    TextMode="Password" MaxLength="4"
                    oninput="this.value=this.value.replace(/[^0-9]/g,'')"
                    placeholder="Confirm MPIN" />

                <asp:Label runat="server" ID="lblerror" CssClass="text-danger"></asp:Label>

                <asp:LinkButton runat="server" ID="btnOTP"
                    class="btn w-100 text-white fw-semibold py-2"
                    style="background-color:#5A2D82;"
                    OnClick="btnOTP_Click">
                    Submit
                </asp:LinkButton>

            </div>
        </div>
    </div>
</div>


    <!-- ===== OTP MODAL ===== -->
    <div class="modal fade" id="otpModal" data-bs-backdrop="static">
        <div class="modal-dialog modal-dialog-centered modal-sm">
            <div class="modal-content shadow-lg rounded-3 mx-2">

                <div class="modal-header border-0 text-center d-block">
                    <h5 class="fw-semibold">Enter OTP</h5>
                    <p class="text-muted small mb-0"> <asp:Label runat="server" ID="lblmsg"></asp:Label>  </p>
                </div>

                <div class="modal-body text-center px-3">

                    <asp:TextBox runat="server" ID="txtOTP"   class="form-control text-center fw-bold mb-4" maxlength="6"    style="font-size:14px;"   placeholder="Enter OTP"></asp:TextBox>

       <asp:LinkButton runat="server" ID="btnsubmit" OnClick="btnsubmit_Click"   class="btn w-100 fw-semibold py-2 text-white" style="background-color:#680088;">Confirm</asp:LinkButton>

                </div>
            </div>
        </div>
    </div>

    <!-- ===== THANK YOU MODAL ===== -->
    <div class="modal fade" id="thankYouModal" data-bs-backdrop="static">
        <div class="modal-dialog modal-dialog-centered modal-sm">
            <div class="modal-content text-center p-4 shadow-lg mx-2">

                <h4 class="text-success fw-semibold mb-2">🎉 Thank You!</h4>
                <p class="mb-3">Your MPIN has been reset successfully.</p>

                <a href="LoginBankU.aspx"
                   class="btn w-100 fw-semibold text-white"
                   style="background-color:#f6931e;">
                    Go to Login
                </a>

            </div>
        </div>
    </div>

</form>
    <!-- jQuery (optional, but safe) -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<script>
    function openOtpModal() {
        new bootstrap.Modal(document.getElementById('otpModal')).show();
    }

    function openThankYou() {
        bootstrap.Modal.getInstance(document.getElementById('otpModal')).hide();
        new bootstrap.Modal(document.getElementById('thankYouModal')).show();
    }
</script>

</body>
</html>
