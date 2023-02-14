<%@ Page Language="VB" MaintainScrollPositionOnPostback="true"  MasterPageFile="~/MasterPages/Default/DefaultMaster.master" AutoEventWireup="false" Inherits="tfsCMS.clspagebase" title="Page Title" Culture="en-US" UICulture="auto" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphbody" Runat="Server">
<div class="main">
    <div id="content">
        <asp:WebPartZone ID="Center" runat="server"  Width="100%">
                <ZoneTemplate>                        
                </ZoneTemplate>
        </asp:WebPartZone>
    </div>
</div>

</asp:Content>

