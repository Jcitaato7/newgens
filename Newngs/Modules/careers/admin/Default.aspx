<%@ Page Title="Job Applications" Language="vb" AutoEventWireup="false" MasterPageFile="~/Masterpages/CMSAdmin.Master" CodeBehind="Default.aspx.vb" Inherits="tfsCMS._Default8" Theme="admin" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphbody" runat="server">
    <script type="text/javascript">
    function UpdateSettings(code) {
        window.radopen("/Modules/common/settings.aspx?code=" + code, "formsettings");
        return false;
    }
    var popUp;
    function PopUpShowing(sender, eventArgs) {
        popUp = eventArgs.get_popUp();
        var gridWidth = sender.get_element().offsetWidth;
        var gridHeight = sender.get_element().offsetHeight;
        var popUpWidth = popUp.style.width.substr(0, popUp.style.width.indexOf("px"));
        var popUpHeight = popUp.style.height.substr(0, popUp.style.height.indexOf("px"));
        popUp.style.left = ((gridWidth - popUpWidth) / 2 + sender.get_element().offsetLeft).toString() + "px";
        popUp.style.top = "50px"; //((gridHeight - popUpHeight) / 2 + sender.get_element().offsetTop).toString() + "px";
    }
</script>
<div style="width:100%; padding:10px;">
 <div class="box" style="width:1100px; margin:0 auto; padding:10px;">
    <h1>
        Manage Job Applications
    </h1>
    <div style="width:100%; text-align:right"><a onclick="return UpdateSettings('JA');" class="button blue" >Notification Settings</a></div>
<br />     
     <telerik:RadTabStrip ID="RadTabStrip1" runat="server" Skin="Silk" 
                    MultiPageID="RadMultiPage1" SelectedIndex="0">
                    <Tabs>
                        <telerik:RadTab runat="server" Text="Job Applications" Selected="True" SelectedIndex="0">
                        </telerik:RadTab>
                        <telerik:RadTab runat="server" Text="Job Vacancies">
                        </telerik:RadTab>
                    </Tabs>
                </telerik:RadTabStrip>
                <telerik:RadMultiPage ID="RadMultiPage1" runat="server" SelectedIndex="0">
                    <telerik:RadPageView ID="RadPageView1" runat="server" Selected="true">
                        <telerik:RadGrid ID="RadGrid1" runat="server" AutoGenerateColumns="False"  Skin="Metro"
         CellSpacing="0" DataSourceID="dsjobapplications" GridLines="None" 
         AllowAutomaticDeletes="True" AllowPaging="True" PageSize="15">
         <ClientSettings>
<Selecting CellSelectionMode="None" AllowRowSelect="True"></Selecting>
</ClientSettings>
<MasterTableView DataKeyNames="id" DataSourceID="dsjobapplications">
<CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>

<RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
<HeaderStyle Width="20px"></HeaderStyle>
</RowIndicatorColumn>

<ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
<HeaderStyle Width="20px"></HeaderStyle>
</ExpandCollapseColumn>

    <Columns>
        <telerik:GridBoundColumn DataField="id" DataType="System.Int32" Display="False" 
            FilterControlAltText="Filter id column" HeaderText="id" ReadOnly="True" 
            SortExpression="id" UniqueName="id">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="name" 
            FilterControlAltText="Filter name column" HeaderText="Name" 
            SortExpression="name" UniqueName="name">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="mail" 
            FilterControlAltText="Filter mail column" HeaderText="Email" 
            SortExpression="mail" UniqueName="mail">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="phone" 
            FilterControlAltText="Filter phone column" HeaderText="Phone" 
            SortExpression="phone" UniqueName="phone">
        </telerik:GridBoundColumn>
          
       <telerik:GridTemplateColumn FilterControlAltText="Filter TemplateColumn1 column" 
            HeaderText="CV" UniqueName="TemplateColumn1">
            <ItemTemplate><asp:HyperLink ID="HyperLink3" runat="server" 
                                        NavigateUrl='<%# "~/Modules/careers/attachments/" + Eval("attachment") %>' 
                                        Text='<%# Eval("attachment") %>' Target="_blank"></asp:HyperLink>
            </ItemTemplate>
        </telerik:GridTemplateColumn>
         <telerik:GridDropDownColumn HeaderText="Position" DataField="job_positionid" DataSourceID="dsvacancies" EnableEmptyListItem="True" FilterControlAltText="Filter job_positionid column" ListTextField="VacancyName" ListValueField="VacancyID" UniqueName="job_positionid">
        </telerik:GridDropDownColumn>
        <telerik:GridBoundColumn DataField="datesubmitted" 
            DataFormatString="{0:dd/MM/yyyy}" DataType="System.DateTime" 
            FilterControlAltText="Filter datesubmitted column" HeaderText="Date Submitted" 
            SortExpression="datesubmitted" UniqueName="datesubmitted">
        </telerik:GridBoundColumn>
         <telerik:GridButtonColumn Text="Delete" CommandName="Delete" ConfirmDialogType="RadWindow" ConfirmTitle="Sure?" ButtonType="ImageButton" ImageUrl="~/app_themes/admin/images/delete.gif" ConfirmText="Are you sure you want to delete this item?">
                        <HeaderStyle Width="2%" />
                    </telerik:GridButtonColumn>
        
       
        
    </Columns>

