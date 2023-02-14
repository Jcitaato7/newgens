<%@ Page Language="VB" MaintainScrollPositionOnPostback="true"  MasterPageFile="~/MasterPages/Default/DefaultMaster.master" AutoEventWireup="false" Inherits="tfsCMS.clspagebase" title="Page Title" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphbody" Runat="Server">
<div class="container">
    <div class="top-margin"></div>
    <div class="row">
        <div class="col-lg-12">
            <ol class="breadcrumb">
                <li><a href="index.html">Home</a></li>
                <li class="active">[Page Name]</li>
            </ol>
        </div>
    </div>
    <div class="row">        
        <asp:WebPartZone ID="Main" runat="server" Width="100%">
            <ZoneTemplate />
        </asp:WebPartZone>    
    </div>
</div>
</asp:Content>