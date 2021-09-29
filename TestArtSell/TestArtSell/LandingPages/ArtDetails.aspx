<%@ Page Title="" Language="C#" MasterPageFile="~/LandingPages/LandingMaster.Master" AutoEventWireup="true" CodeBehind="ArtDetails.aspx.cs" Inherits="TestArtSell.LandingPages.ArtDetails" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script runat="server">

        protected void Page_Load(object sender, EventArgs e)
        {
            LoadMoreArt();
            TestArtSell.CDA objcda = new TestArtSell.CDA();
            System.Data.DataSet dsIemInfo = new System.Data.DataSet();
            System.Data.DataTable dt = new System.Data.DataTable();
            string PhotoID = "";
            string PhotoItemID = Request.QueryString["PhotoID"];
            string Picquery = "Select a.ItemPhoto ,a.ItemTitle,a.ItemDetails,c.CatTitle from tbl_Item_Info a inner join tbl_Item_Category c on a.catid=c.catid  where a.ID='"+PhotoItemID+"'";
            System.Data.DataSet Picds =new System.Data.DataSet();
            Picds = objcda.GetDataSet(Picquery, "SMFM");
            string itemPic= Picds.Tables[0].Rows[0]["ItemPhoto"].ToString();
			string itemTitle= Picds.Tables[0].Rows[0]["ItemTitle"].ToString();
			string itemDetails= Picds.Tables[0].Rows[0]["ItemDetails"].ToString();
            // Create two instances of an HtmlMeta control.
            HtmlMeta hm1 = new HtmlMeta();
            HtmlMeta hm2 = new HtmlMeta();
            HtmlMeta hm3 = new HtmlMeta();
			HtmlMeta hm4 = new HtmlMeta();

            // Get a reference to the page header element.
            HtmlHead head = (HtmlHead)Page.Header;

            // Define an HTML <meta> element that is useful for search engines.
            // Define an HTML <meta> element with a Scheme attribute.
            hm3.Attributes.Add("property", "og:url");
            //hm2.Name = "date";
            hm3.Content = "https://www.artsell.xyz/LandingPages/ArtDetails.aspx?PhotoID="+PhotoItemID;

            head.Controls.Add(hm3);
            hm2.Attributes.Add("property", "og:title");
            //hm2.Name = "date";
            hm2.Content = itemTitle;

            head.Controls.Add(hm2);
            hm1.Attributes.Add("property", "og:image");
            //hm1.Name = "keywords";
            hm1.Content = "https://www.artsell.xyz/"+itemPic;

            head.Controls.Add(hm1);
			hm4.Attributes.Add("property", "og:description");
            //hm1.Name = "keywords";
            hm4.Content = itemDetails;

            head.Controls.Add(hm4);

            



            if (Session["orderCart"] == null)
            {
                Session["orderCart"] = null;
                PhotoID = Request.QueryString["PhotoID"];
                string query = "select a.ItemDetails,a.status,a.height,a.width,a.ItemPhoto,b.UserImage,a.ItemPrice,a.ID as ItemID ,a.UserID, b.UserFullName ,b.UserAddress,c.CatTitle as CatTitle, b.ID from tbl_Item_Info a inner join tbl_User_Info b on  a.UserID= b.ID inner join tbl_Item_Category c on a.catid=c.catid  where a.ID='" + PhotoID + "'";
                System.Data.DataSet ds = objcda.GetDataSet(query, "SMFM");

                string sellStatus = ds.Tables[0].Rows[0]["status"].ToString();
                string imgsrc= ds.Tables[0].Rows[0]["ItemPhoto"].ToString();
                string price = ds.Tables[0].Rows[0]["ItemPrice"].ToString();
                string width = ds.Tables[0].Rows[0]["Width"].ToString();
                string height = ds.Tables[0].Rows[0]["Height"].ToString();
                lblPrice.InnerText = price;
                if (String.IsNullOrEmpty(width)  && String.IsNullOrEmpty(height))
                {
                    lblPriceWFrame.InnerText = "0";
                    lblTotal.InnerText = "Total Price: " + (0 + Convert.ToDouble(price)).ToString();

                }
                else
                {
                    double dimension = Convert.ToDouble(width) * Convert.ToDouble(height);
                    double dimensionPrice = dimension * 200;
                    lblPriceWFrame.InnerText = (dimensionPrice).ToString() + "(Dimension: " + dimension + " )";
                    lblTotal.InnerText = "Total Price: " + (dimensionPrice + Convert.ToDouble(price)).ToString();
                }

                modalImg.Src = imgsrc;
                rptgallerySingle.DataSource = ds;
                rptgallerySingle.DataBind();
                if (sellStatus == "SO")
                {
                    foreach (RepeaterItem item in rptgallerySingle.Items)
                    {
                        //  var btnFBShare = item.FindControl("lit") as Literal;
                        //btnFBShare.Text = "<iframe src='https://www.facebook.com/plugins/share_button.php?href=https%3A%2F%2Fwww.artsell.xyz%2FLandingPages%2FArtDetails.aspx%3FPhotoID%"+PhotoID+"&layout=button_count&size=small&appId=845424682934259&width=77&height=20' width='77' height='20' style='border:none;overflow:hidden' scrolling='no' frameborder='0' allowfullscreen='true' allow='autoplay; clipboard-write; encrypted-media; picture-in-picture; web-share'></iframe>";
                        item.FindControl("linkbtnAddCart").Visible = false;
                        item.FindControl("linkbtnCheckout").Visible = true;
                    }
                }
                else
                {
                    foreach (RepeaterItem item in rptgallerySingle.Items)
                    {

                        item.FindControl("linkbtnAddCart").Visible = true;
                        item.FindControl("linkbtnCheckout").Visible = true;
                    }
                }




            }
            else
            {
                PhotoID = Request.QueryString["PhotoID"];
                string query = "select a.ItemDetails,a.status,a.height,a.width,a.ItemPhoto,b.UserImage,a.ItemPrice,a.ID as ItemID ,a.UserID, b.UserFullName ,b.UserAddress,c.CatTitle as CatTitle, b.ID from tbl_Item_Info a inner join tbl_User_Info b on  a.UserID= b.ID inner join tbl_Item_Category c on a.catid=c.catid  where a.ID='" + PhotoID + "'";
                System.Data.DataSet ds = objcda.GetDataSet(query, "SMFM");
                rptgallerySingle.DataSource = ds;
                rptgallerySingle.DataBind();
                string queryItemInfo = "select * from tbl_Item_Info where ID='" + PhotoID + "'";
                dsIemInfo = objcda.GetDataSet(queryItemInfo, "SMFM");
                dt = (  System.Data.DataTable)Session["orderCart"];
                for (int i = dt.Rows.Count - 1; i >= 0; i--)
                {
                    System.Data.DataRow dr = dt.Rows[i];
                    if (dr["ID"].ToString() == PhotoID)
                    {

                        foreach (RepeaterItem item in rptgallerySingle.Items)
                        {



                            item.FindControl("linkbtnAddCart").Visible = false;
                            item.FindControl("linkbtnCheckout").Visible = true;
                        }


                    }

                }


            }


        }
