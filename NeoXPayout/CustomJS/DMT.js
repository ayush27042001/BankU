/*   <% --end--%>*/

    function changeTransfer(btn, title) {
        document.getElementById("transferTitle").innerText = title;
        document.querySelectorAll(".tab-btn").forEach(b => b.classList.remove("active"));
        btn.classList.add("active");
    }

    function verifyNumber() {
        const mobile = document.getElementById("mobile").value;
        if (mobile.length !== 10 || isNaN(mobile)) {
            alert("Enter valid 10 digit mobile number");
            return;
        }
        alert("Mobile number verified successfully ✅");
    }

    function clearInput() {
        document.getElementById("mobile").value = "";
    }


/*<% --active button change-- %>*/

    function changeTransfer(el, title) {
          
        document.querySelectorAll('.header-tab').forEach(btn => {
            btn.classList.remove('active');
        });

        el.classList.add('active');

        const titleEl = document.getElementById('transferTitle');
        if (titleEl) {
            titleEl.textContent = title;
        }
    }

  
  {/* <% --pop up form script here-- %>*/}
    
        function openSenderSidebar() {
            document.getElementById("senderSidebar").style.display = "flex";
            document.body.style.overflow = "hidden";
        }

        function closeSenderSidebar() {
            document.getElementById("senderSidebar").style.display = "none";
            document.body.style.overflow = "auto";
        }

        window.onclick = function (e) {
            let sidebar = document.getElementById("senderSidebar");
            if (e.target === sidebar) {
                closeSenderSidebar();
            }
        }
 


  /* <% --end here-- %>*/

 /* sender preview start*/
    
        function openPopup() {
            document.getElementById("senderPopup").style.display = "flex";
        }

        function closePopup() {
            document.getElementById("senderPopup").style.display = "none";
        }
 

  /* <% --end --%>*/

 /* <% --avail user-- %>*/
  
      function openSenderAvail() {
          const el = document.getElementById('rightSidebar');
          const offcanvas = new bootstrap.Offcanvas(el);
          offcanvas.show();
      }

      function closeSenderAvail() {
          const el = document.getElementById('rightSidebar');
          const offcanvas = bootstrap.Offcanvas.getInstance(el);
          if (offcanvas) {
              offcanvas.hide();
          }
      }




 /* <% --end--%>*/
  /*<% --add beneficiary-- %>*/
  
      (function () {

          const drawer = document.getElementById("rightBeneficiaryPopup");
          const openBtn = document.getElementById("openBeneficiaryPopupBtn");
          const closeBtn = document.getElementById("closeBeneficiarySidebar");

          function openRightDrawer() {
              drawer.style.right = "0px";
          }

          function closeRightDrawer() {
              drawer.style.right = "-420px";
          }

          openBtn.addEventListener("click", openRightDrawer);
          closeBtn.addEventListener("click", closeRightDrawer);

      })();

    document.addEventListener("DOMContentLoaded", function () {

        // Open sidebar
        document.getElementById("openBeneficiaryPopupBtn").addEventListener("click", function () {
            const sidebar = new bootstrap.Offcanvas(
                document.getElementById("rightBeneficiaryPopup")
            );
            sidebar.show();
        });

        // Close sidebar (Cancel button)
        document.getElementById("closeBeneficiarySidebar").addEventListener("click", function () {
            const sidebarEl = document.getElementById("rightBeneficiaryPopup");
            const sidebar = bootstrap.Offcanvas.getInstance(sidebarEl);
            if (sidebar) sidebar.hide();
        });

    });


///*<% --end--%>*/

    
        (function () {

            const drawer = document.getElementById("moneyPreviewSidebar");
            const closeBtn = document.getElementById("closeMoneySidebar");

            // open on any Pay Now button click
            document.addEventListener("click", function (e) {
                if (e.target.classList.contains("pay-btn")) {
                    drawer.style.right = "0";
                }
            });

            // close
            closeBtn.addEventListener("click", function () {
                drawer.style.right = "-500px";
            });

            // ESC close
            document.addEventListener("keydown", function (e) {
                if (e.key === "Escape") {
                    drawer.style.right = "-500px";
                }
            });

        })();
 
   


function callServiceStatus() {

    const payload = {
        Apiversion: "1.0",
        ServiceName: "DMT"
    };

    $(".loader-overlay").css("display", "flex");

    $.ajax({
        url: "https://partner.banku.co.in/api/MasterFeature",
        type: "POST",
        contentType: "application/json",
        dataType: "json",
        timeout: 30000,
        data: JSON.stringify(payload),

        success: function (res) {
            console.log("Service Status Response:", res);

            if (res.Status === "SUCCESS") {

                $(".loader-overlay").css("display", "none");

                if (res.Data && res.Data.length > 0) {
                    bindTransferTabs(res.Data);
                }

            } else {

                $(".loader-overlay").css("display", "none");
                $("#lblMessage1").text("No request available").css("color", "red");
            }
        },

        error: function (xhr) {
            console.error(xhr.responseText);
            showFailed("Network / CORS Error");
            $(".loader-overlay").css("display", "none");
        }
    });
}

function bindTransferTabs(data) {

    const filteredData = data
        .filter(item => item.ServiceCode === "DMT" && item.IsEnabled === true)
        .sort((a, b) => a.DisplayOrder - b.DisplayOrder);

    let html = "";

    filteredData.forEach((item, index) => {
        html += `
            <button
                type="button"
                class="header-tab ${index === 0 ? "active" : ""}"
                onclick="changeTransfer(this,'${item.FeatureName}')">
                ${item.FeatureName}
            </button>
        `;
    });

    $(".header-tabs").find("button").remove();
    $(".header-tabs").append(html);
    }
    
