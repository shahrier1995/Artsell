<%@ Page Language="C#" MasterPageFile="~/Admin/AdminMaster.Master" AutoEventWireup="true" CodeBehind="UsersList.aspx.cs" Inherits="TestArtSell.Admin.UsersList" %>

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
    <asp:UpdatePanel runat="server" ID="updatepanel1">
        <ContentTemplate>
            <div class="card" style="border-radius:10px">
                <div class="card-header">
                    <h5>All Users List </h5>
                    <div class="row">

                        <div class="col-md-4">
                            <label for="ddlStatus">Filter by User Status</label>
                            <asp:DropDownList runat="server" ID="ddlStatus" CssClass="form-control" OnSelectedIndexChanged="ddlStatus_SelectedIndexChanged" AutoPostBack="true">
                                <asp:ListItem Text="--All Status--" Value="0"></asp:ListItem>
                                <asp:ListItem Text="Requested" Value="RE"></asp:ListItem>
                                <asp:ListItem Text="Active" Value="AC"></asp:ListItem>
                                <asp:ListItem Text="Deactivated" Value="DE"></asp:ListItem>
                                <asp:ListItem Text="Canceled" Value="CA"></asp:ListItem>

                            </asp:DropDownList>
                        </div>
                        <div class="col-md-4">
                        </div>
                        <div class="col-md-4">
                            <label for="txtSearch">Search Order</label>
                            <input type="text" id="txtSearch" class="form-control" placeholder="Search by Order ID" onkeyup="searchTable()" />
                        </div>
                    </div>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-12">
                            <asp:Repeater ID="rptUsers" runat="server">
                                <HeaderTemplate>
                                    <table id="dataTablesExample" class="table table-bordered  table-hover table-sm">
                                        <tr style="background-color: moccasin">
                                            <th scope="col" style="width: 80px">S/L
                                            </th>
                                            <th scope="col" style="width: 120px">Full Name
                                            </th>
                                            <th scope="col" style="width: 100px">User ID
                                            </th>
                                            <th scope="col" style="width: 100px">Password
                                            </th>
                                            <th scope="col" style="width: 100px">Contact
                                            </th>
                                            <th scope="col" style="width: 100px">Email
                                            </th>
                                            <th scope="col" style="width: 100px">Gender
                                            </th>
                                            <th scope="col" style="width: 100px">Type
                                            </th>
                                            <th scope="col" style="width: 100px">Status
                                            </th>
                                            <th scope="col" style="width: 100px">Action
                                            </th>
                                        </tr>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <tr class="ok" style='<%# Eval("USERSTATUS").ToString() == "Deactivated" ? "background-color:#ffe6e6": "" + ";" %>'>
                                        <td>
                                            <asp:Label ID="lblRowNumber" Text='<%# Container.ItemIndex + 1 %>' runat="server" />
                                        </td>
                                        <td>
                                            <%# Eval("USERFULLNAME") %>
                                        </td>
                                        <td>
                                            <%# Eval("USERID") %>
                                        </td>
                                        <td>
                                            <%# Eval("USERPASSWORD") %>
                                        </td>
                                        <td>
                                            <%# Eval("USERCONTACT") %>
                                        </td>
                                        <td>
                                            <%# Eval("USEREMAIL") %>
                                        </td>
                                        <td>
                                            <%# Eval("USERGENDER") %>
                                        </td>
                                        <td>
                                            <%# Eval("USERTYPE") %>
                                        </td>
                                        <td>
                                            <%# Eval("USERSTATUS") %>
                                        </td>
                                        <td>
                                            <asp:LinkButton CssClass="btn btn-sm btn-primary" runat="server" ID="btnApprove" CommandArgument='<%# Eval("USERID") %>' OnCommand="ApproveUser" Text="✔" ToolTip="Approve User"></asp:LinkButton>
                                            <asp:LinkButton CssClass="btn btn-sm btn-danger" runat="server" ID="btnDeactivate" CommandArgument='<%# Eval("USERID") %>' OnCommand="DeactivateUser" Text="X" ToolTip="Deactivate User"></asp:LinkButton>
                                        </td>
                                    </tr>
                                </ItemTemplate>
                                <FooterTemplate>
                                    </table>
                                </FooterTemplate>
                            </asp:Repeater>
                        </div>
                    </div>

                </div>

            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