<EditFormSettings>
<EditColumn FilterControlAltText="Filter EditCommandColumn column"></EditColumn>
</EditFormSettings>
    <PagerStyle PageSizeControlType="RadComboBox" />
</MasterTableView>

                            <PagerStyle PageSizeControlType="RadComboBox" />

<FilterMenu EnableImageSprites="False"></FilterMenu>
     </telerik:RadGrid>
</telerik:RadPageView>
                    <telerik:RadPageView ID="RadPageView2" runat="server">
                     
     <telerik:RadGrid ID="RadGrid2" runat="server" DataSourceID="dsvacancies" 
                    GridLines="None" AllowPaging="True" AutoGenerateColumns="False" 
                    PageSize="15" Skin="Metro" AllowAutomaticDeletes="True" Width="100%" 
                    AllowAutomaticInserts="True" AllowAutomaticUpdates="True">
                  
<MasterTableView DataKeyNames="VacancyID" DataSourceID="dsvacancies" EditMode="PopUp" 
                        CommandItemDisplay="Top" CommandItemStyle-HorizontalAlign="Right">

<RowIndicatorColumn FilterControlAltText="Filter RowIndicator column">
<HeaderStyle Width="20px"></HeaderStyle>
</RowIndicatorColumn>

<ExpandCollapseColumn FilterControlAltText="Filter ExpandColumn column">
<HeaderStyle Width="20px"></HeaderStyle>
</ExpandCollapseColumn>

    <Columns>
        <telerik:GridBoundColumn DataField="VacancyID" DataType="System.Int32" 
            FilterControlAltText="Filter VacancyID column" HeaderText="VacancyID" 
            ReadOnly="True" SortExpression="VacancyID" UniqueName="VacancyID" 
            Display="False">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="VacancyName" 
            FilterControlAltText="Filter VacancyName column" HeaderText="Position" 
            SortExpression="VacancyName" UniqueName="VacancyName">
        </telerik:GridBoundColumn>

        <telerik:GridCheckBoxColumn DataField="IsActive" 
            DataType="System.Boolean" FilterControlAltText="Filter IsActive column" 
            HeaderText="Active" SortExpression="IsActive" 
            UniqueName="IsActive">
        </telerik:GridCheckBoxColumn>
           <telerik:GridBoundColumn DataField="CreatedBy" 
            FilterControlAltText="Filter CreatedBy column" 
            HeaderText="Created By" SortExpression="CreatedBy" 
            UniqueName="CreatedBy">
        </telerik:GridBoundColumn>

        <telerik:GridBoundColumn DataField="DateCreated" 
            FilterControlAltText="Filter DateCreated column" HeaderText="Created Date" 
            SortExpression="DateCreated" UniqueName="DateCreated" 
            DataType="System.DateTime">
        </telerik:GridBoundColumn>
        <telerik:GridEditCommandColumn ButtonType="ImageButton" EditImageUrl="~/app_themes/admin/images/edit.gif"  >
                        <HeaderStyle Width="3%" />
                    </telerik:GridEditCommandColumn>
                    <telerik:GridButtonColumn Text="Delete" CommandName="Delete" ConfirmDialogType="RadWindow" ConfirmTitle="Sure?" ButtonType="ImageButton" ImageUrl="~/app_themes/admin/images/delete.gif" ConfirmText="Are you sure you want to delete this item?">
                        <HeaderStyle Width="2%" />
                    </telerik:GridButtonColumn>
    </Columns>

