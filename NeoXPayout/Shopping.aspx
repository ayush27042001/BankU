<%@ Page Title="" Language="C#" MasterPageFile="~/Neox.Master" AutoEventWireup="true" CodeBehind="Shopping.aspx.cs" Inherits="NeoXPayout.Shopping" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
  /* Gradient Header */
  .bg-gradient {
    background: linear-gradient(135deg, #4e73df, #1cc88a);
  }

  /* Product Image Hover Effect */
  .product-img {
    transition: transform 0.4s ease, box-shadow 0.3s ease;
  }
  .product-img:hover {
    transform: scale(1.05);
    box-shadow: 0 8px 20px rgba(0,0,0,0.15);
  }

  /* Gradient Text */
  .text-gradient {
    background: linear-gradient(135deg, #4e73df, #1cc88a);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
  }

  /* Gradient Button */
  .btn-gradient {
    background: linear-gradient(135deg, #1cc88a, #4e73df);
    color: #fff;
    font-weight: 600;
    border: none;
    transition: all 0.3s ease;
  }
  .btn-gradient:hover {
    background: linear-gradient(135deg, #4e73df, #1cc88a);
    transform: translateY(-2px);
    box-shadow: 0 6px 16px rgba(0,0,0,0.2);
  }

  /* Re-enable arrows for number inputs */
input[type=number] {
  -moz-appearance: textfield; 
}

input[type=number]::-webkit-outer-spin-button,
input[type=number]::-webkit-inner-spin-button {
  -webkit-appearance: auto;
  margin: 0;
}

</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<hr />
 <main class="container-fluid px-0">
  <div class="content">
    <div class="px-xl-5 px-lg-4 px-3 py-4 page-body">
      <div class="row g-4 mb-3">
          <asp:Label runat="server" ID="lblMessage"></asp:Label>
        <asp:Repeater runat="server" ID="rptProduct" OnItemDataBound="rptProduct_ItemDataBound">
          <ItemTemplate>

            <div class="col-md-6 col-xl-4 col-lg-6">
              <div class="card border-0 shadow-lg rounded-4 h-100 product-card overflow-hidden">
                <!-- Header -->
                <div class="card-header bg-gradient text-white text-center border-0 py-3 rounded-top-4">
                  <h5 class="fw-bold mb-1"><%# Eval("ProductName") %></h5>
                  <small class="opacity-75">Model: <%# Eval("Model") %></small>
                </div>
                  
                <!-- Body -->
                <div class="card-body d-flex flex-column p-4">
                  <!-- Image -->
                  <div class="d-flex justify-content-center mb-3">
                   <img src='<%# ResolveUrl(Eval("ProductPic").ToString()) %>' 
                     alt="img"
                     class="img-fluid rounded-4 shadow-lg product-img" style="height:200px;width:300px" />

                  </div>

                  <!-- Status & Price -->
                  <ul class="list-unstyled mb-3">
                    <li class="d-flex justify-content-between align-items-center mb-2">
                      <span class="fw-semibold">Status</span>
                       <span class='badge px-3 py-2 rounded-pill shadow-sm 
                        <%# (Eval("Status").ToString().ToLower() == "in stock" ? "bg-success" : "bg-danger") %>'>
                        <%# (Eval("Status").ToString().ToLower() == "in stock" ? "✅" : "❌") %> 
                        <%# Eval("Status") %>
                      </span>
                    </li>
                    <li class="d-flex justify-content-between align-items-center">
                      <span class="fw-semibold">Price</span>
                      <span class="fw-bold text-gradient fs-4">₹ <%# Eval("Amount") %></span>
                    </li>
                  </ul>

                  <!-- Description -->
                  <p class="text-muted small flex-grow-1">
                    <%# Eval("ProductDesc") %>
                  </p>

                  <!-- Button -->
                  <div class="d-grid">
                    <asp:LinkButton 
                        runat="server" 
                        ID="btnBuy" 
                        CssClass="btn btn-gradient btn-lg rounded-pill shadow"
                        OnClientClick='<%# "openCheckoutModal(\"" + Eval("ProductName") + "\",\"" + Eval("Model") + "\",\"" + Eval("Amount") + "\"); return false;" %>'>
                        Buy Now
                    </asp:LinkButton>

                  </div>
                </div>
              </div>
            </div>
      
         </ItemTemplate>
       </asp:Repeater>  
      </div>
    </div>
  </div>

<asp:HiddenField runat="server" ID="hfProductName" />
<asp:HiddenField runat="server" ID="hfPrice" />
<asp:HiddenField runat="server" ID="hfTotal" />
<!-- Checkout Modal -->
<div class="modal fade" id="checkoutModal" tabindex="-1" aria-labelledby="checkoutModalLabel" aria-hidden="true"  
     data-bs-backdrop="static" data-bs-keyboard="false">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content rounded-4 shadow-lg">
      
      <div class="modal-header bg-gradient text-white rounded-top-4">
        <h5 class="modal-title" id="checkoutModalLabel">Checkout</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      
      <div class="modal-body p-4">

   <asp:Label runat="server" class="fw-bold" ID="checkoutProductName1"></asp:Label>
        <p class="text-muted" runat="server" id="checkoutModel"></p>
        <p >
          Price: ₹ <asp:Label runat="server" class="fw-bold text-success" ID="checkoutPrice1"></asp:Label>
        </p>
          
        <div class="mb-3">
          <label class="form-label">Quantity</label>
          <asp:TextBox TextMode="Number" runat="server" ID="txtQuantity" 
              CssClass="form-control" Text="1" Min="1"></asp:TextBox>
        </div>

        <div class="mb-3">
          <label class="form-label">Total Price: ₹ 
              <asp:Label runat="server" id="lblTotal1"></asp:Label>
           
          </label>
        </div>

        <div class="mb-3">
          <label class="form-label">Address</label>
          <asp:TextBox runat="server" ID="txtAddress" CssClass="form-control"></asp:TextBox>
          <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ValidationGroup="Check" 
              ControlToValidate="txtAddress" ForeColor="Red" 
              SetFocusOnError="true" runat="server" ErrorMessage="Address Required*">
          </asp:RequiredFieldValidator>
        </div>
      </div>
      
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
        <asp:LinkButton runat="server" ID="btnpay" CssClass="btn" ValidationGroup="Check" 
            Style="background-color:purple; color:white" OnClick="btnpay_Click">
          Proceed to Payment
        </asp:LinkButton>
      </div>
      
    </div>
  </div>
</div>



<div class="modal fade" id="successModal" tabindex="-1" aria-labelledby="successModalLabel" aria-hidden="true"
         data-bs-backdrop="static" data-bs-keyboard="false">
      <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content shadow-lg rounded-3 text-center">
      
          <!-- Modal Header -->
         <div class="modal-header text-white border-0" style="background-color:purple;">
            <h5 class="modal-title w-100" id="successModalLabel">Order Added Successfully</h5>
            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
          </div>
      
          <!-- Modal Body -->
          <div class="modal-body">
            <img src="https://cdn-icons-png.flaticon.com/512/845/845646.png" 
                 alt="Success" class="mb-3" width="80" height="80" />
               <h6 class="fw-semibold">Order Id :<span id="lblorderId" runat="server"></span></h6>
            <h6 class="fw-semibold">Your Order has been added successfully!</h6>
           
            <button type="button" class="btn text-white w-100" style="background-color:purple;" data-bs-dismiss="modal">OK</button>
          </div>
      
        </div>
      </div>
    </div>
</main>

<!-- Gradient Button CSS -->
<style>
  .btn-gradient {
    background: linear-gradient(135deg, #6e007c, #a400d6);
    color: #fff;
    border: none;
    transition: 0.3s;
  }
  .btn-gradient:hover {
    background: linear-gradient(135deg, #5c0068, #9000b8);
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(0,0,0,0.2);
  }
  .product-card:hover {
    transform: translateY(-4px);
    transition: 0.3s;
    box-shadow: 0 6px 20px rgba(0,0,0,0.15) !important;
  }
</style>
<script>
    // Get the new Client IDs
    var productNameId = '<%= checkoutProductName1.ClientID %>';
    var modelId = '<%= checkoutModel.ClientID %>';
    var priceId = '<%= checkoutPrice1.ClientID %>';
var qtyInputId = '<%= txtQuantity.ClientID %>';
    var lblTotalId = '<%= lblTotal1.ClientID %>';

    // Make it global so repeater can call it
    window.openCheckoutModal = function (name, model, price) {
        document.getElementById(productNameId).innerText = name;
        document.getElementById(modelId).innerText = "Model: " + model;
        document.getElementById(priceId).innerText = price;
        // Store values in hidden fields so ASP.NET can read them
        document.getElementById('<%= hfProductName.ClientID %>').value = name;
        document.getElementById('<%= hfPrice.ClientID %>').value = price;
        updateTotal();

        var myModal = new bootstrap.Modal(document.getElementById('checkoutModal'));
        myModal.show();
    }

    function updateTotal() {
        let price = parseFloat(document.getElementById(priceId).innerText) || 0;
        let qty = parseInt(document.getElementById(qtyInputId).value) || 1;
        let total = price * qty;
        document.getElementById(lblTotalId).innerText = total.toFixed(2); 
      
        document.getElementById('<%= hfTotal.ClientID %>').value = total.toFixed(2);
    }

    document.addEventListener('DOMContentLoaded', function () {
        var qtyInput = document.getElementById(qtyInputId);
        if (qtyInput) {
            qtyInput.addEventListener('input', updateTotal);
        }
    });


</script>

<!-- load bootstrap at the end -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</asp:Content>

