<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="vendor.aspx.cs" Inherits="WebApplication6.vendor" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
             <div>
            <asp:Label ID="Label1" runat="server" Text="Post product on the system"></asp:Label>
            <br />
            <asp:Label ID="Label2" runat="server" Text="Product name"></asp:Label>
            <br />
            <asp:TextBox ID="name" runat="server"></asp:TextBox>
            <br />
            <asp:Label ID="Label3" runat="server" Text="product description"></asp:Label>
            <br />
            <asp:TextBox ID="description_txt" runat="server"></asp:TextBox>
            <br />
            <asp:Label ID="Label4" runat="server" Text="category"></asp:Label>
            <br />
            <asp:TextBox ID="category_txt" runat="server"></asp:TextBox>
            <br />
            <asp:Label ID="Label5" runat="server" Text="color"></asp:Label>
            <br />
            <asp:TextBox ID="color_txt" runat="server"></asp:TextBox>
            <br />
            <asp:Label ID="Label6" runat="server" Text="price"></asp:Label>
            <br />
            <asp:TextBox ID="price_txt" runat="server"></asp:TextBox>
            <br />
            <asp:Label ID="Label8" runat="server" Text="To edit products you posted"></asp:Label>
            <br />
            <asp:Label ID="Label9" runat="server" Text="serial_no"></asp:Label>
            <br />
            <asp:TextBox ID="serial_no_txt" runat="server"></asp:TextBox>
            <br />
            <asp:Button ID="Button1" runat="server" Text="add" OnClick="postProduct" />
            <asp:Button ID="Button3" runat="server" Text="edit" OnClick="EditProduct" />
            <br />
            <asp:Label ID="Label10" runat="server" Text="show products you posted"></asp:Label>
            <br />
            <asp:Button ID="Button2" runat="server" Text="show" OnClick="goToVendorsProducts" />
            <br />
            <asp:Label ID="Label11" runat="server" Text="add offer"></asp:Label>
            <br />
            <asp:Label ID="Label12" runat="server" Text="offer amount:"></asp:Label>
            <br />
            <asp:TextBox ID="offeramount" runat="server"></asp:TextBox>
            <br />
            <asp:Label ID="Label13" runat="server" Text="expiry date"></asp:Label>
            <br />
            <asp:TextBox ID="expirydate" runat="server"></asp:TextBox>
            <br />
            <asp:Button ID="Button4" runat="server" Text="add offer" OnClick="AddOffer" />
            <br />
            <asp:Label ID="Label14" runat="server" Text="applying an offer on a certin product:"></asp:Label>
            <br />
            <asp:Label ID="Label15" runat="server" Text="offer ID"></asp:Label>
            <br />
            <asp:TextBox ID="offerid" runat="server"></asp:TextBox>
            <br />
            <asp:Label ID="Label16" runat="server" Text="serial no."></asp:Label>
            <br />
            <asp:TextBox ID="serialnum" runat="server"></asp:TextBox>
            <br />
            <asp:Button ID="Button5" runat="server" Text="apply" OnClick="ApplyOffer" />
            <br />
            <asp:Label ID="Label17" runat="server" Text="remove expired offers"></asp:Label>
            <br />
            <asp:Label ID="Label18" runat="server" Text="offer ID"></asp:Label>
            <br />
            <asp:TextBox ID="removeid" runat="server" ></asp:TextBox>
            <br />
            <asp:Button ID="Button6" runat="server" Text="remove" OnClick="RemoveOffer" />
            <br />
        </div>
        </div>
    </form>
</body>
</html>
