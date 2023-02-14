<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="wpjobslist.ascx.vb" Inherits="tfsCMS.wpjobslist" %>
<script type="text/javascript">
    function ShowInsertForm(id) {
        window.radopen('<%=Page.ResolveClientUrl("~/webparts/careers/application.aspx?jid=")%>' + id, "mdialog");
                    return false;
                }
             </script>
<asp:SqlDataSource ID="sqldsArticles" runat="server" 
    ConnectionString="<%$ ConnectionStrings:tfsCMSconn %>" 
    SelectCommand="techCMS_spSite_VacancySelect"
    SelectCommandType="StoredProcedure">
</asp:SqlDataSource>   
   
<asp:DataList ID="dlstArticles" runat="server" 
    DataSourceID="sqldsArticles" CellPadding="0" Width="100%" 
    CellSpacing="0" RepeatDirection="Vertical">
    <ItemTemplate>
        <h3 style="font-family:'Roboto'; font-weight:100;">Job Openings</h3>
        <h2>Position: <%# Eval("VacancyName")%></h2>
       <div style="background: #F8F8F8; border-radius: 5px; padding: 20px;">
                  <ul class="check-list">
                 <%# Eval("FullDescription").ToString.Replace("(", "<li>").Replace(")", "</li>")%>
                  </ul>
                <a href="#" class="btn btn-primary solid" onclick="return ShowInsertForm(<%# Eval("VacancyID")%>);">APPLY NOW</a>
                  </div>            
    </ItemTemplate>
</asp:DataList>  
<hr>
<div class="row text-center">
    <div class="col-lg-12">
        <asp:Literal ID="ltrPageNums" runat="server" Visible="false" />
    </div>
</div>
    