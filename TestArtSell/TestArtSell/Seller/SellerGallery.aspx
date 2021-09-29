<%@ Page Title="" Language="C#" MasterPageFile="~/General/UserMaster.Master" AutoEventWireup="true" CodeBehind="SellerArtsGallery.aspx.cs" Inherits="TestArtSell.Seller.SellerGallery" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.0/jquery.min.js"></script>
    <link href="../AdminPanelAssets/assets/css/Gallery.css" rel="stylesheet" />
    <style>

        .form-group {
            padding: 5px 5px;
        }

        .art-preview {
            width: 300px;
            height: 200px;
            position: relative;
            border: 6px solid #666699;
            box-shadow: 0px 2px 4px 0px rgba(0, 0, 0, 0.4);
            margin-bottom: 2px;
        }

        .btn {
            border-radius:20px;
            background-color:#ffffff;
            color:darkcyan;
            border:1px solid darkcyan;
            box-shadow: 0px 2px 4px 0px rgba(0, 0, 0, 0.2);
        }

        .btn:hover {
            border-radius:20px;
            background-color:#f0f0f5;
            color:darkcyan;
            border:1px solid darkcyan;
            box-shadow: 0px 2px 4px 0px rgba(0, 0, 0, 0.4);
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <asp:MultiView ID="MultiView1" runat="server">
        <asp:View ID="GalleryView" runat="server">
            <div class="row">
                <div class="col-lg-12">
                    <h5 class="heading" style="text-align: center">My Art Gallery</h5>
                </div>
            </div>
            <hr />

            <div class="gallery-image">
                <asp:Repeater ID="rptGallery" runat="server" OnItemCommand="rptGallery_ItemCommand">
                    <ItemTemplate>
                        <div class="card" style="margin: 4px; border-radius: 10px;">
                            <div class="card-body" style="padding: 0;">
                                <asp:LinkButton ID="btnPhoto" runat="server" Style="padding: 0" CommandArgument='<%#Eval("ID") %>'>
                                    <div class="img-box" style="margin: 0;">
                                        <img src='<%#Eval("ItemPhoto") %>' alt="" />
                                        <div class="transparent-box">
                                            <div class="caption">
                                                <p><%#Eval("ItemTitle") %></p>
                                                <p class="opacity-low"><%#Eval("ItemDetails") %></p>
                                            </div>
                                        </div>
                                    </div>
                                </asp:LinkButton>
                            </div>
                            <div class="card-footer" style="padding: 8px">
                                <div class="row">
                                    <div class="col-md-6">
                                        <asp:LinkButton ID="btnEdit" runat="server" CssClass="btn btn-sm btn-block" CommandArgument='<%#Eval("ID") %>'>Edit</asp:LinkButton>
                                    </div>
                                    <div class="col-md-6">
                                        <asp:LinkButton ID="btnDelete" runat="server" CssClass="btn btn-sm btn-block" CommandArgument='<%#Eval("ID") %>'>Delete</asp:LinkButton>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>

            </div>
        </asp:View>
        <asp:View ID="EditView" runat="server">
            <div class="card" style="border: 3px solid #f0f0f5; border-radius: 10px">
                <div class="card-header" style="background-color: #f0f0f5">
                    <div class="row">
                        <div class="col-md-6">
                            <h6>Update Your Art Info </h6>
                        </div>
                        <div class="col-md-6">
                            <asp:LinkButton ID="btnBackToGallery" runat="server" CssClass="btn btn-sm btn-success pull-right" OnClick="btnBackToGallery_Click" Style="width: 130px; color: white"><i class="la la-backward"></i>Go to Gallery</asp:LinkButton>
                        </div>

                    </div>

                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="form-group">
                                        <label class="control-label" for="">Title</label>
                                        <asp:TextBox CssClass="form-control" runat="server" ID="txttitle"></asp:TextBox>
                                    </div>
                                    <div class="form-group">
                                        <label for="squareInput">Category</label>
                                        <asp:DropDownList ID="ddlCat" CssClass="form-control" runat="server"></asp:DropDownList>
                                    </div>
                                    <div class="form-group">
                                        <label for="squareInput">Price</label><br />
                                        <asp:Label ID="lblNotice" runat="server"></asp:Label>
                                        <asp:TextBox ID="txtPrice" onfocusout="myFunction()"  CssClass="form-control" Enabled="false" onkeypress="return isNumber(event)" runat="server"></asp:TextBox>
                                    </div>

                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label for="squareInput">Width(c.m)</label>
                                                <asp:TextBox ID="txtWidth" runat="server" onkeypress="return isNumber(event)" class="form-control"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label for="squareInput">Height(c.m)</label>
                                                <asp:TextBox ID="txtHeight" runat="server" onkeypress="return isNumber(event)" class="form-control"></asp:TextBox>
                                            </div>
                                        </div>

                                    </div>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <label for="comment">Details</label>
                                                <textarea class="form-control" runat="server" id="txtDetails" rows="3"></textarea>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6" style="border-left: 2px solid #666699">

                            <div id="result" class="art-preview">
                                <asp:Image runat="server" ImageUrl="~/images/alterimage.png" ID="imgServer" Width="100%" Height="100%" AlternateText="Select Art" />
                            </div>
                            <br />
                            <p style="font-style:italic;font-size:12px">Note: Image uploaded once can not be changed. If you don't want to keep this photo here you have to request for delete.</p>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <asp:LinkButton ID="btnUpdateArtInfo" runat="server" CssClass="btn btn-sm btn-success" OnClick="btnUpdateArtInfo_Click" Style="width: 100px; color: white"><i class="glyphicon glyphicon-cloud-upload"></i>Update Info</asp:LinkButton>
                            <asp:LinkButton ID="btnDeleteArt" runat="server" CssClass="btn btn-sm btn-danger" OnClick="btnDeleteArt_Click" Style="width: 100px; color: white;"><i class="glyphicon glyphicon-cloud-upload"></i>Delete Art</asp:LinkButton>
                        </div>
                    </div>
                </div>
            </div>
        </asp:View>

    </asp:MultiView>


    <script type="text/javascript">

        function isNumber(evt) {
            evt = (evt) ? evt : window.event;
            var charCode = (evt.which) ? evt.which : evt.keyCode;
            if (charCode > 31 && (charCode < 48 || charCode > 57)) {
                return false;
            }

            return true;
        }
        function myFunction() {
            var MainPrice = document.getElementById("ContentPlaceHolder1_txtPrice").value;
            var Commission = MainPrice * 0.20;
            var SellerPrice = MainPrice - Commission;
            document.getElementById("ContentPlaceHolder1_lblNotice").innerHTML = " the amount  " + Commission + " will be deducted from main price and you will get  " + SellerPrice;
            document.getElementById("ContentPlaceHolder1_lblNotice").style.color = "red"
        }
        $(document).ready(function () {
            $("ContentPlaceHolder1_txtPrice").keypress(function () {
                var a = document.getElementById("ContentPlaceHolder1_txtPrice").value;
                $("lblNotice").text("what upp");
            });
        });
    </script>
    <script>
        function showModal() {
            $("#myModal").modal('show');
        }
        $(document).ready(function () {
            var uri = window.location.toString();
            if (uri.indexOf("?") > 0) {
                var clean_uri = uri.substring(0, uri.indexOf("?"));
                window.history.replaceState({}, document.title, clean_uri);
            }
        });

        $('#myModal').on('shown.bs.modal', function () {
            $(this).find('.modal-dialog').css({
                width: 'auto',
                height: 'auto',
                'max-height': '100%'
            });
        });


        function readURL(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();

                reader.onload = function (e) {
                    $('#UploadImage')
                        .attr('src', e.target.result)
                        .width(150)
                        .height(200);
                };

                reader.readAsDataURL(input.files[0]);
            }
        }
    </script>

</asp:Content>
