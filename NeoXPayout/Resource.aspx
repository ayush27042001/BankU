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
                         <div class="col-md-6 col-lg-6 col-xl-4">
                              <div class="card">
                                   <div class="card-header">
                                        <h6 class="card-title mb-0">BC Certificate</h6>                                       
                                   </div>
                                   <div>
                                       <div  class="card-body" >
                                        <div class="card">
                                             <div class="card-header">    
                                             </div>
                                             <div class="card-body">
                                                  <span class="text-muted">
                                                      The BC Certificate is an official document issued by a bank or financial institution authorizing an individual to act as a representative on its behalf.
                                                  </span>
                                             </div>
                                        </div>
                                   </div>
                                   <div class="d-flex m-3">
                                      
                                       <a href='DownloadCertificate.aspx?file=Certificate.jpg' target='_blank'
                                           class="btn mx-1 btn-dark flex-grow-1">
                                            Download<asp:HiddenField ID="HiddenField1" runat="server" />
                                           <asp:HiddenField ID="HiddenField2" runat="server" />                                          
                                            <i class="fa fa-long-arrow-down fa-lg px-3"></i>                                          
                                        </a>                                      
                                    
                                       <a href="javascript:void(0);" onclick="printImageWithText('Certificate.jpg', '<%=HiddenField1.Value%>', '<%=HiddenField2.Value%>','<%=HiddenFieldDate.Value%>')" class="btn mx-1 btn-grey-outline flex-grow-1">
                                        <i class="fa fa-long-arrow-up fa-lg px-3"></i>
                                        View
                                    </a>

                                   </div>
                                   </div>
                              </div>
                         </div>
                            
                         <div class="col-md-6 col-lg-6 col-xl-4">
                              <div class="card">
                                   <div class="card-header">
                                        <h6 class="card-title mb-0">BC ID Card</h6>                                       
                                   </div>
                                   <div >
                                       <div class="card-body" >
                                        <div class="card">
                                             <div class="card-header">       
                                             </div>
                                             <div class="card-body">
                                                  <span class="text-muted">
                                                      The Business Correspondent (BC) ID Card is an official identification issued by a bank or financial institution to an authorized Business Correspondent. 
                                                  </span>
                                             </div>
                                        </div>
                                   </div>
                                   <div class="d-flex m-3">
                                     <a href='DownloadCertificate.aspx?file=IDCard.jpg' target='_blank'
                                       class="btn mx-1 btn-dark flex-grow-1">
                                        Download
                                        <i class="fa fa-long-arrow-down fa-lg px-3"></i>
                                    </a>
                                       <asp:HiddenField ID="HiddenField3" runat="server" />
                                       <asp:HiddenField ID="HiddenField4" runat="server" />
                                       <asp:HiddenField ID="HiddenField7" runat="server" />
                                       <asp:HiddenField ID="HiddenFieldShop" runat="server" />
                                       <asp:HiddenField ID="HiddenPan" runat="server" />
                                       <asp:HiddenField ID="HiddenFieldDate" runat="server" />
                                        <a href="javascript:void(0);" onclick="printImageWithText('I D Card-1.jpg',  '<%=HiddenField2.Value%>',  '<%=HiddenField4.Value%>',  '<%=HiddenFieldShop.Value%>', '<%=HiddenPan.Value%>', '<%=HiddenField6.Value%>', 'profile.jpg' )" class="btn mx-1 btn-grey-outline flex-grow-1">
                                        <i class="fa fa-long-arrow-up fa-lg px-3"></i>
                                        View
                                    </a>
                                   </div>
                                   </div>
                              </div>
                         </div>

                         <div class="col-md-6 col-lg-6 col-xl-4">
                              <div class="card">
                                   <div class="card-header">
                                        <h6 class="card-title mb-0">BC Authorisation Letter</h6>
                                   </div>
                                   <div  >
                                       <div class="card-body" id="chandan3">
                                        <div class="card">
                                             <div class="card-header">                
                                             </div>
                                             <div class="card-body">
                                                  <span class="text-muted">
                                                      The Authorisation Letter is an official document issued by a bank or financial institution, formally authorizing an individual to operate as a Business Correspondent.
                                                  </span>    
                                             </div>
                                        </div>
                                   </div>
                                   <div class="d-flex m-3">
                                      <a href='DownloadCertificate.aspx?file=bcAuth.jpg' target='_blank'
                                       class="btn mx-1 btn-dark flex-grow-1">
                                        Download
                                        <i class="fa fa-long-arrow-down fa-lg px-3"></i>
                                    </a>
                                       <asp:HiddenField ID="HiddenField5" runat="server" />
                                       <asp:HiddenField ID="HiddenField6" runat="server" />
                                       <a href="javascript:void(0);" onclick="printImageWithText('bcAuth.jpg',  '<%=HiddenField2.Value%>',  '<%=HiddenField5.Value%>', '<%=HiddenField4.Value%>',  '<%=HiddenField6.Value%>',  '<%=HiddenField1.Value%>'  )" class="btn mx-1 btn-grey-outline flex-grow-1">
                                        <i class="fa fa-long-arrow-up fa-lg px-3"></i>
                                        View
                                    </a>
                                   </div>
                                   </div>
                              </div>
                         </div>

                         <div class="col-md-6 col-lg-6 col-xl-4">
                              <div class="card">
                                   <div class="card-header">
                                        <h6 class="card-title mb-0">AePS Cash Register</h6>
                                   </div>
                                   <div>
                                       <div class="card-body" id="chandan4">
                                        <div class="card">
                                             <div class="card-header">        
                                             </div>
                                             <div class="card-body">
                                                  <span class="text-muted">
                                                      The AePS Cash Register is a record-keeping document used by Business Correspondents to track daily Aadhaar-based cash transactions.
                                                  </span>
                                             </div>
                                        </div>
                                   </div>
                                   <div class="d-flex m-3">
                                       <a href='DownloadCertificate.aspx?file=AepsCash.jpg' target='_blank'
                                           class="btn mx-1 btn-dark flex-grow-1">
                                            Download
                                            <i class="fa fa-long-arrow-down fa-lg px-3"></i>
                                       </a>
                                        <a href="javascript:void(0);" onclick="printImageWithText('AepsCash.jpg', 'Avyaanya Tech', 'User123')" class="btn mx-1 btn-grey-outline flex-grow-1">
                                        <i class="fa fa-long-arrow-up fa-lg px-3"></i>
                                        View
                                        </a>
                                   </div>
                                   </div>
                              </div>
                         </div>

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
                                            <!-- Add more as needed -->
                                        </select>                                      
                                   </div>
                                   <div>
                                       <div class="card-body" id="chandan5">
                                        <div class="card">
                                             <div class="card-header">
                                             </div>
                                             <div class="card-body">
                                                  <span class="text-muted">
                                                      Store Branding refers to the visual and promotional materials displayed at a Business Correspondent (BC) outlet to represent the affiliated bank or financial institution. 
                                                  </span> 
                                             </div>
                                        </div>
                                   </div>
                                   <div class="d-flex m-3">
                                    <!-- Download Button -->
                                    <a id="downloadZip" href="/StoreBranding/English.zip"
                                       download
                                       class="btn mx-1 btn-dark flex-grow-1">
                                        Download ZIP
                                        <i class="fa fa-long-arrow-down fa-lg px-3"></i>
                                    </a>
                                   </div>
                                   </div>
                              </div>
                         </div>

                         <div class="col-md-6 col-lg-6 col-xl-4">
                              <div class="card">
                                   <div class="card-header">
                                        <h6 class="card-title mb-0">AePS Customer Letter</h6>
                                   </div>
                                   <div>
                                       <div class="card-body" id="chandan6">
                                        <div class="card">
                                             <div class="card-header">  
                                             </div>
                                             <div class="card-body">
                                                  <span class="text-muted">
                                                      The AePS Customer Letter is an official communication provided to customers to inform them about the features, benefits, and usage of AePS services. 
                                                  </span>
                                             </div>
                                        </div>
                                   </div>
                                   <div class="d-flex m-3">
                                       <a href='DownloadCertificate.aspx?file=AePSconsent.jpg' target='_blank'
                                           class="btn mx-1 btn-dark flex-grow-1">
                                            Download
                                            <i class="fa fa-long-arrow-down fa-lg px-3"></i>
                                       </a>
                                       <a href="javascript:void(0);" onclick="printImageWithText('AePSconsent.jpg', 'Avyaanya Tech', 'User123')" class="btn mx-1 btn-grey-outline flex-grow-1">
                                            <i class="fa fa-long-arrow-up fa-lg px-3"></i>
                                            View
                                        </a>
                                   </div>
                                   </div>
                              </div>
                         </div>
                    </div>
               </div>

  
