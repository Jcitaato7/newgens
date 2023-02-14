<%@ Page Title="Site Settings" Language="vb" AutoEventWireup="false" MasterPageFile="~/Masterpages/CMSAdmin.Master" CodeBehind="Default.aspx.vb" Inherits="tfsCMS._Default9" Theme="admin" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<style type="text/css">
.tabtitle{ text-transform:uppercase !important}
.settings{ border-style: none solid solid solid; border-right-color: #CCCCCC;
    border-bottom-color: #CCCCCC;
    border-left-color: #CCCCCC;
    border-right-width: 1px;
    border-bottom-width: 1px;
    border-left-width: 1px;}
</style>
<script type="text/javascript">
    function RadEditorOnClientSubmit(editor) {
        editor.set_mode(1); //Force design mode
    }
</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphbody" runat="server">
<div style="width:100%; padding:10px;">
 <div class="box" style="width:1000px; margin:0 auto; padding:10px; ">
<h1>Site Settings</h1> 
 
     <telerik:RadTabStrip ID="RadTabStrip1" runat="server" SelectedIndex="0" 
         MultiPageID="RadMultiPage1" Skin="Metro">
         <Tabs>
             <telerik:RadTab runat="server" Selected="True" Text="CODE" CssClass="tabtitle">
             </telerik:RadTab>
             <telerik:RadTab runat="server" Text="SMTP ACCOUNT" CssClass="tabtitle">
             </telerik:RadTab>
             
         </Tabs>
     </telerik:RadTabStrip>
     <telerik:RadMultiPage ID="RadMultiPage1" runat="server" CssClass="settings" 
         SelectedIndex="0">
             <telerik:RadPageView ID="RadPageView1" runat="server" Selected="true"> 
         <div style="padding:20px">
         <table width="100%">
 <tr><td> 
