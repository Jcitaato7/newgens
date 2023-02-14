<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="sidebar.ascx.vb" Inherits="tfsCMS.sidebar1" %>
<asp:SqlDataSource ID="dssidebar" runat="server" 
    ConnectionString="<%$ ConnectionStrings:tfsCMSconn %>" 
    SelectCommand="SELECT [webpageid], [webpagename],[webcontent], [websort], [webpage_ispublished], [webpagefilename],[weburl], webpage_parentid=(CASE when webpage_parentid =0 THEN NULL ELSE webpage_parentid END) FROM [techCMS_webpages] where ( webpage_parentid=41 OR webpageid=41) AND webpage_islocked=0 ORDER BY [websort]">
</asp:SqlDataSource>



    <div class="col-lg-4 col-md-4 col-sm-12 col-xs-12" style="border-right: solid 1px #ECECEC;">
          <div class="service-menu"><br/>
            <br/>
        <asp:Repeater ID="rptItems" runat="server" DataSourceID="dssidebar">
        <HeaderTemplate>
            <ul style="-webkit-padding-start: 0px;">
        </HeaderTemplate>
        <ItemTemplate>
            <li>
                <a href='<%# IIf(Eval("webpagefilename") Is Nothing, "", Eval("webpagefilename"))%>'><h5 style="font-weight:bold; font-size:14px;" class="<%# IIf(System.IO.Path.GetFileName(Request.PhysicalPath) = Eval("webpagefilename"), "active", "")%>"><i class="<%#Eval("webcontent")%>" style="<%# IIf(Eval("WebPageName") = "Banking Solution","padding-right: 21px;", "")%>"></i>  <%# IIf(Eval("WebPageName") = "SOLUTION & SERVICES", "Professional Services" , Eval("WebPageName"))%></h5></a>
            </li>
        </ItemTemplate>
        <FooterTemplate>
            </ul>
        </FooterTemplate>
        </asp:Repeater>  
        <br/>
      </div>
        </div>


