<%@ Page Title="" Language="C#" MasterPageFile="~/Neox.Master" AutoEventWireup="true" CodeBehind="Payment.aspx.cs" Inherits="NeoXPayout.Payment" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="ratio ratio-16x9">
        <iframe id="paymentFrame" runat="server" style="border:0;" title="Payment" allowfullscreen></iframe>
    </div>
</asp:Content>


