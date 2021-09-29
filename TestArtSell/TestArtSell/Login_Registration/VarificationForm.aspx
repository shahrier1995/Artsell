<%@ Page Title="" Language="C#" MasterPageFile="~/Login_Registration/Login-RegistrationMaster.Master" AutoEventWireup="true" CodeBehind="VarificationForm.aspx.cs" Inherits="TestArtSell.Login_Registration.VarificationForm" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="card-header">
                                <div class="card-title">Verification</div>
                            </div>
                            <div class="card-body">
                                <div class="form-group">
                                    <label for="squareInput">Verification Code</label><asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
ControlToValidate="txtVariCode" errormessege="Please enter your User ID" ValidationGroup="reqField" ForeColor="Red"> *</asp:RequiredFieldValidator>

                                    <asp:TextBox ID="txtVariCode" runat="server" class="form-control input-square" placeholder="Verification code"></asp:TextBox>
                                </div>
                           

                            </div>
                            <div class="card-action" style="padding:0px 30px 0px 30px">
                                        <asp:Label ID="lblEmailSent" runat="server"></asp:Label> <br />
                                <asp:Button ID="btnVarification" runat="server" Text="Verify" class="btn btn-success" sstyle="enabled:false"  ValidationGroup="reqField" OnClick="btnVarification_Click" />

                                 <asp:Button ID="btnCancel" runat="server" Text="Cancel" class="btn btn-danger" OnClick="btnCancel_Click"  />
                                  <div class="form-group">
                              <asp:LinkButton ID="LinkButton1"  runat="server" OnClick="regLink_Click">Resend Code Again</asp:LinkButton><br />
                               
                                </div>
                            </div>
<%--    <div class="modal fade" id="ForgetPassModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
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
                                    <label for="squareInput">Email</label><label id="lblError" style="color:red; display:none"></label>
                                       <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server"
ControlToValidate="txtEmail" errormessege="Please enter your User ID" ValidationGroup="reqOTPField" ForeColor="Red"> *</asp:RequiredFieldValidator>
                                        
                                    <asp:TextBox ID="txtEmail" onkeyup="ValidateEmail()" runat="server" class="form-control input-square" placeholder="Email"></asp:TextBox>
                                </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
    <asp:Button ID="btnRegistration" runat="server" Text="Send" class="btn btn-success" sstyle="enabled:false" OnClick="btnForgetPassClick_Click" ValidationGroup="reqOTPField" />
      </div>
    </div>
  </div>
</div>--%>

</asp:Content>
