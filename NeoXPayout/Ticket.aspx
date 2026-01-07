<%@ Page Title="" Language="C#" MasterPageFile="~/Neox.Master" AutoEventWireup="true" CodeBehind="Ticket.aspx.cs" Inherits="NeoXPayout.Ticket" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <hr />
<div class="px-xl-5 px-lg-4 px-3 py-3 page-body">
  <div class="d-flex justify-content-between align-items-center mb-3">
        <h2 class="fw-bold mb-0" style="color:#4a4a4a;">
            <i class="bi bi-receipt"></i> Ticket List
        </h2>

        <button class="btn btn-danger"
                type="button"
                data-bs-toggle="offcanvas"
                data-bs-target="#Ticket">
            Add Ticket
        </button>
    </div>


    <div class="row">
        <div class="col-12">
            <div class="border p-4 rounded-2 rounded-4">                            
                <div class="1">
                <table
                    class="table align-middle table-hover dataTable table-body" >
                    <thead>
                       <tr class="small text-uppercase">                                               
                            <th>Ticket Id</th>                                   
                            <th>TransactionID</th>
                            <th>Type</th>                   
                            <th>Status</th>       
                            <th>Created At</th>    
                            <th>Description</th> 
                        </tr>
                    </thead>
                    <tbody>
                        <asp:Repeater runat="server" ID="rptProduct">
                        <ItemTemplate>
                                <tr>
                                    <td><%# Eval("Id") %></td>
                                  
                                    <td><%# Eval("TransactionID") %></td>
                                    <td><%# Eval("Type") %></td>
                                      <td 
                                        style='<%# 
                                            Eval("Status").ToString() == "Resolved" 
                                            ? "color:#155724;padding:1px 8px;border-radius:20px;text-align:center;font-weight:bold;display:inline-block;" 
                                            : "color:#d80000;padding:1px 8px;border-radius:20px;text-align:center;font-weight:bold;display:inline-block;" 
                                        %>'>
                                        <%# Eval("Status") %>
                                   </td> 
                                    <td data-order='<%# Eval("CreatedAt","{0:yyyyMMdd}") %>'><%# Eval("CreatedAt", "{0:yyyy/MM/dd hh:mm tt}") %></td>                                                        
                                    <td><%# Eval("Description") %></td>
                                </tr>
                        </ItemTemplate>
                        </asp:Repeater>                                         
                    </tbody>
          </table>
        </div>
      </div>
    </div>
  </div>
 </div>
<div class="offcanvas offcanvas-end" tabindex="-1" id="Ticket"
     data-bs-backdrop="static" data-bs-keyboard="false">

    <div class="offcanvas-header text-white" style="background:purple">
        <div>
              
            <h5 class="mb-0 fw-bold">Add Ticket</h5>
         
        </div>
    </div>
      

    <div class="offcanvas-body p-4">
        <div class="mb-3">
            <label class="form-label fw-semibold">Transaction Id</label>
            <asp:TextBox runat="server" ID="txtTxn" cssclass="form-control" Placeholder="Enter description here"></asp:TextBox>
        </div>
        
        <div class="mb-3">
            <label class="form-label fw-semibold">Type</label>
            <asp:DropDownList 
                ID="ddlService" 24
                runat="server" 
                CssClass="form-select">
                <asp:ListItem Value="">Select Service</asp:ListItem>
                <asp:ListItem Value="Recharge">Recharge Service</asp:ListItem>
                <asp:ListItem Value="AEPS">AEPS Service</asp:ListItem>
                <asp:ListItem Value="DMT">DMT Service</asp:ListItem>
            </asp:DropDownList>
        </div>

        <div class="mb-3">
            <label class="form-label fw-semibold">Description</label>
           <asp:TextBox runat="server" ID="txtDescription" cssclass="form-control" TextMode="MultiLine" Rows="4" Placeholder="Enter description here"></asp:TextBox>
           
        </div>
     
        <div class="d-flex justify-content-between mt-4">
            <asp:LinkButton runat="server" ID="btnSave" class="btn text-white px-4" style="background:purple;" OnClick="btnSave_Click">Send</asp:LinkButton>

            <button class="btn btn-outline-secondary px-4"
                    data-bs-dismiss="offcanvas" type="button">
                Cancel
            </button>
        </div>
    </div>
</div>
</asp:Content>
