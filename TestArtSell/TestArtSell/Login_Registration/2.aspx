<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="2.aspx.cs" Inherits="TestArtSell.Login_Registration.LoginForm" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <title>Ready Bootstrap Dashboard</title>
    <meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0, shrink-to-fit=no' name='viewport' />
    <link rel="stylesheet" href="../AdminPanelAssets/assets/css/bootstrap.min.css" />
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" />
    <link rel="stylesheet" href="../AdminPanelAssets/assets/css/ready.css" />
    <link rel="stylesheet" href="../AdminPanelAssets/assets/css/demo.css" />
    <link href="../AdminPanelAssets/assets/css/Gallery.css" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css?family=Raleway:600,900" rel="stylesheet" />
</head>
<body>
    <form id="Form1" runat="server">
        <div class="main">
            <div class="wrapper">
                <div class="content">
                    <div class="container-fluid" style="padding-top: 30px;width:50%">
                        <div class="card">
                            <div class="card-header">
                                <div class="card-title">Login</div>
                            </div>
                            <div class="card-body">
                                <div class="form-group">
                                    <label for="squareInput">User ID</label>

                                    <asp:TextBox ID="txtUserID" runat="server" class="form-control input-square" placeholder="User Name"></asp:TextBox>
                                </div>

                                <div class="form-group">
                                    <label for="pillInput">Password</label>

                                    <asp:TextBox ID="txtPass" runat="server" class="form-control input-square" placeholder="Password"></asp:TextBox>
                                </div>


                            </div>
                            <div class="card-action">

                                <asp:Button ID="btnLogin" runat="server" Text="Login" class="btn btn-success" OnClick="btnLogin_Click" />
                                <button class="btn btn-danger">Cancel</button>
                            </div>
                             <div class="form-group">
                                 <asp:LinkButton ID="regLink" runat="server" OnClick="regLink_Click">Don't have an account?Register now</asp:LinkButton>
                                </div>
                        </div>

                    </div>
                </div>



            </div>
            <!-- Modal -->
            <div class="modal fade" id="modalUpdate" tabindex="-1" role="dialog" aria-labelledby="modalUpdatePro" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered" role="document">
                    <div class="modal-content">
                        <div class="modal-header bg-primary">
                            <h6 class="modal-title"><i class="la la-frown-o"></i>Under Development</h6>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body text-center">
                            <p>Currently the pro version of the <b>Ready Dashboard</b> Bootstrap is in progress development</p>
                            <p>
                                <b>We'll let you know when it's done</b>
                            </p>
                            S
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Sign up form -->
            <%--  <section class="signup">
            <div class="container">
                <div class="signup-content">
                    <div class="signup-form">
                        <h2 class="form-title">Sign up</h2>
                       
                            <div class="form-group">
                                <label for="name"><i class="zmdi zmdi-account material-icons-name"></i></label>
                                <input type="text" name="name" id="name" placeholder="Your Name"/>
                            </div>
                            <div class="form-group">
                                <label for="email"><i class="zmdi zmdi-email"></i></label>
                                <input type="email" name="email" id="email" placeholder="Your Email"/>
                            </div>
                            <div class="form-group">
                                <label for="pass"><i class="zmdi zmdi-lock"></i></label>
                                <input type="password" name="pass" id="pass" placeholder="Password"/>
                            </div>
                             <div class="form-group">
                                <label for="re-pass"><i class="zmdi zmdi-lock-outline"></i></label>
                                <input type="password" name="re_pass" id="re_pass" placeholder="Repeat your password"/>
                            </div>
                            <div class="form-group">
                                <input type="checkbox" name="agree-term" id="agree-term" class="agree-term" />
                                <label for="agree-term" class="label-agree-term"><span><span></span></span>I agree all statements in  <a href="#" class="term-service">Terms of service</a></label>
                            </div> 
                            <div class="form-group form-button">
                                <input type="submit" name="signup" id="signup" class="form-submit" value="Register"/>
                            </div>
                    
                    </div>
                    <div class="signup-image">
                        <figure><img src="../css/SignUpCSS/images/signup-image.jpg" alt="sing up image"></figure>
                        <a href="#" class="signup-image-link">I am already member</a>
                    </div>
                </div>
            </div>
        </section>--%>

            <!-- Sing in  Form -->


        </div>
    </form>
    <script src="../AdminPanelAssets/assets/js/core/jquery.3.2.1.min.js"></script>
    <script src="../AdminPanelAssets/assets/js/plugin/jquery-ui-1.12.1.custom/jquery-ui.min.js"></script>
    <script src="../AdminPanelAssets/assets/js/core/popper.min.js"></script>
    <script src="../AdminPanelAssets/assets/js/core/bootstrap.min.js"></script>
    <script src="../AdminPanelAssets/assets/js/plugin/chartist/chartist.min.js"></script>
    <script src="../AdminPanelAssets/assets/js/plugin/chartist/plugin/chartist-plugin-tooltip.min.js"></script>

    <script src="../AdminPanelAssets/assets/js/plugin/bootstrap-toggle/bootstrap-toggle.min.js"></script>
    <script src="../AdminPanelAssets/assets/js/plugin/jquery-mapael/jquery.mapael.min.js"></script>
    <script src="../AdminPanelAssets/assets/js/plugin/jquery-mapael/maps/world_countries.min.js"></script>
    <script src="../AdminPanelAssets/assets/js/plugin/chart-circle/circles.min.js"></script>
    <script src="../AdminPanelAssets/assets/js/plugin/jquery-scrollbar/jquery.scrollbar.min.js"></script>
    <script src="../AdminPanelAssets/assets/js/ready.min.js"></script>
    <script src="../AdminPanelAssets/assets/js/demo.js"></script>
</body>
</html>
