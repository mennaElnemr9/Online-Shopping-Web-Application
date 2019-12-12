<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="adminHome.aspx.cs" Inherits="WebApplication6.adminHome" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="Label1" runat="server" Text="activate vendor"></asp:Label>
            <br />
            <asp:Label ID="Label2" runat="server" Text="vendor user:"></asp:Label>
            <br />
            <asp:TextBox ID="vendoruser" runat="server"></asp:TextBox>
            <br />
            <asp:Button ID="Button1" runat="server" Text="activate" OnClick="activatevend" />
            <br />
            <asp:Label ID="Label3" runat="server" Text="review orders made through the website"></asp:Label>
            <br />
            <asp:Button ID="Button2" runat="server" Text="review" OnClick="ReviewOrders" />
            <br />
            <asp:Label ID="Label4" runat="server" Text="update order status to in process"></asp:Label>
            <br />
            <asp:TextBox ID="orderno" runat="server"></asp:TextBox>
            <br />
            <asp:Button ID="Button3" runat="server" Text="update" OnClick="updateToInprocess" />
            <br />
            <asp:Label ID="Label8" runat="server" Text="create deal"></asp:Label>
            <br />
            <asp:Label ID="Label9" runat="server" Text="deal amount"></asp:Label>
            <br />
            <asp:TextBox ID="dealamount" runat="server" Height="22px"></asp:TextBox>
            <br />
            <asp:Label ID="Label11" runat="server" Text="expirydate"></asp:Label>
            <br />
            <asp:TextBox ID="expirydate" runat="server"></asp:TextBox>
            <br />
            <asp:Button ID="Button5" runat="server" Text="create" OnClick="CreateTodaysDeal" />
            <br />
            <asp:Label ID="Label5" runat="server" Text="add today's deal on product"></asp:Label>
            <br />
            <asp:Label ID="Label6" runat="server" Text="deal id"></asp:Label>
            <br />
            <asp:TextBox ID="dealid" runat="server"></asp:TextBox>
            <br />
            <asp:Label ID="Label7" runat="server" Text="serial no"></asp:Label>
            <br />
            <asp:TextBox ID="serialno" runat="server"></asp:TextBox>
            <br />
            <asp:Button ID="Button4" runat="server" Text="add" OnClick="addTodaysdealonProduct" />
            <br />
            <asp:Label ID="Label12" runat="server" Text="remove deal"></asp:Label>
            <br />
            <asp:Label ID="Label13" runat="server" Text="deal id"></asp:Label>
            <br />
            <asp:TextBox ID="dealidrem" runat="server"></asp:TextBox>
            <br />
            <asp:Button ID="Button6" runat="server" Text="remove deal" OnClick="removeTodaysDeal" />
            <br />
        </div>
    </form>
</body>
</html>
