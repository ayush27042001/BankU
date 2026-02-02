<%@ Page Title="" Language="C#" MasterPageFile="~/Neox.Master" AutoEventWireup="true" CodeBehind="Resource.aspx.cs" Inherits="NeoXPayout.Resource" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
      <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script>
        function printDiv(divName) {
            var printContents = document.getElementById(divName).innerHTML;
            var originalContents = document.body.innerHTML;

            document.body.innerHTML = printContents;

            window.print();

            document.body.innerHTML = originalContents;
            
        }
    </script>
    <hr />   
    <div class="px-xl-5 px-lg-4 px-3 py-3 page-body">
                    <div class="row g-3 mb-3 row-deck">
                         <!-- BC Certificate Card -->
                         <div class="col-md-6 col-lg-6 col-xl-4">
                              <div class="card">
                                   <div class="card-header">
                                        <h6 class="card-title mb-0">BC Certificate</h6>                                       
                                   </div>
                                   <div>
                                       <div class="card-body">
                                            <span class="text-muted text-center d-block">
                                                The BC Certificate is an official document issued by a bank or financial institution authorizing an individual to act as a representative on its behalf.
                                            </span>
                                       </div>
                                   </div>
                                   <div style="display:flex; gap:10px; margin:12px; flex-wrap:wrap;">
                                        <!-- Download Button -->
                                   
                                       <a href="javascript:void(0);"
                                               onclick="pdfAction='download'; printImageWithText(
                                                   'Certificate.jpg',
                                                   '<%=HiddenField5.Value%>',
                                                   '<%=HiddenField2.Value%>',
                                                   '<%=HiddenFieldDate.Value%>'
                                               )"
                                                style="
                                               flex:1;
                                               text-align:center;
                                               padding:12px;
                                               background:#81007f;
                                               color:#fff;
                                               border:2px solid #f7941d;
                                               border-radius:6px;
                                               text-decoration:none;
                                               font-weight:400;
                                               font-size:14px;
                                               transition:all 0.3s ease; "
                                           onmouseover="this.style.background='#f7941d'; this.style.color='#fff'; this.style.borderColor='#81007f';"
                                           onmouseout="this.style.background='#81007f'; this.style.color='#fff'; this.style.borderColor='#f7941d';">
                                               Download <i class="fa fa-long-arrow-down fa-lg ms-2"></i>
                                            </a>

                                       
                                        <!-- View Button -->
                                       
                                       <a href="javascript:void(0);"
                                           onclick="pdfAction='view'; printImageWithText(
                                               'Certificate.jpg',
                                               '<%=HiddenField5.Value%>',
                                               '<%=HiddenField2.Value%>',
                                               '<%=HiddenFieldDate.Value%>'
                                           )"
                                           style="
                                               flex:1;
                                               text-align:center;
                                               padding:12px;
                                               background:#f7941d;
                                               color:#fff;
                                               border:2px solid #81007f;
                                               border-radius:6px;
                                               text-decoration:none;
                                               font-weight:400;
                                               font-size:14px;
                                               transition:all 0.3s ease;
                                           "
                                           onmouseover="this.style.background='#81007f'; this.style.color='#fff'; this.style.borderColor='#f7941d';"
                                           onmouseout="this.style.background='#f7941d'; this.style.color='#fff'; this.style.borderColor='#81007f';">
                                          
                                               View <i class="fa fa-long-arrow-up fa-lg ms-2"></i>
                                            </a>


                                   </div>
                              </div>
                         </div>

                   <!--Hidden Fields-->
                    <asp:HiddenField ID="HiddenField1" runat="server" />
                    <asp:HiddenField ID="HiddenField2" runat="server" />
                    <asp:HiddenField ID="HiddenField3" runat="server" />
                    <asp:HiddenField ID="HiddenField4" runat="server" />
                    <asp:HiddenField ID="HiddenField7" runat="server" />
                    <asp:HiddenField ID="HiddenFieldShop" runat="server" />
                    <asp:HiddenField ID="HiddenPan" runat="server" />
                    <asp:HiddenField ID="HiddenFieldDate" runat="server" />
                    <asp:HiddenField ID="HiddenField5" runat="server" />
                    <asp:HiddenField ID="HiddenField6" runat="server" />
                    <asp:HiddenField ID="HiddenField8" runat="server" />


                    <!-- BC ID Card -->
                         <div class="col-md-6 col-lg-6 col-xl-4">
                              <div class="card">
                                   <div class="card-header">
                                        <h6 class="card-title mb-0">BC ID Card</h6>                                       
                                   </div>
                                   <div>
                                       <div class="card-body">
                                            <span class="text-muted text-center d-block">
                                                The Business Correspondent (BC) ID Card is an official identification issued by a bank or financial institution to an authorized Business Correspondent.
                                            </span>
                                       </div>
                                   </div>
                                   <div style="display:flex; gap:10px; margin:12px; flex-wrap:wrap;">
                                        <!-- Download Button -->
                                        <a href="javascript:void(0);"
                                           onclick="pdfAction='download'; printImageWithText(
                                               'idcard.jpg',
                                               '<%=HiddenField2.Value%>',
                                               '<%=HiddenField4.Value%>',
                                               '<%=HiddenField5.Value%>',
                                               '<%=HiddenField3.Value%>',
                                               '<%=HiddenField6.Value%>',
                                               '<%=HiddenField7.Value%>')"
                                           style="
                                               flex:1;
                                               text-align:center;
                                               padding:12px;
                                               background:#81007f;
                                               color:#fff;
                                               border:2px solid #f7941d;
                                               border-radius:6px;
                                               text-decoration:none;
                                               font-weight:400;
                                               font-size:14px;
                                               transition:all 0.3s ease;
                                           "
                                           onmouseover="this.style.background='#f7941d'; this.style.color='#fff'; this.style.borderColor='#81007f';"
                                           onmouseout="this.style.background='#81007f'; this.style.color='#fff'; this.style.borderColor='#f7941d';">
                                            Download
                                            
                                            <i class="fa fa-long-arrow-down fa-lg" style="margin-left:8px;"></i>
                                        </a>

                                        <!-- View Button -->
                                        <a href="javascript:void(0);"
                                           onclick="pdfAction='view'; printImageWithText(
                                               'idcard.jpg',
                                               '<%=HiddenField2.Value%>',
                                               '<%=HiddenField4.Value%>',
                                               '<%=HiddenField5.Value%>',
                                               '<%=HiddenField3.Value%>',
                                               '<%=HiddenField6.Value%>',
                                               '<%=HiddenField7.Value%>'  )"
                                            style="
                                               flex:1;
                                               text-align:center;
                                               padding:12px;
                                               background:#f7941d;
                                               color:#fff;
                                               border:2px solid #81007f;
                                               border-radius:6px;
                                               text-decoration:none;
                                               font-weight:400;
                                               font-size:14px;
                                               transition:all 0.3s ease;
                                           "
                                           onmouseover="this.style.background='#81007f'; this.style.color='#fff'; this.style.borderColor='#f7941d';"
                                           onmouseout="this.style.background='#f7941d'; this.style.color='#fff'; this.style.borderColor='#81007f';">
                                            View
                                            <i class="fa fa-long-arrow-up fa-lg" style="margin-left:8px;"></i>
                                        </a>
                                   </div>
                              </div>
                         </div>

                         <!-- BC Authorisation Letter -->
                         <div class="col-md-6 col-lg-6 col-xl-4">
                              <div class="card">
                                   <div class="card-header">
                                        <h6 class="card-title mb-0">BC Authorisation Letter</h6>
                                   </div>
                                   <div>
                                       <div class="card-body">
                                            <span class="text-muted text-center d-block">
                                                The Authorisation Letter is an official document issued by a bank or financial institution, formally authorizing an individual to operate as a Business Correspondent.
                                            </span>
                                       </div>
                                   </div>
                                   <div style="display:flex; gap:10px; margin:12px; flex-wrap:wrap;">
                                        <!-- Download Button -->
                                        <a href="javascript:void(0);"
                                           onclick="pdfAction='download'; printImageWithText(
                                               'BCAuthorization.jpg',
                                               '<%=HiddenField2.Value%>',
                                               '<%=HiddenField5.Value%>',
                                               '<%=HiddenField4.Value%>',
                                               '<%=HiddenField8.Value%>',
                                               '<%=HiddenField1.Value%>'  )"
                                           style="
                                               flex:1;
                                               text-align:center;
                                               padding:12px;
                                               background:#81007f;
                                               color:#fff;
                                               border:2px solid #f7941d;
                                               border-radius:6px;
                                               text-decoration:none;
                                               font-weight:400;
                                               font-size:14px;
                                               transition:all 0.3s ease;
                                           "
                                           onmouseover="this.style.background='#f7941d'; this.style.color='#fff'; this.style.borderColor='#81007f';"
                                           onmouseout="this.style.background='#81007f'; this.style.color='#fff'; this.style.borderColor='#f7941d';">
                                            Download
                                          
                                            <i class="fa fa-long-arrow-down fa-lg" style="margin-left:8px;"></i>
                                        </a>

                                        <!-- View Button -->
                                        <a href="javascript:void(0);"
                                           onclick="pdfAction='view'; printImageWithText(
                                               'BCAuthorization.jpg',
                                               '<%=HiddenField2.Value%>',
                                               '<%=HiddenField5.Value%>',
                                               '<%=HiddenField4.Value%>',
                                               '<%=HiddenField8.Value%>',
                                               '<%=HiddenField1.Value%>'
                                           )"
                                            style="
                                               flex:1;
                                               text-align:center;
                                               padding:12px;
                                               background:#f7941d;
                                               color:#fff;
                                               border:2px solid #81007f;
                                               border-radius:6px;
                                               text-decoration:none;
                                               font-weight:400;
                                               font-size:14px;
                                               transition:all 0.3s ease;
                                           "
                                           onmouseover="this.style.background='#81007f'; this.style.color='#fff'; this.style.borderColor='#f7941d';"
                                           onmouseout="this.style.background='#f7941d'; this.style.color='#fff'; this.style.borderColor='#81007f';">
                                            View
                                            <i class="fa fa-long-arrow-up fa-lg" style="margin-left:8px;"></i>
                                        </a>
                                   </div>
                              </div>
                         </div>

                         <!-- AePS Cash Register -->
                         <div class="col-md-6 col-lg-6 col-xl-4">
                              <div class="card">
                                   <div class="card-header">
                                        <h6 class="card-title mb-0">AePS Cash Register</h6>
                                   </div>
                                   <div>
                                       <div class="card-body">
                                            <span class="text-muted text-center d-block">
                                                The AePS Cash Register is a record-keeping document used by Business Correspondents to track daily Aadhaar-based cash transactions.
                                            </span>
                                       </div>
                                   </div>
                                   <div style="display:flex; gap:10px; margin:12px; flex-wrap:wrap;">
                                        <!-- Download Button -->
                                        <a href="javascript:void(0);"
                                           onclick="viewOrDownloadPlainImage('AepsCash.jpg','download')"
                                           style="
                                               flex:1;
                                               text-align:center;
                                               padding:12px;
                                               background:#81007f;
                                               color:#fff;
                                               border:2px solid #f7941d;
                                               border-radius:6px;
                                               text-decoration:none;
                                               font-weight:400;
                                               font-size:14px;
                                               transition:all 0.3s ease;
                                           "
                                           onmouseover="this.style.background='#f7941d'; this.style.color='#fff'; this.style.borderColor='#81007f';"
                                           onmouseout="this.style.background='#81007f'; this.style.color='#fff'; this.style.borderColor='#f7941d';">
                                            Download
                                            <i class="fa fa-long-arrow-down fa-lg" style="margin-left:8px;"></i>
                                        </a>

                                        <!-- View Button -->
                                        <a href="javascript:void(0);"
                                            onclick="viewOrDownloadPlainImage('AepsCash.jpg','view')"
                                           style="
                                               flex:1;
                                               text-align:center;
                                               padding:12px;
                                               background:#f7941d;
                                               color:#fff;
                                               border:2px solid #81007f;
                                               border-radius:6px;
                                               text-decoration:none;
                                               font-weight:400;
                                               font-size:14px;
                                               transition:all 0.3s ease;
                                           "
                                           onmouseover="this.style.background='#81007f'; this.style.color='#fff'; this.style.borderColor='#f7941d';"
                                           onmouseout="this.style.background='#f7941d'; this.style.color='#fff'; this.style.borderColor='#81007f';">
                                            View
                                            <i class="fa fa-long-arrow-up fa-lg" style="margin-left:8px;"></i>
                                        </a>
                                   </div>
                              </div>
                         </div>

                         <!-- Store Branding -->
                         <div class="col-md-6 col-lg-6 col-xl-4">
                              <div class="card">
                                   <div class="card-header">
                                        <h6 class="card-title mb-0">Store Branding</h6>
                                        <!-- Language Dropdown -->
                                        <select class="form-select form-select-sm" style="width: auto;" id="ddlLanguage" onchange="updateDownloadLink()">
                                            <option value="English">English</option>
                                            <option value="Hindi">Hindi</option>
                                            <option value="Bengali">Bengali</option>
                                            <option value="Marathi">Marathi</option>
                                            <option value="Tamil">Tamil</option>
                                            <option value="Gujarati">Gujarati</option>
                                            <option value="Kannada">Kannada</option>
                                            <option value="Malayalam">Malayalam</option>
                                            <option value="Telugu">Telugu</option>
                                        </select>
                                   </div>
                                   <div>
                                       <div class="card-body">
                                            <span class="text-muted text-center d-block">
                                                Store Branding refers to the visual and promotional materials displayed at a Business Correspondent (BC) outlet to represent the affiliated bank or financial institution.
                                            </span>
                                       </div>
                                   </div>
                                   <div style="display:flex; gap:10px; margin:12px; flex-wrap:wrap;">
                                        <!-- Download ZIP Button -->
                                        <a id="downloadZip"
                                           href="/StoreBranding/English.zip"
                                           download
                                           style="
                                               flex:1;
                                               text-align:center;
                                               padding:12px;
                                               background:#81007f;
                                               color:#fff;
                                               border:2px solid #f7941d;
                                               border-radius:6px;
                                               text-decoration:none;
                                               font-weight:400;
                                               font-size:14px;
                                               transition:all 0.3s ease;
                                           "
                                           onmouseover="this.style.background='#f7941d'; this.style.color='#fff'; this.style.borderColor='#81007f';"
                                           onmouseout="this.style.background='#81007f'; this.style.color='#fff'; this.style.borderColor='#f7941d';">
                                            Download ZIP
                                            <i class="fa fa-long-arrow-down fa-lg" style="margin-left:8px;"></i>
                                        </a>
                                   </div>
                              </div>
                         </div>

                         <!-- AePS Customer Letter -->
                         <div class="col-md-6 col-lg-6 col-xl-4">
                              <div class="card">
                                   <div class="card-header">
                                        <h6 class="card-title mb-0">AePS Customer Letter</h6>
                                   </div>
                                   <div>
                                       <div class="card-body">
                                            <span class="text-muted text-center d-block">
                                                The AePS Customer Letter is an official communication provided to customers to inform them about the features, benefits, and usage of AePS services.
                                            </span>
                                       </div>
                                   </div>
                                   <div style="display:flex; gap:10px; margin:12px; flex-wrap:wrap;">
                                        <!-- Download Button -->
                                        <a  href="javascript:void(0);"
                                             onclick="viewOrDownloadPlainImage('AePSconsent.jpg','download')"
                                           style="
                                               flex:1;
                                               text-align:center;
                                               padding:12px;
                                               background:#81007f;
                                               color:#fff;
                                               border:2px solid #f7941d;
                                               border-radius:6px;
                                               text-decoration:none;
                                               font-weight:400;
                                               font-size:14px;
                                               transition:all 0.3s ease;
                                           "
                                           onmouseover="this.style.background='#f7941d'; this.style.color='#fff'; this.style.borderColor='#81007f';"
                                           onmouseout="this.style.background='#81007f'; this.style.color='#fff'; this.style.borderColor='#f7941d';">
                                            Download
                                            <i class="fa fa-long-arrow-down fa-lg" style="margin-left:8px;"></i>
                                        </a>

                                        <!-- View Button -->
                                        <a href="javascript:void(0);"
                                           onclick="viewOrDownloadPlainImage('AePSconsent.jpg','view')"
                                           style="
                                               flex:1;
                                               text-align:center;
                                               padding:12px;
                                               background:#f7941d;
                                               color:#fff;
                                               border:2px solid #81007f;
                                               border-radius:6px;
                                               text-decoration:none;
                                               font-weight:400;
                                               font-size:14px;
                                               transition:all 0.3s ease;
                                           "
                                           onmouseover="this.style.background='#81007f'; this.style.color='#fff'; this.style.borderColor='#f7941d';"
                                           onmouseout="this.style.background='#f7941d'; this.style.color='#fff'; this.style.borderColor='#81007f';">
                                            View
                                            <i class="fa fa-long-arrow-up fa-lg" style="margin-left:8px;"></i>
                                        </a>
                                   </div>
                              </div>
                         </div>
                    </div>
               </div>

  
