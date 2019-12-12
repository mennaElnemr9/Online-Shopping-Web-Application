<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="addTelephone.aspx.cs" Inherits="WebApplication6.addTelephone" %>

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
            <asp:TextBox ID="user" runat="server"></asp:TextBox>
            <br />
            <asp:Label ID="Label2" runat="server" Text="telephone"></asp:Label>
            <br />
            <asp:TextBox ID="tele" runat="server"></asp:TextBox>
            <br />
            <asp:Button ID="Button1" runat="server" Text="Add" OnClick="Add" />
            <br />
        </div>
    </form>
</body>
</html>
