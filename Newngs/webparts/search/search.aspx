<%@ Page Language="VB" MaintainScrollPositionOnPostback="true"  MasterPageFile="~/MasterPages/Default/DefaultMaster.master" AutoEventWireup="false" Inherits="tfsCMS.clspagebase" title="Search" Culture="en-US" UICulture="auto" %>

<%@ Register src="wpsearch.ascx" tagname="wpsearch" tagprefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphbody2" Runat="Server">
    <div class="main">
      <div id="content">
        <div id="grid-2a">
            <asp:WebPartZone ID="Left"   runat="server" Width="100%" >
                <ZoneTemplate />
            </asp:WebPartZone>
        </div>
        <div id="grid-2b">
            <uc1:wpsearch ID="wpsearch1" runat="server" />       
        </div>
        <div style="clear:both"></div>
        <div style="margin: 10px 0;">
            <asp:WebPartZone ID="Bottom"   runat="server" Width="100%" >
                <ZoneTemplate />
            </asp:WebPartZone>
        </div>
      </div>
    </div>
</asp:Content>

