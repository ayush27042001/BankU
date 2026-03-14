<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/NeoxAdmin.Master" AutoEventWireup="true" CodeBehind="ViewKyc.aspx.cs" Inherits="NeoXPayout.Admin.ViewKyc" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container mt-4">
    <div class="card shadow-sm rounded-4">
        <div class="card-header text-white" style="background-color:purple">
            <h5 class="mb-0">KYC Documents <span id="UserName" runat="server"></span></h5>
        </div>

        <div class="card-body">
            <div class="row g-4">

                <!-- Aadhaar -->
                <div class="col-md-6">
                    <div class="border rounded-3 p-3 text-center">
                        <h6>Aadhaar Card</h6>
                        <asp:Image ID="imgAadhar" runat="server"
                            CssClass="img-fluid rounded shadow-sm"
                            Style="max-height:220px;" />
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
                            CssClass="img-fluid rounded shadow-sm"
                            Style="max-height:220px;" />
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
                            CssClass="img-fluid rounded shadow-sm"
                            Style="max-height:220px;" />
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
                            CssClass="img-fluid rounded shadow-sm"
                            Style="max-height:220px;" />
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
                            CssClass="img-fluid rounded shadow-sm"
                            Style="max-height:220px;" />
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
                            CssClass="img-fluid rounded shadow-sm"
                            Style="max-height:220px;" />
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
                            CssClass="img-fluid rounded shadow-sm"
                            Style="max-height:220px;" />
                           <asp:HyperLink ID="lnkApplication" runat="server"
                            Target="_blank"
                            CssClass="d-block mt-2 text-primary fw-semibold" />
                        <br />
                        <asp:Label ID="lblApplication" runat="server" />
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


</asp:Content>
