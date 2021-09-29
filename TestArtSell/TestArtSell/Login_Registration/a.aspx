<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="a.aspx.cs" Inherits="TestArtSell.Login_Registration.Registration" %>

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
                    <asp:TextBox ID="TextBox1" runat="server" OnUnload="TextBox1_Unload"></asp:TextBox>
                    <div class="container-fluid" style="padding-top: 30px;width:50%">
                        <div class="card">
                            <div class="card-header">
                                <div class="card-title">Registraation</div>
                            </div>
                            <div class="card-body">
                                <div class="form-group">
                                    <label for="squareInput">Full Name</label>

                                    <asp:TextBox ID="txtUserFullName" runat="server" class="form-control input-square" placeholder="User Name"></asp:TextBox>
                                </div>
                                 <div class="form-group">
                                    <label for="squareInput">User ID</label>
                                     <asp:Label ID="lblStatus" runat="server"></asp:Label>  
                                    <asp:TextBox ID="txtUserID" runat="server" onchange="UserOrEmailAvailability()" class="form-control input-square" placeholder="User Name"></asp:TextBox>
                                </div>
                                   <div class="form-group">
                                    <label for="squareInput">Email</label>
                                        
                                    <asp:TextBox ID="txtEmail" runat="server" class="form-control input-square" placeholder="User Name"></asp:TextBox>
                                </div>
                                 <div class="form-group">
                                    <label for="squareInput">Contact Number</label>

                                    <asp:TextBox ID="txtContactNumber" runat="server" class="form-control input-square" placeholder="User Name"></asp:TextBox>
                                </div>
                                <div class="form-group">
                                    <label for="pillInput">Password</label>

                                    <asp:TextBox ID="txtPass" runat="server" class="form-control input-square" placeholder="Password"></asp:TextBox>
                                </div>
                                <div class="form-group">
                                    <label for="pillInput">Confirm Password</label>
                                    <asp:Label ID="lblPass" runat="server"></asp:Label>  
                                    <asp:TextBox ID="txtConPass" runat="server" class="form-control input-square" placeholder="Password"></asp:TextBox>
                                </div>

                            </div>
                            <div class="card-action">

                               <%-- <asp:Button ID="btnRegistration" runat="server" Text="Register" class="btn btn-success" sstyle="enabled:false" OnClick="btnRegistration_Click"  />--%>
                                 <button id="btnRegistration" class="btn btn-danger" onserverclick="btnRegistration_Click"  runat="server" disabled>Registration</button>
                                <button class="btn btn-danger">Cancel</button>
                            </div>
                        </div>

                    </div>
                </div>



            </div>
            <!-- Modal -->
           
            <!-- Sign up form -->
         
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
     <script type="text/javascript">  
  
        function UserOrEmailAvailability() { //This function call on text change.             
            $.ajax({  
                type: "POST",  
                url: "registration.aspx/CheckEmail", // this for calling the web method function in cs code.  
                data: '{useroremail: "' + $("#<%=txtUserID.ClientID%>")[0].value + '" }',// user name or email value  
                contentType: "application/json; charset=utf-8",  
                dataType: "json",  
                success: OnSuccess,  
                failure: function (response) {  
                    alert(response);  
                }  
            });  
        }  
  
        // function OnSuccess  
        function OnSuccess(response) {  
            var msg = $("#<%=lblStatus.ClientID%>")[0];  
            switch (response.d) {  
                case "true":  
                    msg.style.display = "block";  
                    msg.style.color = "red";  
                    msg.innerHTML = "User Name  already exists.";
                    
                    //
                    break;  
                case "false":  
                    msg.style.display = "block";  
                    msg.style.color = "green";  
                    msg.innerHTML = "User Name  Available";
                    document.getElementById("<%=btnRegistration.ClientID %>").disabled = false;
                    
                    break;  
            }  
        }
         $('#txtPass, #txtConPass').on('keyup', function () {
             //console.log("aaaa");
             if ($('#txtPass').val() == $('#txtConPass').val()) {
                 $('#lblPass').html('Matching').css('color', 'green');
                 document.getElementById("<%=btnRegistration.ClientID %>").disabled = false;
             } else
                 $('#lblPass').html('Not Matching').css('color', 'red');
             document.getElementById("<%=btnRegistration.ClientID %>").disabled = true;
         });
  
    </script>  
</body>
</html>