<script>
    function updateDownloadLink() {
        const lang = document.getElementById("ddlLanguage").value;
        const downloadLink = document.getElementById("downloadZip");

      
        downloadLink.href = `/StoreBranding/${lang}.zip`;
     
        downloadLink.download = `Store Branding ${lang}.zip`;
    }
</script>
    <script type="text/javascript">
        var currentUser = '<%= Session["AccountHolderType"] != null ? Session["AccountHolderType"].ToString().ToUpper() : "" %>';
    </script>
<script>
    const userFullName = "<%= HiddenField5.Value %>";  
    const bankuId = "<%= HiddenField2.Value %>";      

     async function printImageWithText(imagePath, shopName, userKey, x, y, z, photo) {
         const img = new Image();
         img.crossOrigin = "anonymous";
         img.src = imagePath;

         img.onload = async function () {
             const canvas = document.createElement('canvas');
             canvas.width = img.width;
             canvas.height = img.height;

             const ctx = canvas.getContext('2d');
             ctx.drawImage(img, 0, 0);

             // Check if user is 'BankU', only then draw text
             if (typeof currentUser !== "undefined" && currentUser === "BANKU SEVA KENDRA") {

                 if (imagePath === "Certificate.jpg") {
                     ctx.font = "bold 45px Arial";
                     ctx.fillStyle = "black";
                     ctx.textAlign = "center";     
                     ctx.fillText(shopName, canvas.width / 2, 536);


                     ctx.fillStyle = "darkorange";
                     ctx.font = "bold 28px Arial";
                     ctx.fillText(userKey, 1310, 140);

                     ctx.fillStyle = "Darkblue";
                     ctx.font = "28px Arial";
                     ctx.fillText(x, 370, 940);

                 } else if (imagePath === "idcard.jpg") {
                     const overlayImg = new Image();
                     overlayImg.crossOrigin = "anonymous";
                     overlayImg.src = photo;

                     overlayImg.onload = function () {
                         drawRoundedImage(ctx, overlayImg, 156, 223, 290, 401, 20);


                         ctx.font = "bold 36px Arial";
                         ctx.fillStyle = "#4B4799";
                         ctx.fillText(shopName, 938, 455);

                         ctx.font = "700 70px Arial";

                         ctx.fillStyle = "Red";
                         ctx.fillText(x, 620, 322);

                         ctx.fillStyle = "Black";
                         ctx.font = "bold 38px Arial";
                         ctx.fillText(userKey, 1020, 505);
                         ctx.fillText("Patna", 938, 557);
                         ctx.fillText(z, 938, 633);
                         ctx.fillText(y, 938, 655);

                         generatePDF(canvas, imagePath);
                     };
                     return;

                 } else if (imagePath === "BCAuthorization.jpg") {
                     const today = new Date();
                     const formattedDate =
                         String(today.getDate()).padStart(2, "0") + "-" +
                         String(today.getMonth() + 1).padStart(2, "0") + "-" +
                         today.getFullYear();
                     ctx.font = "bold 18px Arial";
                     ctx.fillStyle = "Black";
                     const maxWidth = 400;
                     const lineHeight = 28;

                     ctx.fillText(shopName, 300, 360);
                     ctx.fillText(userKey, 300, 395);
                     ctx.fillText(z, 300, 435);
                     ctx.fillText(x, 300, 565);
                     drawWrappedText(ctx, y, 300, 490, maxWidth, lineHeight);
                     console.log(ctx.measureText(y).width);

                     ctx.font = "bold 18px Arial";
                     ctx.fillStyle = "#0A3D62";
                     ctx.fillText(formattedDate, 240, 1243);
                 }

             }
           
             generatePDF(canvas, imagePath);
         };
     }

    function drawWrappedText(ctx, text, x, y, maxWidth, lineHeight) {
        const words = text.split(" ");
        let line = "";

        for (let i = 0; i < words.length; i++) {
            const testLine = line + words[i] + " ";
            const metrics = ctx.measureText(testLine);
            const testWidth = metrics.width;

            if (testWidth > maxWidth && line !== "") {
                ctx.fillText(line, x, y);
                line = words[i] + " ";
                y += lineHeight;
            } else {
                line = testLine;
            }
        }

        ctx.fillText(line, x, y);
    }

     function generatePDF(canvas, imagePath) {
         const { jsPDF } = window.jspdf;

         const isPortrait = imagePath === "BCAuthorization.jpg" || imagePath === "AePSconsent.jpg";

         const pdf = new jsPDF({
             orientation: isPortrait ? "portrait" : "landscape",
             unit: "px",
             format: [canvas.width, canvas.height]
         });

         const imgData = canvas.toDataURL("image/jpeg", 1.0);
         pdf.addImage(imgData, 'JPEG', 0, 0, canvas.width, canvas.height);

         if (pdfAction === "download") {
             // CUSTOM FILE NAME
             let safeName = userFullName.replace(/\s+/g, "_");
             let safeId = bankuId.replace(/\s+/g, "_");
             let fileName = `${safeName}_${safeId}.pdf`;

             pdf.save(fileName);
         } else {
             // VIEW
             const blobUrl = pdf.output("bloburl");
             window.open(blobUrl, "_blank");
         }
     }

     function drawRoundedImage(ctx, img, x, y, width, height, radius) {
         ctx.save();

      
         ctx.beginPath();
         ctx.moveTo(x + radius, y);
         ctx.lineTo(x + width - radius, y);
         ctx.quadraticCurveTo(x + width, y, x + width, y + radius);
         ctx.lineTo(x + width, y + height - radius);
         ctx.quadraticCurveTo(x + width, y + height, x + width - radius, y + height);
         ctx.lineTo(x + radius, y + height);
         ctx.quadraticCurveTo(x, y + height, x, y + height - radius);
         ctx.lineTo(x, y + radius);
         ctx.quadraticCurveTo(x, y, x + radius, y);
         ctx.closePath();

      
         ctx.lineWidth = 6;              // border thickness
         ctx.strokeStyle = "#1FAA59";   
         ctx.stroke();

      
         ctx.clip();
         ctx.drawImage(img, x, y, width, height);

         ctx.restore();
     }


