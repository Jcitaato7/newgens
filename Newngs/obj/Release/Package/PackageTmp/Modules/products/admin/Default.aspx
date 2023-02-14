<%@ Page Title="Products" Language="vb" AutoEventWireup="false" MasterPageFile="~/Masterpages/CMSAdmin.Master" CodeBehind="Default.aspx.vb" Inherits="tfsCMS._Products_Default" Theme="admin" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
     <script type="text/jscript" src='<%=Page.ResolveClientURL("~/Scripts/JScript.js") %>'></script>
    
          <style type="text/css">
        .style1
        {
            width: 100%;
        }
        
              .style3
              {
              }
    
    </style>
    <script type="text/javascript">
        function OnClientLoad(editor, args) {

            var style = editor.get_contentArea().style;
            style.backgroundImage = "none";
            style.backgroundColor = "transparent";
            //remove min-width of editor which were set as default
            var elem = editor.get_element();
            elem.style.minWidth = "";

        }

        function PopUpShowing(sender, eventArgs) {

            popUp = eventArgs.get_popUp();
            var gridWidth = sender.get_element().offsetWidth;
            var gridHeight = sender.get_element().offsetHeight;
            var popUpWidth = popUp.style.width.substr(0, popUp.style.width.indexOf("px"));
            var popUpHeight = popUp.style.height.substr(0, popUp.style.height.indexOf("px"));
            popUp.style.left = ((gridWidth - popUpWidth) / 2 + sender.get_element().offsetLeft).toString() + "px";
            popUp.style.top = ((gridHeight - popUpHeight) / 2 + sender.get_element().offsetTop).toString() + "px";

        }

        function ManageTabPanelDisplay() {

            var idlist = new Array('tab1focus', 'tab2focus', 'tab3focus', 'tab1ready', 'tab2ready', 'tab3ready', 'content1', 'content2', 'content3');

            if (arguments.length < 1) { return; }
            for (var i = 0; i < idlist.length; i++) {
                var block = false;
                for (var ii = 0; ii < arguments.length; ii++) {
                    if (idlist[i] == arguments[ii]) {
                        block = true;
                        break;
                    }
                }
                if (block) { document.getElementById(idlist[i]).style.display = "block"; }
                else { document.getElementById(idlist[i]).style.display = "none"; }
            }
        }

        function UpdateSettings(code) {
            window.radopen("/Modules/common/settings.aspx?code=" + code, "formsettings");
            return false;
        }

        function RadEditorOnClientSubmit(editor) {
            editor.set_mode(1); //Force design mode
        }
    </script>
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
            <script type="text/javascript">
                //Rad Asynchronous Upload
                var uploadedFilesCount = 0;
                var isEditMode;
                function validateRadUpload(source, e) {
                    debugger;
                    if (isEditMode == null || isEditMode == undefined) {
                        e.IsValid = false;

                        if (uploadedFilesCount > 0) {
                            e.IsValid = true;
                        }
                    }
                    isEditMode = null;
                }

                function OnClientFileUploaded(sender, eventArgs) {
                    uploadedFilesCount++;

                }
                function validationFailed(sender, args) {
                    $telerik.$(".invalid")
                .html("Invalid extension, please choose an image file");
                    sender.deleteFileInputAt(0);
                }
                //Ends Rad Asynchronous Upload         
            </script>
        </telerik:RadCodeBlock>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphbody" Runat="Server">
