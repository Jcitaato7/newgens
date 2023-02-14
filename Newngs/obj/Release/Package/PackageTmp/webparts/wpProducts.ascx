<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="wpProducts.ascx.vb" Inherits="tfsCMS.wpProducts" %>
<%@ Register src="products/wpproductcategoriesfeatured.ascx" tagname="wpproductcategoriesfeatured" tagprefix="uc1" %>
<%@ Register src="products/wpproductslist.ascx" tagname="wpproductslist" tagprefix="uc1" %>
<uc1:wpproductcategoriesfeatured ID="wpproductcategoriesfeatured1" runat="server" Title="Featured Products" />
<uc1:wpproductslist ID="wpproductslist1" runat="server" Title="Products List" />