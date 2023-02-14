<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="wpBreadCrumb.ascx.vb" Inherits="tfsCMS.wpBreadcrumb" %>
    <asp:Repeater ID="rptBreadCrumb" runat="server">
        <HeaderTemplate>
            <ol class="breadcrumb" style="margin-left: 50px;" visible='<%# IIf(Eval("WebPageName") <> "Home", "true", "false")%>'>
        </HeaderTemplate>
        <ItemTemplate>
            <li> <a href='<%# FixURL(Eval("WebPageType"), IIf(Eval("WebPageURL") Is Nothing, "", Eval("WebPageURL")))%>' style="color:#fff; text-transform:uppercase; ">  <%# IIf(Eval("WebPageName") = "Home", "", Eval("WebPageName"))%> </a> </li>
        </ItemTemplate>
        <FooterTemplate>
            </ol>
        </FooterTemplate>
    </asp:Repeater>         
