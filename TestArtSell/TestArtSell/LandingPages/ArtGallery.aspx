<%@ Page Title="" Language="C#" MasterPageFile="~/LandingPages/LandingMaster.Master" AutoEventWireup="true" CodeBehind="ArtArtsGallery.aspx.cs" Inherits="TestArtSell.LandingPages.ArtGallery" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
       <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">          
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
                .heart {
  font-size: 25px;
	color:red;
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
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section id="primary" class="content-full-width"> <!-- **Primary Starts Here** -->            
<%--                <div class="fullwidth-section"> <!-- **Full-width-section Starts Here** -->

                    <div class="toast" id="myToast" style="position: fixed; top: 10px; right: 10px;z-index:999999999" >
                        <div class="toast-header">
                            <strong class="mr-auto"><i class="fa fa-check"></i> Wishlist</strong>
                            <small>Just Now</small>
                            <button type="button" class="ml-2 mb-1 close" data-dismiss="toast">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="toast-body">
                            <div>Added to Wishlist</div>
                        </div>
                    </div>

 
                    <div class="toast" id="myToast2" style="position: fixed; top: 10px; right: 10px;z-index:999999999">
                        <div class="toast-header">
                            <strong class="mr-auto"><i class="fa fa-remove"></i> Wishlist</strong>
                            <small>Just Now</small>
                            <button type="button" class="ml-2 mb-1 close" data-dismiss="toast">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="toast-body">
                            <div>Removed from Wishlist</div>
                        </div>
                    </div>
                    	<div class="dt-sc-hr-invisible-small"></div>
                        <div class="main-title" data-animation="pullDown" data-delay="100">
                            <h5> Gallery </h5>
                            <%--<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do</p>--%>
                        </div>
                    
                      <div class="dt-sc-two-sixth column first" style="padding:0px 10px">
                            <div class="categories">
                                <h5>Categories</h5>

                                <div class="selection-box">
                                    <asp:DropDownList ID="ddlCategory" runat="server" CssClass="shop-dropdown" OnSelectedIndexChanged="ddlCategory_SelectedIndexChanged" AutoPostBack="true">
                                    </asp:DropDownList>
                                </div>
                                </div>
                          </div>
                     <div class="dt-sc-two-sixth column first" style="padding:0px 10px">
                            <div class="categories">
                                <h5>Price Range</h5>

                                <div class="selection-box">
                                    <asp:DropDownList ID="ddlPricerange" runat="server" CssClass="shop-dropdown" OnSelectedIndexChanged="ddlPriceRange_SelectedIndexChanged" AutoPostBack="true">
                                        <asp:ListItem Text="0 to 1000" Value="0&1000" />
                                        <asp:ListItem Text="1000&3000" Value="1000&3000" />
                                        <asp:ListItem Text="3000&6000" Value="3000&6000" />
                                    </asp:DropDownList>
                                    </div>
                                </div>
                          </div>
                     <div class="dt-sc-two-sixth column first" style="padding:0px 10px">
                           <h5>Search</h5>
                    <div class="row">
                        <div class="col-md-10" style="padding-right:0px;">
                            <asp:TextBox ID="txtSearch" runat="server" CssClass="input-text" style="height:50px" placeholder=" Item Name"></asp:TextBox>
                        </div>
                        <div class="col-md-2" style="padding:0px;">
                              <a href="#" runat="server" onserverclick="btnSearch_Click" class=" dt-sc-button medium type3 with-icon"><i class="fa fa-search"></i>  </a>
            
                              </div>

                    </div>
                    	</div>
                              
                               
                          </div>
                      
                                                      
                           <div class="aligncenter">
                        <asp:Repeater ID="rptCat" runat="server">
                            <ItemTemplate>
                  
                    
                         <a  href="../LandingPages/ArtsGallery.aspx?CatID=<%#Eval("catID") %>"  class="dt-sc-button medium type2"><%#Eval("CatTitle") %></a>
                        
                  
                            </ItemTemplate>

                        </asp:Repeater>
                   </div>
                    --%>
                  
                    <div class="portfolio-fullwidth" style="margin-bottom:5px;"><!-- **portfolio-fullwidth Starts Here** -->
                    
                    	<div class="portfolio-grid">
                       
                                
                            <div id="divNigga" class="dt-sc-portfolio-container isotope"> <!-- **dt-sc-portfolio-container Starts Here** -->
                      
                                    <%---------------------------------------Update------------------------------------------%>
                    <asp:Repeater ID="rptGallery" runat="server">
                            <ItemTemplate>


                                <div class="portfolio nature still-life dt-sc-one-fourth">

                                    <figure>
                                        <a href="GalleryDetails.aspx">
                                            <div style="position: relative; left: 0; top: 0;">
                                                <img src='<%#Eval("ItemPhoto") %>' style='<%# Eval("Status").ToString() == "SO" ? "opacity:0.6": Eval("Status").ToString() == "1" ? "opacity:1.0" : "-" + ";" %>' class="images" />
                                                <img id="soldImg" style='<%# Eval("Status").ToString() == "SO" ? "visibility:visible": Eval("Status").ToString() == "RE" ? "visibility:hidden" :Eval("Status").ToString() == "APV" ? "visibility:hidden": "-" + ";" %>' src="../images/sold.jpg" class="smallimage" />

                                            </div>

                                        </a>
                                        <figcaption>
                                            <div class="portfolio-detail" >
                                                
                                                <div class="portfolio-title" >
                                                    <h5 ><a  href="ArtDetails.aspx?PhotoID=<%#Eval("ID") %>"><%#Eval("ItemTitle") %></a></h5>
                                                    <p ><%#Eval("ItemDetails") %></p>
                                                </div>
                                            </div>
                                        </figcaption>
                                    </figure>
                                    <div style="text-align: center">


                                         <div class="row">
                                            <div class="col-md-6">
                                              <h4 style="color: black; margin: 0px"><strong>Price:<%#Eval("ItemPrice") %></strong></h4>
                                            </div>
                                               <div class="col-md-6">
                                               <h4 style="color: black; margin: 0px"><i onclick="myFunction(this,'<%#Eval("ID") %>')" class='<%# Eval("wishStatus").ToString() == "AD" ? "heart fa fa-heart": Eval("wishStatus").ToString() == "ND" ? "heart fa fa-heart-o": Eval("wishStatus").ToString() == "" ? "heart fa fa-heart-o": "-" + ";" %>'></i></h4>
                                            </div>
                                        </div>


                                    </div>
                                </div>

                            </ItemTemplate>
                        </asp:Repeater>

                                    <%---------------------------------------Update------------------------------------------%>
                
                            </div><!-- **dt-sc-portfolio-container Ends Here** -->
                        </div>
                      <%--  <div class="aligncenter">
                            <asp:LinkButton ID="lbtnPrev" runat="server" CssClass="dt-sc-button medium type3 with-icon" CausesValidation="false" CommandArgument='<%# Eval("Text") %>'
                                OnClick="Page_Changed" Visible="false" ToolTip="Previous"
                                Font-Bold="true"><i class="fa fa-picture-o"></i><span>Previous page </span>
                            </asp:LinkButton>
                            &nbsp;&nbsp;
 
                        </div>--%>
                    </div>
                    <div aria-live="polite" aria-atomic="true" style="position: relative; min-height: 200px;">
                        </div>
                    <div class="dt-sc-hr-invisible-small"></div>                        
             <!-- **Full-width-section Ends Here** -->
            </section>
</asp:Content>