<div style="padding:10px;">
    <div class="box" style="width:1100px; margin:0 auto; padding:10px;">
        <h1>
            Manage Products
        </h1>        
        <telerik:RadGrid ID="RadGrid1" runat="server"
            GridLines="None" AllowPaging="True" AutoGenerateColumns="False" 
            PageSize="15" Skin="Metro" Width="100%" AllowFilteringByColumn="True">
            <GroupingSettings CaseSensitive="false" /> 
                <MasterTableView DataKeyNames="ProductID" EditMode="PopUp" CommandItemDisplay="Top" CommandItemStyle-HorizontalAlign="Left"
                        AllowFilteringByColumn="True" InsertItemPageIndexAction="ShowItemOnCurrentPage">
                    <RowIndicatorColumn FilterControlAltText="Filter RowIndicator column">
                    <HeaderStyle Width="20px"></HeaderStyle>
    
                    </RowIndicatorColumn>

                    <ExpandCollapseColumn FilterControlAltText="Filter ExpandColumn column">
                    <HeaderStyle Width="20px"></HeaderStyle>
                    </ExpandCollapseColumn>

                    <CommandItemSettings ExportToPdfText="Export to Pdf" AddNewRecordText="Add Product">
                    </CommandItemSettings>

                    <Columns>
                        <telerik:GridBoundColumn DataField="ProductID" DataType="System.Int64" 
                            FilterControlAltText="Filter ProductID column" HeaderText="ProductID" 
                            ReadOnly="True" SortExpression="ProductID" UniqueName="ProductID" 
                            Display="False">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="ProductName" 
                            FilterControlAltText="Filter ProductName column" HeaderText="Name" 
                            SortExpression="ProductName" UniqueName="ProductName"
                            AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="250px">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="ManufacturerName" 
                            FilterControlAltText="Filter ManufacturerName column" HeaderText="Category" 
                            SortExpression="ManufacturerName" UniqueName="ManufacturerName"
                            AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="250px">
                        </telerik:GridBoundColumn>
                        <telerik:GridTemplateColumn UniqueName="TemplateColumn" HeaderText="Active?" AllowFiltering="false">
                            <HeaderStyle Width="3%" />
                            <ItemStyle HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:ImageButton ID="ImageButton3" runat="server" CommandName="IsActive" ToolTip="Activate/Deactivate this product" AlternateText='<%# IIF(Eval("IsActive"), "Active","Inactive") %>'
                                    ImageUrl='<%# IIf(Eval("IsActive"), "~/app_themes/admin/images/checkbox-checked.png", "~/app_themes/admin/images/checkbox-unchecked.png")%>'
                                    OnClientClick="return confirm('Activate/Deactivate this product?');" Height="15px" Width="15px" />
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn UniqueName="TemplateColumn" HeaderText="Featured?" AllowFiltering="false">
                            <HeaderStyle Width="3%" />
                            <ItemStyle HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:ImageButton ID="ImageButton1" runat="server" CommandName="Feature" ToolTip="Feature this Product" AlternateText="Feature"
                                    ImageUrl='<%# IIf(Eval("IsFeatured"), "~/app_themes/admin/images/featured.png", "~/app_themes/admin/images/not-featured.png")%>'
                                    OnClientClick="return confirm('Are you sure you want to feature/un-feature this product?');" />
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridEditCommandColumn ButtonType="ImageButton" EditImageUrl="~/app_themes/admin/images/edit.gif">
                            <HeaderStyle Width="3%" />
                        </telerik:GridEditCommandColumn>
                        <telerik:GridButtonColumn Text="Delete" CommandName="Delete" ConfirmDialogType="RadWindow" ConfirmTitle="Sure?" ButtonType="ImageButton" ImageUrl="~/app_themes/admin/images/delete.gif" ConfirmText="Are you sure you want to delete this product? All other colors will be deleted too.">
                            <HeaderStyle Width="2%" />
                        </telerik:GridButtonColumn>
                    </Columns>
                    <EditFormSettings EditFormType="Template">
                    <EditColumn FilterControlAltText="Filter EditCommandColumn column"></EditColumn>
                        <FormTemplate>
                            <div class="jstab-buttons">
                                <div id="tab1focus" class="tab-adm tabfocus-adm" style="float:left;">
                                    <a name="tab1" href="javascript:ManageTabPanelDisplay('tab1focus','tab2ready','tab3ready','content1')">Product Details</a>
                                </div>
                                <div id="tab1ready" class="tab-adm tabhold-adm" style="display:none; float: left;">
                                <!-- Between the parenthesis, provide a list of ids that are to 
                                        be visible when this tab is clicked. The ids are between 
                                        single quotes (apostrophes) and separated with a comma. -->
                                    <a name="tab1" href="javascript:ManageTabPanelDisplay('tab1focus','tab2ready','tab3ready','content1')">Product Details</a>
                                </div>
                                <div id="tab2focus" class="tab-adm tabfocus-adm" style="display:none; float:left;">
                                    <a name="tab2" href="javascript:ManageTabPanelDisplay('tab1ready','tab2focus','tab3ready','content2')">Description</a>
                                </div>
                                <div id="tab2ready" class="tab-adm tabhold-adm" style="display:block; float: left;">
                                    <a name="tab2" href="javascript:ManageTabPanelDisplay('tab1ready','tab2focus','tab3ready','content2')">Description</a>
                                </div>
                                <div id="tab3focus" class="tab-adm tabfocus-adm" style="display:none; float:left;">
                                    <a name="tab3" href="javascript:ManageTabPanelDisplay('tab1ready','tab2ready','tab3focus','content3')">SEO Details</a>
                                </div>
                                <div id="tab3ready" class="tab-adm tabhold-adm" style="display:block; float: left;">
                                    <a name="tab3" href="javascript:ManageTabPanelDisplay('tab1ready','tab2ready','tab3focus','content3')">SEO Details</a>
                                </div>
                                <div style="clear:both;"></div>             
                            </div>
                            <div id="content1" class="adminPopUp tabcontent-adm">
                                <h2>Product Details</h2>
                                <table width="100%">        
                                    <tr>
                                        <td style="vertical-align: top">
                                            Product Name
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" 
                                                ControlToValidate="txtProductName" Display="Dynamic" ErrorMessage="Product Name is required."
                                                ValidationGroup="ProductMgntValGroup">*</asp:RequiredFieldValidator>
                                        </td>
                                        <td>
                                            <telerik:RadTextBox ID="txtProductName" Runat="server" Text='<%# Bind("ProductName") %>' 
                                                Width="400px" MaxLength="256">
                                            </telerik:RadTextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="vertical-align: top">
                                            Category
                                            <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator8" ControlToValidate="ddlCategory" Display="Dynamic" InitialValue="0" 
                                                ValidationGroup="ProductMgntValGroup" ErrorMessage="Category is required.">*</asp:RequiredFieldValidator>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="ddlCategory" runat="server"
                                                Width="400px">            
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="vertical-align: top">
                                            Short Description
                                            <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" 
                                                ControlToValidate="txtShortDescription" Display="Dynamic" ErrorMessage="Short Description is required."
                                                ValidationGroup="ProductMgntValGroup">*</asp:RequiredFieldValidator>--%>
                                        </td>
                                        <td>
                                            <telerik:RadTextBox ID="txtShortDescription" Runat="server" Height="40px" MaxLength="150" 
                                                Skin="Sitefinity" Text='<%# Bind("ShortDescription") %>' TextMode="MultiLine"
                                                Width="400px">
                                            </telerik:RadTextBox>
                                        </td>
                                    </tr>              
                                    <tr>
                                        <td>
                                            <%--Product Sort--%></td>
                                        <td colspan="2">  
                                            <%--<telerik:RadNumericTextBox ID="txtProductSort" runat="server" MaxLength="5"
                                                Skin="Telerik" Text='<%# Bind("ProductSort") %>' Width="25px" NumberFormat-DecimalDigits="0">
                                            </telerik:RadNumericTextBox>&nbsp;&nbsp;--%>
                                            Is Featured?&nbsp;<asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Bind("IsFeatured") %>' />
                                            Is Active?&nbsp;<asp:CheckBox ID="CheckBox2" runat="server" Checked='<%# Bind("IsActive") %>' />
                                            <%--Enable Add To Cart?&nbsp;<asp:CheckBox ID="CheckBox3" runat="server" Checked='<%# Bind("EnableAddToCart") %>' />--%>
                                        </td>
                                    </tr>                             
                                    <tr>
                                        <td colspan="3"> 
                                            <%# IIf((TypeOf (Container) Is GridEditFormInsertItem), "", "Created by <b>" + Eval("CreatedBy") + "</b> on <b>" + Eval("DateCreated") + "</b>")%>
                                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                            <%# IIf((TypeOf (Container) Is GridEditFormInsertItem), "", IIf(IsDBNull(Eval("ModifiedBy")), "", "Modified by <b>" + Eval("ModifiedBy") + "</b> on <b>" + Eval("DateModified") + "</b>"))%>
                                        </td>                 
                                    </tr>           
                                </table>
                            </div>
                            <div id="content2" class="tabcontent-adm" style="display:none;">
                                <h2>Product Description
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                                        ControlToValidate="redFullDescription" Display="Dynamic" ErrorMessage="Product Description is required." 
                                        ValidationGroup="ProductMgntValGroup">*</asp:RequiredFieldValidator>                
                                </h2>
                                <telerik:RadEditor ID="redFullDescription" Runat="server" height="350px" Width="100%" SkinID="SettingProperties"
                                    ToolsFile="~/webparts/radeditor/ToolsFile.xml" OnClientLoad="OnClientLoad" MaxTextLength="10000" 
                                    Content='<%# Bind("FullDescription") %>' StripFormattingOptions="MsWord,Span,Css,ConvertWordLists" OnClientSubmit="RadEditorOnClientSubmit">
                                    <CssFiles>
                                        <telerik:EditorCssFile Value="~/webparts/radeditor/css/StyleSheet.css" />
                                    </CssFiles> 
                                    <DocumentManager MaxUploadFileSize="10485760" UploadPaths="~/files/documents" ViewPaths="~/files/documents" /> 
                                    <ImageManager MaxUploadFileSize="10485760" UploadPaths="~/files/images" ViewPaths="~/files/images" />
                                    <FlashManager UploadPaths="~/files/flash" ViewPaths="~/files/flash" MaxUploadFileSize="10485760" />
                                    <Modules>
                                        <telerik:EditorModule Name="RadEditorStatistics"   />
                                        <telerik:EditorModule Name="RadEditorDomInspector"  />
                                        <%--<telerik:EditorModule Name="RadEditorNodeInspector"  />--%>
                                        <telerik:EditorModule Name="RadEditorHtmlInspector" Visible="false"/>
                                    </Modules>                                                      
                                </telerik:RadEditor>
                            </div>
                            <div id="content3" class="tabcontent-adm" style="display:none;">
                                <h2>SEO Details</h2>
                                <table width="100%">        
                                    <tr>
                                        <td style="vertical-align: top">
                                            Page Title
                                        </td>
                                        <td>
                                            <telerik:RadTextBox ID="txtPageTitle" Runat="server" Text='<%# Bind("PageTitle") %>' 
                                                Width="400px" MaxLength="256">
                                            </telerik:RadTextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="vertical-align: top">
                                            Meta Description
                                        </td>
                                        <td>
                                            <telerik:RadTextBox ID="txtMetaDescription" Runat="server" Height="40px" MaxLength="256" 
                                                Skin="Sitefinity" Text='<%# Bind("MetaDescription")%>' TextMode="MultiLine"
                                                Width="400px">
                                            </telerik:RadTextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="vertical-align: top">
                                            Meta Keywords <i>(Separated by comma)</i>
                                        </td>
                                        <td>
                                            <telerik:RadTextBox ID="txtMetaKeywords" Runat="server" Height="40px" MaxLength="512" 
                                                Skin="Sitefinity" Text='<%# Bind("MetaKeywords") %>' TextMode="MultiLine"
                                                Width="400px">
                                            </telerik:RadTextBox>
                                        </td>
                                    </tr>                 
                                </table>
                            </div>
