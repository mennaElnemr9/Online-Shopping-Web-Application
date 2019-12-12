<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="register.aspx.cs" Inherits="WebApplication6.register" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="Label1" runat="server" Text="username"></asp:Label>
            <br />
            <asp:TextBox ID="username" runat="server"></asp:TextBox>
            <br />
            <asp:Label ID="Label2" runat="server" Text="email"></asp:Label>
            <br />
            <asp:TextBox ID="emailtext" runat="server"></asp:TextBox>
            <br />
            <asp:Label ID="Label3" runat="server" Text="password"></asp:Label>
            <br />
            <asp:TextBox ID="password" runat="server"></asp:TextBox>
            <br />
            <br />
            <asp:Button ID="Button1" runat="server" Text="customer register" OnClick="cRegister" />
            <asp:Button ID="Button2" runat="server" Text="vendor register" OnClick="vRegister" />
            <asp:Button ID="Button3" runat="server" OnClick="goToLogin" Text="I already have an account" />
            <br />
        </div>
    </form>
</body>
</html>
