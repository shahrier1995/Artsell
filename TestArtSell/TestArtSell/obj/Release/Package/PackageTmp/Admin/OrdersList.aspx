<%@ Page Language="C#" MasterPageFile="~/Admin/AdminMaster.Master" AutoEventWireup="true" CodeBehind="OrdersList.aspx.cs" Inherits="TestArtSell.Admin.OrdersList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script>
        function searchTable() {
            var input, filter, found, table, tr, td, i, j, cstCLASS, empCLASS;
            input = document.getElementById("txtSearch");
            filter = input.value.toUpperCase();
            table = document.getElementById("dataTablesExample");
            tr = table.getElementsByClassName("ok");

            for (i = 0; i < tr.length; i++) {
                td = tr[i].getElementsByTagName("td");

                for (j = 0; j < td.length; j++) {
                    if (td[j].innerHTML.toUpperCase().indexOf(filter) > -1) {
                        found = true;
                    }
                }
                if (found) {
                    tr[i].style.display = "";
                    found = false;

                }
                else {
                    tr[i].style.display = "none";

                }
            }
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    


    <div >
        <asp:UpdatePanel runat="server" ID="updatepanel1">
        <ContentTemplate>
              <h5>All Order List </h5>
            <div class="row">
               
                <div class="col-md-4">
                    <label for="ddlStatus"> Filter by</label>
                    <asp:DropDownList runat="server" ID="ddlStatus" CssClass="form-control" OnSelectedIndexChanged="ddlStatus_SelectedIndexChanged" AutoPostBack="true">
                        <asp:ListItem Text="Select Status" Value="0"></asp:ListItem>
                        <asp:ListItem Text="Requested" Value="OR"></asp:ListItem>
                        <asp:ListItem Text="Confirmed" Value="OC"></asp:ListItem>
                        <asp:ListItem Text="Deivered" Value="OD"></asp:ListItem>
                        <asp:ListItem Text="Canceled" Value="OCA"></asp:ListItem>

                    </asp:DropDownList>
                </div>
                <div class="col-md-4">

                </div>
                <div class="col-md-4">
                   <label for="txtSearch"> Search Order</label>
                    <input type="text" id="txtSearch"  class="form-control" placeholder="Search by Order ID" onkeyup="searchTable()" />
                </div>
            </div>
            <hr />
            <div class="row">
                <div class="col-md-12">
                    <asp:Repeater ID="rptOrders" runat="server">
                        <HeaderTemplate>
                            <table id="dataTablesExample" class="table table-bordered  table-hover  table-striped ">
                                <tr style="background-color: moccasin">
                                    <th scope="col" style="width: 80px">S/L
                                    </th>
                                    <th scope="col" style="width: 120px">Order No
                                    </th>
                                    <th scope="col" style="width: 100px">Date
                                    </th>
                                    <th scope="col" style="width: 100px">Status
                                    </th>
                                    <th scope="col" style="width: 100px">Qty
                                    </th>
                                    <th scope="col" style="width: 100px">Total Price
                                    </th>
                                    <th scope="col" style="width: 100px">Ordered By
                                    </th>
                                    <th scope="col" style="width: 100px">Action
                                    </th>
                                </tr>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <tr class="ok">
                                <td>
                                    <asp:Label ID="lblRowNumber" Text='<%# Container.ItemIndex + 1 %>' runat="server" />
                                </td>
                                <td>
                                    <asp:Label ID="lblOrderId" runat="server" Text='<%# Eval("ODRID") %>' />
                                </td>
                                <td>
                                    <asp:Label ID="lblOrderDate" runat="server" Text='<%# Eval("ODRDATE") %>' />
                                </td>
                                <td style='<%# Eval("Status").ToString() == "OR" ? "color:#ff9900": Eval("Status").ToString() == "OC" ? "color:#336600": Eval("Status").ToString() == "OCA" ? "color:#ff4d4d": "-" + ";" %>'>
                                   <span style="font-weight:bold"> <%#Eval("Status").ToString() == "OR" ? "Requested"
                                                : Eval("Status").ToString() == "OC" ? "Confirmed"
                                                : Eval("Status").ToString() == "OD" ? "Delivered"
                                                : Eval("Status").ToString() == "OCA" ? "Canceled"
                                                : "-" %></span>
                                </td>
                                <td>
                                    <asp:Label ID="lblItemQty" runat="server" Text='<%# Eval("ItemQuantity") %>' />
                                </td>
                                <td>
                                   <asp:Label ID="lblItemPrice" runat="server" Text='<%# Eval("TotalPrice") %>' />
                                </td>
                                <td>
                                   <%# Eval("USERID") %>
                                </td>
                                <td>
                                    <asp:LinkButton CssClass="btn btn-sm btn-primary" runat="server" ID="btnApprove" CommandArgument='<%# Eval("ODRID") %>' OnCommand="ApproveOrder" Text="Approve" ToolTip="Approve Order"></asp:LinkButton>
                                </td>
                            </tr>
                        </ItemTemplate>
                        <FooterTemplate>
                            </table>
                        </FooterTemplate>
                    </asp:Repeater>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
    </div>
</asp:Content>
