<%@ Page Title="" Language="C#" MasterPageFile="~/Neox.Master" AutoEventWireup="true" CodeBehind="ContactBook.aspx.cs" Inherits="NeoXPayout.ContactBook" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
     <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
     <style>

  .cb-header {
    background: linear-gradient(90deg, #6a1b9a, #8e24aa);
    color: #fff;
    padding: 18px 25px;
    border-radius: 12px 12px 0 0;
    display: flex;
    align-items: center;
    box-shadow: 0 4px 8px rgba(0,0,0,0.15);
  }

  .cb-header h2 {
    margin: 0;
    font-weight: 700;
    font-size: 22px;
    letter-spacing: 0.5px;
    display: flex;
    align-items: center;
  }

  .cb-header i {
    font-size: 26px;
    margin-right: 10px;
  }
.main-container {
  display: flex;
  gap: 20px;
}

/* Sidebar */
.contact-sidebar {
  width: 320px;
  border: 1px solid #ddd;
  border-radius: 12px;
  background: #fff;
  padding: 15px;
  display: flex;
  flex-direction: column;
  height: 600px;
}
.custom-header {
  background: linear-gradient(90deg, #9c3cc9, #b966e0); /* purple का हल्का gradient */
  padding: 15px 20px;
  border-bottom-left-radius: 12px;
  border-bottom-right-radius: 12px;
  box-shadow: 0 4px 10px rgba(0,0,0,0.1);
}
.custom-header h5 {
  font-weight: 600;
  font-size: 18px;
}
  .custom-header .btn-close {
    filter: invert(1); /* white cross */
  }
.search-box {
  display: flex;
  align-items: center;
  border: 1px solid #ddd;
  border-radius: 10px;
  padding: 6px 10px;
  margin-bottom: 15px;
  background: #fafafa;
}
.search-box input {
  border: none;
  flex: 1;
  outline: none;
  background: transparent;
}
.search-box i {
  margin-left: 8px;
  color: #777;
  cursor: pointer;
}
.contact-list {
  flex: 1;
  overflow-y: auto;
}
.contact-item {
  padding: 12px;
  border-bottom: 1px solid #eee;
  cursor: pointer;
  border-radius: 8px;
}
.contact-item:hover {
  background: #f3f0ff;
}
.contact-item.active {
  background: #e8eaf6;
}
.contact-name {
  font-weight: 600;
}
.contact-number {
  font-size: 14px;
  color: #555;
}
.badge {
  padding: 2px 8px;
  font-size: 12px;
  border-radius: 8px;
  margin-left: 8px;
}
.emp {
  background: #ede7f6;
  color: #6a1b9a;
}
.vendor {
  background: #e3f2fd;
  color: #1565c0;
}
.primary {
  background: #e3f2fd;
  color: #1565c0;
}
.add-btn {
  background: linear-gradient(90deg, #6a1b9a, #8e24aa);
    color: #fff;
    padding: 12px 25px;
    border: none;
    border-radius: 10px;
    font-weight: 600;
    font-size: 15px;
    cursor: pointer;
    transition: 0.3s;
    box-shadow: 0 4px 8px rgba(0,0,0,0.2);
}
.add-btn:hover {
   background: linear-gradient(90deg, #8e24aa, #ab47bc);
    transform: translateY(-2px);
}

/* Contact Details */
.contact-details {
  flex: 1;
  background: #fff;
  border-radius: 12px;
  padding: 20px;
  border: 1px solid #eee;
}

.profile-card {
  border-bottom: 1px solid #eee;
  padding-bottom: 15px;
}
.profile-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}
.avatar {
  width: 60px;
  height: 60px;
  border-radius: 50%;
  background: #e1bee7;
  color: #4a148c;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 20px;
  font-weight: bold;
  margin-right: 15px;
}
.profile-header h3 {
  margin: 0;
}
.info p {
  margin: 2px 0;
  font-size: 14px;
  color: #555;
}
.actions i {
  margin-left: 12px;
  font-size: 18px;
  cursor: pointer;
}

/* Tabs */
.tabs {
  display: flex;
  gap: 25px;
  margin: 20px 0;
  border-bottom: 1px solid #eee;
}
.tabs a {
  padding-bottom: 8px;
  text-decoration: none;
  color: #555;
  font-weight: 500;
}
.tabs a.active {
  border-bottom: 2px solid #1976d2;
  color: #1976d2;
}
.nav-tabs {
      border-bottom: none;
    }
    .nav-tabs .nav-link {
      color: #6c757d;
      font-weight: 500;
      border: none;
      border-bottom: 2px solid transparent;
    }
    .nav-tabs .nav-link.active {
      color: #8020a4; /* Blue text */
      font-weight: 600;
      border-color: #8020a4; /* Blue underline */
    }
/* Account Card */
.account-card {
  display: flex;
  justify-content: space-between;
  align-items: center;
  border: 1px solid #eee;
  padding: 15px;
  border-radius: 10px;
  margin-top: 15px;
}
.bank-info {
  display: flex;
  align-items: center;
  gap: 15px;
}
.bank-info h4 {
  margin: 0;
}
.menu i {
  font-size: 20px;
  cursor: pointer;
}
.custom-btn {
  border: 2px solid #8020a4;
  color: #8020a4;   
}

.custom-btn:hover {
  background-color: #8020a4; 
  color: #fff;       
}

.verify-btn {
  background: linear-gradient(90deg, #8020a4, #9c3cc9);
  color: #fff;
  font-weight: 600;
  font-size: 12px;
  padding: 8px;
  transition: all 0.3s ease-in-out;
}
.verify-btn:hover {
  background: linear-gradient(90deg, #6a1a8a, #8229a7);
  transform: translateY(-2px);
  box-shadow: 0 6px 15px rgba(128, 32, 164, 0.4);
}

.noverify-btn {
  background: #f8f9fa;
  border: 2px dashed #8020a4;
  color: #8020a4;
  font-weight: 600;
  font-size: 12px;
  padding: 8px;
  transition: all 0.3s ease-in-out;
}
.noverify-btn:hover {
  background: #8020a4;
  color: #fff;
  transform: translateY(-2px);
  box-shadow: 0 6px 15px rgba(128, 32, 164, 0.4);
}

.small-text {
  font-size: 12px;
  font-weight: 400;
  opacity: 0.8;
}

 .bg-purple {
    background: linear-gradient(90deg, #6a0dad, #9b59b6);
  }
  .text-purple {
    color: #6a0dad !important;
  }

  .glass-card {
    background: rgba(255, 255, 255, 0.8);
    border-radius: 20px;
    backdrop-filter: blur(10px);
    -webkit-backdrop-filter: blur(10px);
  }

  /* Gradient heading */
  .text-gradient {
    background: linear-gradient(90deg, #6a11cb, #2575fc);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
  }

  /* Gradient button */
  .btn-gradient {
    background: linear-gradient(90deg, #6a1b9a, #8e24aa);
    color: #fff;
    font-weight: 600;
    border-radius: 12px;
    transition: all 0.3s ease;
  }
  .btn-gradient:hover {
    box-shadow: 0 4px 15px rgba(106, 17, 203, 0.4);
    transform: translateY(-2px);
  }

  /* Icon Box */
  .icon-box {
    width: 70px;
    height: 70px;
    border-radius: 50%;
    background: linear-gradient(135deg, #ff758c, #ff7eb3);
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 28px;
    color: #fff;
    box-shadow: 0 4px 10px rgba(255, 118, 136, 0.4);
  }

  .modal-bottom .modal-content {
    border-radius: 20px 20px 0 0;
    margin: 0;
    position: fixed;
    bottom: 0;
    width: 100%;
    animation: slideUp 0.3s ease-out;
  }
  @keyframes slideUp {
    from { transform: translateY(100%); }
    to { transform: translateY(0); }
  }
  .ipin-box {
    width: 60px;
    height: 60px;
    font-weight: bold;
    border-radius: 12px;
    border: 2px solid #ddd;
  }
  .btn-gradient {
    background: linear-gradient(90deg, #6a11cb, #2575fc);
    color: #fff;
    font-weight: 600;
    border-radius: 10px;
    transition: all 0.3s ease;
  }
  .btn-gradient:hover {
    box-shadow: 0 4px 12px rgba(106, 17, 203, 0.4);
    transform: translateY(-2px);
  }

  .otp-input {
    width: 50px;
    height: 50px;
    text-align: center;
    font-size: 20px;
    font-weight: bold;
    border: 2px solid #9C27B0;
    border-radius: 10px;
    outline: none;
    transition: all 0.2s ease-in-out;
  }
  .otp-input:focus {
    border-color: #673AB7;
    box-shadow: 0 0 5px #9C27B0;
  }

  .contact-list {
    display: flex;
    flex-direction: column;
    gap: 15px; /* yaha se gap control karo */
}

.contact-item {
    background: #f1f3ff;
    border-radius: 10px;
    padding: 12px;
}
.contact-name {
    font-weight: 600;
    font-size: 16px;
}
.contact-number {
    color: #333;
}
.badge.emp {
    color: purple;
    font-weight: bold;
    margin-left: 8px;
}

.contact-list a,
    .contact-list a:hover,
    .contact-list a:focus,
    .contact-list a:active {
        text-decoration: none !important;
        color: inherit !important; /* default bootstrap blue color bhi hatao */
    }

.otp-input {
        width: 280px;               /* Box ko bada kar diya */
        height: 60px;               /* Height bhi badi */
        font-size: 28px;            /* Text bada aur clear */
        letter-spacing: 8px;        /* Digits ke beech space */
        border: 3px solid #8000ff;  /* Purple border */
        border-radius: 15px;        /* Gol corner */
        text-align: center;         /* Digits center me */
        padding: 10px;
        color: #333;                /* Text color */
        transition: all 0.3s ease-in-out;
    }

    .otp-input:focus {
        border-color: #ff00cc;      /* Focus hone par border color */
        box-shadow: 0 0 15px rgba(128, 0, 255, 0.5);
        outline: none;
    }
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
  
<!-- Header -->
<div class="cb-header shadow-sm">
  <h2><i class="bi bi-journal-bookmark-fill me-2"></i> Contact Book</h2>
</div>

<!-- Main Container -->
<div class="main-container">
  <!-- Sidebar -->
  <div class="contact-sidebar">
    <div class="search-box mb-3">
  <input type="text" id="searchBox" placeholder="Search Contact..." class="form-control" />
  <i class="bi bi-search"></i>
</div>
     
    <!-- Contact List -->
<div class="contact-list" id="contactList">
    <asp:Repeater runat="server" ID="rptProduct" OnItemCommand="rptProduct_ItemCommand">
        <ItemTemplate>
            <div class="contact-item p-2 border rounded mb-2">
                <asp:LinkButton runat="server" CommandName="ShowProfile" 
                                CommandArgument='<%# Eval("ContactPersonName") + "|" + Eval("ContactType") + "|" + Eval("PhoneNumber") + "|" + Eval("Email") + "|" + Eval("Id")  %>' 
                                CssClass="w-100 text-start border-0 bg-transparent">
                    
                    <div class="contact-name fw-bold">
                        <%# Eval("ContactPersonName") %>
                        <span class="badge bg-info text-dark ms-2"><%# Eval("ContactType") %></span>
                    </div>
                    
                    <div class="contact-number text-muted">
                        <i class="bi bi-telephone-fill me-2"></i><%# Eval("PhoneNumber") %>
                    </div>
                    
                    <div class="contact-number text-muted">
                        <i class="bi bi-envelope me-2"></i><%# Eval("Email") %>
                    </div>
                </asp:LinkButton>
            </div>
        </ItemTemplate>
    </asp:Repeater>
</div>
    
       <!-- Add Contact Button -->
  <button type="button" class="add-btn" 
        data-bs-toggle="offcanvas" 
        data-bs-target="#addContactSidebar" 
        aria-controls="addContactSidebar">
    <i class="bi bi-plus-lg"></i> Add Contact
</button>
    <%--<button class=""><i class="bi bi-plus-lg"></i> Add Contact</button>--%>
  </div>

  <!-- Contact Details -->
  <div class="contact-details">
    <div class="profile-card">
  <div class="profile-header">
    <div class="avatar" id="lblAvatar" runat="server">--</div>
    <div>
      <h3><asp:Label ID="lblName" runat="server"></asp:Label> 
        <span class="badge emp"><asp:Label ID="lblType" runat="server"></asp:Label></span>
      </h3>
        <asp:HiddenField ID="HiddenField1" runat="server" />
      <div class="info">
        <p><i class="bi bi-telephone"></i> <asp:Label ID="lblPhone" runat="server"></asp:Label></p>
        <p><i class="bi bi-envelope"></i> <asp:Label ID="lblEmail" runat="server"></asp:Label></p>
      </div>
    </div>
    <div class="actions">
        <i class="bi bi-pencil-square cursor-pointer" data-bs-toggle="offcanvas" data-bs-target="#updateContactSidebar"></i>
        <asp:LinkButton ID="LinkButton6" runat="server" OnClick="LinkButton6_Click"> <i class="bi bi-trash cursor-pointer"></i></asp:LinkButton>
        <asp:Label ID="lblOTPStatus" runat="server" ></asp:Label>
      <i class="bi bi-box-arrow-up-right"></i>
    </div>
  </div>
</div>

    <!-- Tabs -->
    <!-- Tabs -->
  <div class="tabs">
     <!-- Tabs -->
  <ul class="nav nav-tabs">
    <li class="nav-item">
      <a class="nav-link active" data-bs-toggle="tab" href="#payment">Payment Accounts</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" data-bs-toggle="tab" href="#registration">Registration Info</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" data-bs-toggle="tab" href="#statements">Statements</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" data-bs-toggle="tab" href="#address">Address</a>
    </li>
    <%--<li class="nav-item">
      <a class="nav-link" data-bs-toggle="tab" href="#notes">Notes</a>
    </li>--%>
  </ul>
  </div>
      <!-- Tab Content -->
  <div class="tab-content mt-4 text-center">

    <!-- Payment Accounts -->
    <div id="payment" class="tab-pane fade show active">

    <!-- Repeater: Accounts List -->
    <asp:Repeater ID="rptPaymentAccounts" runat="server">
        <HeaderTemplate>
            <div class="row g-3">
        </HeaderTemplate>

        <ItemTemplate>
            <div class="col-12">
                <div class="card shadow-sm border-0 rounded-3 p-3 d-flex flex-row align-items-center justify-content-between">

                    <!-- Left: Bank details -->
                    <div class="d-flex align-items-center">
                        <!-- Bank Icon -->
                        <div class="me-3">
                            <i class="bi bi-bank fs-3 text-primary"></i>
                        </div>

                        <!-- Details -->
                        <div>
                            <h6 class="mb-1 fw-bold">
                                <%# Eval("BankName") %>
                                <i class="bi bi-shield-check text-success ms-2"></i>
                               
                            </h6>
                            <small class="text-muted">
                                Account Number : <span class="fw-semibold"><%# Eval("AccountNumber") %></span> 
                                &nbsp; IFSC : <span class="fw-semibold"><%# Eval("IFSC") %></span>
                            </small>
                        </div>
                    </div>

                </div>
            </div>
        </ItemTemplate>

        <FooterTemplate>
            </div>
        </FooterTemplate>
    </asp:Repeater>

    <!-- Add button -->
    <div class="mt-3">
        <button type="button"
                class="btn btn-primary rounded-pill px-4"
                data-bs-toggle="offcanvas"
                data-bs-target="#addPaymentSidebar">
            <i class="bi bi-plus-lg"></i> Add Payment Account
        </button>
    </div>
</div>

    <!-- Registration Info -->
<div id="registration" class="tab-pane fade">
  <div class="p-4 bg-light rounded shadow-sm">
    <h5 class="mb-4 fw-bold text-secondary">
      <i class="bi bi-card-checklist me-2 text-primary"></i> Registration Information
    </h5>
      <div class="row g-3">
    <div class="col-md-6">
        <asp:TextBox ID="txtPAN" runat="server" CssClass="form-control rounded-pill" placeholder="PAN"></asp:TextBox>
    </div>
    <div class="col-md-6">
        <asp:TextBox ID="txtCIN" runat="server" CssClass="form-control rounded-pill" placeholder="CIN"></asp:TextBox>
    </div>
    <div class="col-md-4">
        <asp:TextBox ID="txtGSTIN" runat="server" CssClass="form-control rounded-pill" placeholder="GSTIN"></asp:TextBox>
    </div>
    <div class="col-md-4">
        <asp:TextBox ID="txtTAN" runat="server" CssClass="form-control rounded-pill" placeholder="TAN"></asp:TextBox>
    </div>
    <div class="col-md-4">
        <asp:TextBox ID="txtUDYAM" runat="server" CssClass="form-control rounded-pill" placeholder="UDYAM"></asp:TextBox>
    </div>
</div>

      <div class="text-center mt-4">
          <asp:LinkButton ID="LinkButton3" runat="server" class="btn custom-btn rounded-pill px-4" OnClick="LinkButton3_Click"><i class="bi bi-plus-lg me-1"></i> Add</asp:LinkButton>
      </div>
  </div>
</div>

    <!-- Statements -->
<div id="statements" class="tab-pane fade">

  <div class="card border-0 shadow-sm">
    <div class="card-body p-0">
      <table class="table table-hover text-center align-middle mb-0">
        <thead class="bg-purple text-white">
          <tr>
            <th>Status</th>
            <th>Order ID</th>
            <th>Amount (₹)</th>
            <th>Opening (₹)</th>
            <th>Closing (₹)</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td colspan="5" class="py-5">
              <div class="d-flex flex-column align-items-center">
                <img src="https://cdn-icons-png.flaticon.com/512/4076/4076549.png" width="60" class="mb-2 opacity-75">
                <p class="text-muted mb-0">Transactions will be shown here.</p>
              </div>
            </td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
</div>

    <!-- Address -->
    <div id="address" class="tab-pane fade">
  <div class="card glass-card shadow-lg border-0 p-4 text-center">
    <div class="icon-box mx-auto mb-3">
      <i class="bi bi-geo-alt-fill"></i>
    </div>
     
    <p class="text-muted">Include a contact address so that mailing and communicating is simple and quick.</p>
   <button class="add-btn w-100 mt-3" 
        data-bs-toggle="offcanvas" 
        data-bs-target="#addAddressSidebar">
    <i class="bi bi-plus-lg me-1"></i> Add Address
</button>
  </div>
</div>

    <!-- Notes -->
    <%--<div id="notes" class="tab-pane fade">
      <h5>Notes</h5>
      <p>Here goes notes content...</p>
    </div>--%>
  </div>
  </div>
</div>


    <!-- Sidebar (Bootstrap Offcanvas) Address -->

<!-- Sidebar (Bootstrap Offcanvas) -->
<!-- Offcanvas Sidebar -->
<!-- Offcanvas Sidebar -->
<div class="offcanvas offcanvas-end" tabindex="-1" id="addAddressSidebar">
  <div class="offcanvas-header border-bottom">
    <h5 class="offcanvas-title text-gradient fw-bold">Add New Address</h5>
    <button type="button" class="btn-close" data-bs-dismiss="offcanvas"></button>
  </div>

  <div class="offcanvas-body">

    <div class="mb-3">
        <label class="form-label fw-semibold" for="txtFullName">Full Name</label>
        <asp:TextBox ID="txtFullName" runat="server" CssClass="form-control form-control-lg" Placeholder="Enter full name"></asp:TextBox>
    </div>

    <div class="mb-3">
        <label class="form-label fw-semibold" for="txtPhone">Phone</label>
        <asp:TextBox ID="TextBox1" runat="server" CssClass="form-control form-control-lg" Placeholder="Enter phone number"></asp:TextBox>
    </div>

    <div class="mb-3">
        <label class="form-label fw-semibold" for="txtAddress">Address</label>
        <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control form-control-lg" TextMode="MultiLine" Rows="3" Placeholder="Enter address"></asp:TextBox>
    </div>

    <div class="mb-3">
        <label class="form-label fw-semibold" for="txtPincode">Pincode</label>
        <asp:TextBox ID="txtPincode" runat="server" CssClass="form-control form-control-lg" Placeholder="Enter pincode"></asp:TextBox>
    </div>

    <asp:LinkButton ID="LinkButton4" runat="server" CssClass="add-btn w-100 py-2" OnClick="LinkButton4_Click">
        Save Address
    </asp:LinkButton>
    
  </div>
</div>

     <!-- Sidebar Add COntact -->
  <!-- Sidebar -->
<div class="offcanvas offcanvas-end" tabindex="-1" id="addContactSidebar" 
     data-bs-backdrop="static" data-bs-keyboard="false">
  <div class="offcanvas-header custom-header">
    <h5 class="offcanvas-title text-white">
      <i class="bi bi-person-plus-fill me-2"></i> Add Contact
    </h5>
    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="offcanvas"></button>
  </div>

  <div class="offcanvas-body">
    <div class="mb-3">
      <label for="ddlcontacttype" class="form-label fw-bold">Contact Type</label>
      <asp:DropDownList ID="ddlcontacttype" runat="server" CssClass="form-select">
        <asp:ListItem Value="">Select Contact Type</asp:ListItem>
        <asp:ListItem Value="Vendor">Vendor</asp:ListItem>
        <asp:ListItem Value="Employee">Employee</asp:ListItem>
        <asp:ListItem Value="Customer">Customer</asp:ListItem>
      </asp:DropDownList>
    </div>

    <div class="mb-3">
      <label for="txtcontactperson" class="form-label fw-bold">Contact Person Name</label>
      <asp:TextBox ID="txtcontactperson" runat="server" CssClass="form-control" placeholder="Enter full name"></asp:TextBox>
    </div>

    <div class="mb-3">
      <label for="txtcompanyname" class="form-label fw-bold">Company Name</label>
      <asp:TextBox ID="txtcompanyname" runat="server" CssClass="form-control" placeholder="Optional"></asp:TextBox>
    </div>

    <div class="mb-3">
      <label for="txtphone" class="form-label fw-bold">Phone Number</label>
      <asp:TextBox ID="txtphone" runat="server" CssClass="form-control" placeholder="Enter phone number"></asp:TextBox>
    </div>

    <div class="mb-3">
      <label for="txtemail" class="form-label fw-bold">Email</label>
      <asp:TextBox ID="txtemail" runat="server" CssClass="form-control" placeholder="Enter email"></asp:TextBox>
    </div>

    <!-- Proceed button (save to DB) -->
    <asp:LinkButton ID="LinkButton1" runat="server" CssClass="add-btn w-100" OnClick="LinkButton1_Click">
      Proceed
    </asp:LinkButton>
  </div>
</div>
    <!-- Button -->

    <!-- Sidebar (Bootstrap Offcanvas) Edit -->
<div class="offcanvas offcanvas-end" tabindex="-1" id="updateContactSidebar">
  <div class="offcanvas-header border-bottom">
    <h5 class="offcanvas-title fw-bold">Update Contact</h5>
    <button type="button" class="btn-close" data-bs-dismiss="offcanvas"></button>
  </div>
  <div class="offcanvas-body">
      <div class="mb-3">
        <label class="form-label fw-semibold">Select Contact Type</label><br />
        <asp:DropDownList ID="DropDownList1" runat="server" CssClass="form-select">
            <asp:ListItem Text="Select Contact Type" Value=""></asp:ListItem>
            <asp:ListItem Text="Employee" Value="Employee"></asp:ListItem>
            <asp:ListItem Text="Vendor" Value="Vendor"></asp:ListItem>
            <asp:ListItem Text="Customer" Value="Customer"></asp:ListItem>
        </asp:DropDownList>
    </div>

    <!-- Contact Person Name -->
    <div class="mb-3">
        <label class="form-label fw-semibold" for="txtContactPerson">Contact Person Name</label>
        <asp:TextBox ID="txtcontactpersonname" runat="server" CssClass="form-control" Placeholder="Enter contact person name"></asp:TextBox>
    </div>

    <!-- Company Name -->
    <div class="mb-3">
        <label class="form-label fw-semibold" for="txtCompanyName">Company Name (optional)</label>
        <asp:TextBox ID="txtcompany" runat="server" CssClass="form-control" Placeholder="Enter company name"></asp:TextBox>
    </div>

    <!-- Email -->
    <div class="mb-3">
        <label class="form-label fw-semibold" for="txtEmail">Email ID</label>
        <asp:TextBox ID="txtemailid" runat="server" CssClass="form-control" TextMode="Email" Placeholder="Enter email ID"></asp:TextBox>
    </div>

    <!-- Phone -->
    <div class="mb-3">
        <label class="form-label fw-semibold" for="txtPhone">Phone Number</label>
        <asp:TextBox ID="txtphn" runat="server" CssClass="form-control" Placeholder="Enter phone number"></asp:TextBox>
    </div>
      <asp:LinkButton ID="LinkButton5" runat="server" class="btn btn-gradient w-100 py-2" OnClick="LinkButton5_Click">Proceed</asp:LinkButton>
  </div>
</div>

    <!-- OTP Modal -->
<div class="modal fade" id="otpModal" tabindex="-1">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content rounded-4 border-0 shadow-lg">
      
      <!-- Header -->
      <div class="modal-header text-white" 
           style="background: linear-gradient(90deg,#9C27B0,#673AB7); border-radius: 10px 10px 0 0;">
        <h5 class="modal-title">
          <i class="bi bi-shield-lock me-2"></i> 4-digit iPIN
        </h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
      </div>
      
      <!-- Body -->
      <div class="modal-body text-center">
        <p class="fw-bold mb-3">Enter your 4-digit iPIN to confirm</p>
       <div class="d-flex justify-content-center gap-2 mb-3">
    <asp:TextBox ID="TextBox2" runat="server" 
        CssClass="form-control otp-input text-center fw-bold shadow-sm"
        MaxLength="4"
        placeholder="Enter OTP"></asp:TextBox>
</div>
        <small class="text-muted"><a href="#" class="text-decoration-none">Forgot iPIN?</a></small>
      </div>
      
      <!-- Footer -->
      <div class="modal-footer justify-content-center border-0">
          <asp:LinkButton ID="LinkButton7" runat="server" class="btn text-white px-4 py-2 rounded-pill" 
                style="background: linear-gradient(90deg,#9C27B0,#673AB7);" OnClick="LinkButton7_Click">Submit OTP</asp:LinkButton>
        <button type="button" class="btn btn-secondary px-4 py-2 rounded-pill" 
                data-bs-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>

<!-- Sidebar (Offcanvas) Add Payment Sidebar -->
<div class="offcanvas offcanvas-end" tabindex="-1" id="addPaymentSidebar" data-bs-backdrop="static" data-bs-keyboard="false">
  <div class="offcanvas-header custom-header">
    <h5 class="offcanvas-title text-white">
      <i class="bi bi-bank2 me-2"></i> Add Payment Account
    </h5>
    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="offcanvas"></button>
  </div>

  <div class="offcanvas-body">

    <!-- Payment Method -->
    <div class="mb-3">
      <label class="form-label">Select Payment Method</label>
      <asp:DropDownList ID="ddlPaymentMethod" runat="server" CssClass="form-select" onchange="togglePaymentFields(this)">
        <asp:ListItem Text="Bank Account" Value="Bank"></asp:ListItem>
        <asp:ListItem Text="UPI" Value="UPI"></asp:ListItem>
      </asp:DropDownList>
    </div>

    <!-- UPI Section -->
    <div id="upiSection" style="display:none;">
      <div class="mb-3">
        <asp:TextBox ID="txtUpiId" runat="server" CssClass="form-control" Placeholder="Enter UPI ID"></asp:TextBox>
      </div>
    </div>

    <!-- Bank Section -->
    <div id="bankSection">
      <div class="mb-3">
        <asp:TextBox ID="txtAccountNumber" runat="server" CssClass="form-control" Placeholder="Account Number"></asp:TextBox>
      </div>

      <div class="mb-3">
        <asp:DropDownList ID="ddlBankName" runat="server" CssClass="form-select"></asp:DropDownList>
      </div>

      <div class="mb-3">
        <asp:TextBox ID="txtIFSC" runat="server" CssClass="form-control" Placeholder="IFSC"></asp:TextBox>
      </div>

      <div class="mb-3">
        <asp:TextBox ID="txtBeneficiaryName" runat="server" CssClass="form-control" Placeholder="Beneficiary Name"></asp:TextBox>
      </div>
    </div>

    <!-- Buttons -->
      <asp:LinkButton ID="LinkButton2" runat="server" CssClass="btn verify-btn w-100 mb-3 rounded-pill shadow-sm" OnClick="LinkButton2_Click" >Verify & Add</asp:LinkButton>
    
    <div class="small-text text-center mb-2">(verification charges applicable)</div>

    <asp:Button ID="btnAddWithoutVerify" runat="server" Text="Add without Verifying" CssClass="btn noverify-btn w-100 rounded-pill shadow-sm" />
    <div class="small-text text-center">(no charges)</div>
  </div>
</div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    

     <script>
         const tabs = document.querySelectorAll('.tabs a');
         const contents = document.querySelectorAll('.tab-content');

         tabs.forEach(tab => {
             tab.addEventListener('click', (e) => {
                 e.preventDefault();

                 // remove active from all
                 tabs.forEach(t => t.classList.remove('active'));
                 contents.forEach(c => c.classList.remove('active'));

                 // add active to clicked tab + show content
                 tab.classList.add('active');
                 document.getElementById(tab.dataset.tab).classList.add('active');
             });
         });
     </script>
    <script>
        function togglePaymentFields(dropdown) {
            var value = dropdown.value;
            if (value === "UPI") {
                document.getElementById("upiSection").style.display = "block";
                document.getElementById("bankSection").style.display = "none";
            } else {
                document.getElementById("upiSection").style.display = "none";
                document.getElementById("bankSection").style.display = "block";
            }
        }

        // Page load pe bhi check kare (default selection ke liye)
        window.onload = function () {
            var ddl = document.getElementById("<%= ddlPaymentMethod.ClientID %>");
            togglePaymentFields(ddl);
        };
    </script>

    <script>
        document.getElementById("searchBox").addEventListener("keyup", function () {
            let value = this.value.toLowerCase();
            let items = document.querySelectorAll("#contactList .contact-item");

            items.forEach(item => {
                let text = item.innerText.toLowerCase();
                item.style.display = text.includes(value) ? "" : "none";
            });
        });
    </script>
</asp:Content>