</script>


    <!-- jQuery library -->

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>

    <!-- Latest compiled JavaScript -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <style>
        #carousel-custom {
            margin-top: 10px;
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
       width: 20px;
            height: 20px;
            top: 260px;
            left: 5px;
            margin-top: -27px;
            line-height: 54px;
           color:black;
            opacity: 1;
            text-shadow: none;
            -webkit-transition: all 0.2s ease-in-out 0s;
            -o-transition: all 0.2s ease-in-out 0s;
            transition: all 0.2s ease-in-out 0s;
        }

        .carousel-control.right {
            background-image: none;
width: 20px;
            height: 20px;
            top: 260px;
            right: 5px;
            margin-top: -27px;
            line-height: 54px;
           color:black;
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

        .fishes {
            position: relative;
            top: 0;
            left: 0;
        }

        .fish {
            position: absolute;
            top: 40px;
            left: 120px;
            border: 17px solid; 
            background-color: white; 
            padding: 10px;
            border-image: url(../images/Frame.png) 30 round;
        }
        @media only screen and (max-width: 700px) {
             .fish {
            position: absolute;
            top: 20px;
            left: 30px;
                width: 100px;
    border: 5px solid;
    background-color: white;
    padding: 2px;
    border-image: url(../images/Frame.png) 30 round;
}
                     .carousel-control.left {
            background-image: none;
            width: 20px;
            height: 20px;
            top: 100px;
            left: 5px;
            margin-top: -27px;
            line-height: 54px;
           color:black;
            opacity: 1;
            text-shadow: none;
            -webkit-transition: all 0.2s ease-in-out 0s;
            -o-transition: all 0.2s ease-in-out 0s;
            transition: all 0.2s ease-in-out 0s;
        }

        .carousel-control.right {
            background-image: none;
            width: 20px;
            height: 20px;
            top: 100px;
            right: 5px;
            margin-top: -27px;
            line-height: 54px;
           color:black;
            opacity: 1;
            text-shadow: none;
            -webkit-transition: all 0.2s ease-in-out 0s;
            -o-transition: all 0.2s ease-in-out 0s;
            transition: all 0.2s ease-in-out 0s;
        }
        }



        
    </style>
    <script type="text/javascript">
        function openModal() {
            $('#FrameModal').modal('show');
        }
        $(document).on("click", "#ContentPlaceHolder1_rptgallerySingle_linkbtnAddCart_0", function () {
            //console.log("asaassa");


            ShowTestMessage();

        });

        //AJAX

        function ShowTestMessage() {

            var qString = "?" + window.location.href.split("?")[1];
            //console.log("asasasasasasa");
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
            //console.log(a);
            document.getElementById("itemTag1").innerHTML = a;
            var b = document.getElementById("itemTag1").innerHTML
            //console.log(b);
        }
        window.onload = function () {
            //myFunction();
        };



    </script>
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
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
      <script type="text/javascript">
function fbs_click(width, height) {
    var leftPosition, topPosition;
    //Allow for borders.
    leftPosition = (window.screen.width / 2) - ((width / 2) + 10);
    //Allow for title and status bars.
    topPosition = (window.screen.height / 2) - ((height / 2) + 50);
    var windowFeatures = "status=no,height=" + height + ",width=" + width + ",resizable=yes,left=" + leftPosition + ",top=" + topPosition + ",screenX=" + leftPosition + ",screenY=" + topPosition + ",toolbar=no,menubar=no,scrollbars=no,location=no,directories=no";
    u=location.href;
    t=document.title;
    window.open('http://www.facebook.com/sharer.php?u='+encodeURIComponent(u)+'&t='+encodeURIComponent(t),'sharer', windowFeatures);
    return false;
}
</script>


    <!-- *BreadCrumb Ends here** -->
    <section id="primary" class="content-full-width">
        <!-- **Primary Starts Here** -->
        <div class="container">
            <div class="main-title" data-animation="pullDown" data-delay="100">
                <h5>Art Details </h5>
            </div>
            <div class="cart-wrapper">
                <asp:Repeater ID="rptgallerySingle" runat="server" OnItemCommand="rptgallerySingle_ItemCommand" OnItemDataBound="OnItemDataBound">
                    <ItemTemplate>
                        <div class="dt-sc-three-fifth column first">

                            <div class="cart-thumb">
                                <div class="row">
                                    <div class="col-md-12">

                                        <div id="carousel-custom" class="carousel slide" data-ride="carousel">
                                            <!-- Wrapper for slides -->
                                            <div class="carousel-inner" role="listbox">
                                                <div class="item active">
                                                    <img id="myImg" src='<%#Eval("ItemPhoto") %>' alt="image"  style="width: 100%; cursor: zoom-in;" class="img-responsive">
                                                </div>
                                                <div class="item">
                                                    <img id="myImgWBorder" style="width: 100%; border: 17px solid; background-color: white; padding: 10px; border-image: url(../images/Frame.png) 30 round;" src='<%#Eval("ItemPhoto") %>' alt="image">
                                                </div>
                                                <div class="item">
                                                    <img src="../images/BK.jpg" class="fishes" style="width: 100%" />
                                                    <img class="fish"  src='<%#Eval("ItemPhoto") %>' alt="image" width="200" height="300">

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
                                                    <img src='<%#Eval("ItemPhoto") %>' style="width: 100px" alt="..." class="img-responsive">
                                                </li>
                                                <li data-target="#carousel-custom" data-slide-to="1">
                                                    <img src='<%#Eval("ItemPhoto") %>' style="width: 100px; border: 5px solid; background-color: white; padding: 5px; border-image: url(../images/Frame.png) 30 round;" alt="..." class="img-responsive">
                                                </li>
                                                <li data-target="#carousel-custom" data-slide-to="2">
                                                    <img src="../images/BK.jpg" style="width: 100px" />


                                                </li>

                                            </ol>
                                        </div>

                                    </div>
                                    <%--        <div class="col-md-3">
                          
           
                           
                                      <a id="btnAddFrame" onclick="toggle()" class="dt-sc-button medium " href='#'><i class="fa fa-shopping-cart"></i><span>Add Frame</span></a>
                        </div>--%>
                                </div>
                            </div>

                       
                            <!-- *commententries Ends here** -->
                        </div>
                        <div class="dt-sc-two-fifth column">

                            <h2>Artist</h2>
                            <!-- Author Detail Starts Here -->
                            <div class="post-author-details">
                                <div class="entry-author-image">
                                    <img style="width: 90px; height: 90px" src='<%#Eval("UserImage") %>' alt="" title="" />
                                </div>
                                <div class="author-title">
                                    <h5><a href="ArtistProfile.aspx?UserID=<%#Eval("ID") %>"><%#Eval("UserFullName") %></a></h5>
                                    <span><%#Eval("UserAddress") %></span>

                                    <asp:HiddenField ID="hfuserID" runat="server" Value='<%# Eval("UserID") %>' />

                                </div>
                                <div class="author-desc">

                                
                                </div>
                                <asp:Repeater ID="rptRating" runat="server">
                                                <ItemTemplate>
                                                       <div class="rating" style="visibility:hidden">
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
                                                        <h6><span style="visibility:hidden">(<%#Eval("count") %> person reviewed)</span></h6>
                                                         
                                                    </div>
                                                </ItemTemplate>
                                            </asp:Repeater>
                            </div>
								   <h2>Art Details</h2>

                            
                            <h4 style="margin: 0px">Size (in c:m) : <%#Eval("Height") %> (H) X <%#Eval("Width") %> (W)</h4>
                             <h4 style="margin: 0px">Art Type : <%#Eval("CatTitle") %></h4>
                           <h4 style="margin: 0px"> <p>Details: <%#Eval("ItemDetails") %></p></h4>
                            <!-- Author Detail Ends Here -->

                            <!-- cart-thumb-categories Ends Here -->


                            <div class="dt-sc-three-fifth column" style="padding-bottom: 15px;">
                                <h1 style='<%# Eval("Status").ToString() == "SO" ? "color:red": "-" + ";margin:0px" %>'>Price: <%#Eval("itemPrice") %> BDT</h1>
                                <button type="button" style="display: none" class="dt-sc-button medium type2 with-icon" data-toggle="modal" data-target="#testModal"><i class="fa fa-shopping-cart"></i><span>Check Final Price</span></button>
                            </div>
                            <div class="dt-sc-three-fifth column">
                                <a id="linkbtnAddCart" runat="server" class="dt-sc-button medium type2 with-icon" href=''><i class="fa fa-shopping-cart" style="color:white"></i><span style="color:white">Add to Cart </span></a>

                            </div>
               <%--         <div class="dt-sc-two-fifth column">
                                <asp:LinkButton ID="btnShare" OnClick="btnShare_Click" class="dt-sc-button medium type2 with-icon" runat="server" ><i class="fa fa-shopping-cart" style="color:white"></i> <span style="color:white"> share </span></asp:LinkButton>

                            </div>--%>
                            <div class="dt-sc-two-fifth column">
                                <asp:LinkButton ID="linkbtnCheckout" class="dt-sc-button medium type2 with-icon" runat="server" PostBackUrl="OrderCart.aspx"><i class="fa fa-shopping-cart" style="color:white"></i> <span style="color:white"> Final CheckOut </span></asp:LinkButton>

                            </div>
							<div class="dt-sc-two-fifth column">
 <!-- Please change the width and height to suit your needs -->
<a href="http://www.facebook.com/share.php?u=<full page url to share>" onClick="return fbs_click(500, 300)" target="_blank" title="Share This on Facebook"><i class="fa fa-share-alt" aria-hidden="true"> Facebook Share</i></a>
								   </div>
                            </div>




                        </div>
                    </ItemTemplate>
                </asp:Repeater>
                
                <!-- *cart-wrapper starts here** -->
               <div class="main-title" data-animation="pullDown" data-delay="100">
                <h5>More Arts You Can Buy </h5>
            </div>
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
                <div class="modal fade" id="testModal" role="dialog">
                    <div class="modal-dialog" style="width: 100%">

                        <!-- Modal content-->
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal">&times;</button>
                                <h4 class="modal-title">Modal Header</h4>
                            </div>

                            <div class="modal-body">
                                <div class="row">
                                    <div class="col-md-6">
                                        <img src='../images/banner3.jpg' runat="server" id="modalImg" style="width: 100%; border: 5px solid; background-color: white; padding: 5px; border-image: url(../images/Frame.png) 30 round;" alt="..." class="img-responsive">
                                    </div>
                                    <div class="col-md-6">
                                        <h3>product price:</h3>
                                        <h4 style="color: red" id="lblPrice" runat="server"></h4>
                                        <h3>framing cost(per cm 200BDT):</h3>
                                        <h4 style="color: red" id="lblPriceWFrame" runat="server"></h4>
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
        </div>
    </section>

    <script src="https://code.jquery.com/jquery-3.4.1.js"></script>
    <script type="text/javascript" src="../js/jquery.exzoom.js"></script>
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