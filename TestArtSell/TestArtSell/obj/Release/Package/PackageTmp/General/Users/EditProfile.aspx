<%@ Page Title="" Language="C#" MasterPageFile="~/General/UserMaster.Master" AutoEventWireup="true" CodeBehind="EditProfile.aspx.cs" Inherits="TestArtSell.General.Users.EditProfile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="card" style="border: 3px solid #f0f0f5; border-radius: 10px">
        <div class="card-header">
            <div class="card-title">Update Personal Information</div>
        </div>
        <div class="card-body">
            <div class="row">
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="squareInput">Full Name</label><asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                            ControlToValidate="txtUserFullName" errormessege="Please enter your User ID" ValidationGroup="reqField" ForeColor="Red"> *</asp:RequiredFieldValidator>

                        <asp:TextBox ID="txtUserFullName" runat="server" class="form-control input-square" placeholder="User Name"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label for="squareInput">User ID</label>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
                            ControlToValidate="txtUserID" errormessege="Please enter your User ID" ValidationGroup="reqField" ForeColor="Red"> *</asp:RequiredFieldValidator>
                        <asp:Label ID="lblStatus" runat="server"></asp:Label>
                        <asp:TextBox ID="txtUserID" runat="server" onchange="UserAvailability()" class="form-control input-square" placeholder="User Name"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label for="squareInput">Email</label><label id="lblError" style="color: red; display: none"></label>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server"
                            ControlToValidate="txtEmail" errormessege="Please enter your User ID" ValidationGroup="reqField" ForeColor="Red"> *</asp:RequiredFieldValidator>

                        <asp:TextBox ID="txtEmail" onkeyup="ValidateEmail()" onchange="EmailAvailability()" runat="server" class="form-control input-square" placeholder="User Name"></asp:TextBox>
                        <asp:Label ID="lblEmail" runat="server"></asp:Label>
                    </div>
                    <div class="form-group">
                        <label for="squareInput">Contact Number</label>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server"
                            ControlToValidate="txtContactNumber" errormessege="Please enter your User ID" ValidationGroup="reqField" ForeColor="Red"> *</asp:RequiredFieldValidator>
                        <asp:TextBox ID="txtContactNumber" runat="server" class="form-control input-square" placeholder="Contact Number"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label for="squareInput">user Address</label>


                        <textarea class="form-control" runat="server" id="txtAddress" rows="5">

												</textarea>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">

                        <asp:FileUpload ID="FileUpload1" runat="server" onchange="readURL(this);" />
                    </div>
                    <div class="form-group">
                        <img id="UploadImage" src="#" alt="your image" />
                    </div>
                    <div class="form-group">
                        <label for="squareInput">Gender</label>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server"
                            ControlToValidate="txtContactNumber" errormessege="Please enter your User ID" ValidationGroup="reqField" ForeColor="Red"> *</asp:RequiredFieldValidator>
                        <asp:RadioButtonList ID="Radiobtngender" runat="server">
                            <asp:ListItem Value="Male">Male</asp:ListItem>
                            <asp:ListItem Value="Female">Female</asp:ListItem>
                        </asp:RadioButtonList>

                    </div>
                </div>
            </div>


        </div>
        <div class="card-action">

            <asp:Button ID="btnUpdate" runat="server" Text="Register" class="btn btn-success" sstyle="enabled:false" ValidationGroup="reqField" OnClick="btnUpdate_Click" />


            <asp:Button ID="btnCancel" runat="server" Text="Cancel" class="btn btn-danger" />
        </div>
    </div>


    <script type="text/javascript">
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
        function ValidateEmail() {
            console.log("sasas");
            var email = document.getElementById('<%= txtEmail.ClientID %>').value;
                 var x = document.getElementById("lblError");

                 var lblError = document.getElementById("lblError");
                 lblError.innerHTML = "";
                 var expr = /^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
                 if (!expr.test(email)) {
                     lblError.innerHTML = "Invalid email address.";
                     x.style.display = "block";
                 }
             }


             function UserAvailability() { //This function call on text change.             
                 $.ajax({
                     type: "POST",
                     url: "registrationform.aspx/CheckUserID", // this for calling the web method function in cs code.  
                     data: '{useroremail: "' + $("#<%=txtUserID.ClientID%>")[0].value + '" }',// user name or email value  
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: OnUserIDSuccess,
                failure: function (response) {
                    alert(response);
                }
            });
        }
        function EmailAvailability() { //This function call on text change.             
            $.ajax({
                type: "POST",
                url: "registrationform.aspx/CheckEmail", // this for calling the web method function in cs code.  
                data: '{useroremail: "' + $("#<%=txtEmail.ClientID%>")[0].value + '" }',// user name or email value  
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: OnEmailSuccess,
                failure: function (response) {
                    alert(response);
                }
            });
        }
        // function OnSuccess  
        function OnUserIDSuccess(response) {
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
                    document.getElementById("<%=btnUpdate.ClientID %>").disabled = false;

                    break;
            }
        }
        // function OnSuccess  
        function OnEmailSuccess(response) {
            var msg = $("#<%=lblEmail.ClientID%>")[0];
            switch (response.d) {
                case "true":
                    msg.style.display = "block";
                    msg.style.color = "red";
                    msg.innerHTML = "Email  already exists.";

                    //
                    break;
                case "false":
                    msg.style.display = "block";
                    msg.style.color = "green";
                    msg.innerHTML = "Email  Available";
                    document.getElementById("<%=btnUpdate.ClientID %>").disabled = false;

                    break;
            }
        }


    </script>
</asp:Content>
