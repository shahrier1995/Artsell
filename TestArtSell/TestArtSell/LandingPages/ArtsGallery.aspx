<%@ Page Title="" Language="C#" MasterPageFile="~/LandingPages/LandingMaster.Master" AutoEventWireup="true" CodeBehind="ArtsGallery.aspx.cs" Inherits="TestArtSell.LandingPages.ArtsGallery" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <style>
        .image {
            position: relative;
            top: 0;
            left: 0;
        }

        .smallimage {
            position: absolute;
            top: 0px;
            left: 0px;
        }

        .starempty {
            background-image: url(../images/starempty.png);
            width: 20px;
            height: 20px;
        }

        .starfilled {
            background-image: url(../images/starfilled.png);
            width: 20px;
            height: 20px;
        }

        .starwaiting {
            background-image: url(../images/starwaiting.png);
            width: 20px;
            height: 20px;
        }

        /*RATING*/
        .rating {
            display: inline-block;
            position: relative;
            height: 25px;
            line-height: 25px;
            font-size: 25px;
        }

            .rating label {
                position: absolute;
                top: 0;
                left: 0;
                height: 100%;
                cursor: pointer;
            }

                .rating label:last-child {
                    position: static;
                }

                .rating label:nth-child(1) {
                    z-index: 5;
                }

                .rating label:nth-child(2) {
                    z-index: 4;
                }

                .rating label:nth-child(3) {
                    z-index: 3;
                }

                .rating label:nth-child(4) {
                    z-index: 2;
                }

                .rating label:nth-child(5) {
                    z-index: 1;
                }

                .rating label input {
                    position: absolute;
                    top: 0;
                    left: 0;
                    opacity: 0;
                }

                .rating label .icon {
                    float: left;
                    color: transparent;
                }

                .rating label:last-child .icon {
                    color: black;
                }

            .rating:not(:hover) label input:checked ~ .icon,
            .rating:hover label:hover input ~ .icon {
                color: red;
                border: none;
            }

            .rating label input:focus:not(:checked) ~ .icon:last-child {
                color: #000;
                text-shadow: 0 0 5px #09f;
            }

        .heart {
            font-size: 20px;
            color: red;
            
        }
        .heart:hover {
            font-size: 25px;
            color: #901e1e;
            cursor:pointer;
            
        }
        .iconH{
            padding:0px;right:45px;top:15px;
        }
        @media only screen and (max-width: 700px) {
            .iconH {
                padding: 0px;
                right: 45px;
                top: -25px;
            }
        }
        #myToast {
            width:30%;
            background-color:#daf5d6;
            
        }
        #myToast2 {
            width:30%;
            background-color:#f3a3a3;
            
            
        }
        .toast-body {
            padding:20px;        
        }
    </style>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
       <%-- <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"/>--%>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section id="primary" class="content-full-width">
        <!-- **Primary Starts Here** -->
        <div class="fullwidth-section">

            <%--================Wish List Modal===================================--%>

