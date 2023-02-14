<%@ Page Language="VB" MaintainScrollPositionOnPostback="true"  MasterPageFile="~/MasterPages/Default/DefaultMaster.master" AutoEventWireup="false" Inherits="tfsCMS.clspagebase" title="Products and Services" %>
<%@ Register src="~/webparts/products/wpproductdetails.ascx" tagname="ProductsDetails" tagprefix="techCMS" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<%--    <meta name="description" content="Products and Services">
    <meta name="keywords" content="Products and Services">--%>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphbody" Runat="Server">
    <!---CONTENT---->
    <div class="main">
      <div id="content">
        <div id="grid-2a">
            <asp:WebPartZone ID="Left"   runat="server" Width="100%" >
                <ZoneTemplate>
                    <techCMS:ProductsDetails ID="ProductsDetails1" title="Product Details" runat="server" />
                </ZoneTemplate>
            </asp:WebPartZone>
        </div>
        <div id="grid-2b">
            <asp:WebPartZone ID="Right"   runat="server" Width="100%" >
                <ZoneTemplate>
                    
                </ZoneTemplate>
            </asp:WebPartZone>            
        </div>
        <div style="clear:both"></div>
      </div>
    </div>
<!---END CONTENT----> 
</asp:Content>

