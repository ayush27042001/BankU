<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/NeoxAdmin.Master" AutoEventWireup="true" CodeBehind="ViewKyc.aspx.cs" Inherits="NeoXPayout.Admin.ViewKyc" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<style>
.image-modal {
    display: none;
    position: fixed;
    z-index: 9999;
    padding-top: 40px;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0,0,0,0.92);
}

.modal-content-img {
    margin: auto;
    display: block;
    max-width: 90%;
    max-height: 90vh;
    border-radius: 12px;
    animation: zoomIn .3s ease;
}

.close-preview {
    position: absolute;
    top: 20px;
    right: 35px;
    color: white;
    font-size: 40px;
    cursor: pointer;
    font-weight: bold;
}

.preview-img:hover{
    transform: scale(1.03);
    transition:.3s;
}

@keyframes zoomIn{
    from{transform:scale(.7);}
    to{transform:scale(1);}
}

.kyc-history-btn{
    background-color:white;
    color:#4b0082;
    border:1px solid #4b0082;
    font-weight:600;
    padding:8px 18px;
    transition:all .3s ease;
}

.kyc-history-btn:hover{
    color:orange !important;
    border-color:orange;
    background:#fff8f0;
}

.certificate-wrapper{
    display:flex;
    justify-content:center;
    align-items:center;
}

/* FIXED A4 LOOK */
.certificate-box{
    width: 800px;
    min-height: 1100px;
    background: #fff;
    padding: 40px;
    border: 5px double #c9a96a;
    border-radius: 10px;
    box-shadow: 0 10px 30px rgba(0,0,0,.1);
}

/* GRID LIKE ORIGINAL DESIGN */
.cert-grid{
    display:flex;
    justify-content:space-between;
    gap:40px;
}

.cert-grid div{
    width:50%;
}

.cert-title{
    color:#4b0082;
    font-weight:bold;
}

/* SIGNATURE AREA */
.cert-sign{
    display:flex;
    justify-content:space-between;
    margin-top:60px;
    text-align:center;
}

/* DECLARATION */
.cert-declaration{
    margin-top:20px;
    font-size:15px;
}

/* MOBILE RESPONSIVE SCALE */
@media(max-width: 768px){

    .certificate-box{
        transform: scale(0.65);
        transform-origin: top center;
    }

    .certificate-wrapper{
        overflow:auto;
    }
}

@media(max-width: 480px){

    .certificate-box{
        transform: scale(0.5);
    }
}
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container mt-4">
    <div class="card shadow-sm rounded-4">
        <div class="card-header text-white" style="background-color:purple">
            <h5 class="mb-0">KYC Documents <span id="UserName" runat="server"></span></h5>
            <div class="d-flex justify-content-between align-items-center mb-3">

    <a href='KycApprovalLog.aspx?id=<%= Request.QueryString["ID"] %>' 
       class="btn btn-sm rounded-pill kyc-history-btn">
        View KYC History
    </a>

