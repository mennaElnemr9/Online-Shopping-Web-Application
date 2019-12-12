<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="customer1.aspx.cs" Inherits="WebApplication6.customer1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Button ID="Button1" runat="server" Text="view list of products" />
            <br />
            <asp:Label ID="Label1" runat="server" Text="create wishlist"></asp:Label>
            <br />
            <asp:Label ID="Label3" runat="server" Text="wishlist name"></asp:Label>
            <br />
            <asp:TextBox ID="wishname" runat="server"></asp:TextBox>
            <br />
            <asp:Button ID="Button2" runat="server" Text="create" OnClick="createWishList" />
        
        </div>
    </form>
</body>
</html>
