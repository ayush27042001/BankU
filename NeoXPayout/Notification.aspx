<%@ Page Title="" Language="C#" MasterPageFile="~/Neox.Master" AutoEventWireup="true" CodeBehind="Notification.aspx.cs" Inherits="NeoXPayout.Notification" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    
<style>
  :root {
    --primary: #6e007c;
    --bg: #f5f7fb;
    --card: #ffffff;
    --text-dark: #1f2937;
    --text-light: #6b7280;
  }

  .notification-wrapper {
    padding: 24px;
    background: var(--bg);
    min-height: calc(100vh - 120px);
  }

  .notification-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 20px;
  }

  .notification-header h4 {
    margin: 0;
    color: var(--text-dark);
    font-weight: 600;
  }

  .mark-read-btn {
    background: var(--primary);
    color: #fff;
    border: none;
    padding: 8px 16px;
    border-radius: 20px;
    font-size: 13px;
    cursor: pointer;
  }

  .notification-card {
    background: var(--card);
    border-radius: 14px;
    padding: 16px 18px;
    display: flex;
    gap: 14px;
    align-items: flex-start;
    margin-bottom: 14px;
    box-shadow: 0 6px 18px rgba(0,0,0,0.06);
    transition: all 0.2s ease;
  }

  .notification-card:hover {
    transform: translateY(-2px);
  }

  .notification-icon {
    width: 42px;
    height: 42px;
    background: rgba(110,0,124,0.12);
    color: var(--primary);
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 18px;
    flex-shrink: 0;
  }

  .notification-content h6 {
    margin: 0 0 4px 0;
    font-size: 14px;
    color: var(--text-dark);
    font-weight: 600;
  }

  .notification-content p {
    margin: 0;
    font-size: 13px;
    color: var(--text-light);
    line-height: 1.5;
  }

  .notification-time {
    font-size: 11px;
    color: #9ca3af;
    margin-top: 6px;
  }

  .unread {
    border-left: 4px solid var(--primary);
  }

  .empty-state {
    text-align: center;
    padding: 60px 20px;
    color: var(--text-light);
  }

  .empty-state img {
    width: 120px;
    margin-bottom: 12px;
    opacity: 0.8;
  }
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
<div class="notification-wrapper">

 <!-- Header -->
  <div class="notification-header">
    <h4>Notifications</h4>
    <button type="button" class="mark-read-btn">Mark all as read</button>
  </div>
     
  <!-- Notification Item -->
<%--  <div class="notification-card unread">
    <div class="notification-icon">🔔</div>
    <div class="notification-content">
      <h6>Service Activation Request Submitted</h6>
      <p>Your request for <b>International Money Transfer</b> has been submitted successfully and is under review.</p>
      <div class="notification-time">2 minutes ago</div>
    </div>
  </div>

  <!-- Notification Item -->
  <div class="notification-card">
    <div class="notification-icon">✅</div>
    <div class="notification-content">
      <h6>Service Activated</h6>
      <p>Your <b>AEPS Service</b> has been approved and activated. You can start transactions now.</p>
      <div class="notification-time">Yesterday</div>
    </div>
  </div>

  <!-- Notification Item -->
  <div class="notification-card">
    <div class="notification-icon">⚠️</div>
    <div class="notification-content">
      <h6>KYC Pending</h6>
      <p>Please complete your KYC to avoid service interruption.</p>
      <div class="notification-time">3 days ago</div>
    </div>
  </div>--%>

  <!-- Empty State (use when no notifications) -->
  
  <div class="empty-state">
    <img src="https://cdn-icons-png.flaticon.com/512/4076/4076478.png" />
    <h6>No Notifications</h6>
    <p>You’re all caught up!</p>
  </div>
  

</div>
</asp:Content>