<script>
    function updateDownloadLink() {
        const lang = document.getElementById("ddlLanguage").value;
        const downloadLink = document.getElementById("downloadZip");

        // Construct the file path
        downloadLink.href = `/StoreBranding/${lang}.zip`;
        // Set the file name shown in the "Save As" dialog
        downloadLink.download = `Store Branding ${lang}.zip`;
    }
</script>
    <script type="text/javascript">
        var currentUser = '<%= Session["AccountHolderType"] != null ? Session["AccountHolderType"].ToString().ToUpper() : "" %>';
    </script>

 <script>
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
                     ctx.font = "bold 60px Arial";
                     ctx.fillStyle = "black";
                     ctx.fillText(shopName, 560, 536);

                     ctx.fillStyle = "darkorange";
                     ctx.font = "bold 32px Arial";
                     ctx.fillText(userKey, 1340, 140);

                     ctx.fillStyle = "Darkblue";
                     ctx.font = "28px Arial";
                     ctx.fillText(x, 300, 940);

                 } else if (imagePath === "I D Card-1.jpg") {
                     const overlayImg = new Image();
                     overlayImg.crossOrigin = "anonymous";
                     overlayImg.src = photo;

                     overlayImg.onload = function () {
                         ctx.drawImage(overlayImg, 156, 223, 290, 401);

                         ctx.font = "bold 36px Arial";
                         ctx.fillStyle = "Black";
                         ctx.fillText(shopName, 958, 440);

                         ctx.font = "bold 53px Arial";
                         ctx.fillStyle = "Red";
                         ctx.fillText(x, 731, 322);

                         ctx.fillStyle = "Black";
                         ctx.font = "bold 36px Arial";
                         ctx.fillText(userKey, 958, 490);
                         ctx.fillText(x, 958, 535);
                         ctx.fillText(z, 958, 633);
                         ctx.fillText(y, 958, 580);

                         generatePDF(canvas, imagePath);
                     };
                     return;

                 } else if (imagePath === "bcAuth.jpg") {
                     ctx.font = "bold 20px Arial";
                     ctx.fillStyle = "Black";
                     ctx.fillText(shopName, 330, 360);
                     ctx.fillText(userKey, 330, 395);
                     ctx.fillText(z, 330, 435);
                     ctx.fillText(x, 330, 565);
                     ctx.fillText(y, 330, 505);
                 }

             }
             // Generate the PDF regardless of text
             generatePDF(canvas, imagePath);
         };
     }


     function generatePDF(canvas, imagePath) {
         const { jsPDF } = window.jspdf;

         const isPortrait = imagePath === "bcAuth.jpg" || imagePath === "AePSconsent.jpg";

         const pdf = new jsPDF({
             orientation: isPortrait ? "portrait" : "landscape",
             unit: "px",
             format: [canvas.width, canvas.height]
         });

         const imgData = canvas.toDataURL("image/jpeg", 1.0);
         pdf.addImage(imgData, 'JPEG', 0, 0, canvas.width, canvas.height);

         const blob = pdf.output('blob');
         const blobUrl = URL.createObjectURL(blob);
         window.open(blobUrl, '_blank');
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
