<%@ Page Title="" Language="C#" MasterPageFile="~/LandingPages/LandingMaster.Master" AutoEventWireup="true" CodeBehind="OrderCart.aspx.cs" Inherits="TestArtSell.LandingPages.OrderCart" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>


    <script>
      $(document).on("click", "#chkout", function () {

         
            ShowTestMessage();

        });

        //AJAX

        function ShowTestMessage() {

            
            $.ajax({
                type: "GET",
                url: "OrderCart.aspx/CheckLogin",
                data: {},
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    if (data.d == "0") {
                       
                        $("#loginModal").modal('show');
                        $("#login").show();
                        $("#confirm").hide();
                      $("#ContentPlaceHolder1_btnLogin").show();
                        $("#ContentPlaceHolder1_btnConfirm ").hide();
                    }
                    else {
                        
                        $("#loginModal").modal('show');
                        $("#confirm").show();
                        $("#login").hide();
                        $("#ContentPlaceHolder1_btnLogin").hide();
                        $("#ContentPlaceHolder1_btnConfirm ").show();
                    }
                     
                },
                failure: function (response) {
                    alert(response.d);
                }
            });
        }

    </script>
    <style>
         .BigCheckBox input {width:20px; height:20px;    margin-right: 15px;}
        .textbox {
                font-size: 25px;
    font-weight: bold;
    height: 50px;
    color: black;
        }
        .center {
            margin: auto;
            width: 80%;
            
            padding: 10px;
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <section id="primary" class="content-full-width">

        <!-- **Primary Starts Here** -->
        <div class="container">



            <div id="noOrder" style="text-align:center" runat="server">
                <h1>No order has been placed</h1>
                <img src="../images/noCart.png" /><br />
                   <a runat="server" class="dt-sc-button medium type2 with-icon" href="ArtsGallery.aspx"><i class="fa fa-shopping-cart" style="color:white" ></i><span style="color:white">Continue Shopping </span></a>
            </div>
            
            <div class="woocommerce">
                <div id="isOrder" runat="server">
                <table id="tableId"  class=" cart table-responsive" style="overflow-x:auto;">
                    <thead>
                        <tr>
                            <th class="product-thumbnail" style="color:white">Image</th>
                            <th class="product-name" style="color:white">Product</th>
                            <th class="product-price " style="color:white">Price</th>


                            <th class="product-remove" style="color:white">Remove</th>
                        </tr>
                    </thead>

                    <tbody>

                        <asp:Repeater ID="rptOrder" runat="server">
                            <ItemTemplate>
                                <tr class="cart_table_item">

                                    <!-- The thumbnail -->
                                    <td class="product-thumbnail" style="width: 10%; height: 50%; padding: 5px">
                                        <a href="ArtDetails.aspx?PhotoID=<%#Eval("ID") %>">
                                            <img src='<%#Eval("ItemPhoto") %>' class="attachment-shop_thumbnail wp-post-image" alt="T_7_front" /></a>
                                    </td>

                                    <!-- Product Name -->
                                    <td class="product-name" style="padding: 5px;">
                                        <h6><a href="ArtDetails.aspx?PhotoID=<%#Eval("ID") %>"><%#Eval("ItemTitle") %></a></h6>
                                    </td>

                                    <!-- Product price -->
                                    <td class="product-price" style="padding: 5px;">
                                        <span class="amount"><%#Eval("ItemPrice") %> BDT</span>
                                    </td>


                                    <td class="product-remove" style="padding: 5px;">
          
                                        <a href="#" id="rptAnc" class="remove" title="Remove this item" data-itemid="'<%#Eval("ID") %>'" data-toggle="modal" data-target="#myModal">&times; 
                                            <label id="lblID" style="display: none"></label>
                                        </a></td>
                                </tr>
                                <!-- Modal -->
                                <div class="modal fade" id="myModal" role="dialog">
                                    <div class="modal-dialog">

                                        <!-- Modal content-->
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <button type="button" class="close" data-dismiss="modal">&times;</button>
                                                <h4 class="modal-title" style="color:black">Do you wat to delete this item?</h4>
                                            </div>



                                            <div class="modal-body" style="color: black">

                                                <div class="row">
                                                    <div class="col-md-4">
                                                        <h6  style="color:black ; margin:0px;">Item</h6>
                                                        <img src='<%#Eval("ItemPhoto") %>' class="attachment-shop_thumbnail wp-post-image" alt="T_7_front" /></a>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <h6 style="color:black ; margin:0px;">Item Title</h6>
                                                        <span class="amount"> <%#Eval("ItemTitle") %></span>

                                                    </div>
                                                    <div class="col-md-4">
                                                        <h6 style="color:black; margin:0px;">Item Price</h6>
                                                        <span class="amount"> <%#Eval("ItemPrice") %> BDT</span>
                                                    </div>
                                                </div>

                                            </div>



                                            <div class="modal-footer">
                               

                                                <asp:Button ID="btnLogout" OnCommand="deleteITem" CommandArgument='<%#Eval("ID") %>'  ForeColor="White" CssClass="dt-sc-button small type2" runat="server" Text="Delete" />
         

                                                <button type="button" class="dt-sc-button small type2" style="color:white" data-dismiss="modal">Close</button>
                                            </div>
                                        </div>

                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </tbody>
                </table>
                         <div class="cart-collaterals">

                    <div class="cart_totals">
                        <h3>Cart Totals</h3>
                        <table>
                            <tbody>

                                <tr class="cart-subtotal">
                                    <th>Cart Subtotal</th>
                                    <td><span class="amount">
                                        <asp:Label ID="totalLabel" runat="server" Text=""></asp:Label> BDT
                                    </span></td>
                                </tr>
                             
                                <tr class="shipping">
                                    <th>Shipping</th>
                                    <td><span class="amount">
                                        <asp:Label ID="deliveryCharge" runat="server" Text="60"></asp:Label> BDT
                                    </span></td>
                                    </tr>

                                    <tr class="total">
                                        <th>Order Price Total</th>
                                        <td><strong><span class="amount">
                                            <asp:Label ID="totalAmount" runat="server" Text=""></asp:Label> BDT</span></strong></td>
                                    </tr>
                            </tbody>
                        </table>
                        <a runat="server" class="dt-sc-button medium type2 with-icon" href="ArtsGallery.aspx"><i class="fa fa-shopping-cart" style="color:white"></i><span style="color:white">Continue Shopping </span></a>
                        <a  id="chkout" class="dt-sc-button medium type2 with-icon" href="#" ><i class="fa fa-shopping-cart" style="color:white"></i><span style="color:white">Proceed to Checkout </span></a>
                    </div>
                </div>
                </div>
  

           
            </div>
            <div class="modal fade" id="loginModal" role="dialog">
                    <div class="modal-dialog">
                        <!-- Modal content-->
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <%--    <h4 class="modal-title">Sign in for confirmation</h4>--%>
                            </div>
                            <div class="modal-body" style="color: black">
                                <div id="login">
                                 
                                    <div class="cart-collaterals">
                                        <div class="center">
                                            <div class="">
                                                <h3 style="color: black;">Login</h3>
                                                      <h6 style="color:black;text-align:left">User ID</h6>
                                                <asp:TextBox ID="txtUserID" runat="server" Height="50" Font-Size="25px" Font-Bold="true" ForeColor="#581845" CssClass="form-control" placeholder="User Name"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="rfvEmail" runat="server"

ControlToValidate="txtUserID" errormessege="Please enter your User ID" ValidationGroup="reqField" ForeColor="Red">please give UserID </asp:RequiredFieldValidator>
                                            </div>
                                            <div class="" style="padding-top: 10px;">
                                                      <h6 style="color:black;text-align:left">Password</h6>
                                                <asp:TextBox ID="txtPassword" TextMode="Password" Height="50" Font-Size="25px" Font-Bold="true" ForeColor="#581845" runat="server" CssClass="form-control" placeholder="Password"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"

ControlToValidate="txtPassword" errormessege="Please enter your User ID" ValidationGroup="reqField" ForeColor="Red"> please give Password</asp:RequiredFieldValidator>
                                            </div>
                                        </div>
                                       

                                    </div>
                         
                                </div>
                                <div id="confirm">
                                    <h3 style="color:black;text-align:center">Order Details</h3>
                                    <h6 style="color:black;text-align:left;margin:0px">Order reciever name</h6>
                                                  <asp:TextBox ID="txtName"  runat="server" Height="50" Font-Size="25px" Font-Bold="true" ForeColor="#581845" CssClass="form-control" placeholder="Password"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"

ControlToValidate="txtName" errormessege="Please give full name" ValidationGroup="reqConField" ForeColor="Red">Please give full name</asp:RequiredFieldValidator>
                                    <h6 style="color:black;text-align:left;margin:0px">Order reciever Contact number</h6>
                                                      <asp:TextBox ID="txtContact" Enabled="false"  runat="server" Height="50" Font-Size="25px" Font-Bold="true" ForeColor="#581845" CssClass="form-control" placeholder="Password"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server"

ControlToValidate="txtContact" errormessege="Please give a contact number" ValidationGroup="reqConField" ForeColor="Red">Please give a contact number</asp:RequiredFieldValidator>
                                    <h6 style="color:black;text-align:left;margin:0px">Order reciever address</h6>
                                   <%-- <textarea id="txtAddress" cols="20" rows="2" runat="server" style=" font-size:25px;font-weight:bold ;color:#581845;"></textarea>--%>
                                   <asp:TextBox id="txtAddress" TextMode="multiline" Columns="20" Rows="3" runat="server"  Font-Size="25px" Font-Bold="true" ForeColor="#581845" />
                                               <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server"

ControlToValidate="txtAddress" errormessege="Please give an address" ValidationGroup="reqConField" ForeColor="Red"> Please give an address</asp:RequiredFieldValidator>
                                    <div class="row" style="margin:0px ;padding-bottom:10px;">
                                    <asp:CheckBox CssClass="BigCheckBox" ID="CkhBAdd" Font-Size="19px" Font-Bold="true" ForeColor="#581845" runat="server" Text="     Update this address to your profile"/>  
                                     </div><table id="tblOrder"  class=" cart table-responsive" style="overflow-x:auto;">
                    <thead>
                        <tr>
                            <th class="product-thumbnail" style="color:white">Image</th>
                            <th class="product-name" style="color:white">Product</th>
                            <th class="product-price " style="color:white">Price</th>


                           
                        </tr>
                    </thead>

                    <tbody>
                                         <asp:Repeater ID="rptConfrmOrder" runat="server">
                            <ItemTemplate>
                                            <tr class="cart_table_item" style="background:white;">

                                    <!-- The thumbnail -->
                                    <td class="product-thumbnail" style=" border-style:none;width: 10%; height: 50%; padding: 0px;margin:0px; background-color:white">
                                        <a href="ArtDetails.aspx?PhotoID=<%#Eval("ID") %>">
                                            <img src='<%#Eval("ItemPhoto") %>' style="width:80px" class="attachment-shop_thumbnail wp-post-image" alt="T_7_front" /></a>
                                    </td>

                                    <!-- Product Name -->
                                    <td class="product-name"style="padding: 5px; margin:0px;border-style:none; background-color:white">
                                        <h6 style="margin:0px;"><a href="ArtDetails.aspx?PhotoID=<%#Eval("ID") %>"><%#Eval("ItemTitle") %></a></h6>
                                    </td>

                                    <!-- Product price -->
                                    <td class="product-price" style="padding:5px; text-align:center; border-style:none;margin:0px; background-color:white">
                                        <span class="amount"><%#Eval("ItemPrice") %> BDT</span>
                                    </td>


                              
                                </tr>
                                </ItemTemplate></asp:Repeater>
                        <tr style="border-style:none">
                             <td class="product-name"style="padding: 5px; margin:0px; background-color:white;border-top:1px solid">
                                        <h6 style="margin:0px;"></h6>
                                    </td>
                             <td class="product-name"style="padding: 5px; margin:0px; background-color:white;border-top:1px solid">
                                        <h6 style="margin:0px;">TOTAL (including delivery charge)</h6>
                                    </td>
                             <td class="product-name"style="padding: 5px; margin:0px; background-color:white;border-top:1px solid">
                                        <h6 runat="server" id="txtOrderTotal" style="margin:0px;">20</h6>
                                    </td>
                        </tr>
                        </tbody>
                                         </table>
                                    <h3 style="color:black;text-align:center">Are you sure to place the order?</h3>

                                </div>
                                

                            </div>



                            <div class="modal-footer">
                                <asp:Button CssClass="dt-sc-button small type2" ForeColor="White" ID="btnLogin" runat="server" Text="Login"  ValidationGroup="reqField" OnClick="btnLogin_Click" />
                                <asp:Button CssClass="dt-sc-button small type2"  ForeColor="White" ID="btnConfirm" runat="server" Text="Yes" OnClick="btnConfirm_Click" ValidationGroup="reqConField"  />
                                <button type="button" class="dt-sc-button small type2" data-dismiss="modal" style="color:white">Close</button>
                            </div>
                        </div>

                    </div>
                </div>
        </div>
        

    </section>
    <!-- **Primary Ends Here** -->
    

</asp:Content>
