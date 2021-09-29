<%@ Page Title="" Language="C#" MasterPageFile="~/LandingPages/LandingMaster.Master" AutoEventWireup="true" CodeBehind="ArtDetails.aspx.cs" Inherits="TestArtSell.LandingPages.ArtDetails" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- jQuery library -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>

    <!-- Latest compiled JavaScript -->
    <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    
    <style>
        #carousel-custom {
    margin-top:  10px;
    width: 100%;
}
#carousel-custom .carousel-indicators {
    margin: 10px 0 0;
    overflow: auto;
    position: static;
    text-align: left;
    white-space: nowrap;
    width: 100%;
}
#carousel-custom .carousel-indicators li {
    background-color: transparent;
    -webkit-border-radius: 0;
    border-radius: 0;
    display: inline-block;
    height: auto;
    margin: 0 !important;
    width: auto;
}
#carousel-custom .carousel-indicators li img {
    display: block;
    opacity: 0.5;
}
#carousel-custom .carousel-indicators li.active img {
    opacity: 1;
}
#carousel-custom .carousel-indicators li:hover img {
    opacity: 0.75;
}
#carousel-custom .carousel-outer {
    position: relative;
}
.carousel-control.left {
    background-image: none;
    width: 54px;
    height: 54px;
    top: 50%;
    left: 20px;
    margin-top: -27px;
    line-height: 54px;
    border: 2px solid #fff;
    opacity: 1;
    text-shadow: none;
    -webkit-transition: all 0.2s ease-in-out 0s;
    -o-transition: all 0.2s ease-in-out 0s;
    transition: all 0.2s ease-in-out 0s;
}
.carousel-control.right {
    background-image: none;
    width: 54px;
    height: 54px;
    top: 50%;
    right: 20px;
    margin-top: -27px;
    line-height: 54px;
    border: 2px solid #fff;
    opacity: 1;
    text-shadow: none;
    -webkit-transition: all 0.2s ease-in-out 0s;
    -o-transition: all 0.2s ease-in-out 0s;
    transition: all 0.2s ease-in-out 0s;
}








        #myImg {
            border-radius: 5px;
            cursor: pointer;
            transition: 0.3s;
            display: block;
           
        }

            #myImg:hover {
                opacity: 0.7;
            }

        /* The Modal (background) */
        .modal {
            display: none; /* Hidden by default */
            position: fixed; /* Stay in place */
            padding-top: 100px; /* Location of the box */
            left: 0;
            top: 0;
            width: 100%; /* Full width */
            height: 100%; /* Full height */
            overflow: auto; /* Enable scroll if needed */
            background-color: rgb(0,0,0); /* Fallback color */
            background-color: rgba(0,0,0,0.9); /* Black w/ opacity */
        }

        /* Modal Content (image) */
        .modal-content {
            margin: auto;
            display: block;
            width: 75%;
            //max-width: 75%;
        }

        /* Caption of Modal Image */
        #caption {
            margin: auto;
            display: block;
            width: 80%;
            max-width: 700px;
            text-align: center;
            color: #ccc;
            padding: 10px 0;
            height: 150px;
        }

        /* Add Animation */
        .modal-content, #caption {
            -webkit-animation-name: zoom;
            -webkit-animation-duration: 0.6s;
            animation-name: zoom;
            animation-duration: 0.6s;
        }

        .out {
            animation-name: zoom-out;
            animation-duration: 0.6s;
        }

        @-webkit-keyframes zoom {
            from {
                -webkit-transform: scale(1);
            }

            to {
                -webkit-transform: scale(2);
            }
        }

        @keyframes zoom {
            from {
                transform: scale(0.4);
            }

            to {
                transform: scale(1);
            }
        }

        @keyframes zoom-out {
            from {
                transform: scale(1);
            }

            to {
                transform: scale(0);
            }
        }

        /* The Close Button */
        .close {
            position: absolute;
            top: 15px;
            right: 35px;
            color: #f1f1f1;
            font-size: 40px;
            font-weight: bold;
            transition: 0.3s;
        }

            .close:hover,
            .close:focus {
                color: #bbb;
                text-decoration: none;
                cursor: pointer;
            }

        /* 100% Image Width on Smaller Screens */
        @media only screen and (max-width: 700px) {
            .modal-content {
                width: 100%;
            }

            .modal {
                padding-top: 200px; /* Location of the box */
            }
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

              .fishes
    {
      position: relative;
      top: 0;
      left: 0;
    }
    .fish
    {
      position: absolute;
      top: 40px;
      left: 120px;
    }
    </style>
    <script type="text/javascript">
        function openModal() {
            $('#FrameModal').modal('show');
        }
        $(document).on("click", "#ContentPlaceHolder1_rptgallerySingle_linkbtnAddCart_0", function () {
            console.log("asaassa");


            ShowTestMessage();

        });

        //AJAX

        function ShowTestMessage() {

            var qString = "?" + window.location.href.split("?")[1];
            console.log("asasasasasasa");
            $.ajax({
                type: "GET",
                url: "ArtDetails.aspx/addCart" + qString,
                data: {},
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    if (data.d == "OR") {

                        $("#ContentPlaceHolder1_rptgallerySingle_linkbtnAddCart_0").hide();
                        $('#loginModal').modal('show');
                      

                    }
                    else {

                        $("#loginModal").modal('show');
                        $("#ContentPlaceHolder1_rptgallerySingle_linkbtnAddCart_0").show();



                    }

                },
                failure: function (response) {
                    alert(response.d);
                }
            });
        }

        function myFunction() {


            var a = document.getElementById("itemTag").textContent;

            // The function returns the product of p1 and p2
            console.log(a);
            document.getElementById("itemTag1").innerHTML = a;
            var b = document.getElementById("itemTag1").innerHTML
            console.log(b);
        }
        window.onload = function () {
            myFunction();
        };



    </script>
    <link href="../css/jquery.exzoom.css" rel="stylesheet" />

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <!-- *BreadCrumb Ends here** -->
    <section id="primary" class="content-full-width">

        <!-- **Primary Starts Here** -->
        <div class="container">
            <div class="main-title" data-animation="pullDown" data-delay="100">
                <h3>Art Details </h3>
                <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do</p>
            </div>



            <div class="cart-wrapper">

          
                <asp:Repeater ID="rptgallerySingle" runat="server" OnItemCommand="rptgallerySingle_ItemCommand" OnItemDataBound="OnItemDataBound">
                    <ItemTemplate>
                        <div class="dt-sc-three-fifth column first">
                       
                            <div class="cart-thumb" >
                    <div class="row">
                        <div class="col-md-12">

  <div id="carousel-custom" class="carousel slide" data-ride="carousel">
  <!-- Wrapper for slides -->
  <div class="carousel-inner" role="listbox">
    <div class="item active">
      <img  id="myImg" src='<%#Eval("ItemPhoto") %>' alt="image"   style="width:100%;cursor: zoom-in;" class="img-responsive">
    </div>
    <div class="item">
