<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Masterpages/CMSAdmin.Master" CodeBehind="ImageEditor.aspx.vb" Inherits="tfsCMS.ImageEditor" Theme="Admin" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphbody" runat="server">
 
<div  class="box"  style="width:800px; min-height:500px;padding:10px;margin:0 auto;" align="center" >
    <telerik:RadImageEditor ID="RadImageEditor1" runat="server" Skin="Metro" 
        Width="100%">
        <ImageManager MaxUploadFileSize="104800" />
</telerik:RadImageEditor>
</div>
 
</asp:Content>