<%--                            <div id="content3" class="tabcontent-adm" style="display:none;">
                                <h1>Embed Video Code</h1>
                                <telerik:RadEditor ID="RadEditor1" Runat="server" Width="100%" SkinID="SettingProperties"
                                    EditModes="Html,Preview" MaxTextLength="1000" 
                                    Content='<%# Bind("Video") %>' 
                                    ToolsFile="~/admin/ToolsFileforVideo.xml">
                                </telerik:RadEditor> 
                            </div>--%>
                            <div style="float:Left; padding: 5px;">
                                <asp:ValidationSummary ID="ValidationSummary1" runat="server" ValidationGroup="ProductMgntValGroup" />
                            </div>
                            <div style="float:right">
                                <asp:Button ID="btnCancel" runat="server" CausesValidation="False" 
                                    CommandName="Cancel" Text="Cancel" />&nbsp;
                                <asp:Button ID="btnUpdate" runat="server" 
                                    CommandName='<%# IIf((TypeOf(Container) is GridEditFormInsertItem), "PerformInsert", "Update")%>' 
                                    Text='<%# IIf((TypeOf(Container) is GridEditFormInsertItem), "Insert", "Update") %>' 
                                    ValidationGroup="ProductMgntValGroup" />
                            </div>
                            <div style="clear:both;"></div>
                        </FormTemplate>   
                        <PopUpSettings Modal="True" Height="550px" Width="600px" />   
                        </EditFormSettings>
                        <CommandItemStyle HorizontalAlign="Right"></CommandItemStyle>
                    </MasterTableView>
                    <ClientSettings>
                        <ClientEvents OnPopUpShowing="PopUpShowing" />
                        <Selecting AllowRowSelect="true" />
                    </ClientSettings>
                    <FilterMenu EnableImageSprites="False"></FilterMenu>
                    <HeaderContextMenu CssClass="GridContextMenu GridContextMenu_Default"></HeaderContextMenu>         
        </telerik:RadGrid>
    </div>
</div>
<telerik:RadWindowManager ID="RadWindowManager1" runat="server" 
    Behavior="Close"
    Skin="Metro" Style="z-index:10000"
    Modal="True" VisibleStatusbar="False"  DestroyOnClose="true"
    Behaviors="Close">
    <Windows>
        <telerik:RadWindow ID="formsettings" runat="server" Width="600px" Height="550px"  Title="" Modal="true" />    
    </Windows>
</telerik:RadWindowManager>
</asp:Content>