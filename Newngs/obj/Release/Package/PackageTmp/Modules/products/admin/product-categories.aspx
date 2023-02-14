<%@ Page Title="Product Brands" Language="vb" AutoEventWireup="false" MasterPageFile="~/Masterpages/CMSAdmin.Master" CodeBehind="product-categories.aspx.vb" Inherits="tfsCMS._Product_Categories_Default" Theme="admin" %>
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

        function UpdateSettings(code) {
            window.radopen("/Modules/common/settings.aspx?code=" + code, "formsettings");
            return false;
        }

        function WebURLValidation(oSrouce, args) {            
            var weburl = $("[id$=txtUrl]").val();

            if (!validateURL(weburl))
                args.IsValid = false;
            else
                args.IsValid = true;
        }

        function validateURL(value) {
            return /^(https?|ftp):\/\/(((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:)*@)?(((\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5]))|((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.?)(:\d*)?)(\/((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)+(\/(([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)*)*)?)?(\?((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)|[\uE000-\uF8FF]|\/|\?)*)?(\#((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)|\/|\?)*)?$/i.test(value);
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
            Manage Product Categories
        </h1>
        <telerik:RadGrid ID="RadGrid1" runat="server"
            GridLines="None" AllowPaging="True" AutoGenerateColumns="False" AllowFilteringByColumn="true"
            PageSize="15" Skin="Metro" AllowAutomaticDeletes="True" Width="100%">
            <GroupingSettings CaseSensitive="false" />
            <MasterTableView DataKeyNames="ProductCategoryID" EditMode="PopUp" CommandItemDisplay="Top" CommandItemStyle-HorizontalAlign="Left"
                AllowFilteringByColumn="true" InsertItemPageIndexAction="ShowItemOnCurrentPage">
    <%--            <CommandItemTemplate>
                    <div style="text-align:left; width: 300px; float: left; padding: 5px 10px;">
                        <asp:LinkButton ID="LinkButton2" runat="server" CommandName="InitInsert" Visible='<%# Not RadGrid1.MasterTableView.IsItemInserted %>'><asp:Image ID="Image3" runat="server" ImageUrl="~/app_themes/admin/images/AddRecord.gif" />Add Product Category</asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="btnAddProduct" runat="server" PostBackUrl="~/Modules/Products/admin/Default.aspx"><asp:Image ID="Image2" runat="server" ImageUrl="~/app_themes/admin/images/photocat.png" />Manage Products</asp:LinkButton>
                    </div>
                    <div style="text-align:right; width: 300px; float: right; padding: 5px 10px;">
                        <asp:LinkButton ID="LinkButton4" runat="server" CommandName="RebindGrid"><asp:Image ID="Image4" runat="server" ImageUrl="~/app_themes/admin/images/Refresh.gif" />Refresh</asp:LinkButton>        
                    </div>
                </CommandItemTemplate>--%>
                <RowIndicatorColumn FilterControlAltText="Filter RowIndicator column">
                <HeaderStyle Width="20px"></HeaderStyle>
    
                </RowIndicatorColumn>

                <ExpandCollapseColumn FilterControlAltText="Filter ExpandColumn column">
                <HeaderStyle Width="20px"></HeaderStyle>
                </ExpandCollapseColumn>

                <CommandItemSettings ExportToPdfText="Export to Pdf" AddNewRecordText="Add Category">
                </CommandItemSettings>

                    <Columns>
                        <telerik:GridBoundColumn DataField="ProductCategoryID" DataType="System.Int64" 
                            FilterControlAltText="Filter ProductCategoryID column" HeaderText="ProductCategoryID" 
                            ReadOnly="True" SortExpression="ProductCategoryID" UniqueName="ProductCategoryID" 
                            Display="False">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="CategoryName" 
                            FilterControlAltText="Filter CategoryName column" HeaderText="Category Name" 
                            SortExpression="CategoryName" UniqueName="CategoryName"
                            AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="250px">
                        </telerik:GridBoundColumn>
<%--                        <telerik:GridBoundColumn DataField="CategoryParentName" 
                            FilterControlAltText="Filter CategoryParentName column" HeaderText="Parent Category" 
                            SortExpression="CategoryParentName" UniqueName="CategoryParentName"
                            AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="250px">
                        </telerik:GridBoundColumn>--%>
                        <telerik:GridBoundColumn DataField="CategorySort" 
                            FilterControlAltText="Filter CategorySort column" HeaderText="Sort" 
                            SortExpression="CategorySort" UniqueName="CategorySort" AllowFiltering="false">
                        </telerik:GridBoundColumn>
    <%--                                <telerik:GridCheckBoxColumn DataField="IsActive" 
                            DataType="System.Boolean" FilterControlAltText="Filter IsActive column" 
                            HeaderText="Active" SortExpression="IsActive" 
                            UniqueName="IsActive" AllowFiltering="false">
                        </telerik:GridCheckBoxColumn>--%>
                        <telerik:GridTemplateColumn UniqueName="TemplateColumn" HeaderText="Active" AllowFiltering="false">
                            <HeaderStyle HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:ImageButton ID="ImageButton3" runat="server" CommandName="IsActive" ToolTip="Activate/Deactivate this category" AlternateText='<%# IIF(Eval("IsActive"), "Active","Inactive") %>'
                                    ImageUrl='<%# IIf(Eval("IsActive"), "~/app_themes/admin/images/checkbox-checked.png", "~/app_themes/admin/images/checkbox-unchecked.png")%>'
                                    OnClientClick="return confirm('Activate/Deactivate this category?');" Height="15px" Width="15px" />
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridEditCommandColumn ButtonType="ImageButton" EditImageUrl="~/app_themes/admin/images/edit.gif">
                            <HeaderStyle Width="3%" />
                        </telerik:GridEditCommandColumn>
                        <telerik:GridButtonColumn Text="Delete" CommandName="Delete" ConfirmDialogType="RadWindow" ConfirmTitle="Sure?" ButtonType="ImageButton" ImageUrl="~/app_themes/admin/images/delete.gif" ConfirmText="Are you sure you want to delete this product category?">
                            <HeaderStyle Width="2%" />
                        </telerik:GridButtonColumn>
                    </Columns>
                <EditFormSettings EditFormType="Template">
                <EditColumn FilterControlAltText="Filter EditCommandColumn column"></EditColumn>
                    <FormTemplate> 
                        <div style="padding: 5px; margin: 5px; border: 1px solid gray">
                            <table width="100%">
                            <tr>
                                <td>
                                    Category Name
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" 
                                        ControlToValidate="txtCategoryName" Display="Dynamic" ErrorMessage="Category Name is required" 
                                        ValidationGroup="ProductCategoryMgntValGroup">*</asp:RequiredFieldValidator>
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txtCategoryName" Runat="server" Text='<%# Bind("CategoryName") %>' 
                                        Width="400px" MaxLength="256">
                                    </telerik:RadTextBox>
                                </td>
<%--                                <td rowspan="2" style="width: 350px; vertical-align:top; padding-left: 5px; border: 1px dashed;">
                                    <div>
                                        Photo<br />
                                        <asp:Image ID="Image1" runat="server" Height="150px" ImageUrl='<%# IIf(System.IO.File.Exists(MapPath("~/modules/products/images/categories/" & DataBinder.Eval(Container.DataItem, "CategoryPhoto"))), "~/modules/products/images/categories/" & DataBinder.Eval(Container.DataItem, "CategoryPhoto"), "~/App_Themes/Default/images/nophoto.png")%>' />
                                    </div>
                                    <div style="margin: 5px 0 0 0" class="prod-up">
                                        <div style="float: left; width: 150px;">
                                            <telerik:RadTextBox ID="txtPhoto" Runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"CategoryPhoto") %>' ReadOnly="true" 
                                                Width="145px" CssClass="txt-readonly">
                                            </telerik:RadTextBox>
                                        </div>
                                        <div style="float: left;">
                                            <telerik:RadAsyncUpload runat="server" ID="AsyncUpload1" OnClientFileUploaded="OnClientFileUploaded" OnClientValidationFailed="validationFailed"
                                                AllowedFileExtensions="jpg,jpeg,png,gif" Width="140px"    
                                                MaxFileSize="5242880" OnValidatingFile="RadAsyncUpload1_ValidatingFile" InputSize="23" MaxFileInputsCount="1">
                                            </telerik:RadAsyncUpload>
                                        </div>
                                    </div>
                                    <div style="clear:both"></div>
                                </td>--%>
                            </tr>  
                                        <%--<tr>
                                <td style="vertical-align: top">
                                    Search Keywords</td>
                                <td>
                                    <telerik:RadTextBox ID="txtKeywords" Runat="server" Height="30px" MaxLength="256" 
                                        Skin="Sitefinity" Text='<%# Bind("Keywords") %>' TextMode="MultiLine"
                                        Width="400px">
                                    </telerik:RadTextBox>
                                    Example: Inspection Instrument, NDT Instrument, Instrument
                                    <asp:RegularExpressionValidator ID="KeywordsRegExValidator" runat="server" 
                                        ControlToValidate="txtKeywords" Display="Dynamic" 
                                        ErrorMessage="<br />Only letters, numbers and commas are accepted." 
                                        ValidationExpression="[a-zA-Z0-9 ]+[,a-zA-Z0-9 ]*" 
                                        ValidationGroup="ProductCategoryMgntValGroup"></asp:RegularExpressionValidator>
                                </td>
                            </tr>                                              
                            <tr>
                                <td style="vertical-align: top">
                                    Parent Category</td>
                                <td>
                                    <asp:DropDownList ID="ddlCategory" runat="server" SelectedValue='<%# DataBinder.Eval(Container.DataItem,"CategoryParentID") %>'
                                        Width="410px">            
                                    </asp:DropDownList>
                                </td>
                            </tr>--%>
                            <tr>
                                <td style="vertical-align: top">
                                    Short Description
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" 
                                        ControlToValidate="txtShortDescription" Display="Dynamic" ErrorMessage="Short Description is required." 
                                        ValidationGroup="ProductCategoryMgntValGroup">*</asp:RequiredFieldValidator>
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txtShortDescription" Runat="server" Height="100px" MaxLength="100" 
                                        Skin="Sitefinity" Text='<%# Bind("ShortDescription") %>' TextMode="MultiLine"
                                        Width="400px">
                                    </telerik:RadTextBox>
                                </td>
                            </tr>                       
<%--                            <tr>
                                <td style="vertical-align: top">
                                    Description
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                                        ControlToValidate="redFullDescription" Display="Dynamic" ErrorMessage="Description is required." 
                                        ValidationGroup="ProductCategoryMgntValGroup">*</asp:RequiredFieldValidator></td>
                                </td>
                                <td colspan="2">
                                    <telerik:RadEditor ID="redFullDescription" Runat="server" height="350px" Width="100%" SkinID="SettingProperties"
                                        ToolsFile="~/webparts/radeditor/ToolsFile.xml" OnClientLoad="OnClientLoad" MaxTextLength="10000" 
                                        Content='<%# Bind("FullDescription") %>'>
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
                                </td>
                            </tr>--%>
                            <tr>
                                <td>
                                    Category Sort</td>
                                <td colspan="2">  
                                    <telerik:RadNumericTextBox ID="txtCategorySort" runat="server" MaxLength="5"
                                        Skin="Telerik" Text='<%# Bind("CategorySort") %>' Width="25px" NumberFormat-DecimalDigits="0">
                                    </telerik:RadNumericTextBox>&nbsp;&nbsp;
                                    Is Active?&nbsp;<asp:CheckBox ID="CheckBox2" runat="server" Checked='<%# Bind("IsActive") %>' />
                                </td>
                            </tr>                             
                            <tr>
                                <td colspan="3"> 
                                    <%# IIf((TypeOf (Container) Is GridEditFormInsertItem), "", "Created by <b>" + Eval("CreatedBy") + "</b> on <b>" + Eval("DateCreated") + "</b>")%>
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    <%# IIf((TypeOf (Container) Is GridEditFormInsertItem), "", IIf(IsDBNull(Eval("ModifiedBy")), "", "Modified by <b>" + Eval("ModifiedBy") + "</b> on <b>" + Eval("DateModified") + "</b>"))%>

                                    <div style="float:Left; padding: 5px;">
                                        <asp:ValidationSummary ID="ValidationSummary1" runat="server" ValidationGroup="ProductCategoryMgntValGroup" />
                                    </div>                    
                                    <div style="float:right"> 
                                        <asp:Button ID="btnCancel" runat="server" CausesValidation="False" 
                                            CommandName="Cancel" Text="Cancel" />
                                        &nbsp;<asp:Button ID="btnUpdate" runat="server" 
                                            CommandName='<%# IIf((TypeOf(Container) is GridEditFormInsertItem), "PerformInsert", "Update")%>' 
                                            Text='<%# IIf((TypeOf(Container) is GridEditFormInsertItem), "Insert", "Update") %>' 
                                            ValidationGroup="ProductCategoryMgntValGroup" />
                                    </div>
                                    <div style="clear:both;"></div>
                                </td>                 
                            </tr>
           
                        </table>
                        
                        </div>        
                    </FormTemplate>
   
                    <PopUpSettings Height="250px" Modal="True" Width="700px" />
   
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
        <telerik:RadWindow ID="formsettings" runat="server" Width="700px" Height="350px"  Title="" Modal="true" />    
    </Windows>
</telerik:RadWindowManager>
</asp:Content>