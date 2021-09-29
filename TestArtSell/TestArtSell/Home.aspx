<%@ Page Title="" Language="C#" MasterPageFile="~/LandingPages/LandingMaster.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="TestArtSell.LandingPages.Home" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

        <style>



    .image
    {
      position: relative;
      top: 0;
      left: 0;
    }
    .smallimage
    {
      position: absolute;
      top: 20px;
      left: 20px;
    }
         .starempty
        {
            background-image: url(../images/starempty.png);
            width: 20px;
            height: 20px;
        }
.starfilled
        {
            background-image: url(../images/starfilled.png);
            width: 20px;
            height: 20px;
        }
.starwaiting
        {
            background-image: url(../images/starwaiting.png);
            width: 20px;
            height: 20px;
        }
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section id="primary" class="content-full-width">
        <article>


            <div class="dt-sc-one-column column first">
                <div class="recent-gallery-container">
                    <ul class="recent-gallery" >
                        <li style="height:450px">
                              <img src="../images/LandingBanner/banner1.jpg" alt="image" />
                        </li>
                        <li style="height:450px">
                            <img src="../images/LandingBanner/banner2.jpg" />
                           
                        </li>
                        <li style="height:450px">
                            <img src="../images/LandingBanner/banner3.jpg" />
                         
                        </li>
                        <li style="height:450px">
                       
                            <img src="../images/LandingBanner/banner4.jpg" alt="image" />
                        </li>
                    </ul>
                    <div id="bx-pager" >
                        <a href="#" data-slide-index='0' style="width:10px;height:10px;background-color:white">
                            </a>
                        <a href="#" data-slide-index='1' style="width:10px;height:10px;background-color:white">
                            </a>
                        <a href="#" data-slide-index='2' style="width:10px;height:10px;background-color:white">
                            </a>
                        <a href="#" data-slide-index='3' style="width:10px;height:10px;background-color:white">
                            </a>
                    </div>
                </div>
            </div>

        </article>
        <!-- **Primary Starts Here** -->

        <div class="dt-sc-hr-invisible-small"></div>

        <div class="fullwidth-section">
            <!-- **Full-width-section Starts Here** -->
            <div class="container">
                <div class="main-title animate" data-animation="pullDown" data-delay="100">
                    <h2 class="aligncenter">Gallery </h2>
                    <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do </p>
                </div>
            </div>
            <!-- <div class="dt-sc-sorting-container">
                        <a data-filter="*" href="#" title = "09" class="dt-sc-tooltip-top active-sort type1 dt-sc-button animate" data-animation="fadeIn" data-delay="100">All</a>
                        <a data-filter=".nature" href="#" title = "06" class="dt-sc-tooltip-top type1 dt-sc-button animate" data-animation="fadeIn" data-delay="200">Nature</a>
                        <a data-filter=".people" href="#" title = "06" class="dt-sc-tooltip-top type1 dt-sc-button animate" data-animation="fadeIn" data-delay="300">People</a>
                        <a data-filter=".street" href="#" title = "05" class="dt-sc-tooltip-top type1 dt-sc-button animate" data-animation="fadeIn" data-delay="400">Street</a>
                        <a data-filter=".still-life" href="#" title = "08" class="dt-sc-tooltip-top type1 dt-sc-button animate" data-animation="fadeIn" data-delay="500">Still life</a>
                    </div> -->


            <div class="portfolio-fullwidth" style="margin-bottom: 10px;">
                <div class="portfolio-grid">
                    <div class="dt-sc-portfolio-container isotope">
                        <!-- **dt-sc-portfolio-container Starts Here** -->



                        <%---------------------------------------Update------------------------------------------%>

                          <asp:Repeater ID="rptGallery" runat="server">
                                        <ItemTemplate>
                                            

                                            <div class="portfolio nature still-life dt-sc-one-fourth">

                                                <figure>
                                                    <a href="GalleryDetails.aspx">
                                                          <div style="position: relative; left: 0; top: 0; " >
    <img src='<%#Eval("ItemPhoto") %>' style='<%# Eval("Status").ToString() == "SO" ? "opacity:0.6": Eval("Status").ToString() == "1" ? "opacity:1.0" : "-" + ";" %>' class="images"/>
        <img  id="soldImg" style='<%# Eval("Status").ToString() == "SO" ? "visibility:visible": Eval("Status").ToString() == "RE" ? "visibility:hidden" :Eval("Status").ToString() == "1" ? "visibility:hidden": "-" + ";" %>'  src="../images/sold.jpg"  class="smallimage"/>
                                                           
  </div>
                                                       <%-- <img src='<%#Eval("ItemPhoto") %>' alt="" title="" style="position:absolute">
                                                        <div class="transbox" style="position:relative">
    
                                                            <img src="../images/sold.jpg" />
  </div>--%>
                                                    </a>
                                                    <figcaption>
                                                        <div class="portfolio-detail">
                                                            <div class="views">
                                                                <%--<a class="fa fa-camera-retro" data-gal="prettyPhoto[gallery]" href="http://placehold.it/500x800&text=Portfolio+Image1"></a><span>3</span>--%>
                                                            </div>
                                                            <div class="portfolio-title">
                                                                <h5><a href="ArtDetails.aspx?PhotoID=<%#Eval("ID") %>"><%#Eval("ItemTitle") %></a></h5>
                                                                <p ><%#Eval("ItemDetails") %></p>
                                                            </div>
                                                        </div>
                                                    </figcaption>
                                                </figure>
                                                <div style="text-align:center">
                                                 
                                                   <h4 style="color:black;margin:0px"><strong> Price:<%#Eval("ItemPrice") %></strong></h4>
                                                </div>
                                            </div>

                                        </ItemTemplate>
                                    </asp:Repeater>


                        <%---------------------------------------Update------------------------------------------%>
                    </div>
                    <!-- **dt-sc-portfolio-container Ends Here** -->
                </div>
            </div>

        </div>
        <!-- **Full-width-section Ends Here** -->
        <div class="aligncenter">
            <a href="../Landingpages/Gallery.aspx" class="dt-sc-button medium type3 with-icon"><i class="fa fa-picture-o"></i><span>View All </span></a>
        </div>
        <div class="clear"></div>
        <div class="container">
            <div class="main-title animate" data-animation="pullDown" data-delay="100">
                <h2 class="aligncenter">Category </h2>
                <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do </p>
            </div>
        </div>
        <div class="fullwidth-section">

            <%--------------------------------------------Update--------------------------------%>


            <div class="fullwidth-section shop-grid">
                <ul class="products isotope">
                    <asp:Repeater ID="rptCat" runat="server">
                        <ItemTemplate>
                            <li class="product-wrapper dt-sc-one-fifth">
                                <!-- **product-wrapper - Starts** -->
                                <!-- **product-container - Starts** -->
                                <div class="product-container">
                                    <a href="../LandingPages/Gallery.aspx?CatID=<%#Eval("catID") %>">
                                        <div class="product-thumb">
                                            <img src='<%#Eval("ItemPhoto") %>' alt="image" />
                                        </div>
                                    </a>
                                    <!-- **product-title - Starts** -->
                                    <div class="product-title">

                                        <a href="../LandingPages/Gallery.aspx?CatID=<%#Eval("catID") %>" class="type1 dt-sc-button"><span class="fa fa-unlink"></span>Show More </a>
                                        <p><%#Eval("CatTitle") %></p>
                                    </div>
                                    <!-- **product-title - Ends** -->
                                </div>
                                <!-- **product-container - Ends** -->
                                <!-- **product-details - Starts** -->
                                <div class="product-details">
                                    <h5><a href="../LandingPages/Gallery.aspx?CatID=<%#Eval("catID") %>"><%#Eval("CatTitle") %></a> </h5>
                              <%--      <span class="amount">'<%#Eval("CatDetails") %>' </span>--%>
                                </div>
                                <!-- **product-details - Ends** -->
                            </li>
                            <!-- **product-wrapper - Ends** -->
                        </ItemTemplate>

                    </asp:Repeater>


                </ul>
            </div>
            </div>
        <div class="container">
            <div class="main-title animate" data-animation="pullDown" data-delay="100">
                <h2 class="aligncenter">Artist </h2>
                <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do </p>
            </div>
        </div>
        <div class="fullwidth-section">

            <%--------------------------------------------Update--------------------------------%>
         
            <div class="fullwidth-section shop-grid" style="border:none">
                <div class="dt-sc-hr-invisible-very-small"></div>
                    <div class="clear"></div>  
                <asp:Repeater ID="rptUser" runat="server">
                    <ItemTemplate>
                                                               
                    <div class="column dt-sc-one-sixth first animate" style="border:none" data-animation="fadeInRight" data-delay="100">
                        <div class="post-author-details">
                                <div class="entry-author-image">
                                  <a href="ArtistProfile.aspx?UserID=<%#Eval("ID") %>">  <img src='<%#Eval("userImage") %>' alt="" title="" /></a>
                                </div>
                                <div class="author-title">
                                    <h5><a href="ArtistProfile.aspx?UserID=<%#Eval("ID") %>"><%#Eval("UserFullName") %></a></h5>
                                    <span><%#Eval("UserAddress") %></span>
									<div class="woocommerce-product-rating">
                                         
                                               <cc1:Rating ID="rateArtist"  MaxRating="5"  AutoPostBack="true"  runat="server" CurrentRating='<%#Eval("rate") %>'
                                            StarCssClass="starempty" WaitingStarCssClass="starfilled" EmptyStarCssClass="starempty"
                                            FilledStarCssClass="starwaiting">
                                        </cc1:Rating>
                                      
                                       
                                               <a href="#"><%#Eval("RatingCount") %>  customer reviews </a>
                                     
                                    
                                    </div>
                                </div>                                
                              
                            </div>
                    </div>
                    </ItemTemplate>
                </asp:Repeater>
           
                   
            </div>
            </div>




            <!-- **Full-width-section Ends Here** -->
            <div class="clear"></div>

            <!-- <div class="fullwidth-section">
                    <div class="container">
                        <div class="main-title animate" data-animation="pullDown" data-delay="100">
                            <h2 class="aligncenter"> Frames </h2>
                            <p> Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do </p>
                        </div>
                    </div>
                    <div class="frame-grid">
                        <div class="frame-thumb">
                            <div class="frame-fullwidth">
                                <div class="dt-sc-frame-container isotope"> 
                                    <div class="frame ceramic dt-sc-one-third">
                                        <figure>
                                            <img src="http://placehold.it/272x185" alt="" title="">
                                       </figure>
                                    </div>
                                    <div class="frame plastic dt-sc-one-third">
                                        <figure>
                                            <img src="http://placehold.it/200x250" alt="" title="">
                                       </figure>
                                    </div>
                                    <div class="frame steel dt-sc-one-third">
                                        <figure>
                                            <img src="http://placehold.it/260x195" alt="" title="">
                                       </figure>
                                    </div>
                                    <div class="frame wooden dt-sc-one-third">
                                        <figure>
                                            <img src="http://placehold.it/470x500" alt="" title="">
                                       </figure>
                                    </div>                                    
                                    <div class="frame wooden dt-sc-one-third">
                                        <figure>
                                            <img src="http://placehold.it/375x300" alt="" title="">
                                       </figure>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="frame-details">
                        	<div class="frame-content">
                            	<div id="frame-all" class="dt-frames">
                                    <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore</p>
                                </div>
                            	<div id="frame-steel" class="dt-frames hidden">
                                    <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris.</p>
                                </div>
                            	<div id="frame-wooden" class="dt-frames hidden">
                                    <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>
                                </div>
                            	<div id="frame-plastic" class="dt-frames hidden">
                                    <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
                                </div>
                            	<div id="frame-ceramic" class="dt-frames hidden">
                                    <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam.</p>
                                </div>
                            </div>
                            <div class="frame-sorting">
                                <a data-filter="*" href="#" class="active-sort type1 dt-sc-button animate" data-animation="fadeIn" data-delay="100">All</a>
                                <a data-filter=".steel" href="#" class="type1 dt-sc-button animate" data-animation="fadeIn" data-delay="200">Steel</a>
                                <a data-filter=".wooden" href="#" class="type1 dt-sc-button animate" data-animation="fadeIn" data-delay="300">Wooden</a>
                                <a data-filter=".plastic" href="#" class="type1 dt-sc-button animate" data-animation="fadeIn" data-delay="400">plastic</a>
                                <a data-filter=".ceramic" href="#" class="type1 dt-sc-button animate" data-animation="fadeIn" data-delay="500">Ceramic</a>
                            </div>
                        </div>
                    </div>
                </div> -->
            
                    <!-- **Full-width-section Ends Here** -->
            <div class="dt-sc-hr-invisible-small"></div>
            <div class="clear"></div>

            <div class="fullwidth-section">
                <!-- **Full-width-section Starts Here** -->
                <div class="container">

                    <div class="main-title animate" data-animation="pullDown" data-delay="100">
                        <h2 class="aligncenter">About Us </h2>
                        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do </p>
                    </div>

                    <div class="about-section">

                        <div class="dt-sc-one-half column first">
                            <img src="../images/about.png" title="" alt="">
                        </div>

                        <div class="dt-sc-one-half column">
                            <h3 class="animate" data-animation="fadeInLeft" data-delay="200">A Little Intro</h3>
                            <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore</p>
                            <h3 class="animate" data-animation="fadeInLeft" data-delay="300">My Exhibitions</h3>
                            <p>Sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, Lorem ipsum dolor quis nostrud exercitation ullamco</p>
                            <h3 class="animate" data-animation="fadeInLeft" data-delay="400">Newsletter</h3>
                            <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit,</p>

                       

                     
                        </div>
                    </div>
                </div>
            </div>
            <!-- **Full-width-section Ends Here** -->

            <div class="dt-sc-hr-invisible-small"></div>
    </section>
    <!-- **Primary Ends Here** -->
</asp:Content>
