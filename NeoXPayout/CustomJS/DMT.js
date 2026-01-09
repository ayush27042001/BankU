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
 
   

/*  <% --end --%>*/