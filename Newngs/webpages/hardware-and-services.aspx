<%@ Page Language="VB" MaintainScrollPositionOnPostback="true"  MasterPageFile="~/MasterPages/Default/DefaultMaster.master" AutoEventWireup="false" Inherits="tfsCMS.clspagebase" title="Page Title" %>
<%@ Register src="~/webparts/navigation/sidebar.ascx" tagname="SideBar" tagprefix="techCMS" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphbody" Runat="Server">

    <asp:WebPartZone ID="Heading" runat="server" Width="100%">
        <ZoneTemplate />
    </asp:WebPartZone>
   
  <section id="main-container">
    <div class="container">
      <div class="row">
      
       
             <techCMS:SideBar ID="SideBar1" runat="server" Title="SiteMap" />        
    <div class="col-lg-8 col-md-8 col-sm-12 col-xs-12">
            <asp:WebPartZone ID="Left" runat="server" Width="100%">
                <ZoneTemplate />
            </asp:WebPartZone>  
        </div>
    </div>  
</div>
</section>
</asp:Content>
