<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<MvcApplication10.Models.GameAddModel>" %>

<asp:Content ID="GameContent" ContentPlaceHolderID="AddingGame" runat="server">
    <link href="./Content/Style.css" rel="stylesheet" />
    <script src="./Scripts/jquery-1.9.1.min.js"></script>
    <script src="./Scripts/Common.js"></script>

    <script type="text/javascript">
        $(window).load(function () { AdminBttnBind(); });
    </script>
    
    <section id="AddingGameForm">
    <% using (Html.BeginForm(new { ReturnUrl = ViewBag.ReturnUrl })) { %>
        <fieldset class="AddGameFieldSet">
            <legend>Adding Game Form</legend>
            <ol>
                <table cellpadding="0" cellspacing="0" class="AddingGameContainer">
                    <tr>
                        <td class="LabelBox">
                            <%: Html.LabelFor(m => m.GameName) %>
                        </td>
                        <td>
                            <%: Html.TextBoxFor(m => m.GameName) %>
                        </td>
                    </tr>
                    <tr>
                        <td class="LabelBox">
                            <%: Html.LabelFor(m => m.GameDescription) %>
                        </td>
                        <td>
                            <%: Html.TextAreaFor(m => m.GameDescription, new { @class = "DescriptionBox" }) %>
                        </td>
                    </tr>
                    <tr>
                        <td class="LabelBox">
                            <%: Html.LabelFor(m => m.ImageUrl) %>
                        </td>
                        <td>
                            <input type="file" name="image" id="photo" />
                        </td>
                    </tr>
                    <tr>
                        <td class="LabelBox">
                            <%: Html.LabelFor(m => m.GamePrice) %>
                        </td>
                        <td>
                            <%: Html.TextBoxFor(m => m.GamePrice) %>
                        </td>
                    </tr>
                </table>
            </ol>
            <input type="submit" name="button" value="Add Game" />
        </fieldset>
    <% } %>
    </section>
</asp:Content>

<asp:Content ID="UsersContent" ContentPlaceHolderID="AddingUsers" runat="server">
    <section id="AddingUsersForm">
    <% using (Html.BeginForm(new { ReturnUrl = ViewBag.ReturnUrl })) { %>
        <fieldset class="AddGameFieldSet">
            <legend>Adding Users Form</legend>
            <ol>
                <table cellpadding="0" cellspacing="0" class="AddingGameContainer">
                    <tr>
                        <td class="LabelBox">
                            <%: Html.LabelFor(m => m.UserName) %>
                        </td>
                        <td>
                            <%: Html.TextBoxFor(m => m.UserName) %>
                        </td>
                    </tr>
                    <tr>
                        <td class="LabelBox">
                            <%: Html.LabelFor(m => m.UserPassword) %>
                        </td>
                        <td>
                            <%: Html.PasswordFor(m => m.UserPassword) %>
                        </td>
                    </tr>
                    <tr>
                        <td class="LabelBox">
                            <%: Html.LabelFor(m => m.UserEmail) %>
                        </td>
                        <td>
                            <%: Html.TextBoxFor(m => m.UserEmail) %>
                        </td>
                    </tr>
                    <tr>
                        <td class="LabelBox">
                            <%: Html.LabelFor(m => m.CreditCard) %>
                        </td>
                        <td>
                            <%: Html.TextBoxFor(m => m.CreditCard) %>
                        </td>
                    </tr>
                </table>
            </ol>
            <input type="submit" name="button" value="Add User" />
        </fieldset>
    <% } %>
    </section>
</asp:Content>

<asp:Content runat="server" ID="GridSwitcher" ContentPlaceHolderID="GridSwitcher">
    <section id="SwitchingGrids">
    <% using (Html.BeginForm(new {ReturnUrl = ViewBag.ReturnUrl})) { %>
        <table cellpadding="0" cellspacing="0" style="margin: 5px;">
            <tr>
                <td>
                    <div ID="GamesList" class="GamesList">Game List:</div>
                </td>
                <td>
                    <div ID="UsersList" class="UsersList">Users List:</div>
                </td>
            </tr>
        </table>
    <% } %>
    </section>
</asp:Content>

