<%@ Page Title="" Language="C#" MasterPageFile="~/General/UserMaster.Master" AutoEventWireup="true" CodeBehind="UploadArtwork.aspx.cs" Inherits="TestArtSell.Seller.UploadArtwork" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script src="http://lesscss.googlecode.com/files/less-1.0.30.min.js"></script>
    <link rel="stylesheet/less" href="../css/img.less" type="text/css" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>


    <script src="../js/crop/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/cropper/2.3.3/cropper.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/cropper/2.3.3/cropper.css" />

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <style>
        #canvas {
            height: 100%;
            width: 100%;
            background-color: #ffffff;
            cursor: default;
            border: 8px solid #fff;
        }

        .form-group {
            padding: 5px 5px;
        }

        .art-preview {
            width: 100%;
            height: 300px;
            position: relative;
            border: 10px solid #8f5c00;
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
    <asp:ScriptManager runat="server" ID="sc1"></asp:ScriptManager>
     <asp:UpdatePanel runat="server" ID="pnl" UpdateMode="Conditional">
                <ContentTemplate>

    <div class="card" style="border: 3px solid #f0f0f5; border-radius: 10px">
        <div class="card-header" style="background-color: #f0f0f5">
            <strong style="font-size:18px">Upload Your ArtWorks</strong>
        </div>
        <div class="card-body">
            <div class="row">
                <div class="col-md-7" style="border-right: 2px solid #666699">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="form-group">
                                
                               
                                <label class="control-label" for="txttitle">Title</label>&nbsp&nbsp
                                <a  title="Give a nice title for your artwork" data-toggle="tooltip" data-placement="right"><i class="fa fa-question-circle" style="font-size:15px;color:#581845"></i></a>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
ControlToValidate="txttitle" errormessege="Please enter your Title" ValidationGroup="reqField" ForeColor="Red"> Please enter your Title</asp:RequiredFieldValidator>
                                <asp:TextBox CssClass="form-control" runat="server" ID="txttitle"></asp:TextBox>
                            </div>
                            <div class="form-group">
                                <label for="squareInput">Category</label>&nbsp&nbsp
                                <a  title="If your desired category doesn't exist select others" data-toggle="tooltip" data-placement="right"><i class="fa fa-question-circle" style="font-size:15px;color:#581845"></i></a>
                                 <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"  InitialValue="NA"
ControlToValidate="ddlCat" errormessege="Please select a Category" ValidationGroup="reqField" ForeColor="Red">  Please select a Category</asp:RequiredFieldValidator>
                                <asp:DropDownList ID="ddlCat" CssClass="form-control" runat="server"></asp:DropDownList>
                            </div>
                            <div class="form-group">
                                <label for="squareInput">Price</label>&nbsp&nbsp
                                <a  title="Artsell will cut 20% from your given price.So suggetion will be : to get your desired price include our 20% in the price." data-toggle="tooltip" data-placement="right"><i class="fa fa-question-circle" style="font-size:15px;color:#581845"></i></a>
                                 <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server"
ControlToValidate="txtPrice" errormessege="Please enter a price" ValidationGroup="reqField" ForeColor="Red"> Please enter a price</asp:RequiredFieldValidator>
                                <br />
                                <asp:Label ID="lblNotice" runat="server"></asp:Label>
                                <asp:TextBox ID="txtPrice" onfocusout="myFunction()" onkeypress="return isNumber(event)" runat="server" class="form-control"></asp:TextBox>
                            </div>

                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="squareInput">Width(c.m)</label>&nbsp&nbsp
                                <a  title="Total width of the artwork. if its framed include the frame width" data-toggle="tooltip" data-placement="right"><i class="fa fa-question-circle" style="font-size:15px;color:#581845"></i></a>
                                         <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server"
ControlToValidate="txtWidth" errormessege="Please enter a width" ValidationGroup="reqField" ForeColor="Red"> Please enter a width</asp:RequiredFieldValidator>
                                        <asp:TextBox ID="txtWidth" runat="server" onkeypress="return isNumber(event)" class="form-control"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="squareInput">Height(c.m)</label>&nbsp&nbsp
                                <a  title="Total Height of the artwork. if its framed include the frame Height" data-toggle="tooltip" data-placement="right"><i class="fa fa-question-circle" style="font-size:15px;color:#581845"></i></a>
                                         <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server"
ControlToValidate="txtHeight" errormessege="Please enter a height" ValidationGroup="reqField" ForeColor="Red"> Please enter a height</asp:RequiredFieldValidator>
                                        <asp:TextBox ID="txtHeight" runat="server" onkeypress="return isNumber(event)" class="form-control"></asp:TextBox>
                                    </div>
                                </div>

                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="form-group">
                                        <label for="comment">Details</label>&nbsp&nbsp
                                <a  title="Tell more about your creativity. give some instruction for the customer like how they can use your art. the more detailed your master piece is the higher chane to get it sold." data-toggle="tooltip" data-placement="right"><i class="fa fa-question-circle" style="font-size:15px;color:#581845"></i></a>
                                                   <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server"
ControlToValidate="txtDetails" errormessege="Please enter a Details" ValidationGroup="reqField" ForeColor="Red"> Please enter a details</asp:RequiredFieldValidator>
                                        <textarea class="form-control" runat="server" id="txtDetails" rows="3"></textarea>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-5" >
                      <label for="comment">Upload picture</label>&nbsp&nbsp
                                <a title="Please select vey clean and clear picture of your art work. Initially we show only one picture of your artwork so select the best one. " data-toggle="tooltip" data-placement="right"><i class="fa fa-question-circle" style="font-size:15px;color:#581845"></i></a>
                    <div id="result" class="art-preview">
                        <%--<asp:Image  runat="server" ImageUrl="~/images/alterimage.png" ID="imgServer" Width="100%" Height="100%" AlternateText="Select Art"  />--%>
                              
                        <canvas id="canvas">
                        </canvas>
                    </div>
                    <br />
                    <%--<button type="button" class="btn btn-sm" data-toggle="modal" data-target="#myModal" style="width: 160px; margin-bottom: 3px"><i class="fa fa-image"></i>Select & Resize Photo</button>--%>
                    <asp:FileUpload ID="FileUpload1" runat="server" CssClass="btn btn-sm"  accept="image/*" />&nbsp&nbsp
                                <a  title="The above image not how it should be showed in our gallery. its just for checking that you are uploading the right photo. " data-toggle="tooltip" data-placement="right"><i class="fa fa-question-circle" style="font-size:15px;color:#581845"></i></a>

                </div>
            </div>
            <br />
            <div class="row">
                <div class="col-md-12">
                   
                    <asp:LinkButton ID="btnSubmitArt" runat="server" CssClass="btn btn-sm" OnClick="btnSubmitArt_Click" style="width: 150px;" ValidationGroup="reqField"><i class="la la-upload" ></i>Submit Photo</asp:LinkButton>

                </div>
            </div>

        </div>

    </div>
                    
    
    <div class="modal fade" id="myModal" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header" >
                    
                    <span >Upload & Edit Image</span>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
                <div class="modal-body">
                    <div style="margin-bottom: 3px">
                        
                    </div>
                    <%--<input type="file" id="fileInput" accept="image/*" class="form-control" />--%>

                </div>
                <div class="modal-footer">
                    <input type="button" id="btnRestore" value="Restore" class="btn btn-info" />
                    <button type="button" id="btnCrop" value="Crop" class="btn btn-success" data-dismiss="modal">Crop Apply</button>
                </div>
            </div>

        </div>
    </div>
    </ContentTemplate>

            <Triggers>
          <asp:PostBackTrigger ControlID="btnSubmitArt"  />
      </Triggers>
            </asp:UpdatePanel>
    <div class="modal" id="successModal" data-backdrop="static" data-keyboard="false">
            <div class="modal-dialog">
                <div class="modal-content">
                    <%--<div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times; </span> Close </button>
                        
                    </div>--%>
                    <div class="modal-body">
                        <br />

                        <h2 style="text-align: center; color: #237c19"><span class="la la-check"></span></h2>
                        
                        <h5 id="msgS" style="text-align: center; color: #097800"></h5>
                        <p id="msgS2" style="text-align: center; color: black"></p>
                        <p id="msgS3" style="text-align: center; color: #267d1c;font-style:italic"></p>

                    </div>::
                    <div class="modal-footer">

                       <asp:Button ID="goToGallery" runat="server" Text="Okay"  class="btn btn-block" Style="border-radius: 20px; width: 120px" OnClick="goToGallery_Click" />
                    </div>
                </div>
            </div>
        </div>
    <script type="text/javascript">

        var canvas = $("#canvas"),
        context = canvas.get(0).getContext("2d"),
        $result = $('#result');


        $('#ContentPlaceHolder1_FileUpload1').on('change', function () {

            if (this.files && this.files[0]) {
                if (this.files[0].type.match(/^image\//)) {
                    var reader = new FileReader();

                    reader.onload = function (evt) {

                        var img = new Image();
                        img.onload = function () {
                            context.canvas.height = img.height;
                            context.canvas.width = img.width;
                            context.drawImage(img, 0, 0);
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
            var Commission = Math.round(MainPrice * 0.20);
            var SellerPrice = MainPrice - Commission;
            document.getElementById("ContentPlaceHolder1_lblNotice").innerHTML =   Commission + " BDT will be deducted from main price and you will get  " + SellerPrice;
            document.getElementById("ContentPlaceHolder1_lblNotice").style.color = "red"
        }
        $(document).ready(function () {
            $("ContentPlaceHolder1_txtPrice").keypress(function () {
                var a = document.getElementById("ContentPlaceHolder1_txtPrice").value;
                $("lblNotice").text("what upp");
            });
        });
    </script>


    <script type="text/javascript">
        function ShowPopup2(msg, msg2, msg3) {
            $('#successModal').modal();
            $('#successModal').modal('show');
            $(".modal-body #msgS").text(msg);
            $(".modal-body #msgS2").text(msg2);
            $(".modal-body #msgS3").text(msg3);


        }
    </script>
</asp:Content>