</div>
        </div>

        <div class="card-body">
            <div class="row g-4">

                <!-- Aadhaar -->
                <div class="col-md-6">
                    <div class="border rounded-3 p-3 text-center">
                        <h6>Aadhaar Card</h6>
                        <asp:Image ID="imgAadhar" runat="server"
                            CssClass="img-fluid rounded shadow-sm preview-img"
                            Style="max-height:220px; cursor:pointer;" />
                        <asp:HyperLink ID="lnkAadhar" runat="server"
                        Target="_blank"
                        CssClass="d-block mt-2 text-primary fw-semibold" />
                        <br />
                        <asp:Label ID="lblAadharStatus" runat="server" />
                    </div>
                </div>

                <!-- PAN -->
                <div class="col-md-6">
                    <div class="border rounded-3 p-3 text-center">
                        <h6>PAN Card</h6>
                        <asp:Image ID="imgPan" runat="server"
                            CssClass="img-fluid rounded shadow-sm preview-img"
                            Style="max-height:220px; cursor:pointer;" />
                        <asp:HyperLink ID="lnkPan" runat="server"
                            Target="_blank"
                            CssClass="d-block mt-2 text-primary fw-semibold" />
                        <br />
                        <asp:Label ID="lblPanStatus" runat="server" />
                    </div>
                </div>

                <!-- Photo -->
                <div class="col-md-6">
                    <div class="border rounded-3 p-3 text-center">
                        <h6>Photo</h6>
                        <asp:Image ID="imgPhoto" runat="server"
                            CssClass="img-fluid rounded shadow-sm preview-img"
                            Style="max-height:220px; cursor:pointer;" />
                        <asp:HyperLink ID="lnkPhoto" runat="server"
                    Target="_blank"
                    CssClass="d-block mt-2 text-primary fw-semibold" />
                        <br />
                        <asp:Label ID="lblPhotoStatus" runat="server" />
                    </div>
                </div>

                <!-- GST (Optional) -->
                <div class="col-md-6">
                    <div class="border rounded-3 p-3 text-center">
                        <h6>Business Proof(<span runat="server" id="proofType" class="shadow small"></span>)</h6>
                        <asp:Image ID="imgGst" runat="server"
                            CssClass="img-fluid rounded shadow-sm preview-img"
                            Style="max-height:220px; cursor:pointer;" />
                        <asp:HyperLink ID="lnkGst" runat="server"
                    Target="_blank"
                    CssClass="d-block mt-2 text-primary fw-semibold" />
                        <br />
                        <asp:Label ID="lblGstStatus" runat="server" />
                    </div>
                </div>
                  <!-- GST (Optional) -->
                <div class="col-md-6">
                    <div class="border rounded-3 p-3 text-center">
                        <h6>Outlet/Shop GeoTag Photo (Front side)</h6>
                        <asp:Image ID="imgFront" runat="server"
                            CssClass="img-fluid rounded shadow-sm preview-img"
                            Style="max-height:220px; cursor:pointer;" />
                         <asp:HyperLink ID="lnkFront" runat="server"
                    Target="_blank"
                    CssClass="d-block mt-2 text-primary fw-semibold" />
                        <br />
                        <asp:Label ID="lblShopFront" runat="server" />
                    </div>
                </div>
                  <!-- GST (Optional) -->
                <div class="col-md-6">
                    <div class="border rounded-3 p-3 text-center">
                        <h6>Outlet/Shop GeoTag Photo (Inside)</h6>
                        <asp:Image ID="imgInside" runat="server"
                            CssClass="img-fluid rounded shadow-sm preview-img"
                            Style="max-height:220px; cursor:pointer;" />
                           <asp:HyperLink ID="lnkInside" runat="server"
                            Target="_blank"
                            CssClass="d-block mt-2 text-primary fw-semibold" />
                        <br />
                        <asp:Label ID="lblShopIn" runat="server" />
                    </div>
                </div>
                 <div class="col-md-6">
                    <div class="border rounded-3 p-3 text-center">
                        <h6>Application Form</h6>
                        <asp:Image ID="imgApplication" runat="server"
                            CssClass="img-fluid rounded shadow-sm preview-img"
                            Style="max-height:220px; cursor:pointer;" />
                           <asp:HyperLink ID="lnkApplication" runat="server"
                            Target="_blank"
                            CssClass="d-block mt-2 text-primary fw-semibold" />
                        <br />
                        <asp:Label ID="lblApplication" runat="server" />
                    </div>
                </div>
            </div>
        </div>

        <div class="row mt-4">
    <div class="col-md-12">
        <div class="border rounded-3 p-3">
            <h6 class="mb-3">KYC Status</h6>

            <!-- Current Status -->
            <div class="mb-3">
                <label class="form-label fw-semibold">Current Status</label><br />
                <asp:Label ID="lblKycStatus" runat="server" CssClass="badge bg-warning fs-6"></asp:Label>
            </div>

            <!-- Update Status -->
            <div class="mb-3">
                <label class="form-label fw-semibold">Update Status</label>
                <asp:DropDownList ID="ddlKycStatus" runat="server" CssClass="form-select">
                    <asp:ListItem Text="Review" Value="Review"></asp:ListItem>
                    <asp:ListItem Text="Clarification" Value="Clarification"></asp:ListItem>
                    <asp:ListItem Text="Approved" Value="Approved"></asp:ListItem>
                             <asp:ListItem Text="Rejected" Value="Rejected"></asp:ListItem>
                </asp:DropDownList>
            </div>
            <div class="mb-3" id="rejectReasonBox" style="display:none;">
                <label class="form-label fw-semibold">Rejection Reason</label>
                <asp:TextBox ID="txtRejectReason" runat="server" 
                    CssClass="form-control" 
                    TextMode="MultiLine" Rows="3"
                    placeholder="Enter reason for rejection..."></asp:TextBox>
            </div>
            <!-- Button -->
            <asp:Button ID="btnUpdateStatus"
                runat="server"
                Text="Update KYC Status"
                CssClass="btn btn-primary"
                OnClick="btnUpdateStatus_Click" />
        </div>
    </div>
</div>
    </div>
