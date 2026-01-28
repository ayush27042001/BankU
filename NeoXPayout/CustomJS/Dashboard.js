
    function copyText(text) {
        navigator.clipboard.writeText(text);
        showToast("Copied");
    }

    function showToast(msg) {
        const toast = document.getElementById("copyToast");
        toast.style.display = "inline-block";
        toast.innerHTML = msg + ` <span style="margin-left:10px; cursor:pointer; font-weight:bold;" onclick="hideToast()">×</span>`;

        clearTimeout(window.toastTimer);
        window.toastTimer = setTimeout(() => {
            hideToast();
        }, 2000);
    }

    function hideToast() {
        document.getElementById("copyToast").style.display = "none";
    }


let isBalanceVisible = false;

function toggleBalanceInline() {
    const toggleEl = document.getElementById("balanceToggle");
    const balanceLabel = document.getElementById("Label3");

    if (!balanceLabel) {
        console.error("Label3 not found in DOM");
        return;
    }

    const balanceValue = "₹ " + balanceLabel.innerText.trim();

    toggleEl.innerText = isBalanceVisible ? "View Balance" : balanceValue;
    isBalanceVisible = !isBalanceVisible;
}

function checkStatusAjax() {

    $(".loader-overlay").show();

    $.ajax({
        url: "Dashboard.aspx/CheckstatusAjax",
        type: "POST",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        data: "{}",

        success: function (res) {

            $(".loader-overlay").hide();
           

            if (res.d.Status === "SUCCESS") {

                
            }
        },

        error: function (xhr) {
            $(".loader-overlay").hide();
            console.error(xhr.responseText);
            alert("Server error");
        }
    });
}