<img id="myImgWBorder" style="width:100%; border:17px solid ;background-color:white; padding:10px;    border-image: url(../images/Frame.png) 30 round;" src='<%#Eval("ItemPhoto") %>' alt="image" >
    </div>
          <div class="item">
 <img  src="../images/BK.jpg" class="fishes" style="width:100%" />
                 <img  class="fish" style=" border:17px solid ;background-color:white; padding:10px;    border-image: url(../images/Frame.png) 30 round;" src='<%#Eval("ItemPhoto") %>' alt="image" width="200" height="300">
               
<%-- <img   src='<%#Eval("ItemPhoto") %>' alt="image" width="225" height="100" class="fish" style="cursor: zoom-in;">--%>
    </div>
  </div>

  <!-- Controls -->
  <a class="left carousel-control" href="#carousel-custom" role="button" data-slide="prev">
    <i class="fa fa-chevron-left"></i>
    <span class="sr-only">Previous</span>
  </a>
  <a class="right carousel-control" href="#carousel-custom" role="button" data-slide="next">
    <i class="fa fa-chevron-right"></i>
    <span class="sr-only">Next</span>
  </a>
  
  
  <!-- Indicators -->
  <ol class="carousel-indicators visible-sm-block hidden-xs-block visible-md-block visible-lg-block">
            <li data-target="#carousel-custom" data-slide-to="0" class="active">
              <img src='<%#Eval("ItemPhoto") %>' style="width:100px" alt="..." class="img-responsive">
            </li>
            <li data-target="#carousel-custom" data-slide-to="1">
              <img src='<%#Eval("ItemPhoto") %>' style="width:100px; border:5px solid ;background-color:white; padding:5px;  border-image: url(../images/Frame.png) 30 round;" alt="..." class="img-responsive">
            </li>
         <li data-target="#carousel-custom" data-slide-to="2">
             <img  src="../images/BK.jpg"  style="width:100px" />
               
    
            </li>

          </ol> 
