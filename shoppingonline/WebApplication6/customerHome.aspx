<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="customerHome.aspx.cs" Inherits="WebApplication6.customerHome" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="Label1" runat="server" Text="view Products ordered by price"></asp:Label>
            <br />
            <asp:Button ID="Button1" runat="server" Text="view" OnClick="ViewProducts" />
            <br />
            <asp:Label ID="Label2" runat="server" Text="create wishlist"></asp:Label>
            <br />
            <asp:Label ID="Label3" runat="server" Text="whishlist name:"></asp:Label>
            <br />
            <asp:TextBox ID="wishname" runat="server"></asp:TextBox>
            <br />
            <asp:Button ID="Button2" runat="server" Text="create" OnClick="createWishList" />
            <br />
            <asp:Label ID="Label4" runat="server" Text="remove/add product to/from wishlist:"></asp:Label>
            <br />
            <asp:Label ID="Label5" runat="server" Text="wishlist name"></asp:Label>
            <br />
            <asp:TextBox ID="wishnameaddrem" runat="server"></asp:TextBox>
            <br />
            <asp:Label ID="Label6" runat="server" Text="serial no."></asp:Label>
            <br />
            <asp:TextBox ID="productno" runat="server"></asp:TextBox>
            <br />
            <asp:Button ID="Button3" runat="server" Text="add" OnClick="AddToWishList" />
            <asp:Button ID="Button4" runat="server" Text="remove" OnClick="removeFromWishList" />
            <br />
            <asp:Label ID="Label7" runat="server" Text="add credit card:"></asp:Label>
            <br />
            <asp:Label ID="Label8" runat="server" Text="credit card number"></asp:Label>
            <br />
            <asp:TextBox ID="creditno" runat="server"></asp:TextBox>
            <br />
            <asp:Label ID="Label9" runat="server" Text="expiry date"></asp:Label>
            <br />
            <asp:TextBox ID="exdate" runat="server"></asp:TextBox>
            <br />
            <asp:Label ID="Label10" runat="server" Text="cvv"></asp:Label>
            <br />
            <asp:TextBox ID="ccvv" runat="server"></asp:TextBox>
            <br />
            <asp:Button ID="Button7" runat="server" OnClick="AddCreditCard" Text="Add" />
            <br />
            <asp:Label ID="Label11" runat="server" Text="add/remove products to/from cart:"></asp:Label>
            <br />
            <asp:Label ID="Label12" runat="server" Text="serial no."></asp:Label>
            <br />
            <asp:TextBox ID="proincart" runat="server"></asp:TextBox>
            <br />
            <asp:Button ID="Button5" runat="server" Text="add" OnClick="AddToCart" />
            <asp:Button ID="Button6" runat="server" Text="remove" OnClick="removeFromCart" />
            <br />
            <asp:Label ID="Label13" runat="server" Text="add telephone"></asp:Label>
            <br />
            <asp:TextBox ID="telephone" runat="server"></asp:TextBox>
            <br />
            <asp:Button ID="Button8" runat="server" Text="add" OnClick="addTelephone" />
            <br />
            <asp:Label ID="Label14" runat="server" Text="make order by items in your cart"></asp:Label>
            <br />
            <asp:Button ID="Button9" runat="server" Text="make" OnClick="makeOrder" />
            <br />
            <asp:Label ID="Label15" runat="server" Text="choosing payment method:"></asp:Label>
            <br />
            <asp:Label ID="Label16" runat="server" Text="cash,credit and points"></asp:Label>
            <br />
            <asp:Label ID="Label18" runat="server" Text="order id:"></asp:Label>
            <asp:TextBox ID="orderid" runat="server" Width="69px"></asp:TextBox>
            <asp:Label ID="Label24" runat="server" Text="cash amount:"></asp:Label>
            <asp:TextBox ID="cash" runat="server" Width="50px"></asp:TextBox>
            <asp:Label ID="Label25" runat="server" Text="credit amount:"></asp:Label>
            <asp:TextBox ID="credit" runat="server" Width="57px"></asp:TextBox>
            <asp:Button ID="Button13" runat="server" Text="pay" OnClick="DiffPaymentMethods" />
            <br />
            <asp:Label ID="Label19" runat="server" Text="or pay with credit card only:"></asp:Label>
            <br />
            <asp:Label ID="Label20" runat="server" Text="order id"></asp:Label>
            <asp:TextBox ID="orderid2" runat="server"></asp:TextBox>
            <br />
            <asp:Label ID="Label21" runat="server" Text="credit card number"></asp:Label>
            <asp:TextBox ID="creditcardnum" runat="server"></asp:TextBox>
            <br />
            <asp:Button ID="Button11" runat="server" OnClick="PayWithCreditCard" Text="pay" style="height: 29px; width: 41px" />
            <br />
            <asp:Label ID="Label22" runat="server" Text="cancelling order"></asp:Label>
            <br />
            <asp:Label ID="Label23" runat="server" Text="order id"></asp:Label>
            <br />
            <asp:TextBox ID="orderid3" runat="server"></asp:TextBox>
            <br />
            <asp:Button ID="Button12" runat="server" Text="cancel" OnClick="CancelOrder" />
            <br />
        </div>
    </form>
</body>
</html>
