<%@ Page Title="" Language="C#" MasterPageFile="~/General/UserMaster.Master" AutoEventWireup="true" CodeBehind="AccountSettings.aspx.cs" Inherits="TestArtSell.General.Users.AccountSettings" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="card-header">
        <div class="card-title">Change Password</div>
    </div>
    <div class="card-body">
        <div class="form-group">
            <label for="squareInput">Current pass</label>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                ControlToValidate="txtCurrentPass" errormessege="Please enter your User ID" ValidationGroup="reqField" ForeColor="Red"> *</asp:RequiredFieldValidator>
            <asp:TextBox ID="txtCurrentPass" TextMode="Password" runat="server" class="form-control input-square" placeholder="Current Password"></asp:TextBox>
            <asp:LinkButton ID="LinkButton1" Visible="false" data-toggle="modal" data-target="#ForgetPassModal" runat="server">Forget Password?</asp:LinkButton>

        </div>


        <div class="form-group">
            <label for="pillInput">New Password</label>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server"
                ControlToValidate="txtPass" errormessege="Please enter your User ID" ValidationGroup="reqField" ForeColor="Red"> *</asp:RequiredFieldValidator>
            <asp:TextBox ID="txtPass" TextMode="Password" runat="server" class="form-control input-square" placeholder="Password"></asp:TextBox>

        </div>
        <div class="form-group">
            <label for="pillInput">Confirm Password</label>

            <asp:TextBox ID="txtConfirmPass" TextMode="Password" runat="server" class="form-control input-square" placeholder="Password"></asp:TextBox>
            <asp:CompareValidator ID="CompareValidator1" runat="server"
                ControlToValidate="txtConfirmPass"
                CssClass="ValidationError"
                ControlToCompare="txtPass"
                ErrorMessage="Password did  not Match"
                ToolTip="Password must be the same" ValidationGroup="reqField" ForeColor="red" />
        </div>


    </div>
    <div class="card-action">

        <asp:Button ID="btnChange" runat="server" Text="Change Password" class="btn btn-success" OnClick="btnChange_click" ValidationGroup="reqField" />
        <asp:Button ID="btnCancel" runat="server" Text="Cancel" class="btn btn-danger" />


    </div>

    <!-- Modal -->
    <div class="modal fade" id="ForgetPassModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Modal title</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label for="squareInput">Email</label><label id="lblError" style="color: red; display: none"></label>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server"
                            ControlToValidate="txtEmail" errormessege="Please enter your User ID" ValidationGroup="reqField1" ForeColor="Red"> *</asp:RequiredFieldValidator>

                        <asp:TextBox ID="txtEmail" onkeyup="ValidateEmail()" runat="server" class="form-control input-square" placeholder="Email"></asp:TextBox>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <asp:Button ID="btnRegistration" runat="server" Text="Send" class="btn btn-success" sstyle="enabled:false" OnClick="btnForgetPassClick_Click" ValidationGroup="reqField1" />
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
                 }
             }
    </script>
</asp:Content>
