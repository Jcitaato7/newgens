<%@ Page Language="VB" MaintainScrollPositionOnPostback="true"  MasterPageFile="~/MasterPages/Default/DefaultMaster.master" AutoEventWireup="false" Inherits="tfsCMS.clspagebase" title="Page Title" %>
<%@ Register src="~/webparts/navigation/wpBreadCrumb.ascx" tagname="BreadCrumb" tagprefix="techCMS" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphbody" Runat="Server">
<div class="container">
    <div class="top-margin"></div>
    <div class="row">
        <div class="col-lg-12">
            <techCMS:BreadCrumb ID="BreadCrumb1" runat="server" Title="Breadcrumb" />           
        </div>
    </div>
    <div class="row">        
        <asp:WebPartZone ID="Main" runat="server" Width="100%">
            <ZoneTemplate />
        </asp:WebPartZone>
    </div>
</div>
</asp:Content>