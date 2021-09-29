<%@ Page Language="C#" MasterPageFile="~/General/UserMaster.Master" AutoEventWireup="true" EnableEventValidation="false" CodeBehind="OrderRequests.aspx.cs" Inherits="TestArtSell.Seller.OrderRequests" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>

    <script type="text/javascript">
     
    </script>
    <style>
        .card {
            border-radius: 10px;
            box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2);
            transition: 0.3s;
        }

        .artistPhoto {
            height: 80px;
            width: 100%;
            border-radius:6px;
        }
        
        .orderlist:hover {
            box-shadow: 0 0 11px rgba(33,33,33,.2);
            border-right: 2px solid darkcyan;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row">
        <div class="col-md-12">
            <h5>New Order Requests</h5>
        </div>
    </div>

     <div class="row">
        <div class="col-md-5">
            <div class="card ">
              <div class="card-header border-success" ><span style="font-size:16px;font-weight:bold;color:darkcyan">Current Order Lists</span></div>
              <div class="card-body text-success" style="padding:0">
                
                  <div class="list-group">
                      <asp:Repeater ID="Repeater1" runat="server">
                          <ItemTemplate>
                              <asp:LinkButton ID="btnClickOrder" CommandArgument='<%#Eval("ODRID") + ";" +Eval("USERID")%>' runat="server" OnCommand="GetOrderDetails"  class="list-group-item list-group-item-action flex-column align-items-start">
                                  <div class="d-flex w-100 justify-content-between">
                                      <h5 class="card-title">Order No : <%#Eval("ODRID") %></h5>
                                      <small style="color:#4ad44a;font-weight:bold">*<%#Eval("Status").ToString() == "OR" ? "Requested"
                                                : Eval("Status").ToString() == "OC" ? "Confirmed"
                                                : Eval("Status").ToString() == "OD" ? "Canceled"
                                                : "-" %>* </small>
                                  </div>
                                  <p>  <%#Eval("ODRDATE") %></p>
                                  <div>
                                      <span>Item Quantity : <%#Eval("qty") %> </span><span class="pull-right">Total Amount : <b><%#Eval("TotalPrice") %>  BDT</b>  </span>
                                  </div>
                                  
                              </asp:LinkButton>
                          </ItemTemplate>
                      </asp:Repeater>

                      
                  </div>
              </div>
             
            </div>
        </div>
        <div class="col-md-7">
            <div class="card">
              <div class="card-header bg-transparent"><span style="font-size:16px;font-weight:bold;color:darkcyan">Order Details (Item List)</span></div>
              <div class="card-body text-success" style="padding:0">
                  <div class="list-group">
                      <asp:Repeater ID="rptrOrderDetails" runat="server">
                          <ItemTemplate>
                              <a href="#" class="list-group-item list-group-item-action flex-column align-items-start">
                                  <div class="w-100 justify-content-between">
                                      <div class="row">
                                          <div class="col-md-3">
                                              <img class="artistPhoto" src='<%#Eval("ITEMPHOTO") %>'  />
                                          </div>
                                          <div class="col-md-9">
                                              <h5 class="card-title"><%#Eval("ITEMTITLE") %></h5>
                                              
                                              <strong style="font-size:18px;color:darkcyan"> <span class="la la-money"></span> <%#Eval("ITEMPRICE") %> BDT</strong>
                                                <p><%#Eval("HEIGHT") %>" X <%#Eval("WIDTH") %>"</p>
                                          </div>
                                      </div>
                                  </div>
                              </a>
                          </ItemTemplate>
                      </asp:Repeater>

                      
                  </div>
              </div>
              <%--<div class="card-footer bg-transparent border-success"><a style="text-decoration:none" href="#">See all Artists</a></div>--%>
            </div>
        </div>
    </div>
</asp:Content>
