<%@ Page Language="C#" MasterPageFile="~/Admin/AdminMaster.Master" AutoEventWireup="true" CodeBehind="CategorySetup.aspx.cs" Inherits="TestArtSell.Admin.CategorySetup" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server" >
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
<h6>
    Category Setup
</h6>


    
    <asp:UpdatePanel runat="server" ID="updatepanel1">
        <ContentTemplate>
            <div class="form-inline">
                <div class="input-group mb-2 mr-sm-2">
                    <div class="input-group-prepend">
                        <div class="input-group-text">Title</div>
                    </div>
                    <asp:TextBox  CssClass="form-control" id="txtTitle" placeholder="Write Category Title" runat="server"></asp:TextBox>
                </div>
                <div class="input-group mb-2 mr-sm-2" style="width: 60%">
                    <div class="input-group-prepend">
                        <div class="input-group-text">Details</div>
                    </div>
                    <input type="text" class="form-control" id="txtDetails" placeholder="Write Category Details">
                </div>
                <asp:LinkButton ID="btnDipo"  CssClass="btn btn-primary mb-2" runat="server" OnClick="btnDipo_Click" >Submit</asp:LinkButton>
            </div>
          
                    <div class="row">
                        <div class="col-md-12">
                            <asp:Repeater ID="rptUsers" runat="server">
                                <HeaderTemplate>
                                    <table id="dataTablesExample" class="table table-bordered  table-hover table-sm">
                                        <tr style="background-color: moccasin">
                                            <th scope="col" style="width: 80px">S/L
                                            </th>
                                            <th scope="col" style="width: 120px">Title
                                            </th>
                                            <th scope="col" style="width: 100px">Details
                                            </th>
                                            <th scope="col" style="width: 100px">Status
                                            </th>
                                             <th scope="col" style="width: 100px">Actions
                                            </th>
                                        </tr>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <tr class="ok"  style="background-color:white;">
                                        <td>
                                            <asp:Label ID="lblRowNumber" Text='<%# Container.ItemIndex + 1 %>' runat="server" />
                                        </td>
                                        <td>
                                            <%# Eval("CatTitle") %>
                                        </td>
                                        <td>
                                            <%# Eval("CatDetails") %>
                                        </td>
                                        <td>
                                            <%# Eval("Status") %>
                                        </td>
                                        <td>
                                            <asp:LinkButton CssClass="btn btn-sm btn-danger" runat="server" ID="btnDeactivate" CommandArgument='<%# Eval("ID") %>' OnCommand="DeactivateUser" Text="Delete" ToolTip="Deactivate User" Style="height:20px;padding:0;padding:1px 3px 3px 3px;width:30%;"></asp:LinkButton>
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
</asp:Content>