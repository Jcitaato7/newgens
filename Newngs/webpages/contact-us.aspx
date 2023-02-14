<%@ Page Language="VB" MaintainScrollPositionOnPostback="true"  MasterPageFile="~/MasterPages/Default/DefaultMaster.master" AutoEventWireup="false" Inherits="tfsCMS.clspagebase" title="Page Title" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphbody" Runat="Server">

            <asp:WebPartZone ID="Heading" runat="server" Width="100%">
                <ZoneTemplate />
            </asp:WebPartZone>    
       
      <section id="main-container">
    <div class="container">
      <div class="row">
      
       <asp:WebPartZone ID="WebPartZone1" runat="server" Width="100%">
                <ZoneTemplate />
            </asp:WebPartZone>  

                 <div class="gap-40"></div>

       <div class="col-md-7" hidden>
            <asp:WebPartZone ID="Left" runat="server" Width="100%">
                <ZoneTemplate />
            </asp:WebPartZone>  
        </div>
        <div class="col-md-12">
            <asp:WebPartZone ID="Right" runat="server" Width="100%">
                <ZoneTemplate />
            </asp:WebPartZone>  
        </div>

    </div>  
</div>
          </section>
</asp:Content>