<asp:FormView ID="FormView1" runat="server" DataKeyNames="site_code" 
            DataSourceID="dssettings"   Width="100%" 
            CellPadding="0" DefaultMode="Edit" >
            <EditItemTemplate>
              <div style="padding:0px; width:100%">
                <h1>Header Code</h1>
                    <telerik:RadEditor ID="RadEditor1" Runat="server"   
                        ToolsFile="~/webparts/radeditor/ToolsFile.xml" Content='<%# Bind("site_headercode")%>'
                        OnClientSubmit="RadEditorOnClientSubmit">                                  
                        <DocumentManager MaxUploadFileSize="10485760" UploadPaths="~/files/documents" ViewPaths="~/files/documents" />
                        <ImageManager MaxUploadFileSize="10485760" UploadPaths="~/files/images" ViewPaths="~/files/images" />
                        <Modules>
                            <telerik:EditorModule Name="RadEditorStatistics"   />
                            <telerik:EditorModule Name="RadEditorDomInspector"  />
                            <telerik:EditorModule Name="RadEditorNodeInspector"  />
                            <telerik:EditorModule Name="RadEditorHtmlInspector" Visible="false"/>
                        </Modules>
                  
                        <FlashManager UploadPaths="~/files/flash" ViewPaths="~/files/flash" MaxUploadFileSize="10485760" />
                    </telerik:RadEditor>
                    <br />
                    <h1>Footer Code</h1>
                    <telerik:RadEditor ID="RadEditor2" Runat="server" 
                        ToolsFile="~/webparts/radeditor/ToolsFile.xml" Content='<%# Bind("site_footercode")%>'
                        OnClientSubmit="RadEditorOnClientSubmit">
                        <DocumentManager MaxUploadFileSize="10485760" UploadPaths="~/files/documents" ViewPaths="~/files/documents" />
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
                    <div align="right" style="padding:0px; width:100%;background-color: #3399FF;z-index:999;">                 
                        <asp:Button ID="btncancel" runat="server" CssClass="button blue" CommandName="Cancel" Text="Cancel" CausesValidation="false" />&nbsp;
                        <asp:Button ID="btnsave" runat="server" CssClass="button blue" Text="Save" CommandName="Update"  CausesValidation="True" />
                    </div>
                </EditItemTemplate>
           
            <ItemTemplate>
             <div style="width:100%; text-align:right">
                 <span style="font-size:15px;float:left">Header Code</span><br />
                 <asp:ImageButton ID="ImageButton1" CommandName="Edit" ImageUrl="~/admin/images/edit.gif" runat="server" /> </div>
            <div style="padding:0px; width:100%; overflow: visible;"><%# Eval("site_headercode")%></div><br />
              <span style="font-size:15px;float:left">Footer Code</span><br />
                   <div style="padding:0px; width:100%; overflow: visible;"><%# Eval("site_headercode")%></div>
            </ItemTemplate>
        </asp:FormView>
        </td></tr></table>
         </div>
         </telerik:RadPageView>
         <telerik:RadPageView ID="RadPageView2" runat="server">
    <div style="padding:20px">
      <table class=" " width="500px">
          <tr>
              <td width="130px">
                  SMTP Host</td>
              <td>
                  <asp:Label ID="lblhost" runat="server"></asp:Label>
              </td>
          </tr>
          <tr>
              <td>
                  SMTP Port</td>
              <td>
                  <asp:Label ID="lblport" runat="server"></asp:Label>
              </td>
          </tr>
          <tr>
              <td>
                  Use SSL</td>
              <td>
                  <asp:CheckBox ID="chkssl" runat="server" Enabled="False" />
              </td>
          </tr>
          <tr>
              <td>
                  Username</td>
              <td>
                  <asp:Label ID="lblusername" runat="server"></asp:Label>
              </td>
          </tr>
          <tr>
              <td>
                  Password</td>
              <td>
                  <asp:Label ID="lblpassword" runat="server"></asp:Label>
              </td>
          </tr>
          <tr>
              <td>
                  Email Address</td>
              <td>
                  <asp:Label ID="lblemailaddress" runat="server"></asp:Label>
              </td>
          </tr>
          <tr>
              <td>
                  &nbsp;</td>
              <td>
                  &nbsp;</td>
          </tr>
          <tr>
              <td style="vertical-align: top">
                  Test Email Account</td>
              <td align="left">
                  <telerik:RadTextBox ID="txtemail" Runat="server" MaxLength="50" 
                          Width="200px" style="top: -4px; left: 0px">
                  </telerik:RadTextBox>
                  &nbsp;<asp:Button ID="btnsend" runat="server" CssClass="cbutton" Text="Send Now" 
                      ToolTip="Click to test SMTP" ValidationGroup="smtptest" />
              </td>
          </tr>
          <tr>
              <td>
                  
                  
               
              </td>
              <td align="left">
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                      ControlToValidate="txtemail" Display="Dynamic" 
                      ErrorMessage="*Test Email Account is Required" ForeColor="Red" 
                      ValidationGroup="smtptest"></asp:RequiredFieldValidator>
                  <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" 
                      ControlToValidate="txtemail" Display="Dynamic" ErrorMessage="Invalid Email" 
                      ForeColor="Red" 
                      ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" 
                      ValidationGroup="smtptest"></asp:RegularExpressionValidator>
              </td>
          </tr>
          <tr>
              <td>&nbsp;</td>
              <td align="left">
                  <asp:Label ID="lblmsg" runat="server" ForeColor="Red"></asp:Label>
              </td>
          </tr>
      </table>
  </div>
  
             </telerik:RadPageView>
     
          
     </telerik:RadMultiPage>
</div>
</div>
 <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" Runat="server" 
          Skin="Metro">
      </telerik:RadAjaxLoadingPanel>
       <asp:SqlDataSource ID="dssettings" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:mugenCMSconn %>" 

                    SelectCommand="SELECT site_code,site_headercode,site_footercode,site_modifiedby,site_modifieddate FROM [techCMS_settings] where site_code='DE'" 
                    
    UpdateCommand="UPDATE [techCMS_settings] SET  [site_headercode] = @site_headercode,  [site_footercode] = @site_footercode, [site_modifieddate] = getdate(), [site_modifiedby] = @site_modifiedby WHERE [site_code] = @site_code">
                   
                   
                    <UpdateParameters>
                        <asp:Parameter Name="site_headercode" Type="String" />
                         <asp:Parameter Name="site_footercode" Type="String" />
                        <asp:Parameter Type="DateTime" Name="site_modifieddate" />
                        <asp:Parameter Name="site_modifiedby" Type="String" />
                        <asp:Parameter Name="site_code" Type="String" />
                    </UpdateParameters>
                   
                </asp:SqlDataSource>
</asp:Content>
