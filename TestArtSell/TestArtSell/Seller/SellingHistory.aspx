<%@ Page Language="C#" MasterPageFile="~/General/UserMaster.Master" AutoEventWireup="true" CodeBehind="SellingHistory.aspx.cs" Inherits="TestArtSell.Seller.SellingHistory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>

    <script type="text/javascript">
     
    </script>
    <style>
        .orderlist:hover {
            box-shadow: 0 0 11px rgba(33,33,33,.2);
            border-right: 2px solid darkcyan;
        }

        .cust {
            border-radius: 10px;
            text-decoration: none;
            cursor: pointer;
        }
        .cust:hover {
            box-shadow: 0 0 11px rgba(33,33,33,.2);
        }

        .cust-a {
            text-decoration: none;
            cursor: pointer;
        }

        .cust-a:hover {
            text-decoration: none;
            cursor: pointer;
            
        }
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="card">
        <div class="card-header">
            <strong class="card-title pull-left">Selling History</strong>

            <asp:DropDownList ID="ddlMonth" runat="server" class="form-control pull-right" Width="40%" AutoPostBack="true" OnSelectedIndexChanged="OnSelectedIndexChanged">
                <asp:ListItem Selected="True" Value="0">--Select month--</asp:ListItem>
                <asp:ListItem Value="1">January</asp:ListItem>
                <asp:ListItem Value="2">February</asp:ListItem>
                <asp:ListItem Value="3">March</asp:ListItem>
                <asp:ListItem Value="4">April</asp:ListItem>
                <asp:ListItem Value="5">May</asp:ListItem>
                <asp:ListItem Value="6">June</asp:ListItem>
                <asp:ListItem Value="7">July</asp:ListItem>
                <asp:ListItem Value="8">August</asp:ListItem>
                <asp:ListItem Value="9">September</asp:ListItem>
                <asp:ListItem Value="10">October</asp:ListItem>
                <asp:ListItem Value="11">November</asp:ListItem>
                <asp:ListItem Value="12">December</asp:ListItem>
            </asp:DropDownList>
        </div>
        <div class="card-body" style="padding: 0" runat="server" id="bodyDiv">
            <div class="container" style="padding-top:10px">
            <div class="row">
                <!-- Earnings (Monthly) Card Example -->

                <div class="col-xl-3 col-md-6 mb-6">

                    <a href="#" runat="server" onserverclick="OnWorthClick" class="cust-a">
                        <div class="card shadow h-100 py-2 cust" style="border-radius: 10px">
                            <div class="card-body">
                                <div class="row no-gutters align-items-center">
                                    <div class="col mr-2">
                                        <div class="text-xs font-weight-bold text-info text-uppercase mb-1">Selling Target</div>
                                        <div class="row no-gutters align-items-center">
                                            <div class="col-auto">
                                                <asp:Label ID="lblPercentage" CssClass="h5 mb-0 mr-3 font-weight-bold text-gray-800" runat="server" Text="Label"></asp:Label>

                                            </div>
                                            <div class="col">
                                                <div class="progress progress-sm mr-2">
                                                    <div class="progress-bar bg-info" role="progressbar" runat="server" id="lblprog" style="width: 80%" aria-valuemin="0" aria-valuemax="100"></div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-auto">
                                        <i class="fas fa-clipboard-list fa-2x text-gray-300"></i>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </a>

                </div>

                <!-- Pending Requests Card Example -->
                <div class="col-xl-3 col-md-6 mb-6">
                    <a href="#" runat="server" onserverclick="OnWorthClick" class="cust-a">
                        <div class="card border-left-info shadow h-100 py-2 cust">
                            <div class="card-body">
                                <div class="row no-gutters align-items-center">
                                    <div class="col mr-2">
                                        <div class="text-xs font-weight-bold text-warning text-uppercase mb-1">Total Worth</div>
                                        <asp:Label ID="lblAmount" runat="server" CssClass="h5 mb-0 font-weight-bold text-gray-800" Text="18"></asp:Label>
                                        <%--      <div class="h5 mb-0 font-weight-bold text-gray-800">18</div>--%>
                                    </div>
                                    <div class="col-auto">
                                        <i class="fas fa-comments fa-2x text-gray-300"></i>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </a>
                </div>


                <div class="col-xl-3 col-md-6 mb-6">
                    <a href="#" runat="server" onserverclick="OnSoldClick" class="cust-a">
                        <div class="card border-left-info shadow h-100 py-2 cust">
                            <div class="card-body">
                                <div class="row no-gutters align-items-center">
                                    <div class="col mr-2">
                                        <div class="text-xs font-weight-bold text-warning text-uppercase mb-1">Total Sold</div>
                                        <asp:Label ID="lblSold" runat="server" CssClass="h5 mb-0 font-weight-bold text-gray-800" Text="18"></asp:Label>
                                        <%--      <div class="h5 mb-0 font-weight-bold text-gray-800">18</div>--%>
                                    </div>
                                    <div class="col-auto">
                                        <i class="fas fa-comments fa-2x text-gray-300"></i>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </a>
                </div>


                <div class="col-xl-3 col-md-6 mb-6">
                    <a href="#" runat="server" onserverclick="OnYetClick" class="cust-a">
                        <div class="card border-left-info shadow h-100 py-2 cust">
                            <div class="card-body">
                                <div class="row no-gutters align-items-center">
                                    <div class="col mr-2">
                                        <div class="text-xs font-weight-bold text-warning text-uppercase mb-1">Yet To Sell</div>
                                        <asp:Label ID="lblLeft" runat="server" CssClass="h5 mb-0 font-weight-bold text-gray-800" Text="18"></asp:Label>
                                        <%--      <div class="h5 mb-0 font-weight-bold text-gray-800">18</div>--%>
                                    </div>
                                    <div class="col-auto">
                                        <i class="fas fa-comments fa-2x text-gray-300"></i>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </a>
                </div>
            </div>
                </div>
            <hr />

            <div class="row">
                <div class="col-md-12">
                    <table class="table table-sm table-bordered" style="width: 100%;">
                        <thead style="background-color:#ffe6cc">
                            <tr>
                                <th scope="col">Sl</th>
                                <th scope="col">Art</th>
                                <th scope="col">Item</th>
                                <th scope="col">Details</th>
                                <th scope="col">Price</th>

                            </tr>
                        </thead>
                        <tbody>
                            <asp:Repeater ID="rptiteminfo" runat="server">

                                <ItemTemplate>
                                    <tr>
                                        <td><%#  Container.ItemIndex + 1 %></td>
                                        <td>
                                            <img src='<%#Eval("ITEMPHOTO") %>' alt="" width="80" height="60" /></td>
                                        <td><%#Eval("ItemTitle") %></td>
                                        <td><%#Eval("ItemDetails") %></td>
                                        <td><%#Eval("ItemPrice") %></td>
                                    </tr>

                                </ItemTemplate>
                            </asp:Repeater>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