<%--            <div class="toast" id="myToast" style="position: fixed; text-align:center;top:10px;left:10px; z-index: 999999999">
                <div class="toast-header">
                    <strong class="mr-auto"><i class="fa fa-check"></i>Wishlist</strong>
                    <small>Just Now</small>
                    <button type="button" class="ml-2 mb-1 close" data-dismiss="toast">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="toast-body">
                    <div>Added to Wishlist</div>
                </div>
            </div>
            <div class="toast" id="myToast2" style="position: fixed; top: 10px; right: 10px; z-index: 999999999">
                <div class="toast-header">
                    <strong class="mr-auto"><i class="fa fa-remove"></i>Wishlist</strong>
                    <small>Just Now</small>
                    <button type="button" class="ml-2 mb-1 close" data-dismiss="toast">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="toast-body">
                    <div>Removed from Wishlist</div>
                </div>
            </div>--%>

            <%--================Wish List Modal===================================--%>
            <!-- **Full-width-section Starts Here** -->
            <div class="container">
                <div class="main-title">
                    <h4 class="aligncenter">Gallery </h4>
                    <p>You will find all Artist's creations here</p>
                </div>
            </div>
            <div class="dt-sc-two-sixth column first" style="padding: 0px 10px">
                <div class="categories">
                    <h5>Categories</h5>

                    <div class="selection-box">
                        <asp:DropDownList ID="ddlCategory" runat="server" CssClass="shop-dropdown" AutoPostBack="true" OnSelectedIndexChanged="ddlCategory_SelectedIndexChanged1">
                        </asp:DropDownList>
                    </div>
                </div>
            </div>
            <div class="dt-sc-two-sixth column first" style="padding: 0px 10px">
                <div class="categories">
                    <h5>Price Range</h5>

                    <div class="selection-box">
                        <asp:DropDownList ID="ddlPricerange" runat="server" CssClass="shop-dropdown" AutoPostBack="true" OnSelectedIndexChanged="ddlPricerange_SelectedIndexChanged1">
                            <asp:ListItem Text="0 to 1000" Value="0&1000" />
                            <asp:ListItem Text="1000&3000" Value="1000&3000" />
                            <asp:ListItem Text="3000&6000" Value="3000&6000" />
                        </asp:DropDownList>
                    </div>
                </div>
            </div>
            <div class="dt-sc-two-sixth column first" style="padding: 0px 10px">
                <h5>Search</h5>
                <div class="row">
                    <div class="col-md-10" style="padding-right: 0px;">
                        <asp:TextBox ID="txtSearch" runat="server" CssClass="input-text" Style="height: 50px" placeholder=" Item Name"></asp:TextBox>
                    </div>
                    <div class="col-md-2" style="padding: 0px;">
                        <a href="#" runat="server" onserverclick="btnSearch_Click" class=" dt-sc-button medium type3 with-icon"><i class="fa fa-search"></i></a>

                    </div>

                </div>
            </div>
            <%--class="portfolio-fullwidth" style="margin-bottom: 10px;"--%>
            <div >
                <div class="portfolio-grid">
                    <div class="dt-sc-portfolio-container isotope">
                        <asp:Repeater ID="rptGallery" runat="server">
                            <ItemTemplate>

                                <div class="portfolio nature  dt-sc-one-fourth" style="background-color: white; box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2); border-radius: 5px">
                                    
                                    <a href="../LandingPages/ArtDetails.aspx?PhotoID=<%#Eval("ID") %>">
                                        <div style="padding-bottom: 10px">
                                            <img src='<%#Eval("ItemPhoto") %>' style='<%# Eval("Status").ToString() == "SO" ? "opacity:0.6": Eval("Status").ToString() == "1" ? "opacity:1.0" : "-" + ";width:100%" %>' class="images" />
                                            <img id="soldImg" style='<%# Eval("Status").ToString() == "SO" ? "visibility:visible": Eval("Status").ToString() == "RE" ? "visibility:hidden" :Eval("Status").ToString() == "APV" ? "visibility:hidden": "-" + ";" %>' src="../images/sold.jpg" class="smallimage" />
                                        </div>
                                    </a>

                                    <br />
                                    <strong style="padding-top: 10px; padding-left: 8px"><%#Eval("ItemTitle") %></strong><br />
                                    <strong style="padding-left: 8px"><%#Eval("ItemPrice") %> BDT</strong>
                                   <strong class="pull-right" style="padding-right:15px"><i  onclick="myFunction(this,'<%#Eval("ID") %>')" class='<%# Eval("wishStatus").ToString() == "AD" ? "heart fa fa-heart": Eval("wishStatus").ToString() == "ND" ? "heart fa fa-heart-o": Eval("wishStatus").ToString() == "" ? "heart fa fa-heart-o": "-" + ";" %>'></i></strong>

                                </div>
                            </ItemTemplate>
                        </asp:Repeater>


                        <%---------------------------------------Update------------------------------------------%>
                    </div>
                    <!-- **dt-sc-portfolio-container Ends Here** -->
                </div>
            </div>



        </div>
        
    </section>
    <!-- **Primary Ends Here** -->

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

    <script>
        function test(x, y) {

            var rate = "'" + x + "'";
            var id = "'" + y + "'";
            //console.log(rate);
            //console.log(id);

            $.ajax({
                type: "GET",
                url: "Home.aspx/addRating",
                data: { ID: id, Rate: rate },
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    if (data.d == "LO") {
                        //console.log(data.d);
                        window.location.href = "../Login_Registration/LoginForm.aspx";
                    }
                    else {
                        alert("Thanks for rating");
                    }
                },
                failure: function (response) {
                    alert(response.d);
                }
            });


        }
        function myFunction(x, y) {
            $(x).toggleClass("fa-heart fa-heart-o");

            var id = "'" + y + "'";
            $.ajax({
                type: "GET",
                url: "Home.aspx/addWishList",
                data: { ID: id },
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    if (data.d == "LO") {
                        //console.log(data.d);
                        window.location.href = "../Login_Registration/LoginForm.aspx";

                    }
                    else if (data.d == "AD") {

                        //alert("ADDED TO WISHLIST");
                        $("#myToast").toast({ delay: 2000 });
                        $("#myToast").toast('show');
                    }
                    else {
                        //alert("DELETED FROM WISHLIST");
                        $("#myToast2").toast({ delay: 2000 });
                        $("#myToast2").toast('show');
                    }

                },
                failure: function (response) {
                    alert(response.d);
                }
            });


        }

        </script>
</asp:Content>
