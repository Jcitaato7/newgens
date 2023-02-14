<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="sitemap.ascx.vb" Inherits="tfsCMS.sitemap1" %>
    <h1>SITE MAP</h1><br />
    <p>        
        From here you can see the pages of our site. Below is an overview of our site's content at a single glance.
    </p>
<div class="box">
 <telerik:RadSiteMap ID="RadSiteMap1" Runat="server" DataFieldID="webpageid" 
        DataFieldParentID="webpage_parentid" DataNavigateUrlField="weburl" 
        DataSourceID="dssitemap" DataTextField="webpagename"  Skin="Windows7"
        DataValueField="webpageid" ShowNodeLines="True"  >
          <LevelSettings>
            <telerik:SiteMapLevelSetting Level="0">
                <ListLayout RepeatColumns="5" AlignRows="true"></ListLayout>
            </telerik:SiteMapLevelSetting>
        </LevelSettings>
    </telerik:RadSiteMap>
</div>
<asp:SqlDataSource ID="dssitemap" runat="server" 
    ConnectionString="<%$ ConnectionStrings:tfsCMSconn %>" 
    SelectCommand="SELECT [webpageid], [webpagename], [websort], [webpage_ispublished], [weburl], webpage_parentid=(CASE when webpage_parentid =0 THEN NULL ELSE webpage_parentid END) FROM [techCMS_webpages] where webpage_islocked=0 ORDER BY [websort]">
</asp:SqlDataSource>

