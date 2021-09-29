<%@ Page Title="" Language="C#" MasterPageFile="~/LandingPages/LandingMaster.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="TestArtSell.LandingPages.Home" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
      <%-- <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"/>--%>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" media="all" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/3.5.2/animate.min.css" rel="stylesheet" media="all" />
    <link href="../css/bootstrap-touch-slider.css" rel="stylesheet" media="all" />

    <style>
        .center {
            display: flex;
  align-items: center;
  justify-content: center
        }
        .centerImage {
        display: block;
  margin-left: auto;
  margin-right: auto;
      align-items: center;
    justify-content: center;
    padding-left: 50px;
        }
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
            height: 20px;
            line-height: 20px;
            font-size: 20px;
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
                color: darkcyan;
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
        .bs-slider {
    overflow: hidden;
    max-height: 400px;
    position: relative;
    background: #000000;
}
        .iconH{
            padding:0px;right:45px;top:15px;
        }
        @media only screen and (max-width: 700px) {
        .iconH{
            padding:0px;right:45px;top:-25px;
        } 
        }

        .card {
  box-shadow: 0 2px 2px 0 rgb(102, 0, 51);
  transition: 0.3s;
  width: 40%;
  border-radius: 5px;
  height:50px;
  padding-top:10px;
  margin-bottom:20px;
  text-align:center;
 
}

.card:hover {
  box-shadow: 0 8px 16px 0 rgba(0,0,0,0.2);
  cursor:pointer;
   width: 50%;
}

