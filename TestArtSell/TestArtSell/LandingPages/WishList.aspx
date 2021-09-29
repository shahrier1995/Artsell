<%@ Page Title="" Language="C#" MasterPageFile="~/LandingPages/LandingMaster.Master" AutoEventWireup="true" CodeBehind="WishList.aspx.cs" Inherits="TestArtSell.LandingPages.WishList" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
            <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
   
    <script>
        $(document).ready(function () {
            var uri = window.location.toString();
            if (uri.indexOf("?") > 0) {
                var clean_uri = uri.substring(0, uri.indexOf("?"));
                window.history.replaceState({}, document.title, clean_uri);
            }
        });
    </script>
    <style>


div.transbox {
  
  background-color: #ffffff;
  border: 1px solid black;
  opacity: 0.6;
  filter: alpha(opacity=60); /* For IE8 and earlier */
  text-align:center;
    min-width: 20px;
    min-height: 20px;
    padding: 13px;

}

.sold {
 
  font-weight: bold;
  color: #000000;
  margin: 0 auto;
}

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
            .iconH{
            padding:0px;right:45px;top:15px;
        }
        @media only screen and (max-width: 700px) {
        .iconH{
            padding:0px;right:45px;top:-25px;
        } 
        }
 
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        			<section id="primary" class="content-full-width"> <!-- **Primary Starts Here** -->            
                <div class="fullwidth-section"> <!-- **Full-width-section Starts Here** -->
                    
                    	<div class="dt-sc-hr-invisible-small"></div>
                        <div class="main-title" data-animation="pullDown" data-delay="100">
                            <h5> Gallery </h5>
       
                        </div>
                    


                              
                               
                          </div>
                      

                    
                  
                    <div class="portfolio-fullwidth" style="margin-bottom:5px;"><!-- **portfolio-fullwidth Starts Here** -->
                         <div id="noOrder" style="text-align:center;" runat="server">
                <h1>You have no data in wishlist</h1>
                <img src="../images/noCart.png" /><br />
                             <br />
                             <br />
                   <a runat="server" class="dt-sc-button medium type2 with-icon" href="ArtsGallery.aspx"><i class="fa fa-shopping-cart"></i><span>Add Items </span></a>
            </div>
                    	<div class="portfolio-grid">
                            <div class="dt-sc-portfolio-container isotope"> <!-- **dt-sc-portfolio-container Starts Here** -->
                      
                                    <%---------------------------------------Update------------------------------------------%>

                                    <asp:Repeater ID="rptGallery" runat="server">
                                        <ItemTemplate>
                                             <div class="portfolio nature  dt-sc-one-fourth" style="background-color:white;box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2);border-radius:5px">
                                    <a href="../LandingPages/ArtDetails.aspx?PhotoID=<%#Eval("ID") %>">
                                        <img  src='<%#Eval("ItemPhoto") %>' style='<%# Eval("Status").ToString() == "SO" ? "opacity:0.6": Eval("Status").ToString() == "1" ? "opacity:1.0" : "-" + ";width:100%" %>' class="images" />
                                        <img id="soldImg" style='<%# Eval("Status").ToString() == "SO" ? "visibility:visible": Eval("Status").ToString() == "RE" ? "visibility:hidden" :Eval("Status").ToString() == "APV" ? "visibility:hidden": "-" + ";" %>' src="../images/sold.jpg" class="smallimage" />
                                    </a>
                                    
                                    <div style="padding-top:20px;padding-left:8px">
                                        <div class="row">
                                            <div class="col-md-10">
                                                 <p style="color: #808080; margin: 0px;"><strong><%#Eval("ItemTitle") %></strong> </p>
                                                <p style="color: black; margin: 0px;font-size:16px"><strong><%#Eval("ItemPrice") %> BDT</strong>  </p>
                                            </div>
                                               <div class="col-md-2 iconH" >
                                                               <span class="pull-right" style="color: black; margin: 0px">   <asp:LinkButton ID="linkBtnWish"  CommandArgument='<%#Eval("ID") %>' runat="server" OnCommand="DeletefromWishList"><i class="fa fa-times" style="font-size:20px;" aria-hidden="true"></i></asp:LinkButton></span>
                                            </div>
                                        </div>
       
                                    </div>
                                </div>

                         <%--                   <div class="portfolio nature still-life dt-sc-one-fourth">

                                                <figure>
                                                    <a href="GalleryDetails.aspx">
                                                          <div style="position: relative; left: 0; top: 0; " >
    <img src='<%#Eval("ItemPhoto") %>' style='<%# Eval("Status").ToString() == "SO" ? "opacity:0.6": Eval("Status").ToString() == "1" ? "opacity:1.0" : "-" + ";" %>' class="images"/>
    <img  id="soldImg" style='<%# Eval("Status").ToString() == "SO" ? "visibility:visible": Eval("Status").ToString() == "RE" ? "visibility:hidden" :Eval("Status").ToString() == "1" ? "visibility:hidden": "-" + ";" %>'  src="../images/sold.jpg"  class="smallimage"/>
                                                           
  </div>

                                                    </a>
                                                    <figcaption>
                                                        <div class="portfolio-detail">
                                                            <div class="views">
                             
                                                            </div>
                                                            <div class="portfolio-title">
                                                                <h5><a href="ArtDetails.aspx?PhotoID=<%#Eval("ID") %>"><%#Eval("ItemTitle") %></a></h5>
                                                                <p ><%#Eval("ItemDetails") %></p>
                                                            </div>
                                                        </div>
                                                    </figcaption>
                                                </figure>
                                                    <div style="text-align:center">

                                                 <div>
                                                     <div class="col-md-6">
                                                                <h4 style="color:black;margin:0px"><strong> Price:<%#Eval("ItemPrice") %></strong></h4>
                                                     </div>
                                                       <div class="col-md-6">
                                                           <asp:LinkButton ID="linkBtnWish"  CommandArgument='<%#Eval("ID") %>' runat="server" OnCommand="DeletefromWishList"><i class="fa fa-times" aria-hidden="true"></i></asp:LinkButton>
                                                     </div>
                                                 </div>
                                            
                                                   
                                     

                                                </div>
                                            </div>--%>

                                        </ItemTemplate>
                                    </asp:Repeater>
                                          
                                    <%---------------------------------------Update------------------------------------------%>
                
                            </div><!-- **dt-sc-portfolio-container Ends Here** -->
                        </div>
                    </div><!-- **portfolio-fullwidth Ends Here** -->
                
                    <div class="aligncenter">
                        <a href="#" class="loadmore dt-sc-button medium type3 with-icon"><i class="fa fa-picture-o"></i> <span> load more  </span> </a>
                    </div>
                    <div class="dt-sc-hr-invisible-small"></div>                        
             <!-- **Full-width-section Ends Here** -->
            </section><!-- **Primary Ends Here** -->

</asp:Content>
