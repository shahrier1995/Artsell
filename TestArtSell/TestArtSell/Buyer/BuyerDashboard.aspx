<%@ Page Language="C#" MasterPageFile="~/General/UserMaster.Master" AutoEventWireup="true" CodeBehind="BuyerDashboard.aspx.cs" Inherits="TestArtSell.Buyer.BuyerDashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css">
    <link href="../css/infinite-slider.css" rel="stylesheet" />
    <style>
        .card {
            border-radius: 10px;
            box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2);
            transition: 0.3s;
            border:1px solid #d1e0e0;
        }

        .my-card {
            position: absolute;
            left: 40%;
            top: -20px;
            border-radius: 50%;
        }

        .card:hover {
            box-shadow: 0 8px 16px 0 rgba(0,0,0,0.2);
        }

        img {
            vertical-align: middle;
            max-width: 100%;
            max-height: 100%;
            -webkit-transition: 0 linear left;
            -moz-transition: 0 linear left;
            transition: 0 linear left;
            opacity: 0.90;
        }

            img:hover {
                opacity: 1.0;
            }

        /*SLIDER*/

        .orb {
            display: inline-block;
            margin: 10px;
            float: left;
            transition: all;
        }

            .orb:hover {
                transform: scale(1.1);
                cursor: pointer;
            }


        .marquee {
            background-color: rgb(255, 255, 255);
            height: 240px;
            width: 300%;
            /*border: 2px solid #eee;*/
            overflow: hidden;
            box-sizing: border-box;
            position: relative;
            border-radius: 10px;
            /*box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2);*/
        }

        .marquee--inner {
            display: block;
            width: 600%;
            margin: 10px;
            position: absolute;
            animation: marquee 15s linear infinite;
        }

            .marquee--inner:hover {
                animation-play-state: paused;
            }


        @keyframes marquee {
            0% {
                left: 0;
            }

            100% {
                left: -100%;
            }
        }

        .imgContainer {
            position: relative;
            text-align: center;
            color: white;
        }

        .bottom-left {
            position: absolute;
            bottom: 8px;
            left: 16px;
        }
        .imgContainer .content {
            position: absolute;
            top: 0;
            background: rgb(0, 0, 0); /* Fallback color */
            background: rgba(0, 0, 0, 0.5); /* Black background with 0.5 opacity */
            color: #f1f1f1;
            width: 100%;
            padding: 20px;
        }

        .panel-default > .panel-heading {
            color: #333333;
            background-color: #ffffff;
            border-color: #e2e9e6;
        }

        .panel-footer {
            padding: 10px 15px;
            background-color: #ffffff;
            border-top: 1px solid #e2e9e6;
            border-bottom-right-radius: -1;
            border-bottom-left-radius: -1;
        }

        .artistPhoto {
            height: 30px;
            width: 30px;
            border-radius: 50%;
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <br />
    <div class="row w-100">
        <div class="col-md-3">
            <div class="card shadow mx-sm-1 p-3">
                <div class="card border-info shadow text-info p-3 my-card"><i class="fa fa-shopping-cart"></i></div>
                <div class="text-info text-center mt-3">
                    <h5>Orders</h5>
                </div>
                <div class="text-info text-center  mt-2">
                    <h4>
                        <asp:Label runat="server" ID="lbltotalOrder" Text="" ></asp:Label></h4>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card  mx-sm-1 p-3">
                <div class="card border-danger shadow text-danger p-3 my-card"><i class="fa fa-anchor"></i></div>
                <div class="text-danger text-center mt-3">
                    <h5>Expense</h5>
                </div>
                <div class="text-danger text-center mt-2">
                    <h4>
                        <asp:Label runat="server" ID="lblMoney" Text=""></asp:Label></h4>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card  mx-sm-1 p-3">
                <div class="card border-success shadow text-success p-3 my-card"><i class="fa fa-paint-brush"></i></div>
                <div class="text-success text-center mt-3">
                    <h5>Items</h5>
                </div>
                <div class="text-success text-center mt-2">
                    <h4><asp:Label runat="server" ID="lblQuantity" Text=""></asp:Label></h4>
                </div>
            </div>
        </div>

        <div class="col-md-3">

            <div class="card  mx-sm-1 p-3">
                <a href="../LandingPages/WishList.aspx" style="display: block; text-decoration: none;">
                    <div class="card border-warning shadow text-warning p-3 my-card"><i class="fa fa-heart" aria-hidden="true"></i></div>
                    <div class="text-warning text-center mt-3">
                        <h5>Wishlist</h5>
                    </div>
                    <div class="text-warning text-center mt-2">
                        <h4>
                            <asp:Label runat="server" ID="lblWishList" Text=""></asp:Label></h4>
                    </div>
                </a>
            </div>
        </div>

    </div>
    <div class="row w-100">
        <div class="col-md-12">
            <div class="card  mb-12">
                <div class="card-header" ><b>Awesome Artworks</b></div>
                <div class="card-body text-success" style="padding: 0">

                    <div class="row w-100 marquee" style="margin-left:0px">
                        <div class="col-md-12">
                            <div class="marquee--inner">
                                <asp:Repeater ID="rptItems" runat="server">
                                    <ItemTemplate>
                                        <a href="../LandingPages/ArtDetails.aspx?PhotoID=<%#Eval("ID") %>" style="text-decoration: none; color: #000000">
                                            <div class="card orb">

                                                <div class="imgContainer">
                                                    <img src="<%#Eval("ITEMPHOTO") %>" alt="" width="180" height="160" />
                                                    
                                                    <%#Eval("Status").ToString() == "SO" ? "<div class=\"content\"><strong>SOLD</strong></div>" : ""%>

                                                </div>
                                                <div style="padding: 5px; text-align: center">
                                                    <strong>
                                                        <asp:Label ID="lblItemPrice" runat="server" Text='<%# Eval("ITEMPRICE") %>' />
                                                        BDT</strong>
                                                </div>
                                            </div>
                                        </a>
                                    </ItemTemplate>

                                </asp:Repeater>

                            </div>
                        </div>

                    </div>
                </div>
                <div class="card-footer bg-transparent "><a style="text-decoration: none" href="../LandingPages/ArtsGallery.aspx">Explore all Artworks</a></div>
            </div>
        </div>
    </div>
    <div class="row w-100">
        <div class="col-md-6">
            <div class="card  mb-6" style="max-width: 30rem;">
                <div class="card-header bg-transparent "><b>Recent Order Status</b></div>
                <div class="card-body text-success" style="padding: 0">

                    <div class="list-group">
                        <asp:Repeater ID="rptOrder" runat="server">
                            <ItemTemplate>
                                <a href="#" class="list-groupnitem list-group-item-action flex-column align-items-start">
                                    <div class="d-flex w-100 justify-content-between">
                                        <h5 class="card-title" style="color:darkcyan">New Order Requested</h5>
                                        <small style="color:green"><b>*New*</b></small>
                                    </div>
                                    <p class="card-text">Order No: <%#Eval("ODRID") %></p>
                                    <div>
                                        <span>Item Quantity: <%#Eval("ItemQuantity") %> </span><span class="pull-right">Total Amount : <b><%#Eval("TotalPrice") %>  BDT</b>  </span>
                                    </div>
                                    <small>Status:  <%#Eval("Status").ToString() == "OR" ? "Requested"
                                                : Eval("Status").ToString() == "OC" ? "Confirmed"
                                                : Eval("Status").ToString() == "OD" ? "Canceled"
                                                : "-" %> </small>
                                </a>
                            </ItemTemplate>
                        </asp:Repeater>


                    </div>
                </div>
                <div class="card-footer bg-transparent "><a style="text-decoration: none" href="../General/Orders/RunningOrders.aspx">See all orders</a></div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="card  mb-6" style="max-width: 30rem;">
                <div class="card-header bg-transparent "><b>Check Out Amazing Artists</b></div>
                <div class="card-body text-success" style="padding: 0">
                    <div class="list-group" >
                        <asp:Repeater ID="rptArtist" runat="server">
                            <ItemTemplate>
                                <a href="../LandingPages/ArtistProfile.aspx?UserID=<%#Eval("ID") %>" style="border-radius:0px" class="list-group-item list-group-item-action flex-column align-items-start">
                                    <div class="d-flex w-100 justify-content-between">


                                        <h5 class="card-title" style="font-size:13px">
                                            <img class="artistPhoto" src='<%#Eval("UserImage") %>' />&nbsp; &nbsp;<%#Eval("UserFullName") %></h5>
                                        <br />

                                        <small>Rating : <%#Eval("rate") %> 
                                            <span class="fa fa-star" style="color:darkcyan"></span></small>
                                            <%--<span class="fa fa-location-arrow" style="color:darkcyan"></span> <%#Eval("UserAddress") %></small>--%>
                                    </div>


                                </a>
                            </ItemTemplate>
                        </asp:Repeater>


                    </div>
                </div>
                <div class="card-footer bg-transparent "><a style="text-decoration: none" href="../LandingPages/ArtistList.aspx">See all Artists</a></div>
            </div>
        </div>

    </div>

</asp:Content>
