<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="wpBreadCrumb.ascx.vb" Inherits="tfsCMS.wpBreadcrumb" %>
    <asp:Repeater ID="rptBreadCrumb" runat="server">
        <HeaderTemplate>
            <ol class="breadcrumb">
        </HeaderTemplate>
        <ItemTemplate>
            <li> <a href='<%# FixURL(Eval("WebPageType"), IIf(Eval("WebPageURL") Is Nothing, "", Eval("WebPageURL")))%>'><%# Eval("WebPageName").ToString%></a> </li>
        </ItemTemplate>
        <FooterTemplate>
            </ol>
        </FooterTemplate>
    </asp:Repeater>         
