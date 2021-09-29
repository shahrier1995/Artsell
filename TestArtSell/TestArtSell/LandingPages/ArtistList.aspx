<%@ Page Title="" Language="C#" MasterPageFile="~/LandingPages/LandingMaster.Master" AutoEventWireup="true" CodeBehind="ArtistList.aspx.cs" Inherits="TestArtSell.LandingPages.ArtistList" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
  
    <style>
  

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
                color: darkcyan;
                border: none;
            }

            .rating label input:focus:not(:checked) ~ .icon:last-child {
                color: #000;
                text-shadow: 0 0 5px #09f;
            }

        .blog-items .blog-entry::before {
            background: #ffffff;
            box-shadow: 0px 4px 4px 0px rgba(0, 0, 0, 0.2);
        }

        .blog-entry:hover {
            border-radius:15px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
	<section id="primary" class="content-full-width"> <!-- **Primary Starts Here** -->
                <div class="fullwidth-section"><!-- Full-width section Starts Here -->
                	<div class="container">
                        <div class="main-title ">
                            <h3> Artist List </h3>
                        </div>
                        <!-- Blog Post Starts Here -->
                        <div class="blog-items apply-isotope clear">
                            <asp:Repeater ID="rptArtist" runat="server" OnItemDataBound="OnItemDataBound" >
                                <ItemTemplate>
                              <div class="dt-sc-one-third column" style="">
                                <article class="blog-entry" style="margin:0px;padding-top:10px">
                                    <div class="row">
                                        <div class="col-md-4 col-sm-4">
                                            <div>
                                                <a href="ArtistProfile.aspx?UserID=<%#Eval("ID") %>">
                                                    <img src='<%#Eval("UserImage") %>' alt="" title="" style="border-radius: 50%; height: 100px; width: 100px; border: 1px solid #808080"></a>
                                            </div>
                                        </div>
                                        <div class="col-md-8 col-sm-8">
                                            <div class="entry-details">
                                                <div class="entry-title">
                                                    <h4 style="margin: 0px"><a href="ArtistProfile.aspx?UserID=<%#Eval("ID") %>"><%#Eval("UserFullName") %></a> </h4>
                                                </div>

                                               
                                                <div class="entry-body">
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
                                                            <div class="rating">
                                                                <h6><span>(<%#Eval("count") %> person reviewed)</span></h6>

                                                            </div>


                                                        </ItemTemplate>
                                                    </asp:Repeater>
                                                </div>
                                                 <div class="entry-body">
                                                    <p><i class="fa fa-map-marker" aria-hidden="true"></i> <%#Eval("UserAddress") %> </p>
                                                </div>

                                            </div>
                                        </div>

                                    </div>
                                    <div  style="visibility:collapse"> 
                                       <asp:Repeater ID="rptUserImage" runat="server">
                                                <ItemTemplate>
                                                        <div class="col-md-4 col-xs-12" style="padding:5px 10px;text-align:center">
                                                     <a href="ArtDetails.aspx?PhotoID=<%#Eval("ID") %>"><img  src='<%#Eval("itemPhoto") %>' alt="" title="" style="width:115px;height:75px;"></a>
                                            </div>
                                                </ItemTemplate>
                                            </asp:Repeater>
                                     
                                      <asp:HiddenField ID="hfuserID" runat="server" Value='<%# Eval("ID") %>' />
                                   
                                    </div>
                        <%--            <div class="entry-details">
                                        <div class="entry-title">
                                            <h4 style="margin:0px"> <a href="blog-detail-with-lhs.html"><%#Eval("UserFullName") %></a> </h4>
                                        </div>
                                  
                                        <div class="entry-body">
                                            <p><i class="fa fa-map-marker" aria-hidden="true"></i>  <%#Eval("UserAddress") %> </p>
                                        </div>
                                    </div>--%>
                                </article>
                            </div>
                                </ItemTemplate>
                            </asp:Repeater>
                      
         
                        </div>
                        <!-- Blog Post Ends Here -->
                                
					</div>
                    <br />
                </div><!-- Full-width section Ends Here -->           	
            </section>
    
    <script>
        function test(x, y) {
      
            var rate = "'" + x + "'";
            var id = "'" + y + "'";
            //console.log(rate);
            //console.log(id);

            $.ajax({
                type: "GET",
                url: "ArtistList.aspx/addRating",
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
    </script>
</asp:Content>
