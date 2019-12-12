<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="WebApplication6.login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
             <div>
            <asp:Label ID="Label1" runat="server" Text="username"></asp:Label>
            <br />
            <asp:TextBox ID="username" runat="server"></asp:TextBox>
            <br />
            <asp:Label ID="Label2" runat="server" Text="password"></asp:Label>
            <br />
            <asp:TextBox ID="password" runat="server"></asp:TextBox>
            <br />
            <asp:Button ID="Button1" runat="server" Text="login" OnClick="LogIn" />
            <asp:Button ID="Button2" runat="server" Text="I don't have an account" OnClick="goToRegister" />
            <br />
        </div>
        </div>
    </form>
</body>
</html>
