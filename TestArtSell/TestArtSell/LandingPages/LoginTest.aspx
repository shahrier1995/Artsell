<%@ Page Title="" Language="C#" MasterPageFile="~/LandingPages/LandingMaster.Master" AutoEventWireup="true" CodeBehind="LoginTest.aspx.cs" Inherits="TestArtSell.LandingPages.LoginTest" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
         <section id="primary" class="content-full-width"><!-- **Primary Starts Here** -->
            	<div class="container">
                	<div class="dt-sc-hr-invisible-small"></div>
                	<div class="woocommerce">
                     
                           
                           
    
                              
                     
                        <div class="cart-collaterals">
                            <div class="coupon">
                            	<h3>Login</h3>

                                    <asp:TextBox ID="txtUserID" runat="server" CssClass="input-text" placeholder="User Name"></asp:TextBox>
                                    
                    
                            </div>
                                   <div class="coupon" style="padding-top:10px">
                                    
                                    <asp:TextBox ID="txtPassword" runat="server" CssClass="input-text" placeholder="Password"></asp:TextBox>
                                   
                                

                                                              
                            </div>
                                <div class="coupon" style="padding-top:10px">
                                    
                                  <asp:Button CssClass="dt-sc-button small type2" ID="btnLogin" runat="server" Text="Login" OnClick="btnLogin_Click" />
                                   
                                

                                                              
                            </div>
                         
                                	
                                	
                        </div>
                    </div>
                </div>
                <div class="dt-sc-hr-invisible-small"></div>

            </section><!-- **Primary Ends Here** -->

</asp:Content>