</script>
<script>
    function viewOrDownloadPlainImage(imagePath, action) {
        const img = new Image();
        img.crossOrigin = "anonymous";
        img.src = imagePath;

        img.onload = function () {
            const canvas = document.createElement("canvas");
            canvas.width = img.width;
            canvas.height = img.height;

            const ctx = canvas.getContext("2d");
            ctx.drawImage(img, 0, 0);

            const { jsPDF } = window.jspdf;

            const pdf = new jsPDF({
                orientation: img.height > img.width ? "portrait" : "landscape",
                unit: "px",
                format: [canvas.width, canvas.height]
            });

            const imgData = canvas.toDataURL("image/jpeg", 1.0);
            pdf.addImage(imgData, "JPEG", 0, 0, canvas.width, canvas.height);

            if (action === "download") {
                pdf.save(imagePath.replace(".jpg", "") + ".pdf");
            } else {
                window.open(pdf.output("bloburl"), "_blank");
            }
        };
    }
</script>


  <script>
      function printImage(imageUrl) {
          var win = window.open('', '_blank');
          win.document.write(`
        <html>
            <head><title>Print</title></head>
            <body style="margin:0; padding:0;">
                <img src="${imageUrl}" style="width:100%; height:auto;" onload="window.print(); window.close();" />
            </body>
        </html>
    `);
          win.document.close();
      }
  </script>    
</asp:Content>
