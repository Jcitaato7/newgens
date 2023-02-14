<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="wpHeaderMenu.ascx.vb" Inherits="tfsCMS.wpHeaderMenu" %>
<asp:Repeater ID="rptMainItem" runat="server">
    <HeaderTemplate>
        <ul class="nav navbar-nav navbar-right">
    </HeaderTemplate>
    <ItemTemplate>
        <%# GenerateListItemMarkup(Eval("ChildNodesCount"), Eval("WebPageType"), IIf(Eval("WebPageURL") Is Nothing, "", Eval("WebPageURL")), Eval("WebPageName"), Eval("WebPageFileName"))%>                    
                <%--<li <%# IIf(Eval("ChildNodesCount") > 0, "class=""dropdown""", "")%>> <a href='<%# FixURL(Eval("WebPageType"), IIf(Eval("WebPageURL") Is Nothing, "", Eval("WebPageURL")))%>' <%# IIf(Eval("ChildNodesCount") > 0, "class=""dropdown-toggle"" data-toggle=""dropdown""", "")%>><%# Eval("WebPageName").ToString%>&nbsp;<%# IIf(Eval("ChildNodesCount") > 0, "<b class=""caret""></b>", "")%></a>--%>
                <asp:Repeater runat="server" ID="rptSubItems" DataSource='<%# Eval("ChildNodes")%>'>
                    <HeaderTemplate>
                        <ul class="dropdown-menu">
                    </HeaderTemplate>
                    <ItemTemplate>                    
                        <li> <a href='<%# FixURL(Eval("WebPageType"), IIf(Eval("WebPageURL") Is Nothing, "", Eval("WebPageURL")))%>'><%# Eval("WebPageName").ToString%></a> </li>
                    </ItemTemplate>
                    <FooterTemplate>
                        </ul>
                    </FooterTemplate>
                </asp:Repeater>
            </li>
    </ItemTemplate>
    <FooterTemplate>
        </ul>
    </FooterTemplate>
</asp:Repeater> 


