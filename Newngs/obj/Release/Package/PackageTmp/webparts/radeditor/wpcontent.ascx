<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="wpcontent.ascx.vb" Inherits="tfsCMS.wpcontent" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
 <script type="text/javascript">
     function RadEditorOnClientSubmit(editor) {
         editor.set_mode(1); //Force design mode
     }
 </script>
 <style type="text/css">
  .radeditor { z-index: 8000 !important; }
 </style>
<telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Skin="Metro"></telerik:RadAjaxLoadingPanel>
<telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server"  Width="100%" EnablePageHeadUpdate="False" HorizontalAlign="NotSet" LoadingPanelID="RadAjaxLoadingPanel1">
    <div style="z-index:100000;padding:0; border:0; vertical-align:top;">
        <asp:FormView ID="FormView1" runat="server" DataKeyNames="content_id"  
            DataSourceID="dscontent" Width="100%"  DefaultMode="ReadOnly" 
            CellPadding="0" CellSpacing="0" CssClass="contenteditor">
            <EditItemTemplate>
                <div style="padding:0px; width:100%;">
                    <asp:CheckBox ID="chkborder" runat="server" Checked="True" Text="Border" /> 
                    <telerik:RadEditor ID="RadEditor1" Runat="server" SkinID="tfsDefault" Width="100%"      
                        Content='<%# Bind("content_text") %>' ToolbarMode="Default" OnClientSubmit="RadEditorOnClientSubmit">
                        <CssFiles>
                            <telerik:EditorCssFile Value="~/webparts/radeditor/css/StyleSheet.css" />
                        </CssFiles>                                  
                        <DocumentManager MaxUploadFileSize="10485760" UploadPaths="~/files/documents" ViewPaths="~/files/documents" />
                        <TemplateManager ViewPaths="~/webparts/radeditor/templates" UploadPaths="~/webparts/radeditor/templates"   />
                        <ImageManager MaxUploadFileSize="10485760" UploadPaths="~/files/images" ViewPaths="~/files/images" />                     
                        <Modules>
                            <telerik:EditorModule Name="RadEditorStatistics"   />
                            <telerik:EditorModule Name="RadEditorDomInspector"  />
                            <%--<telerik:EditorModule Name="RadEditorNodeInspector"  />--%>
                            <telerik:EditorModule Name="RadEditorHtmlInspector" Visible="false"/>
                        </Modules>                  
                        <FlashManager UploadPaths="~/files/flash" ViewPaths="~/files/flash" MaxUploadFileSize="10485760" />
                    </telerik:RadEditor>                       
                </div>    
                <div style="text-align:right; padding:5px 0; width:100%;background-color: #3399FF;z-index:999; opacity: 0.9;">                
                <asp:Button ID="btncancel" runat="server" CommandName="Cancel" Text="Cancel" CausesValidation="false" CssClass="button"  Width="70px"/>  
                            &nbsp;
                            <asp:Button ID="btnsave" runat="server" Text="Save" CommandName="Update"  CausesValidation="True" CssClass="button"  Width="70px"/>
                            </div>
            </EditItemTemplate>
            <InsertItemTemplate>
                <div style="padding:0px; width:100%">
                    <asp:CheckBox ID="chkborder" runat="server" Checked="True" Text="Border" />
                    <telerik:RadEditor ID="RadEditor1" Runat="server" Width="100%" SkinID="tfsDefault"                                         
                        Content='<%# Bind("content_text") %>' ToolbarMode="Default" OnClientSubmit="RadEditorOnClientSubmit">
                        <CssFiles>
                            <telerik:EditorCssFile Value="~/webparts/radeditor/css/StyleSheet.css" />
                        </CssFiles>                                  
                        <DocumentManager MaxUploadFileSize="10485760" UploadPaths="~/files/documents" ViewPaths="~/files/documents" />
                                        <TemplateManager ViewPaths="~/webparts/radeditor/templates" UploadPaths="~/webparts/radeditor/templates"   />
                        <ImageManager MaxUploadFileSize="10485760" UploadPaths="~/files/images" ViewPaths="~/files/images" />                             
                        <Modules>
                            <telerik:EditorModule Name="RadEditorStatistics"   />
                            <telerik:EditorModule Name="RadEditorDomInspector"  />
                            <telerik:EditorModule Name="RadEditorNodeInspector"  />
                            <telerik:EditorModule Name="RadEditorHtmlInspector" Visible="false"/>
                        </Modules>                  
                        <FlashManager UploadPaths="~/files/flash" ViewPaths="~/files/flash" MaxUploadFileSize="10485760" />                             
                    </telerik:RadEditor>
                </div>    
                <div style="text-align:right; padding:5px 0; width:100%;background-color: #3399FF;z-index:999;"> 
                    <asp:Button ID="btncancel" runat="server" CommandName="Cancel" Text="Cancel" CausesValidation="false" CssClass="button"  Width="70px"/>&nbsp;
                    <asp:Button ID="btnsave" runat="server"  Text="Save" CommandName="Insert"  CausesValidation="True" CssClass="button"  Width="70px"/>
                </div>
             
            </InsertItemTemplate>
            <ItemTemplate>
                <div class="col-lg-12">
                    <%# Eval("content_text") %> 
                </div>
   </ItemTemplate>
        </asp:FormView>
    </div>
    </telerik:RadAjaxPanel>
 
                <asp:SqlDataSource ID="dscontent" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:tfsCMSconn %>" 
                    DeleteCommand="DELETE FROM [editor_contents] WHERE [content_id] = @content_id" 
                    InsertCommand="INSERT INTO [editor_contents] ( [content_text], [content_date_created], [content_date_modified]) VALUES ( @content_text, getdate(), getdate());Select @NewID = Scope_Identity()"                    
                    SelectCommand="SELECT [content_id],  [content_text], [content_date_created], [content_date_modified], [content_modified_by] FROM [editor_contents] where content_id=@content_id" 
                    
    UpdateCommand="UPDATE [editor_contents] SET  [content_text] = @content_text,  [content_date_modified] = getdate(), [content_modified_by] = @content_modified_by WHERE [content_id] = @content_id">
                    <SelectParameters>
                        <asp:Parameter Name="content_id" DefaultValue="" />
                    </SelectParameters>
                    <DeleteParameters>
                        <asp:Parameter Name="content_id" Type="Int64" />
                    </DeleteParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="content_text" Type="String" />
                        <asp:Parameter Type="DateTime" Name="content_date_created" />
                        <asp:Parameter Type="DateTime" Name="content_date_modified" />
                        <asp:Parameter Name="content_modified_by" Type="String" />
                        <asp:Parameter Name="content_id" Type="Int64" />
                    </UpdateParameters>
                    <InsertParameters>
                        <asp:Parameter Name="content_text" Type="String" />
                        <asp:Parameter Type="DateTime" Name="content_date_created" />
                        <asp:Parameter Type="DateTime" Name="content_date_modified" />
                        <asp:Parameter Name="content_modified_by" Type="String" />
                        <asp:Parameter Type="Int64" Name="NewID" Direction="Output" />
                    </InsertParameters>
                </asp:SqlDataSource>
 
