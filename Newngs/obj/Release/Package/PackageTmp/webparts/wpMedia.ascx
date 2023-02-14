<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="wpMedia.ascx.vb" Inherits="tfsCMS.wpMedia" %>
<%@ Register src="photoslide/flash.ascx" tagname="flash" tagprefix="techCMS" %>
<%@ Register src="photoslide/logoslide.ascx" tagname="logoslide" tagprefix="techCMS" %>
<techCMS:flash ID="flash1" runat="server" Title="Photo Slide" />
<techCMS:logoslide ID="logoslide1" runat="server" Title="Logo Slide" />
