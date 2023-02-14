<%@ Page Language="VB" MaintainScrollPositionOnPostback="true"  MasterPageFile="~/MasterPages/Default/DefaultMaster.master" AutoEventWireup="false" Inherits="tfsCMS.clspagebase" title="Page Title" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphbody" Runat="Server">
<asp:WebPartZone ID="Slider" runat="server" Width="100%" Height="100%">
    <PartChromeStyle Height="100%" />
    <PartStyle Height="100%" />
    <ZoneTemplate />
</asp:WebPartZone>
<div class="container"> 
    <div class="row">
        <asp:WebPartZone ID="Main" runat="server" Width="100%">
            <ZoneTemplate />
        </asp:WebPartZone>           
    </div>
</div>
</asp:Content>



