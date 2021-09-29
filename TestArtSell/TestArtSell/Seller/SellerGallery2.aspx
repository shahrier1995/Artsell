<%@ Page Title="" Language="C#" MasterPageFile="~/General/UserMaster.Master" AutoEventWireup="true" CodeBehind="SellerGallery2.aspx.cs" Inherits="TestArtSell.Seller.SellerGallery2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <%--<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css" />--%>

    <script src="../js/crop/jquery.min.js"></script>
    <%--<script src="../js/crop/bootstrap.min.js"></script>--%>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/cropper/2.3.3/cropper.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/cropper/2.3.3/cropper.css" />


    <style>
        #canvas {
            height: 300px;
            width: 100%;
            background-color: #ffffff;
            cursor: default;
            border: 1px solid black;
        }
    </style>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <button type="button" class="btn bg-primary btn-sm" data-toggle="modal" data-target="#myModal" style="width: 160px; margin-bottom: 3px"><i class="fa fa-image"></i>Select & Resize Photo</button>
    <button type="button" class="btn btn-success btn-sm" onclick="UploadPic()" style="width: 160px;"><i class="glyphicon glyphicon-cloud-upload"></i>Upload Photo</button>

    <div id="result" style="border: 1px solid Black; height: 180px; width: 160px; margin-bottom: 3px">
        <asp:Image runat="server" ImageUrl="#" ID="imgServer" />
    </div>
    <div class="modal fade" id="myModal" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Upload & Edit Image</h4>
                </div>
                <div class="modal-body">
                    <div style="margin-bottom: 3px">
                        <canvas id="canvas">Your browser does not support the HTML5 canvas element.
                        </canvas>
                    </div>
                    <input type="file" id="fileInput" accept="image/*" class="form-control" />

                </div>
                <div class="modal-footer">
                    <input type="button" id="btnRestore" value="Restore" class="btn btn-info" />
                    <button type="button" id="btnCrop" value="Crop" class="btn btn-success" data-dismiss="modal">Crop Apply</button>
                </div>
            </div>

        </div>
    </div>
        <script type="text/javascript">

            var canvas = $("#canvas"),
            context = canvas.get(0).getContext("2d"),
            $result = $('#result');


            $('#fileInput').on('change', function () {
                if (this.files && this.files[0]) {
                    if (this.files[0].type.match(/^image\//)) {
                        var reader = new FileReader();
                        reader.onload = function (evt) {
                            var img = new Image();
                            img.onload = function () {
                                context.canvas.height = img.height;
                                context.canvas.width = img.width;
                                context.drawImage(img, 0, 0);
                                var cropper = canvas.cropper({

                                    //aspectRatio: 6 / 6,
                                    dragMode: 'move',

                                    cropBoxResizable: true,
                                    minCropBoxWidth: 128,
                                    minCropBoxHeight: 128
                                });



                                $('#btnCrop').click(function () {
                                    //$result.empty();
                                    // Get a string base 64 data url
                                    var croppedImageDataURL = canvas.cropper('getCroppedCanvas').toDataURL("image/png");
                                    //$result.append($('<img id="croppedImg" required>').attr('src', croppedImageDataURL));
                                    $('#ContentPlaceHolder1_imgServer').attr('src', croppedImageDataURL);
                                    //console.log(croppedImageDataURL);
                                });
                                $('#btnRestore').click(function () {
                                    canvas.cropper('reset');
                                    $result.empty();
                                    canvas.cropper('replace', '', true);
                                });
                            };
                            img.src = evt.target.result;
                        };
                        reader.readAsDataURL(this.files[0]);
                    }
                    else {
                        alert("Invalid file type! Please select an image file.");
                    }
                }
                else {
                    alert('No file(s) selected.');
                }
            });






</script>
    <script type="text/javascript">


       

</script>
</asp:Content>


