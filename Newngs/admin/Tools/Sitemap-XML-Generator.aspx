<%@ Page Title="File-Manager" Language="vb" AutoEventWireup="false" MasterPageFile="~/Masterpages/CMSAdmin.Master" CodeBehind="Sitemap-XML-Generator.aspx.vb" Inherits="tfsCMS.SitemapXMLGenerator" Theme="admin" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
   <script type="text/javascript">
   </script>    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphbody" runat="server">
<div style="padding:10px;">
 <div class="box" style="width:1000px; margin:0 auto;padding:10px">
  <h1>Generate Sitemap XML</h1>
    <table  style="width:100%; margin:0 auto;">
       
        <tr>
           <td colspan="2"></td>
            
        </tr>
        <tr>
            <td colspan="2" style="text-align: left; vertical-align: top;padding:10px">
                <p>This tool generates an XML file for the sitemap that you can submit to search engines. You can download the file and submit it or you can submit the XML's URL indicated below to the search engine.</p>
                <p>You can only generate the XML file once every 5 minutes to prevent repeated requests and potentially crashing the website. Make sure all pages are finalized like page titles, meta tags are set properly before clicking the button below.</p>                
                <br />
                <p><asp:Button ID="btnGenerate" runat="server" Text="Generate Sitemap XML" />
                <asp:HyperLink ID="hplSiteMapXML" runat="server"></asp:HyperLink></p>
                <br />
               <p><b>Note:</b> The URL of Sitemap's XML file is http://www.uniengr.com.sg/admin/tools/files/SiteMap.xml</p>               
           </td>
        </tr>
        <tr>
            <td class="style3">
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
    </table>
    </div>
     </div>
</asp:Content>
