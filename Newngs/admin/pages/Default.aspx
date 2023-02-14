<%@ Page Title="Pages" Language="vb" AutoEventWireup="false" MasterPageFile="~/Masterpages/CMSAdmin.Master" CodeBehind="Default.aspx.vb" Inherits="tfsCMS._Default3" Theme="admin" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
 <script type="text/javascript" src="/Scripts/jquery-1.4.1.min.js"></script>
 <style type="text/css">
 .btnsubpage
{
 visibility:hidden; font-size:11px !important; padding:3px !important;
}
.RadTreeView_Black, .RadTreeView_Black a.rtIn, .RadTreeView_Black .rtEdit .rtIn input
{color: #333333 !important;}
 
 </style>
 
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="cphbody" runat="server">
   <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
    <script src="/Scripts/jquery-1.6.4.min.js" type="text/jscript"></script>
   <script src="/Scripts/JScript.js" type="text/jscript"></script>
    <script type="text/javascript">
      
        function toggleDiv(id, flagit) {
            if (flagit == "1") {
                if (document.layers) document.layers['' + id + ''].visibility = "show"
                else if (document.all) document.all['' + id + ''].style.visibility = "visible"
                else if (document.getElementById) document.getElementById('' + id + '').style.visibility = "visible"
            }
            else
                if (flagit == "0") {
                    if (document.layers) document.layers['' + id + ''].visibility = "hide"
                    else if (document.all) document.all['' + id + ''].style.visibility = "hidden"
                    else if (document.getElementById) document.getElementById('' + id + '').style.visibility = "hidden"
                }
            }
        function showpage(id) {
           
                window.radopen("pageproperties.aspx?webpageid=" + id, "pagepropdialog");
               
            }
            function createpage(parentid) {
                window.radopen("pageproperties.aspx?webpageparentid=" + id, "pagepropdialog");
                return false;
            }
            function OnClientPagePropClose(oWnd, args) {
              
                var arg = args.get_argument();
                
                if (arg) {
                    var id = arg.pageid;
                    var oWnd = radalert("Save Successful!");
                    oWnd.close(arg);
                    var ajaxManager = $find("<%= RadAjaxManager1.ClientID %>");
                      ajaxManager.ajaxRequest("insert:" + id);
                                      }
               
                 //sender.remove_close(OnClientPagePropClose);
            }
            function CreateNewPage(id) {
                if (id=='0') {
                    // window.radopen("pageproperties.aspx?webpageparentid=" + node.get_value(), "pagepropdialog");
                    window.radopen("pageproperties.aspx?webpageparentid=0", "pagepropdialog");
                }
                else {
                    window.radopen("pageproperties.aspx?webpageparentid=" + id, "pagepropdialog");
                 }
                return false;
            }
            function confirmCallBackFn(arg) {
                radalert("<strong>radconfirm</strong> returned the following result: <h3 style='color: #ff0000;'>" + arg + "</h3>", null, null, "Result");
            }

            function ConfirmBox(cMsg) {
                radconfirm(cMsg, ConfirmBoxCallBackFn, 250, 150, '', 'Confirm');
                return false;
            }
            function ConfirmBoxCallBackFn(arg) {
                if (arg) {
                    var ajaxManager = $find("<%= RadAjaxManager1.ClientID %>");
                    ajaxManager.ajaxRequest("delete");
                }
            }


            function UnSelectAllNodes() {
                var tree = $find("<%= RadTreeView1.ClientID %>");
                tree.unselectAllNodes();

            }
            function pageLoad1(sender, eventArgs) {
                if (!eventArgs.get_isPartialLoad()) {
                    $find("<%= RadAjaxManager1.ClientID %>").ajaxRequest("pgload");
                }
            }

</script>
       </telerik:RadCodeBlock>
 
     <telerik:RadSplitter ID="Radsplitter1" runat="server" height="650px" Width="100%" Skin="Metro">
        <telerik:RadPane ID="LeftPane" runat="server" Width="25%">
            <div>        
                <span class="t1">PAGES</span>      
                <div style="margin-top:5px; margin-bottom:5px">
                    <asp:Button ID="btnaddpage" CssClass="button blue" runat="server" Font-Size="12px" CausesValidation="False" Text="Create New Page" OnClientClick="return CreateNewPage('0');false;" />
                </div>
                <asp:Image ID="Image1" runat="server" ImageUrl="~/App_Themes/Admin/images/pages.png" AlternateText="" />&nbsp;All Pages         
                <br />
                <telerik:RadTreeView 
                        ID="RadTreeView1" Runat="server" OnDataBound="PageTreeView_DataBound"  
                                    CausesValidation="False"  onnodeclick="NodeClick" 
                                    DataFieldID="webpageid"  
                    DataFieldParentID="webpage_parentId" Height="500px" 
                                    DataSourceID="dspages" DataTextField="webpagename" DataValueField="webpageid"                      
                                    EnableDragAndDrop="true" 
                    OnNodeDrop="RadTreeView1_NodeDrop"    Width="100%" 
                                Skin="Metro" BorderStyle="NotSet"  
                    EnableDragAndDropBetweenNodes="True">
                    <NodeTemplate> 
                        <div runat="server" id="nodetemplate">
                            <asp:Image ID="Image2" runat="server" ImageAlign="Left" ImageUrl='<%# Eval("imgurl")%>'   
                                                Visible='<%# Eval("webpage_isdefault") %>'   BorderStyle="None" Height="15px" 
                                                Width="15px" />&nbsp;<asp:Label ID="lblwebpagename" runat="server"  Text='<%# IIF((Eval("webpage_ispublished")=false and Eval("webpage_type")=1), "<span style=color:#FF0000>" + Eval("webpagename") + "</span>",Eval("webpagename") ) %>' 
                                                    font-size="12px" style="cursor:pointer;"></asp:Label>&nbsp;<asp:LinkButton ID="btnaddsubpage" runat="server" CssClass="btnsubpage button blue">Add Sub Page</asp:LinkButton> 
                        </div>
                    </NodeTemplate>
                </telerik:RadTreeView>
                <asp:Label ID="lblmsg" runat="server"  Font-Size="12px" ForeColor="Red"></asp:Label><br />
            </div>
        </telerik:RadPane>
        <telerik:RadSplitBar ID="RadSplitBar1" runat="server" />
       <telerik:RadPane ID="MiddlePane" runat="server" Width="75%" > 
       <div style="border: 3px solid #eff3f6; padding: 5px 5px 0 5px; text-align:left; background-color: #ffffff;" >
       <asp:FormView ID="FormView1" runat="server" DataKeyNames="webpageid" 
                                DataSourceID="dspage"   Width="100%" ForeColor="#070707"  >
                                <ItemTemplate>
                                    <asp:HiddenField ID="hfpagetype" runat="server" Value='<%#Eval("webpage_type") %>' />
                                     <asp:HiddenField ID="hfweburl" runat="server" Value='<%#Eval("weburl") %>' />
                                    <div style="width:100%; background-color: #EFEFEF; padding:5px;margin-bottom:10px;">
                                <table style="width:100%;color:#242424">
                                <tr>
                                <td colspan="2" class="t2">Page Settings</td><td ></td><td></td><td></td><td></td></tr>
                                    <tr ><td style="width:80px"><b>Page Name</b></td>
                                        <td style="text-align:left"><%# Eval("webpagename")%></td>
                                        <td style="text-align:left" colspan="2"><b>Show in navigation menu</b>&nbsp;&nbsp;<asp:CheckBox ID="chkshwmnu" runat="server" 
                                            checked='<%# IIF(Eval("webpage_navigation"), "True", "False") %>' 
                                            Enabled="false" /></td>
                                        <td><%--<b>Show in footer menu</b></td><td><asp:CheckBox ID="chkshwftr" runat="server" 
                                            checked='<%# IIF(Eval("webpage_infooteronly"), "True", "False") %>' 
                                            Enabled="false" />--%></td>
                                    </tr>
                                    <tr><td><b>Page Type</b> </td>
                                        <td><asp:Label ID="webpage_typeLabel" runat="server"  
                                                    Text='<%# Eval("webpage_typename") %>' /><asp:Label ID="lbltype" runat="server"  
                                                    Text='<%# Eval("webpage_type") %>' Visible="false" /><asp:Label ID="lbltemplate" runat="server"  
                                                    Text='<%# Eval("webpage_template") %>' Visible="false" /></td>
                                        <td colspan='2'><%# IIf(Eval("webpage_type") <> 2, "<b>URL</b>&nbsp;<a href='" + IIf(Eval("webpage_type") = 1, ResolveUrl(Eval("weburl")), Eval("weburl")) + "' target='_blank' style='text-decoration:none'>" + IIf(Eval("webpage_type") = 1, Request.Url.GetLeftPart(UriPartial.Authority) & ResolveUrl(Eval("weburl")), Eval("weburl")) + " (<b>Preview</b>)</a>", "")%>
                                            <%--(String.Format("http://{0}{1}?p=1", Request.ServerVariables("HTTP_HOST"), Replace(Eval("weburl"), "~", "")))--%>
                                        </td>
 <td><b>Editors</b></td><td><%#IIf(Eval("webpageadmins") = "0", "All Editors", "")%><asp:HyperLink ID="lnkpageadmins" runat="server"  NavigateUrl="#"  ><%#IIf(Eval("webpageadmins") = "" Or Eval("webpageadmins") = "0", "", "View")%></asp:HyperLink>
     <telerik:RadToolTip ID="RadToolTip1" runat="server" Position="MiddleLeft" ShowEvent="OnClick" TargetControlID="lnkpageadmins" Width="400px" RelativeTo="Element" Sticky="True">
         <div style="padding:10px"> <%#Eval("webpageadmins")%></div>
                                        </telerik:RadToolTip>
                                        </td>
                                    </tr></table>
                                        </div>
                                    <div runat="server" style="padding:0;display:inline;margin-bottom:10px;" visible='<%# IIf(Eval("webpage_type") = 1, isPageEditor(Eval("webpageid")), "False")%>'><a  href='<%# "../../admin/pages/loading.htm?page=" + ResolveUrl(Eval("weburl"))%>' class="button blue" style="padding: 5px 8px;">Edit Page Content</a></div> 
<div   <%= IIf(Roles.IsUserInRole("Super Admin") or Roles.IsUserInRole("Contributor"), "style='padding:0;display:inline'", "style='display:none;width:100%;background-color: #CCCCCC; vertical-align:top'")%>>
<asp:Button ID="btneditsettings" runat="server"  CssClass="button blue" Text="&nbsp;Edit Page Settings&nbsp;" CausesValidation="False" Enabled='<%# Eval("webpage_islocked")=0 %>' OnClientClick='<%# Eval("webpageid","showpage(""{0}"");") %>' Font-Underline="False" /><asp:Button ID="btnpublish" runat="server"   CausesValidation="False"  ForeColor="White" CssClass="button blue" CommandName='<%#IIf((Eval("webpage_ispublished")) = True, "Unpublish", "Publish")%>' Visible='<%# Eval("webpage_isdefault")=0 and  Eval("webpage_type")=1 and Eval("webpage_islocked")=0 %>'
   Text='<%#IIf((Eval("webpage_ispublished")) = True, "Unpublish this Page", "Publish this Page")%>' /><asp:Button ID="btnsetdefault" runat="server"  CausesValidation="False"  ForeColor="White" CssClass="button blue"   CommandName="SetDefault" Visible='<%# Eval("webpage_type")=1 and Eval("webpage_isdefault")=0  and Eval("webpage_ispublished") = True and Eval("webpage_islocked")=0 %>'  Text="Set as Default Page" />
   
   <asp:Button ID="btndeletepage" runat="server" CausesValidation="False" ForeColor="White" CssClass="button blue"  Visible='<%# Eval("webpage_isdefault")=0 and Eval("webpage_islocked")=0 %>'
    OnClientClick="ConfirmBox('Are you sure you want to delete this page?')" Text="Delete this Page" /></div>
   
    
    <hr/>
    <iframe  id="previewframe"  frameborder="0"  
        src='<%# IIf(Eval("webpage_type") = 1 And Not IsDBNull(Eval("weburl")), Page.ResolveClientUrl("~/admin/pages/loading.htm") + "?page=" + (ResolveUrl(Eval("weburl")) + "?p=1"), "welcome.aspx?type=blank")%>'
                          marginheight="0"  scrolling="auto"  
                        style="z-index:0; height:500px; width:100%;" ></iframe>
                        
                        </ItemTemplate>
                        <EmptyDataTemplate>
                        <table align="left"  style="vertical-align: top; text-align: left;" width="100%"><tr><td class="t2" style="height:650px; text-align:center; font-size:27px; color: #333333;">Please select a page from the left</td></tr></table>
                        </EmptyDataTemplate></asp:FormView>
                        </div> 
                        </telerik:RadPane>
      
</telerik:RadSplitter>
 
 <asp:SqlDataSource ID="dspages" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:tfsCMSconn %>" 
                    DeleteCommand="DELETE FROM [techCMS_webpages] WHERE [webpageid] = @webpageid" 
                    
                    SelectCommand="SELECT webpageid,  webpagename, webpage_parentid =case when webpage_parentid =0 then NULL else webpage_parentid END, weburl, websort,imgurl=case when webpage_isdefault=1 then '~/app_themes/admin/images/home.png' ELSE NULL END,
                    ISNULL(webpage_isdefault,0) as webpage_isdefault,ISNULL(webpage_ispublished,0) as webpage_ispublished,webpage_type FROM techCMS_webpages order by websort " >
                    <DeleteParameters>
                        <asp:Parameter Name="webpageid" Type="Int32" />
                    </DeleteParameters>
                    
                  
                </asp:SqlDataSource>
              
                <asp:SqlDataSource ID="dspage" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:tfsCMSconn %>" 
                     SelectCommand="techCMS_spPageSelect" 
                    SelectCommandType="StoredProcedure" 
                    DeleteCommand="techCMS_spPageDelete" 
                       DeleteCommandType="StoredProcedure"
                    >
                    <SelectParameters>
                        <asp:ControlParameter ControlID="RadTreeView1" Name="webpageid" 
                            PropertyName="SelectedValue"  Type="Int32" />
                           
                    </SelectParameters>
                    <DeleteParameters>
                        <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" DefaultValue="" Type="Int32" />
                        <asp:Parameter Name="webpageid" Type="Int32" />
                    </DeleteParameters>
                  
                   
                    
                </asp:SqlDataSource>
      
          <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" Runat="server" 
                                height="75px" width="75px" Skin="Metro">
                            </telerik:RadAjaxLoadingPanel>
 
<telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" RestoreOriginalRenderDelegate="false"      
        OnAjaxRequest="RadAjaxManager1_AjaxRequest" 
       >
  <AjaxSettings>
         
          
      <telerik:AjaxSetting AjaxControlID="RadAjaxManager1" >
             <UpdatedControls>
          <telerik:AjaxUpdatedControl ControlID="RadTreeView1" LoadingPanelID="RadAjaxLoadingPanel1" />  
             <telerik:AjaxUpdatedControl ControlID="RadWindowManager1" LoadingPanelID="RadAjaxLoadingPanel1"  />  
            <telerik:AjaxUpdatedControl ControlID="FormView1" LoadingPanelID="RadAjaxLoadingPanel1"  />    
             </UpdatedControls>
         </telerik:AjaxSetting>
        
         <telerik:AjaxSetting AjaxControlID="RadTreeView1" >
             <UpdatedControls>
                 <telerik:AjaxUpdatedControl ControlID="FormView1" LoadingPanelID="RadAjaxLoadingPanel1" />
              
                 </UpdatedControls>
         </telerik:AjaxSetting>
         <telerik:AjaxSetting AjaxControlID="FormView1" >
             <UpdatedControls>
                 <telerik:AjaxUpdatedControl ControlID="RadTreeView1" LoadingPanelID="RadAjaxLoadingPanel1"  />
                               </UpdatedControls>
         </telerik:AjaxSetting>
     </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadToolTipManager ID="RadToolTipManager1" OffsetY="-1" UpdateMode="Conditional"
        HideEvent="ManualClose" ShowEvent="OnClick"
        Width="750px" Height="550px" runat="server" RelativeTo="BrowserWindow"
        Position="Center" Animation="Fade" Skin="Metro" Modal="True" 
        AnimationDuration="500" Overlay="True">
            </telerik:RadToolTipManager>
     <telerik:RadWindowManager ID="RadWindowManager1" runat="server" 
            IconUrl="~/images/page.png" Behavior="Close"
            Skin="Metro" Style="z-index:10000"
                  Modal="True" VisibleStatusbar="False"  DestroyOnClose="true"
            Behaviors="Close">
        <Windows>
                   <telerik:RadWindow ID="pagepropdialog" runat="server" Width="900px" Height="700px"  Title="" Modal="true"  OnClientClose="OnClientPagePropClose" />
    
        </Windows>
        </telerik:RadWindowManager> 
</asp:Content>
