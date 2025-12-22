<%@ Page Title="" Language="C#" MasterPageFile="~/team/Team.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="NeoXPayout.team.Dashboard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <hr />
    <div class="px-xl-5 px-lg-4 px-3 py-2">
                    <div class="row g-2 align-items-center">
                         <div class="col-sm-6">
                              <ol class="breadcrumb mb-0 bg-transparent ">
                                   <li class="breadcrumb-item"><a class="text-muted" href="Dashboard.aspx"
                                             title="home">Home</a>
                                   </li>
                                   <li class="breadcrumb-item active" aria-current="page" title="Dashboard">Dashboard
                                   </li>
                              </ol>
                         </div>
                         <div class="col-sm-6 d-flex justify-content-center align-items-center ">
                              
                         </div>
                    </div>
               </div>
               <!-- start: page body area -->
               <div class="px-xl-5 px-lg-4 px-3 py-3 page-body">
                    <div class="row g-3 mb-3 row-deck">
                         <div class="col-md-6 col-lg-6 col-xl-6">
                              <div class="card">
                                   <div class="card-header">
                                        <h6 class="card-title mb-0">Today Transaction</h6>
                                        <div class="card-action">
                                             <div>
                                                  <a href="#" class="card-fullscreen" data-bs-toggle="tooltip"
                                                       aria-label="Card Full Screen"
                                                       data-bs-original-title="Card Full Screen">
                                                       <svg class="svg-stroke" xmlns="http://www.w3.org/2000/svg"
                                                            width="20" height="20" viewBox="0 0 24 24" fill="none"
                                                            stroke="currentColor" stroke-linecap="round"
                                                            stroke-linejoin="round">
                                                            <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>
                                                            <path
                                                                 d="M21 12v3a1 1 0 0 1 -1 1h-16a1 1 0 0 1 -1 -1v-10a1 1 0 0 1 1 -1h9">
                                                            </path>
                                                            <path d="M7 20l10 0"></path>
                                                            <path d="M9 16l0 4"></path>
                                                            <path d="M15 16l0 4"></path>
                                                            <path d="M17 4h4v4"></path>
                                                            <path d="M16 9l5 -5"></path>
                                                       </svg>
                                                  </a>
                                                  <a href="#" class="dropdown-toggle after-none"
                                                       data-bs-toggle="dropdown" aria-expanded="false"
                                                       title="More Action">
                                                       <svg class="svg-stroke" xmlns="http://www.w3.org/2000/svg"
                                                            width="20" height="20" viewBox="0 0 24 24" fill="none"
                                                            stroke="currentColor" stroke-linecap="round"
                                                            stroke-linejoin="round">
                                                            <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>
                                                            <path
                                                                 d="M10 6h-3a2 2 0 0 0 -2 2v9a2 2 0 0 0 2 2h9a2 2 0 0 0 2 -2v-3">
                                                            </path>
                                                            <path d="M17 7m-3 0a3 3 0 1 0 6 0a3 3 0 1 0 -6 0"></path>
                                                       </svg>
                                                  </a>
                                                  
                                             </div>
                                        </div>
                                   </div>
                                   <div class="card-body">
                                        <div class="card">
                                             <div class="card-header">
                                                  <div class="me-2">
                                                       <img src="../assets/images/flags/1x1/in.svg" alt="um"
                                                            class="img-fluid rounded-circle avatar sm">
                                                  </div>
                                                  <h6 class="card-title mb-0 me-auto">INDIAN INR</h6>
                                             </div>
                                             <div class="card-body">
                                                  <h2>₹<asp:Label ID="lblsuccess" runat="server"></asp:Label></h2>
                                                 
                                                  <!-- Success Alert -->
                                                  <div class="alert alert-success mt-3 py-2" role="alert">
                                                       <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20"
                                                            fill="currentColor" class="bi bi-question-circle"
                                                            viewBox="0 0 16 16">
                                                            <path
                                                                 d="M8 0a8 8 0 1 0 0 16 8 8 0 0 0 0-16zm0 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14z">
                                                            </path>
                                                            <path
                                                                 d="M8 4a1 1 0 1 0 0 2 1 1 0 0 0 0-2zm0 3a2 2 0 0 0-1.995 1.85L6 9a1 1 0 0 0 1 1h1a1 1 0 0 0 1-1c0-1.08-.64-2-1.5-2z">
                                                            </path>
                                                       </svg>
                                                       This is a success
                                                  </div>
                                             </div>
                                        </div>
                                   </div>
                                  
                              </div>
                         </div>
                         <div class="col-md-6 col-lg-6 col-xl-6">
                              <div class="card">
                                   <div class="card-header">
                                        <h6 class="card-title mb-0">My Wallet</h6>
                                        <div class="card-action">
                                             <div>
                                                  <!--============== full srcen  =============-->
                                                  <a href="#" class="card-fullscreen" data-bs-toggle="tooltip"
                                                       aria-label="Card Full Screen"
                                                       data-bs-original-title="Card Full Screen">
                                                       <svg class="svg-stroke" xmlns="http://www.w3.org/2000/svg"
                                                            width="20" height="20" viewBox="0 0 24 24" fill="none"
                                                            stroke="currentColor" stroke-linecap="round"
                                                            stroke-linejoin="round">
                                                            <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>
                                                            <path
                                                                 d="M21 12v3a1 1 0 0 1 -1 1h-16a1 1 0 0 1 -1 -1v-10a1 1 0 0 1 1 -1h9">
                                                            </path>
                                                            <path d="M7 20l10 0"></path>
                                                            <path d="M9 16l0 4"></path>
                                                            <path d="M15 16l0 4"></path>
                                                            <path d="M17 4h4v4"></path>
                                                            <path d="M16 9l5 -5"></path>
                                                       </svg>
                                                  </a>
                                                  <!--============== dropdown =============-->
                                                  <a href="#" class="dropdown-toggle after-none"
                                                       data-bs-toggle="dropdown" aria-expanded="false"
                                                       title="More Action">
                                                       <svg class="svg-stroke" xmlns="http://www.w3.org/2000/svg"
                                                            width="20" height="20" viewBox="0 0 24 24" fill="none"
                                                            stroke="currentColor" stroke-linecap="round"
                                                            stroke-linejoin="round">
                                                            <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>
                                                            <path
                                                                 d="M10 6h-3a2 2 0 0 0 -2 2v9a2 2 0 0 0 2 2h9a2 2 0 0 0 2 -2v-3">
                                                            </path>
                                                            <path d="M17 7m-3 0a3 3 0 1 0 6 0a3 3 0 1 0 -6 0"></path>
                                                       </svg>
                                                  </a>
                                                  
                                             </div>
                                        </div>
                                   </div>
                                   <div class="card-body d-flex justify-content-center flex-column">
                                        <div class="card-wrapper align-self-center">
                                             <div class=" cc visa ">
                                                  <div class="card-data">
                                                       <div class="type">Debit</div>
                                                       <div class="circuit">
                                                            <i class="fa fa-cc-visa fa-2x"></i>
                                                       </div>
                                                  </div>
                                                  <div class="holder">
                                                       <span class="name">
                                                           <asp:Label ID="Label1" runat="server"></asp:Label></span>
                                                       <span class="number">1234 - XXXX - XXXX - XXX6</span>
                                                  </div>
                                             </div>
                                        </div>
                                        <div class="mt-3">
                                             <div class="d-flex justify-content-between mb-2">
                                                  <span>Spending Limit</span>
                                                  <span>₹<asp:Label ID="lblmainwallet" runat="server"></asp:Label></span>
                                             </div>
                                             <div class="progress" role="progressbar" aria-label="Example 1px high"
                                                  aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"
                                                  style="height: 2px">
                                                  <div class="progress-bar" style="width: 25%"></div>
                                             </div>
                                        </div>
                                   </div>
                              </div>
                         </div>
                    </div>
                  
               </div>
</asp:Content>
