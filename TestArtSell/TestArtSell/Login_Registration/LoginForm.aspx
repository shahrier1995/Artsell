<%@ Page Title="" Language="C#" EnableEventValidation="true" MasterPageFile="~/Login_Registration/Login-RegistrationMaster.Master" AutoEventWireup="true" CodeBehind="LoginForm.aspx.cs" Inherits="TestArtSell.Login_Registration.LoginForm1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <meta name="google-signin-scope" content="profile email" />
    <meta name="google-signin-client_id" content="717713248369-0s92lqhvd00asggpaou8ps472dujr6nv.apps.googleusercontent.com" />
    <script src="https://apis.google.com/js/platform.js" async defer></script>
    <style type="text/css">
        div.ringcaptcha.widget.no-brand {
            border: 0px;
            !important;
        }
        .modal-dialog {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 80%;
        }
        button.btn.btn-submit.btn-block.btn-verify.js-send-code {
            color: white;
            !important;
            background-color: green;
            !important;
        }
        .vertical-center {
            margin: 0;
  position: absolute;
  top: 50%;
  left: 50%;
  -ms-transform: translate(-50%, -50%);
  transform: translate(-50%, -50%);
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:MultiView ID="mv" runat="server">
        <asp:View runat="server" ID="viewLogin">
            <div class="card-header">
                <div class="card-title">Login</div>
            </div>
            <div class="card-body">
                <div class="form-group">
                    <label for="squareInput"><i class="fa fa-user"></i> User ID</label>

                    <asp:TextBox ID="txtUserID" runat="server" class="form-control" placeholder="User ID"></asp:TextBox>
                </div>

                <div class="form-group">
                    <label for="pillInput"><i class="fa fa-key"></i> Password</label>

                    <asp:TextBox ID="txtPass" TextMode="Password" runat="server" class="form-control" placeholder="Password"></asp:TextBox>
                    <br />
                    <asp:LinkButton ID="LinkButton1" runat="server" OnClick="regLink_Click">Forget Password?</asp:LinkButton>
                </div>

                <%--                  <div id="xyz" data-widget data-app="i5a4u5a3oso1i7e8e2ov" data-locale="en" data-mode="verification" data-type="sms"></div>--%>
            </div>
            <div class="card-footer">

                <asp:Button ID="btnLogin" runat="server" Text="Login" class="btn btn-success" Style="border-radius: 20px; width: 120px" OnClick="btnLogin_Click" />
                <asp:Button ID="btnCancel" runat="server" Text="Back to Home" class="btn btn-danger pull-right" Style="border-radius: 20px; width: 120px" OnClick="btnCancel_Click" />

                <br />
                <a data-toggle="modal" href="#register">Don't have an account ? Register now </a>
            </div>
        </asp:View>
        <asp:View runat="server" ID="viewResetPass">
            <div class="card-header">
                 <div class="card-title">Forgot Password ?</div>
            </div>
            <div class="card-body">
                <div class="form-group">
                        <i> Please input your registerd email address below </i>
                    <br />
                        <label id="lblError" style="color:red; display: none"></label>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server"
                            ControlToValidate="txtEmail" errormessege="Please enter your User ID" ValidationGroup="reqField" ForeColor="Red">* Please write your email *</asp:RequiredFieldValidator>

                        <asp:TextBox ID="txtEmail" onkeyup="ValidateEmail()" runat="server" class="form-control" placeholder="Email"></asp:TextBox>
                    </div>
            </div>
            <div class="card-footer">
                 <asp:Button ID="btnBackToLogin" runat="server" Style="border-radius: 20px; width: 130px" Text="Back to Login" class="btn btn-default"  OnClick="btnBackToLogin_Click"  />
                <asp:Button ID="btnRegistration" runat="server" Style="border-radius: 20px; width: 130px" Text="Reset Password" class="btn btn-success" sstyle="enabled:false" OnClick="btnForgetPassClick_Click" ValidationGroup="reqField" />
            </div>
        </asp:View>
    </asp:MultiView>


    <%--ERROR MODAL--%>
    <div class="modal" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" >
        <div class="modal-dialog">
            <div class="modal-content">
                <%--<div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times; </span> Close </button>
                        
                </div>--%>
                <div class="modal-body">
                    <br />
                    <br />

                    <h2 style="text-align: center; color: #ffcc00"><span class="la la-warning"></span></h2>
                        
                    <h5 id="msg" style="text-align: center; color: #983c3c"></h5>
                    <p id="msg2" style="text-align: center; color: red"></p>

                </div>
                <div class="modal-footer">

                       
                    <button type="button" id="ok" class="btn btn-default" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>
    <div class="modal" id="successModal" data-backdrop="static" data-keyboard="false">
            <div class="modal-dialog">
                <div class="modal-content">
                    <%--<div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times; </span> Close </button>
                        
                    </div>--%>
                    <div class="modal-body">
                        <br />
                        <br />

                        <h2 style="text-align: center; color: #237c19"><span class="la la-check"></span></h2>
                        
                        <h5 id="msgS" style="text-align: center; color: #097800"></h5>
                        <p id="msgS2" style="text-align: center; color: #237c19"></p>

                    </div>
                    <div class="modal-footer">

                       <asp:Button ID="btnBackToLoginFromModal" runat="server" Text="Login"  class="btn btn-success" Style="border-radius: 20px; width: 120px" OnClick="btnBackToLoginFromModal_Click" />
                    </div>
                </div>
            </div>
        </div>
    <div class="modal" id="errorModal" >
            <div class="modal-dialog">
                <div class="modal-content">

                    <div class="modal-body">
                        <br />
                        <br />

                        <h2 style="text-align: center; color: #ffcc00"><span class="la la-warning"></span></h2>
                        <h5 id="msgE" style="text-align: center; color: #983c3c"></h5>
                        <p id="msgE2" style="text-align: center; color: red"></p>
                    </div>
                    <div class="modal-footer">

                        <button type="button" id="ok2" class="btn btn-default" data-dismiss="modal">Close</button>
                      
                       
                    </div>
                </div>
            </div>
        </div>
    <!-- Modal -->
    <div class="modal " id="register" tabindex="-1" role="dialog"  aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Join us</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body " style="padding:25px 70px 25px 70px">
                    <div class="">
                        <asp:LinkButton ID="btnSeller" runat="server" CssClass="btn btn-block" style="background-color:#581845;width:100%;border-radius:20px;color:white" OnClick="btnSeller_Click"><i class="fa fa-palette"></i> As an Artist </asp:LinkButton>
                        <asp:LinkButton ID="btnBuyer" runat="server"  CssClass="btn btn-block" style="background-color:#581845;width:100%;border-radius:20px;color:white" OnClick="btnBuyer_Click"><i class="fa fa-suitcase"></i> As a Buyer</asp:LinkButton>
                    </div>
                    
                </div>
                
            </div>
        </div>
    </div>
    <script>
        function ValidateEmail() {
            //console.log("sasas");
            var email = document.getElementById('<%= txtEmail.ClientID %>').value;
            var x = document.getElementById("lblError");
                 
            var lblError = document.getElementById("lblError");
            lblError.innerHTML = "";
            var expr = /^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
            if (!expr.test(email)) {
                lblError.innerHTML = "Invalid email address.";
                x.style.display = "block";
                x.style.color = "red";
            }
        }
    </script>
    <script type='text/javascript' charset='UTF-8' src="//cdn.ringcaptcha.com/widget/v2/bundle.min.js"></script>

    <script  type='text/javascript'>
        function ShowPopup(msg,msg2) {
            $('#exampleModal').modal();
            $('#exampleModal').modal('show');
            $(".modal-body #msg").text(msg);
            $(".modal-body #msg2").text(msg2);
           
            
        }
        function ShowPopup2(msg, msg2) {
            $('#successModal').modal();
            $('#successModal').modal('show');
            $(".modal-body #msgS").text(msg);
            $(".modal-body #msgS2").text(msg2);

            
        }
        function ShowPopup3(msg, msg2) {
            $('#errorModal').modal();
            $('#errorModal').modal('show');
            $(".modal-body #msgE").text(msg);
            $(".modal-body #msgE2").text(msg2);


        }
        
</script>

     <%--        <div class="g-signin2" data-onsuccess="onSignIn" data-theme="dark"></div>--%>
            <script type="text/javascript">
                $(document).ready(function () {
                    var appKey = "i5a4u5a3oso1i7e8e2ov";
                    var widget = new RingCaptcha.Widget('#xyz', {
                        app: appKey,
                        events: {
                            // When widget is read
                            ready: function (event) {
                            },
                            // Add JavaScript Callbacks
                            verified: function (event) {
                                const dataString = localStorage.getItem('ringcaptcha.widget.' + appKey);
                                const data = dataString ? JSON.parse(dataString) : null;
                                const phone = data.phoneNumber;
                                alert("Phone number verified:" + phone);
                                // Make the widget disappear
                                $('div.ringcaptcha.widget.no-brand').hide();
                            }
                        }
                    }).setup();

                    function onSignIn(googleUser) {
                        // Useful data for your client-side scripts:
                        var profile = googleUser.getBasicProfile();
                        //console.log("ID: " + profile.getId()); // Don't send this directly to your server!
                        //console.log('Full Name: ' + profile.getName());
                        //console.log('Given Name: ' + profile.getGivenName());
                        //console.log('Family Name: ' + profile.getFamilyName());
                        //console.log("Image URL: " + profile.getImageUrl());
                        //console.log("Email: " + profile.getEmail());
                        //console.log("Email: " + profile.getPhoneNumber());

                        // The ID token you need to pass to your backend:
                        var id_token = googleUser.getAuthResponse().id_token;
                        //console.log("ID Token: " + id_token);
                    }
                });
            </script>
</asp:Content>