<EditFormSettings EditFormType="Template">
<EditColumn FilterControlAltText="Filter EditCommandColumn column"></EditColumn>
    <FormTemplate>
        <table   width="100%">
            <tr>
                <td class="style3">
                    Vacancy&nbsp;Name&nbsp;&nbsp;&nbsp;&nbsp;
                    <telerik:RadTextBox ID="txttitle" Runat="server" MaxLength="100" 
                        Text='<%# Bind("VacancyName") %>' Width="400px">
                    </telerik:RadTextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                        ControlToValidate="txttitle" Display="Dynamic" ErrorMessage="*Required"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td>
                    Short Description
                    <telerik:RadTextBox ID="txtShortDescription" Runat="server" MaxLength="150" 
                        Skin="Sitefinity" Text='<%# Bind("ShortDescription") %>'
                        Width="400px">
                    </telerik:RadTextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" 
                        ControlToValidate="txtShortDescription" Display="Dynamic" ErrorMessage="*Required" 
                        ValidationGroup="ProductCategoryMgntValGroup">*</asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td class="style3">
                    Description</td>
            </tr>
            <tr><td>
                <telerik:RadEditor ID="RadEditor1" Runat="server" height="450px" Width="100%"   
                             ToolsFile="~/webparts/radeditor/ToolsFile.xml" 
                    MaxTextLength="5000" Skin="Windows7"  ContentFilters="RemoveScripts, MakeUrlsAbsolute, FixUlBoldItalic, FixEnclosingP, IECleanAnchors, MozEmStrong, ConvertFontToSpan, IndentHTMLContent"  
                                Content='<%# Bind("FullDescription") %>'>
                                <CssFiles>
                                    <telerik:EditorCssFile Value="~/app_themes/default/radeditor.css" />
                                </CssFiles>    
                                <DocumentManager MaxUploadFileSize="10485760" UploadPaths="~/files/documents" ViewPaths="~/files/documents" /> 
                                <ImageManager MaxUploadFileSize="10485760" UploadPaths="~/files/images" ViewPaths="~/files/images" />                             
                               <Modules>
                                    <telerik:EditorModule Name="RadEditorStatistics"   />
                                    <telerik:EditorModule Name="RadEditorDomInspector"  />
                                    <telerik:EditorModule Name="RadEditorNodeInspector"  />
                                    <telerik:EditorModule Name="RadEditorHtmlInspector" Visible="false"/>
                                </Modules>
                  
                                <FlashManager UploadPaths="~/files/flash" ViewPaths="~/files/flash" MaxUploadFileSize="10485760" />
                               <CssFiles>
       <telerik:EditorCssFile Value="~/webparts/news/css/StyleSheet.css" />
   </CssFiles>
   </telerik:RadEditor>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                    ControlToValidate="RadEditor1" Display="Dynamic" ErrorMessage="*Required"></asp:RequiredFieldValidator>
            </td></tr>
            <tr>
                <td class="style3">
                    Is Active&nbsp;
                    <asp:CheckBox ID="CheckBox1" runat="server" 
                        Checked='<%# Bind("IsActive") %>' />
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                </td>
            </tr>
            <tr>
                <td>
                   <%# IIf((TypeOf (Container) Is GridEditFormInsertItem), "", "Created by <b>" + Eval("CreatedBy") + "</b> on <b>" + Eval("DateCreated") + "</b>")%> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  <%# IIf((TypeOf (Container) Is GridEditFormInsertItem), "", "Modified by <b>" + Eval("ModifiedBy") + "</b> on <b>" + Eval("DateModified") + "</b>")%> </td>
                <td>
                    
                </td>
            </tr>
            <tr>
               <td><asp:Button ID="btnCancel" Text="Cancel" runat="server" CausesValidation="False"
