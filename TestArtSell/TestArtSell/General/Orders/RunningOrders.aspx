<%@ Page Language="C#" MasterPageFile="~/General/UserMaster.Master" AutoEventWireup="true" CodeBehind="RunningOrders.aspx.cs" Inherits="TestArtSell.General.Orders.RunningOrders" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../../css/timeline.css" type="text/css" rel="stylesheet" />
    <style>
        .orderlist:hover {
            box-shadow: 0 0 11px rgba(33,33,33,.2);
            border-right: 2px solid darkcyan;
            font-size: 14px;
            font-weight: 600;
        }

        #cardBack:hover {
            box-shadow: 0 0 11px rgba(33,33,33,.2);
            border-right: 4px solid darkcyan;
            border-left: 4px solid darkcyan;
        }

        .lblRowNumber {
            color: #a7c4bb;
        }

        .list-group-item {
            border-radius: 0;
        }

            .list-group-item:hover {
                border-left: 4px solid darkcyan;
            }


        @media only screen and (max-width: 700px) {
            small {
                visibility: hidden;
            }

            h5 {
                font-size: 18px;
            }
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:MultiView ID="MultiView1" runat="server">
        <asp:View ID="OrderListView" runat="server">
            <div class="card">
                <div class="card-header">
                    <strong class="card-title pull-left">My Orders</strong>
                   <%-- <asp:DropDownList ID="ddlMonth" runat="server" class="form-control pull-right" Width="40%" AutoPostBack="true" OnSelectedIndexChanged="OnSelectedIndexChanged">
                    </asp:DropDownList>--%>
                </div>
                <div class="card-body" style="padding: 0">
                    <div class="list-group">
                        <asp:Repeater ID="rptrOrder" runat="server" OnItemCommand="rptrOrder_ItemCommand">
                            <ItemTemplate>
                                <asp:LinkButton ID="rptAnc" CommandArgument='<%#Eval("ODRID")%>' runat="server" CssClass="list-group-item list-group-item-action flex-column align-items-start">
                            <div class="d-flex w-100 justify-content-between">
                                <h5 class="mb-1"><span class="lblRowNumber"># <%#  Container.ItemIndex + 1 %></span>    <%#Eval("ODRID") %></h5>
                                <small>Quantity : <strong><%#Eval("ItemQuantity") %> Pc </strong>
                                    <br />
                                    Total Price :  <strong><%#Eval("TotalPrice") %> BDT</strong> </small>

                                <small>Order Status
                                    <br />
                                    <strong><%#Eval("Status").ToString() == "OR" ? "Requested"
                                                : Eval("Status").ToString() == "OC" ? "Confirmed"
                                                : Eval("Status").ToString() == "OD" ? "Canceled"
                                                : "-" %>
                                    </strong>
                                </small>

                            </div>
                            <p class="mb-1">Order Date:  <%#Eval("ODRDATE") %></p>
                           
                           
                                </asp:LinkButton>

                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                </div>
            </div>
        </asp:View>

        <asp:View ID="OrderDetailsView" runat="server">
            <div class="card" style="border-radius: 10px" id="cardBack">
                <asp:LinkButton ID="btnBackToOrderList" runat="server" OnClick="btnBackToOrderList_Click" Style="text-decoration: none; cursor: pointer;">
                    <div class="card-header">
                        <div class="card-title">
                            Invoice No:
                            <asp:Label ID="lblInvoiceNo" runat="server"></asp:Label>

                            <span class="pull-right"><span class="la la-arrow-circle-left"></span>Order List</span>
                        </div>
                        <span>
                            <asp:Label ID="lblOrderDate" runat="server"></asp:Label>
                        </span>
                    </div>
                </asp:LinkButton>
            </div>

            <div class="row">
                <div class="col-md-8">
                    <div class="card" style="border-radius: 10px">
                        <div class="card-header">
                            <div class="row">

                                <div class="col-md-7">
                                    Items
                                </div>


                                <div class="col-md-5" style="text-align: right">
                                    Price & Quantity
                                </div>
                            </div>
                        </div>
                        <div class="card-body" style="padding: 0">
                            <asp:Repeater ID="rptrOrderDetails" runat="server">
                                <ItemTemplate>
                                    <ul class="list-group">
                                        <div class="list-group-item ccs" style="margin-bottom: 5px; border-radius: 0; text-decoration: none; color: #808080">
                                            <div class="row ">


                                                <div class="col-md-7">
                                                    <img src="../<%#Eval("ITEMPHOTO") %>" alt="" width="60" height="40" />
                                                    <%#Eval("ITEMTITLE") %>
                                                </div>
                                                <div class="col-md-5" style="text-align: right">
                                                    <%#Eval("ITEMPRICE") %> BDT X 1
                                                </div>
                                            </div>
                                        </div>
                                    </ul>


                                </ItemTemplate>
                            </asp:Repeater>
                            <div class="row">
                                <div class="col-md-8"></div>
                                <div class="col-md-4">
                                    <table style="text-align: right">
                                        <tr>
                                            <td>Total Price : </td>
                                            <td>
                                                <asp:Label ID="lblTotalPrice" runat="server" ></asp:Label></td>
                                        </tr>
                                        <tr>
                                            <td>Discount :  </td>
                                            <td ><asp:Label ID="lblDiscount" runat="server" >--</asp:Label></td>
                                        </tr>
                                        <tr>
                                            <td>Delivery Charge : </td>
                                            <td><asp:Label ID="lblDelivery" runat="server" >60 BDT</asp:Label></td>
                                        </tr>
                                        <tr>
                                            <td><b>Total Amount :</b></td>
                                            <td><b><asp:Label ID="lblTotalAmount" runat="server" ></asp:Label></b></td>
                                        </tr>
                                        <tr>
                                            <td>Payment status :</td>
                                            <td><asp:Label ID="lblPaymentStatus" runat="server" ></asp:Label></td>
                                        </tr>
                                    </table>

                                </div>

                            </div>
                        </div>
                       <%-- <div class="card-footer">
                            <i>** Payment Status: Paid</i>
                        </div>--%>
                    </div>
                    
                </div>
                <div class="col-md-4">
                        <div class="card" style="border-radius: 10px">
                            <div class="card-header">
                                <strong style="text-align: center; color: darkcyan; font-size: 20px" runat="server" id="lblOrderStatus">Order Status : Confirmed</strong>
                            </div>
                            <div class="card-body">
                                <strong>Bills To </strong>
                                <hr />
                                <p runat="server" id="lblUserName">Mr. Buyer </p>
                                <p runat="server" id="iblAddress">Delivery Address:</p>
                                <p runat="server" id="lblContact">Delivery Address:</p>
                            </div>
                            <%--<div class="timeline">
                                <div class="ctr right">
                                    <div class="cnt">
                                        <p>Delivered</p>
                                        <small>03 Apr 2020</small>
                                    </div>
                                </div>
                                <div class="ctr right">
                                    <div class="cnt">
                                        <p>Shiped</p>
                                         <small>03 Apr 2020</small>
                                    </div>
                                </div>
                                <div class="ctr right">
                                    <div class="cnt">
                                        <p>Approved</p>
                                         <small>03 Apr 2020</small>
                                    </div>
                                </div>
                                <div class="ctr right">
                                    <div class="cnt">
                                        <p>Ordered</p>
                                         <small>03 Apr 2020</small>
                                    </div>
                                </div>
                            </div>--%>
                        </div>
                    </div>
            </div>


        </asp:View>
    </asp:MultiView>
</asp:Content>