img {
  border-radius: 5px 5px 0 0;
}
    </style>

    <script>
       
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section id="primary" class="content-full-width">
         <div id="bootstrap-touch-slider" class="carousel bs-slider fade  control-round indicators-line" style="z-index:0" data-ride="carousel" data-pause="hover" data-interval="false" >

            <!-- Indicators -->
            <ol class="carousel-indicators">
                <li data-target="#bootstrap-touch-slider" data-slide-to="0" class="active"></li>
                <li data-target="#bootstrap-touch-slider" data-slide-to="1"></li>
                <li data-target="#bootstrap-touch-slider" data-slide-to="2"></li>
            </ol>

            <!-- Wrapper For Slides -->
            <div class="carousel-inner" role="listbox">

                <!-- Third Slide -->
                  <div class="item active">

                    <!-- Slide Background -->
                    <img src="../images/LandingBanner/banner1.jpg" alt="Bootstrap Touch Slider"  class="slide-image"/>
                    <div class="bs-slider-overlay"></div>
                    <!-- Slide Text Layer -->
                    <div class="slide-text slide_style_left">
                        <h2 data-animation="animated flipInX" style="color:white">"Every artist was first an amateur."</h2>
                        <p data-animation="animated lightSpeedIn">Join now whatever role you like</p>
                        <a href="../Login_Registration/SellerRegistration.aspx" style="color:#581845; font-weight: bold; background:white" target="_blank" class="btn btn-default" data-animation="animated fadeInUp">Become a Seller</a>
                        <a href="../Login_Registration/RegistrationForm.aspx" style="color:white; font-weight: bold; background:#581845" target="_blank"  class="btn btn-primary" data-animation="animated fadeInDown">Become a Buyer</a>
                    </div>
                </div>
                <!-- End of Slide -->

                <!-- Second Slide -->
                <div class="item">

                    <!-- Slide Background -->
                    <img src="../images/LandingBanner/banner2.jpg" alt="Bootstrap Touch Slider"  class="slide-image"/>
                    <div class="bs-slider-overlay"></div>
                    <!-- Slide Text Layer -->
                    <div class="slide-text slide_style_center">
                        <h2 data-animation="animated flipInX">"The nice thing about the gallery shows is that without having to pay any money you can just go and see it."</h2>
                  <%--      <p data-animation="animated lightSpeedIn">Yoko Ono</p>--%>
                        <a href="../LandingPages/ArtsGallery.aspx" style="color:white; font-weight: bold; background:#581845" target="_blank" class="btn btn-default" data-animation="animated fadeInUp">Explore Arts</a>
                     <%--   <a href="../Login_Registration/SellerRegistration.aspx" target="_blank"  class="btn btn-primary" data-animation="animated fadeInDown">Become a Seller</a>--%>
                    </div>
                </div>
                <!-- End of Slide -->

                <!-- Third Slide -->
                <div class="item">

                    <!-- Slide Background -->
                    <img src="../images/LandingBanner/banner3.jpg" alt="Bootstrap Touch Slider"  class="slide-image"/>
                    <div class="bs-slider-overlay"></div>
                    <!-- Slide Text Layer -->
                    <div class="slide-text slide_style_right">
                        <h2 data-animation="animated zoomInLeft">An artist can show things that other people are terrified of expressing</h2>
          <%--              <p data-animation="animated fadeInRight">Lots of css3 Animations to make slide beautiful .</p>--%>
                        <a href="../LandingPages/ArtistList.aspx" style="color:#581845; font-weight: bold; background:white" target="_blank" class="btn btn-default" data-animation="animated fadeInLeft">See our creative people</a>
                       <%-- <a href="../LandingPages/ArtsGallery.aspx" target="_blank" class="btn btn-primary" data-animation="animated fadeInRight">select two</a>--%>
                    </div>
                </div>
                <!-- End of Slide -->


            </div><!-- End of Wrapper For Slides -->

            <!-- Left Control -->
            <a class="left carousel-control" href="#bootstrap-touch-slider" role="button" data-slide="prev">
                <span class="fa fa-angle-left" aria-hidden="true"></span>
                <span class="sr-only">Previous</span>
            </a>

            <!-- Right Control -->
            <a class="right carousel-control" href="#bootstrap-touch-slider" role="button" data-slide="next">
                <span class="fa fa-angle-right" aria-hidden="true"></span>
                <span class="sr-only">Next</span>
            </a>

        </div> <!-- End  bootstrap-touch-slider Slider -->

        <!-- **Primary Starts Here** -->

        <div class="dt-sc-hr-invisible-small"></div>

        <div class="fullwidth-section">
            <!-- **Full-width-section Starts Here** -->
            <div class="container">
                <div class="main-title">
                    <h4 class="aligncenter">Gallery </h4>
                    <p>You will find all Artist's creations here</p>
                </div>
            </div>

           

            <div style="margin-bottom: 10px;">
                <div class="portfolio-grid">
                    <div class="dt-sc-portfolio-container isotope">
                        <asp:Repeater ID="rptGallery" runat="server">
                            <ItemTemplate>

                                <%--<div class="portfolio nature  dt-sc-one-fourth" style="background-color: white; box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2); border-radius: 5px">
                                    <a href="../LandingPages/ArtDetails.aspx?PhotoID=<%#Eval("ID") %>">
                                        <img src='<%#Eval("ItemPhoto") %>' style='<%# Eval("Status").ToString() == "SO" ? "opacity:0.6": Eval("Status").ToString() == "1" ? "opacity:1.0" : "-" + ";width:100%" %>' class="images" />
                                        <img id="soldImg" style='<%# Eval("Status").ToString() == "SO" ? "visibility:visible": Eval("Status").ToString() == "RE" ? "visibility:hidden" :Eval("Status").ToString() == "APV" ? "visibility:hidden": "-" + ";" %>' src="../images/sold.jpg" class="smallimage" />
                                    </a>

                                    <div style="padding-top: 20px; padding-left: 8px">
                                        <div class="row">
                                            <div class="col-md-10">
                                                <p style="color: #808080; margin: 0px;"><strong><%#Eval("ItemTitle") %></strong> </p>
                                                <p style="color: black; margin: 0px; font-size: 16px"><strong><%#Eval("ItemPrice") %> BDT</strong>  </p>
                                            </div>
                                            <div class="col-md-2 iconH">
                                                <span class="pull-right" style="color: black; margin: 0px"><i onclick="myFunction(this,'<%#Eval("ID") %>')" class='<%# Eval("wishStatus").ToString() == "AD" ? "heart fa fa-heart": Eval("wishStatus").ToString() == "ND" ? "heart fa fa-heart-o": Eval("wishStatus").ToString() == "" ? "heart fa fa-heart-o": "-" + ";" %>'></i></span>
                                            </div>
                                        </div>

                                    </div>
                                </div>--%>
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
                    </div>
                </div>
            </div>

        </div>
        <!-- **Full-width-section Ends Here** -->
        <div class="aligncenter">
            <a href="../Landingpages/ArtsGallery.aspx" class="dt-sc-button medium type3 with-icon"><i class="fa fa-picture-o" style="color:white"></i><span style="color:white">View All </span></a>
        </div>
        <div class="clear"></div>
        <div class="container">
            <div class="main-title">
                <h4 class="aligncenter">Category </h4>
                <p>There are various Art categories, you can sort by them to find your desired one </p>
            </div>
        </div>

        <div class="fullwidth-section">

            <%--------------------------------------------Update--------------------------------%>


            <div class="fullwidth-section shop-grid" style="border: none; padding:10px 50px">
                <ul class="products isotope">
                    <asp:Repeater ID="rptCat" runat="server">
                        <ItemTemplate>
                            <li class="product-wrapper dt-sc-one-fifth">
                                <a href="../LandingPages/ArtsGallery.aspx?CatID=<%#Eval("catID") %>" style="text-decoration:none;">
                                    <div class="card">
                                        <p><%#Eval("CatTitle") %></p>
                                    </div>
                                </a>
                                <%--<div class="product-container">
                                    <a href="../LandingPages/ArtsGallery.aspx?CatID=<%#Eval("catID") %>">
                                        <%--<div class="product-thumb">
                                            <img src='<%#Eval("ItemPhoto") %>' alt="image" />
                                        </div>
                                    </a>
                                    <div class="product-title">
                                        <a href="../LandingPages/ArtsGallery.aspx?CatID=<%#Eval("catID") %>" class="type1 dt-sc-button"><span class="fa fa-unlink"></span>Show More </a>
                                        <p><%#Eval("CatTitle") %></p>
                                    </div>
                                </div>
                                <div class="product-details">
                                    <h5><a href="../LandingPages/ArtsGallery.aspx?CatID=<%#Eval("catID") %>"><%#Eval("CatTitle") %></a> </h5>
                                </div>--%>
                            </li>
                        </ItemTemplate>

                    </asp:Repeater>


                </ul>
            </div>
        </div>

        <div class="container">
            <div class="main-title">
                <h4 class="aligncenter">Our Artists </h4>
                <p>All Creative Artists are here</p>
            </div>
        </div>
        <%--fullwidth-section--%>
        <div class="container">
            <asp:Repeater ID="rptUser" runat="server" OnItemDataBound="OnItemDataBound">
                    <ItemTemplate>

                        <div class="column dt-sc-one-fifth first " style="border: none">
                            <div class="post-author-details centerImage " style="border: none">
                                <div class="entry-author-image ">
                                    <a  href="../LandingPages/ArtistProfile.aspx?UserID=<%#Eval("ID") %>">
                                        <img style="width: 70px; height: 70px;" src='<%#Eval("userImage") %>' alt="" title="" /></a>
                                </div>
                                <div class="author-title">
                                    <h5><a href="../LandingPages/ArtistProfile.aspx?UserID=<%#Eval("ID") %>"><%#Eval("UserFullName") %></a></h5>
                                    <%--<span><i class="fa fa-map-marker" aria-hidden="true"></i><%#Eval("UserAddress") %></span>--%>
                                    <asp:Repeater ID="rptRating" runat="server">
                                        <ItemTemplate>
                                            <div class="rating">
                                                <label>
                                                    <input <%# Eval("rate").ToString() == "1" ? "checked": Eval("rate").ToString() == "6" ? "": "-" + ";" %> type="checkbox" name="stars" value="no" onclick="test(1,'<%#Eval("sellerId") %>    ')" />
                                                    <span class="icon">★</span>
                                                </label>
                                                <label>
                                                    <input <%# Eval("rate").ToString() == "2" ? "checked": Eval("rate").ToString() == "6" ? "": "-" + ";" %> type="checkbox" name="stars" value="no" onclick="test(2,'<%#Eval("sellerId") %>    ')" />
                                                    <span class="icon">★</span>
                                                    <span class="icon">★</span>
                                                </label>
                                                <label>
                                                    <input <%# Eval("rate").ToString() == "3" ? "checked": Eval("rate").ToString() == "6" ? "": "-" + ";" %> type="checkbox" name="stars" value="no" onclick="test(3,'<%#Eval("sellerId") %>    ')" />
                                                    <span class="icon">★</span>
                                                    <span class="icon">★</span>
                                                    <span class="icon">★</span>
                                                </label>
                                                <label>
                                                    <input <%# Eval("rate").ToString() == "4" ? "checked": Eval("rate").ToString() == "6" ? "": "-" + ";" %> type="checkbox" name="stars" value="no" onclick="test(4,'<%#Eval("sellerId") %>    ')" />
                                                    <span class="icon">★</span>
                                                    <span class="icon">★</span>
                                                    <span class="icon">★</span>
                                                    <span class="icon">★</span>
                                                </label>
                                                <label>
                                                    <input <%# Eval("rate").ToString() == "5" ? "checked": Eval("rate").ToString() == "6" ? "": "-" + ";" %> type="checkbox" name="stars" value="no" onclick="test(5,'<%#Eval("sellerId") %>    ')" />
                                                    <span class="icon">★</span>
                                                    <span class="icon">★</span>
                                                    <span class="icon">★</span>
                                                    <span class="icon">★</span>
                                                    <span class="icon">★</span>
                                                </label>
                                            </div>
                                            <%--<div class="rating">
                                                <h6><span>(<%#Eval("count") %> person reviewed)</span></h6>

                                            </div>--%>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                    <asp:HiddenField ID="hfuserID" runat="server" Value='<%# Eval("ID") %>' />

                                </div>

                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            <%--<div class="fullwidth-section shop-grid " style="border: none;">
                <div class="dt-sc-hr-invisible-very-small"></div>
                <div class="clear"></div>
                
            </div>--%>
        </div>


        <!-- **Full-width-section Ends Here** -->
        <div class="clear"></div>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.touchswipe/1.6.18/jquery.touchSwipe.min.js"></script>
        <!-- Bootstrap bootstrap-touch-slider Slider Main JS File -->
        <script src="../js/bootstrap-touch-slider.js"></script>
        <script>
            $('#bootstrap-touch-slider').bsTouchSlider();
            function test(x, y) {
      
                var rate = "'" + x + "'";
                var id = "'" + y + "'";
                //console.log(rate);
                //console.log(id);

                $.ajax({
                    type: "GET",
                    url: "Home.aspx/addRating",
                    data: { ID: id ,Rate: rate},
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
            function myFunction(x,y) {
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
                            window.location.href="../Login_Registration/LoginForm.aspx";

                        }
                        else if (data.d == "AD") {

                            alert("ADDED TO WISHLIST");

                        }
                        else {
                            alert("DELETED FROM WISHLIST");
                        }

                    },
                    failure: function (response) {
                        alert(response.d);
                    }
                });


            }
        </script>
  
    </section>
</asp:Content>