</div>
    <div id="imagePreviewModal" class="image-modal">
    <span class="close-preview">&times;</span>
    <img class="modal-content-img" id="fullPreviewImage">
</div>

<div class="modal fade" id="statusUpdatedModal" tabindex="-1"
     data-bs-backdrop="static" 
     data-bs-keyboard="false">
  <div class="modal-dialog modal-xl modal-dialog-centered">
     
   <div class="modal-content p-3 border-0 bg-transparent">
        <button type="button"
                class="btn-close position-absolute top-0 end-0 m-3 bg-white rounded-circle shadow"
                data-bs-dismiss="modal"
                aria-label="Close">
        </button>
    <div class="certificate-wrapper">

        <div id="kycCertificate" class="certificate-box">

            <!-- HEADER -->
            <div class="text-center mb-3">
                <h2 class="cert-title">BankU India Limited</h2>
                <h4>KYC APPROVAL REPORT</h4>
                <hr />
            </div>

            <!-- CONTENT -->
            <div class="cert-grid">
                <div>
                    <p><b>Approval No:</b> <span id="certApproval"></span></p>
                    <p><b>Name:</b> <span id="certName"></span></p>
                    <p><b>Mobile:</b> <span id="certMobile"></span></p>
                    <p><b>KYC Status:</b> <span id="certStatus"></span></p>
                    <p><b>Approved By:</b> <span id="certAdmin"></span></p>
                    <p><b>IP Address:</b> <span id="certIP"></span></p>
                    <p><b>PAN No:</b> <span id="certPan"></span></p>
                    <p><b>Aadhaar No:</b> <span id="certAadhar"></span></p>
                </div>

                <div>
                    <p><b>Cust ID:</b> <span id="certCustId"></span></p>
                    <p><b>Request ID:</b> <span id="certReqId"></span></p>
                    <p><b>Email:</b> <span id="certEmail"></span></p>
                    <p><b>Location:</b> <span id="certLocation"></span></p>
                    <p><b>Date:</b> <span id="certDate"></span></p>
                </div>
            </div>

            <hr />

            <p class="cert-declaration">
                This is to certify that the above-mentioned customer has successfully completed
                the KYC process and has been verified by BankU India Limited.
            </p>

            <div class="cert-sign">
                <div>__________________________<br />Nodal Officer</div>
                <div>__________________________<br />Checker</div>
            </div>

        </div>

    </div>

    <!-- CENTERED BUTTON -->
    <div class="text-center mt-3">
        <button class="btn btn-success px-4 rounded-pill" type="button" onclick="downloadKycPdf()">
            ⬇ Download Certificate
        </button>
    </div>
   <div class="text-center mt-2">
            <button class="btn btn-outline-secondary rounded-pill px-4"
                    data-bs-dismiss="modal">
                Close
            </button>
        </div>
</div>

  </div>
</div>
<script>
    async function downloadKycPdf() {

        const { jsPDF } = window.jspdf;

        let element = document.getElementById("kycCertificate");

        let canvas = await html2canvas(element, {
            scale: 1.5,
            useCORS: true
        });

        let imgData = canvas.toDataURL("image/jpeg", 0.7);

        let pdf = new jsPDF('p', 'mm', 'a4');

        let imgWidth = 190;
        let pageHeight = 297;
        let imgHeight = canvas.height * imgWidth / canvas.width;

        pdf.addImage(imgData, 'PNG', 10, 10, imgWidth, imgHeight);

        pdf.save("BankU_KYC_Certificate.pdf");
    }
</script>
<script>
document.addEventListener("DOMContentLoaded", function () {

    let modal = document.getElementById("imagePreviewModal");
    let modalImg = document.getElementById("fullPreviewImage");

    document.querySelectorAll(".preview-img").forEach(function (img) {

        img.addEventListener("click", function () {

            modal.style.display = "block";
            modalImg.src = this.src;

        });

    });

    document.querySelector(".close-preview").onclick = function () {
        modal.style.display = "none";
    };

    modal.onclick = function (e) {
        if (e.target === modal) {
            modal.style.display = "none";
        }
    };

});
document.addEventListener("DOMContentLoaded", function () {

        const ddl = document.getElementById("<%= ddlKycStatus.ClientID %>");
        const box = document.getElementById("rejectReasonBox");

        function toggleRejectBox() {
            if (ddl.value === "Rejected") {
                box.style.display = "block";
            } else {
                box.style.display = "none";
            }
        }

        ddl.addEventListener("change", toggleRejectBox);
        toggleRejectBox(); // initial check

    });
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/1.4.1/html2canvas.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
</asp:Content>