<asp:Content runat="server" ID="UsersGrid" ContentPlaceHolderID="UsersGrid">
    <asp:GridView runat="server" ID="UserList" DataSourceID="UserListFromDB" AllowSorting="True" AllowPaging="True" PageSize="15" AutoGenerateColumns="False" AutoGenerateEditButton="False" Width="100%">
        <FooterStyle ForeColor="#000066" BackColor="White"></FooterStyle>
        <PagerStyle ForeColor="#000066" HorizontalAlign="Left" BackColor="White"></PagerStyle>
        <HeaderStyle ForeColor="White" Font-Bold="True" BackColor="#006699"></HeaderStyle>
        <Columns>
            <asp:BoundField HeaderText="User ID" DataField="ID">
                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="60px"></ItemStyle>
            </asp:BoundField>
            <asp:TemplateField HeaderText="User Name">
                <ItemTemplate>
                    <asp:TextBox ID="TextBox9" runat="server" TextMode="MultiLine" Width="200px" Rows="1" Text=' <%# Eval("Name") %>' style="resize: none; border: none; outline: none" />
                </ItemTemplate>
                <ItemStyle VerticalAlign="Top"></ItemStyle>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="User Password">
                <ItemTemplate>
                    <asp:TextBox ID="TextBox10" runat="server" TextMode="MultiLine" Width="99%" Rows="1" Text=' <%# Eval("Password") %>' style="resize: vertical; border: none; outline: none" />
                </ItemTemplate>
                <ItemStyle VerticalAlign="Top"></ItemStyle>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="User Email">
                <ItemTemplate>
                    <asp:TextBox ID="TextBox10" runat="server" TextMode="MultiLine" Width="99%" Rows="1" Text=' <%# Eval("Emai") %>' style="resize: vertical; border: none; outline: none" />
                <ItemStyle HorizontalAlign="Center"></ItemStyle>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Is Admin">
                <ItemTemplate>
                    <asp:TextBox ID="TextBox10" runat="server" TextMode="MultiLine" Width="99%" Rows="1" Text=' <%# Eval("isAdmin") %>' style="resize: vertical; border: none; outline: none" />
                <ItemStyle HorizontalAlign="Center"></ItemStyle>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Delete">
	            <ItemTemplate>
		            <asp:Button ID="deleteButton2" runat="server" CommandName="Delete2" Text="Delete" OnClientClick="return confirm('Are you sure you want to delete this user?');" />
	            </ItemTemplate>
                <ItemStyle Width="60px"></ItemStyle>
            </asp:TemplateField>
        </Columns>
        <SelectedRowStyle ForeColor="White" Font-Bold="True" BackColor="#669999"></SelectedRowStyle>
        <RowStyle ForeColor="#000066"></RowStyle>
    </asp:GridView>
    <asp:ObjectDataSource runat="server" ID="UserListFromDB" SelectMethod="GetData"  TypeName="MvcApplication10.Models.AdminMain">
    </asp:ObjectDataSource>
</asp:Content>

<asp:Content runat="server" ID="GameGrid" ContentPlaceHolderID="GameGrid">
    <asp:GridView runat="server" ID="GameList" DataSourceID="GameListFromDB" AllowPaging="True" PageSize="15" AutoGenerateColumns="False" AutoGenerateEditButton="False" Width="100%">
        <FooterStyle ForeColor="#000066" BackColor="White"></FooterStyle>
        <PagerStyle ForeColor="#000066" HorizontalAlign="Left" BackColor="White"></PagerStyle>
        <HeaderStyle ForeColor="White" Font-Bold="True" BackColor="#006699"></HeaderStyle>
        <Columns>
            <asp:BoundField HeaderText="Game ID" DataField="ProductID">
                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="60px"></ItemStyle>
            </asp:BoundField>
            <asp:TemplateField HeaderText="Game Name">
                <ItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" TextMode="MultiLine" Width="200px" Rows="3" Text=' <%# Eval("Name") %>' style="resize: none; border: none; outline: none" />
                </ItemTemplate>
                <ItemStyle VerticalAlign="Top"></ItemStyle>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Game Description">
                <ItemTemplate>
                    <asp:TextBox ID="TextBox2" runat="server" TextMode="MultiLine" Width="99%" Rows="5" Text=' <%# Eval("Description") %>' style="resize: vertical; border: none; outline: none" />
                </ItemTemplate>
                <ItemStyle Width="100%" VerticalAlign="Top"></ItemStyle>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Game Image">
                <ItemTemplate>
                    <asp:Image ID="testingIm" runat="server" ImageUrl='<%# Eval("ImageUrl", "~/{0}")%>' Width="100px" Height="100px"/>
                <ItemStyle Width="100%" HorizontalAlign="Center"></ItemStyle>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Game Price">
                <ItemTemplate>
                    <asp:TextBox ID="TextBox3" runat="server" Text='<%# Eval("Price", "$ {0}")%>' Width="40px"/>
                <ItemStyle Width="100%" HorizontalAlign="Center"></ItemStyle>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Delete">
	            <ItemTemplate>
		            <asp:Button ID="deleteButton" runat="server" CommandName="Delete" Text="Delete" OnClientClick="return confirm('Are you sure you want to delete this game?');" />
	            </ItemTemplate>
            </asp:TemplateField>
        </Columns>
        <SelectedRowStyle ForeColor="White" Font-Bold="True" BackColor="#669999"></SelectedRowStyle>
        <RowStyle ForeColor="#000066"></RowStyle>
    </asp:GridView>
    <asp:SqlDataSource runat="server" ID="GameListFromDB" 
        SelectCommand="SELECT * FROM Products ORDER BY ProductID"
        ConnectionString="<%$ connectionStrings:MyBase %>">
    </asp:SqlDataSource>
</asp:Content>
