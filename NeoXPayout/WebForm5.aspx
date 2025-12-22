<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm5.aspx.cs" Inherits="NeoXPayout.WebForm5" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Face Liveness Test</title>
</head>

<body>
    <form id="form1" runat="server">
        <div>
            <div style="position: relative; width: 320px; height: 240px;">
                <video id="video" width="320" height="240" autoplay style="position: absolute; top: 0; left: 0;"></video>
                <img src="assets/images/OvalImage.png" alt="Face Frame" 
                     style="position: absolute; top: 0; left: 0; width: 320px; height: 240px; pointer-events: none;" />
            </div>

            <canvas id="canvas" width="320" height="240" style="display:none;"></canvas>
            <button type="button" onclick="captureAndUpload()">Capture & Upload</button>

            <!-- Hidden field to pass image path -->
            <asp:HiddenField ID="hdnImagePath" runat="server" />

            <!-- Hidden button to trigger postback -->
            <asp:Button ID="btnVerifyFace" runat="server" Text="Verify" Style="display:none;" OnClick="btnVerifyFace_Click" />

            <br />
            <asp:Label ID="lblStatus" runat="server" ForeColor="Red"></asp:Label>
        </div>


                                    
    </form>
    


    <script>
        // Start webcam when page loads
        window.onload = function () {
            const video = document.getElementById('video');
            if (navigator.mediaDevices.getUserMedia) {
                navigator.mediaDevices.getUserMedia({ video: true })
                    .then(function (stream) {
                        video.srcObject = stream;
                    })
                    .catch(function (error) {
                        console.log("Webcam access error:", error);
                    });
            }
        };

        function captureAndUpload() {
            const video = document.getElementById('video');
            const canvas = document.getElementById('canvas');
            const context = canvas.getContext('2d');

            context.drawImage(video, 0, 0, canvas.width, canvas.height);
            const imageData = canvas.toDataURL('image/png');

            fetch('SaveImageHandler.ashx', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ image: imageData })
            })
                .then(response => response.text())
                .then(filename => {
                    document.getElementById('<%= hdnImagePath.ClientID %>').value = filename;
                document.getElementById('<%= btnVerifyFace.ClientID %>').click();
            })
                .catch(error => {
                    alert("Upload failed.");
                    console.error(error);
                });
        }
    </script>
</body>
</html>