CommandName="Cancel"></asp:Button>&nbsp;<asp:Button ID="btnUpdate"  ValidationGroup="editform"  Text='<%# IIf((TypeOf(Container) is GridEditFormInsertItem), "Insert", "Update") %>'
                                        runat="server" CommandName='<%# IIf((TypeOf(Container) is GridEditFormInsertItem), "PerformInsert", "Update")%>'>
        </asp:Button></td> </tr>
        </table>
    </FormTemplate>
    <PopUpSettings Width="700px" Height="620px" />
</EditFormSettings>
     
</MasterTableView>
 <ClientSettings>
       <ClientEvents OnPopUpShowing="PopUpShowing" />
       <Selecting AllowRowSelect="true" />
   </ClientSettings>
<FilterMenu EnableImageSprites="False"></FilterMenu>

<HeaderContextMenu CssClass="GridContextMenu GridContextMenu_Default"></HeaderContextMenu>
             
                </telerik:RadGrid>
                      
                    </telerik:RadPageView>
                    
                </telerik:RadMultiPage>
     
        <asp:SqlDataSource ID="dsjobapplications" runat="server" 
         ConnectionString="<%$ ConnectionStrings:tfsCMSconn %>" 
         DeleteCommand="DELETE FROM [job_applications] WHERE [id] = @id" 
         InsertCommand=" " 
         SelectCommand="SELECT [id], [name], [mail], [phone], [coverletter], [attachment], [datesubmitted],job_positionid FROM [job_applications] ORDER BY [id] DESC" 
         UpdateCommand=" ">
         <DeleteParameters>
             <asp:Parameter Name="id" Type="Int32" />
         </DeleteParameters>
     </asp:SqlDataSource>
    </div>
        </div>
          <telerik:RadWindowManager ID="RadWindowManager1" runat="server" 
             Behavior="Close"
            Skin="Metro" Style="z-index:10000"
                  Modal="True" VisibleStatusbar="False"  DestroyOnClose="true"
            Behaviors="Close">
        <Windows>
                   <telerik:RadWindow ID="formsettings" runat="server" Width="500px" Height="400px"  Title="" Modal="true"   />
    
        </Windows>
        </telerik:RadWindowManager> 
    <asp:SqlDataSource ID="dsvacancies" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:tfsCMSconn %>" 
                    DeleteCommand=" " 
                    InsertCommand="INSERT INTO [techCMS_Vacancies] ([VacancyName], [ShortDescription], [FullDescription], [IsActive], [CreatedBy],  [DateCreated]) VALUES (@VacancyName, @ShortDescription, @FullDescription, @IsActive, @CreatedBy,  getdate() )" 
                    SelectCommand="SELECT [VacancyID], [VacancyName], [ShortDescription], [FullDescription], [IsActive], [CreatedBy], [ModifiedBy],convert(char(10),DateCreated,103) as DateCreated, [DateModified] FROM [techCMS_Vacancies] ORDER BY [VacancyID] DESC" 
                    
                    UpdateCommand="UPDATE [techCMS_Vacancies] SET [VacancyName] = @VacancyName, [ShortDescription] = @ShortDescription, [FullDescription] = @FullDescription, [IsActive] = @IsActive,   [ModifiedBy] = @ModifiedBy,  [DateModified] = getdate() WHERE [VacancyID] = @VacancyID">
                    <InsertParameters>
                        <asp:Parameter Name="VacancyName" Type="String" />
                        <asp:Parameter Name="ShortDescription" Type="String" />
                        <asp:Parameter Name="FullDescription" Type="String" />
                        <asp:Parameter Name="IsActive" Type="Boolean" />
                        <asp:Parameter Name="CreatedBy" Type="String" />
                    </InsertParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="VacancyName" Type="String" />
                        <asp:Parameter Name="ShortDescription" Type="String" />
                        <asp:Parameter Name="FullDescription" Type="String" />
                        <asp:Parameter Name="IsActive" Type="Boolean" />
                        <asp:Parameter Name="ModifiedBy" Type="String" />
                        <asp:Parameter Name="VacancyID" Type="Int32" />
                    </UpdateParameters>
                </asp:SqlDataSource>
</asp:Content>