</div>
  

 
                     
              
       

                               


               
                         
                        </div>
                <%--        <div class="col-md-3">
                          
           
                           
                                      <a id="btnAddFrame" onclick="toggle()" class="dt-sc-button medium " href='#'><i class="fa fa-shopping-cart"></i><span>Add Frame</span></a>
                        </div>--%>
                    </div>
                              
                
                 
                            </div>

                            <h2>Art Details</h2>
                         
                                      <h6 style="margin:0px">Width: <%#Eval("Width") %></h6>
                                    <h6 style="margin:0px">Height: <%#Eval("Height") %></h6>
                              
                                    <p>Details: <%#Eval("ItemDetails") %></p>
                            <!-- *commententries Ends here** -->
                        </div>
                        <div class="dt-sc-two-fifth column">
                            <!-- Author Detail Starts Here -->
                            <div class="post-author-details">
                                <div class="entry-author-image">
                                    <img style="width:90px;height:90px" src='<%#Eval("UserImage") %>' alt="" title="" />
                                </div>
                                <div class="author-title">
                                    <h5><a href="ArtistProfile.aspx?UserID=<%#Eval("ID") %>"><%#Eval("UserFullName") %></a></h5>
                                    <span><%#Eval("UserAddress") %></span>
                                               
                                          <asp:HiddenField ID="hfuserID" runat="server" Value='<%# Eval("UserID") %>' />

                                </div>
                                <div class="author-desc">
                               
                                    <p><%#Eval("ItemDetails") %></p>
                                </div>
                                     <asp:Repeater ID="rptRating" runat="server">
                                                <ItemTemplate>
                                                    <div class="row">
                                                       
                                                                              <div class="rating">
                                        <label >
                                            <input <%# Eval("rate").ToString() == "1" ? "checked": Eval("rate").ToString() == "6" ? "": "-" + ";" %>  type="checkbox" name="stars" value="no" onclick="test(1,'<%#Eval("sellerId") %>')" />
                                            <span class="icon">★</span>
                                        </label>
                                        <label>
                                            <input <%# Eval("rate").ToString() == "2" ? "checked": Eval("rate").ToString() == "6" ? "": "-" + ";" %> type="checkbox" name="stars" value="no" onclick="test(2,'<%#Eval("sellerId") %>')" />
                                            <span class="icon">★</span>
                                            <span class="icon">★</span>
                                        </label>
                                        <label >
                                            <input <%# Eval("rate").ToString() == "3" ? "checked": Eval("rate").ToString() == "6" ? "": "-" + ";" %> type="checkbox" name="stars" value="no" onclick="test(3,'<%#Eval("sellerId") %>')" />
                                            <span class="icon">★</span>
                                            <span class="icon">★</span>
                                            <span class="icon">★</span>
                                        </label>
                                        <label >
                                            <input <%# Eval("rate").ToString() == "4" ? "checked": Eval("rate").ToString() == "6" ? "": "-" + ";" %> type="checkbox" name="stars" value="no" onclick="test(4,'<%#Eval("sellerId") %>')" />
                                            <span class="icon">★</span>
                                            <span class="icon">★</span>
                                            <span class="icon">★</span>
                                            <span class="icon">★</span>
                                        </label>
                                        <label >
                                            <input <%# Eval("rate").ToString() == "5" ? "checked": Eval("rate").ToString() == "6" ? "": "-" + ";" %>   type="checkbox" name="stars" value="no" onclick="test(5,'<%#Eval("sellerId") %>')" />
                                            <span class="icon">★</span>
                                            <span class="icon">★</span>
                                            <span class="icon">★</span>
                                            <span class="icon">★</span>
                                            <span class="icon">★</span>
                                        </label>
                                    </div>
                                                    
                                                      
                                                            
                                                    <div class="rating">
                                                        <h5><span>(<%#Eval("count") %> person reviewed)</span></h5>
                                                         
                                                    </div>
                                                    
                                      
                                                    </div>
                                                       
                                             
                                                              
                                                </ItemTemplate>
                                            </asp:Repeater>
                            </div>

                            <!-- Author Detail Ends Here -->

                            <!-- cart-thumb-categories Ends Here -->
                    

                            <div class="dt-sc-three-fifth column" style="padding-bottom:15px;">
                                   <h1 style='<%# Eval("Status").ToString() == "SO" ? "color:red" : "-" + ";margin:0px" %>'  >Price: <%#Eval("itemPrice") %> BDT</h1>
               <button type="button" class="dt-sc-button medium type2 with-icon" data-toggle="modal" data-target="#testModal"><i class="fa fa-shopping-cart"></i><span>Check Final Price</span></button>
                            </div>
                            <div class="dt-sc-three-fifth column">
                                <a id="linkbtnAddCart" runat="server" class="dt-sc-button medium type2 with-icon" href=''><i class="fa fa-shopping-cart"></i><span>Add to Cart </span></a>
               
                            </div>
                            <div class="dt-sc-two-fifth column">
                                <asp:LinkButton ID="linkbtnCheckout" class="dt-sc-button medium type2 with-icon" runat="server" PostBackUrl="OrderCart.aspx"><i class="fa fa-shopping-cart"></i> <span> Final CheckOut </span></asp:LinkButton>
          
                            </div>
                      
          
                    
                        </div>
                    </ItemTemplate>
                </asp:Repeater>

                <!-- *cart-wrapper starts here** -->

                <div class="modal fade" id="loginModal" role="dialog">
                    <div class="modal-dialog">
                        <!-- Modal content-->
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal">&times;;</button>
                                <h4 class="modal-title">Added to Cart</h4>
                            </div>
                            <div class="modal-body" style="color: black">
                            </div>



                            <div class="modal-footer">

                                <button type="button" class="dt-sc-button small type2" data-dismiss="modal">Close</button>
                            </div>
                        </div>

                    </div>
                </div>
       <div class="modal fade" id="testModal" role="dialog" >
    <div class="modal-dialog" style="width:100%">
    
      <!-- Modal content-->
      <div class="modal-content" >
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">Modal Header</h4>
        </div>
        
        <div class="modal-body" >
            <div class="row">
                <div class="col-md-6">
                    <img src='../images/banner3.jpg' runat="server" id="modalImg" style="width:100%; border:5px solid ;background-color:white; padding:5px;  border-image: url(../images/Frame.png) 30 round;" alt="..." class="img-responsive">
                </div>
                <div class="col-md-6">
                    <h3>product price:</h3>
                    <h4 style="color:red" id="lblPrice" runat="server"></h4>
                    <h3>framing cost(per cm 200BDT):</h3>
                    <h4 style="color:red" id="lblPriceWFrame" runat="server"></h4>
                    <h3 id="lblTotal" runat="server"></h3>
                </div>
            </div>
         
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div>
      
    </div>
  </div>
   
                <div id="myModal" class="modal">
                    <img class="modal-content" id="img01">
                </div>
            </div>

            <!-- *cart-wrapper Ends here** -->
        </div>

        <!-- The Modal -->


    </section>

    <script src="https://code.jquery.com/jquery-3.4.1.js"></script>
    <script type="text/javascript" src="../js/jquery.exzoom.js"></script>
    <script>
        function test(x, y) {
      
            var rate = "'" + x + "'";
            var id = "'" + y + "'";
            console.log(rate);
            console.log(id);

            $.ajax({
                type: "GET",
                url: "ArtistList.aspx/addRating",
                data: { ID: id ,Rate: rate},
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    if (data.d == "LO") {
                        console.log(data.d);
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
        function toggle() {
            var myImgWBorder = document.getElementById('myImgWBorder');
            var myImg = document.getElementById('myImg');

            if (myImgWBorder.style.display == "none") {
                myImgWBorder.style.display = "block";
                myImg.style.display = "none";
            }
            else {
                myImgWBorder.style.display = "none";
                myImg.style.display = "block";
            }
        }


        // Get the modal
        var modal = document.getElementById('myModal');

        // Get the image and insert it inside the modal - use its "alt" text as a caption
        var img = document.getElementById('myImg');
        var myImgWBorder = document.getElementById('myImgWBorder');
        var modalImg = document.getElementById("img01");
        var captionText = document.getElementById("caption");
        img.onclick = function () {
            modal.style.display = "block";
            modalImg.src = this.src;
            modalImg.alt = this.alt;
            captionText.innerHTML = this.alt;
        }
        myImgWBorder.onclick = function () {
            modal.style.display = "block";
            modalImg.src = this.src;
            modalImg.alt = this.alt;
            captionText.innerHTML = this.alt;
        }


        // When the user clicks on <span> (x), close the modal
        modal.onclick = function () {
            img01.className += " out";
            setTimeout(function () {
                modal.style.display = "none";
                img01.className = "modal-content";
            }, 400);

        }


    </script>

</asp:Content>
