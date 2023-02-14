<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="wpHeaderMenu.ascx.vb" Inherits="tfsCMS.wpHeaderMenu" %>
<asp:Repeater ID="rptMainItem" runat="server">
    <HeaderTemplate>
        <ul class="nav navbar-nav navbar-right">
           
    </HeaderTemplate>
    <ItemTemplate>
        <%# GenerateListItemMarkup(Eval("ChildNodesCount"), Eval("WebPageType"), IIf(Eval("WebPageURL") Is Nothing, "", Eval("WebPageURL")), Eval("WebPageName"), Eval("WebPageFileName"), Eval("IsActiveParent"))%>
                
            </li>
    </ItemTemplate>
    <FooterTemplate>
      </ul>
    </FooterTemplate>
</asp:Repeater> 


