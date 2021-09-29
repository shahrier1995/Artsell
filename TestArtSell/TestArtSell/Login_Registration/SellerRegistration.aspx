<%@ Page Title="" Language="C#" MasterPageFile="~/Login_Registration/Login-RegistrationMaster.Master" AutoEventWireup="true" CodeBehind="SellerRegistration.aspx.cs" Inherits="TestArtSell.Login_Registration.SellerRegistration" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
          <div class="card-header">
                                <div class="card-title">Seller Registration</div>
                            </div>
                             <div class="card-body">
                                <div class="form-group">
                                    <label for="squareInput">Full Name</label><asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
ControlToValidate="txtUserFullName" errormessege="Please enter your Full Name" ValidationGroup="reqField" ForeColor="Red"> *</asp:RequiredFieldValidator>

                                    <asp:TextBox ID="txtUserFullName" runat="server" class="form-control input-square" placeholder="Full Name"></asp:TextBox>
                                </div>
                                 <div class="form-group">
                                    <label for="squareInput">User ID</label>
                                     <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
ControlToValidate="txtUserID" errormessege="Please enter your User ID" ValidationGroup="reqField" ForeColor="Red"> *</asp:RequiredFieldValidator>
                                     
                                     <%--onchange="UserAvailability()"--%>
                                    <asp:TextBox ID="txtUserID" AutoPostBack="true"  OnTextChanged="txtUserID_TextChanged" runat="server"  class="form-control input-square" placeholder="User ID"></asp:TextBox>
                                    
                                </div>
                                   <div class="form-group">
                                    <label for="squareInput">Email</label>
                                       <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server"
ControlToValidate="txtEmail" errormessege="Please enter your Email" ValidationGroup="reqField" ForeColor="Red"> *</asp:RequiredFieldValidator>
                                         <asp:RegularExpressionValidator ID="RegularExpressionValidator2"
    ControlToValidate="txtEmail" runat="server"
    ErrorMessage="Please type a valid Email"
    ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ForeColor="Red">
     </asp:RegularExpressionValidator >
                                       <%----%>
                                       <%--onchange="UserAvailability()"--%>
                                    <asp:TextBox ID="txtEmail" onkeyup="ValidateEmail()" AutoPostBack="true"  OnTextChanged="txtUserID_TextChanged"  runat="server" class="form-control input-square" placeholder="User Email"></asp:TextBox>
                                        <asp:Label ID="lblEmail" runat="server"></asp:Label> 
                                </div>
                                 <div class="form-group">
                                    <label for="squareInput">Contact Number</label>
                                       <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server"
ControlToValidate="txtContactNumber" errormessege="Please enter your Contact Number" ValidationGroup="reqField" ForeColor="Red"> *</asp:RequiredFieldValidator>
                                     <asp:RegularExpressionValidator ID="RegularExpressionValidator1"
    ControlToValidate="txtContactNumber" runat="server"
    ErrorMessage="Only Numbers allowed"
    ValidationExpression="\d+" ValidationGroup="reqField" ForeColor="Red">
     </asp:RegularExpressionValidator >
                                    <asp:TextBox ID="txtContactNumber" runat="server" class="form-control input-square" placeholder="Contact Number" ></asp:TextBox>
                                </div>
                                <div class="form-group">
                                    <label for="pillInput">Password</label>
                                      <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server"
ControlToValidate="txtPass" errormessege="Please enter your Password" ValidationGroup="reqField" ForeColor="Red"> *</asp:RequiredFieldValidator>
                                    <asp:TextBox ID="txtPass" TextMode="Password" runat="server" class="form-control input-square" placeholder="Password"></asp:TextBox>
                                </div>
                                <div class="form-group">
                                    <label for="pillInput">Confirm Password</label>
                                    <asp:CompareValidator ID="CompareValidator1" runat="server" 
     ControlToValidate="txtConPass"
     CssClass="ValidationError"
     ControlToCompare="txtPass"
     ErrorMessage="Password did  not Match" 
     ToolTip="Password must be the same" ValidationGroup="reqField" ForeColor="red"/>
                                    <asp:Label ID="lblPass" runat="server"></asp:Label>  
                                    <asp:TextBox ID="txtConPass" TextMode="Password" runat="server" class="form-control input-square" placeholder="Confirm Password"></asp:TextBox>
                                </div>

                            </div>
                            <div class="card-action">
                                 <asp:Label ID="lblStatus" runat="server"></asp:Label> <br />
                                <asp:Button ID="btnRegistration" runat="server" Text="Register" class="btn btn-success" sstyle="enabled:false" OnClick="btnRegistration_Click" ValidationGroup="reqField" />
           
                       
                                <asp:Button ID="btnCancel"  runat="server" Text="Cancel" class="btn btn-danger" OnClick="btnCancel_Click"  />
                            </div>
         <script type="text/javascript"> 
			 function DisableButton() {
    document.getElementById("<%=btnRegistration.ClientID %>").disabled = true;
}
window.onbeforeunload = DisableButton;
             var emailError = false;
             var userError = false;
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
     
      
             function UserAvailability() { //This function call on text change. 
                 //console.log("okkk");
            $.ajax({  
                type: "POST",  
                url: "registrationform.aspx/CheckUserID", // this for calling the web method function in cs code.  
                data: '{useroremail: "' + $("#<%=txtUserID.ClientID%>")[0].value + '", useroremail2: "' + $("#<%=txtEmail.ClientID%>")[0].value + '" }',// user name or email value  
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
                data: '{useroremail: "' + $("#<%=txtEmail.ClientID%>")[0].value + '", field: "email" }',// user name or email value  
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
            var msg1 = $("#<%=lblEmail.ClientID%>")[0];
            switch (response.d) {  
                case "true":
                    //console.log(emailError);
                    msg.style.display = "block";  
                    msg.style.color = "red";  
                    msg.innerHTML = "User Name  already exists.";
                    userError = false;
                    msg.style.display = "block";
                    msg.style.color = "red";
                    msg.innerHTML = "Email  already exists.";
                    emailError = false;
                    document.getElementById("<%=btnRegistration.ClientID %>").setAttribute("disabled", "disabled");
                    //
                    break;  
                case "false":
                    //console.log(emailError);
                    msg.style.display = "block";  
                    msg.style.color = "green";  
                    msg.innerHTML = "User Name  Available";
                    document.getElementById("<%=btnRegistration.ClientID %>").disabled = false;
                    
                    
                     //document.getElementById("<%=btnRegistration.ClientID %>").setAttribute("enabled", "enabled");
                    
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
                    emailError = false;
                     document.getElementById("<%=btnRegistration.ClientID %>").setAttribute("disabled", "disabled");
                    //
                    break;  
                case "false":  
                    msg.style.display = "block";  
                    msg.style.color = "green";  
                    msg.innerHTML = "Email  Available";
                    emailError = true;
                    if (userError == true && emailError == true) {
                        document.getElementById("<%=btnRegistration.ClientID %>").disabled = false;
                    }
                    else {
                        document.getElementById("<%=btnRegistration.ClientID %>").disabled = true;
                    }
                    document.getElementById("<%=btnRegistration.ClientID %>").disabled = false;
                    // document.getElementById("<%=btnRegistration.ClientID %>").setAttribute("disabled", "false");
                    
                    break;  
            }  
        }
             window.onbeforeunload = DisableButton;
  
    </script>  
</asp:Content>
