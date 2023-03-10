<%@ Page Title="Product Photos" Language="vb" AutoEventWireup="false" MasterPageFile="~/Masterpages/CMSAdmin.Master" CodeBehind="product-photos.aspx.vb" Inherits="tfsCMS._Product_Photos_Default" Theme="admin" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script type="text/jscript" src='<%=Page.ResolveClientURL("~/Scripts/JScript.js") %>'></script>   
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
            var weburl = $("[id$=txtAlternateText]").val();

            if (!validateURL(weburl))
                args.IsValid = false;
            else
                args.IsValid = true;
        }

        function validateURL(value) {
            return /^(https?|ftp):\/\/(((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:)*@)?(((\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5]))|((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.?)(:\d*)?)(\/((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)+(\/(([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)*)*)?)?(\?((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)|[\uE000-\uF8FF]|\/|\?)*)?(\#((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)|\/|\?)*)?$/i.test(value);
        }

        function RadNumericTextBox_OnBlur(sender, args) {
            if (sender.get_value() == "") {
                sender.set_value("0");
            }
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

                    //Set txtPhoto's value = file name of uploaded image
                    var fileName = eventArgs.get_fileName();
                    getEditFormFromItem(fileName);

                }

                function getEditFormFromItem(fn) {
                    
                    var formItem;
                    var master = $find("<%=RadGrid1.ClientID%>").get_masterTableView();
                    if (master.get_isItemInserted()) {
                        // insert mode
                        formItem = master.get_insertItem();
                    } else {
                        // @todo check Edit mode
                        // get_editItems() is blank
                        var editItem = master.get_editItems()[0];
                        if (editItem) {
                            formItem = editItem.get_editFormItem();
                        }
                    }
                    // set txtPhoto's value
                    var txtPhoto = $telerik.findControl(formItem, "txtPhoto");

                    txtPhoto.set_value(fn);

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
            Manage Product Photos
        </h1>        
        <telerik:RadGrid ID="RadGrid1" runat="server"
            GridLines="None" AllowPaging="True" AutoGenerateColumns="False" AllowFilteringByColumn="true"
            PageSize="15" Skin="Metro" AllowAutomaticDeletes="True" Width="100%">
            <GroupingSettings CaseSensitive="false" />
            <MasterTableView DataKeyNames="PhotoID, ProductPhotoID, ProductID" EditMode="PopUp" CommandItemDisplay="Top" CommandItemStyle-HorizontalAlign="Left"
                AllowFilteringByColumn="true" InsertItemPageIndexAction="ShowItemOnCurrentPage">
                <RowIndicatorColumn FilterControlAltText="Filter RowIndicator column">
                <HeaderStyle Width="20px"></HeaderStyle>
    
                </RowIndicatorColumn>

                <ExpandCollapseColumn FilterControlAltText="Filter ExpandColumn column">
                <HeaderStyle Width="20px"></HeaderStyle>
                </ExpandCollapseColumn>

                <CommandItemSettings ExportToPdfText="Export to Pdf" AddNewRecordText="Add Photo">
                </CommandItemSettings>

                    <Columns>
                        <telerik:GridBoundColumn DataField="PhotoID" DataType="System.Int64" 
                            FilterControlAltText="Filter PhotoID column" HeaderText="PhotoID" 
                            ReadOnly="True" SortExpression="PhotoID" UniqueName="PhotoID" 
                            Display="False">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="ProductID" DataType="System.Int64" 
                            FilterControlAltText="Filter ProductID column" HeaderText="ProductID" 
                            ReadOnly="True" SortExpression="ProductID" UniqueName="ProductID" 
                            Display="False">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="FilePath" 
                            FilterControlAltText="Filter FilePath column" HeaderText="FilePath" 
                            ReadOnly="True" SortExpression="FilePath" UniqueName="FilePath" 
                            Display="False">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="ProductName" 
                            FilterControlAltText="Filter ProductName column" HeaderText="Product Name" 
                            SortExpression="ProductName" UniqueName="ProductName"
                            AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false">
                        </telerik:GridBoundColumn>
                        <telerik:GridTemplateColumn UniqueName="TemplateColumn" HeaderText="Preview" AllowFiltering="false">
                            <HeaderStyle HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Image ID="Image2" ImageUrl='<%#Eval("FilePath")%>' runat="server" Height="50px" />
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridBoundColumn DataField="FileName" 
                            FilterControlAltText="Filter FileName column" HeaderText="File Name" 
                            SortExpression="FileName" UniqueName="FileName"
                            AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="250px">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="Sort" 
                            FilterControlAltText="Filter Sort column" HeaderText="Sort" 
                            SortExpression="Sort" UniqueName="Sort" AllowFiltering="false">
                        </telerik:GridBoundColumn>
    <%--                                <telerik:GridCheckBoxColumn DataField="IsActive" 
                            DataType="System.Boolean" FilterControlAltText="Filter IsActive column" 
                            HeaderText="Active" SortExpression="IsActive" 
                            UniqueName="IsActive" AllowFiltering="false">
                        </telerik:GridCheckBoxColumn>--%>
                        <telerik:GridTemplateColumn UniqueName="TemplateColumn" HeaderText="Featured Photo?" AllowFiltering="false">
                            <HeaderStyle Width="3%" />
                            <ItemStyle HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:ImageButton ID="ImageButton1" runat="server" CommandName="Feature" ToolTip="Feature this photo" AlternateText="Feature"
                                    ImageUrl='<%# IIf(Eval("IsFeatured"), "~/app_themes/admin/images/featured.png", "~/app_themes/admin/images/not-featured.png")%>'
                                    OnClientClick="return confirm('Are you sure you want to feature/un-feature this photo?');" />
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridEditCommandColumn ButtonType="ImageButton" EditImageUrl="~/app_themes/admin/images/edit.gif">
                            <HeaderStyle Width="3%" />
                        </telerik:GridEditCommandColumn>
                        <telerik:GridButtonColumn Text="Delete" CommandName="Delete" ConfirmDialogType="RadWindow" ConfirmTitle="Sure?" ButtonType="ImageButton" ImageUrl="~/app_themes/admin/images/delete.gif" ConfirmText="Are you sure you want to delete this item?">
                            <HeaderStyle Width="2%" />
                        </telerik:GridButtonColumn>
                    </Columns>
                <EditFormSettings EditFormType="Template">
                <EditColumn FilterControlAltText="Filter EditCommandColumn column"></EditColumn>
                    <FormTemplate> 
                        <div class="adminPopUp">
                            <h2>Photo Details</h2>
                            <table>
                                <tr>
                                    <td>
                                        Product
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlProduct" runat="server"
                                            Width="400px">            
                                        </asp:DropDownList>
                                            <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator8" ControlToValidate="ddlProduct" Display="Dynamic" InitialValue="0" 
                                                ValidationGroup="PhotoMgntValGroup" ErrorMessage="Product is required.">* Required</asp:RequiredFieldValidator>
                                    </td>
                                </tr>  
                                <tr>
                                    <td>
                                        Alternate Text
                                    </td>
                                    <td>
                                        <telerik:RadTextBox ID="txtAlternateText" Runat="server" Text='<%# Bind("AlternateText")%>' 
                                            Width="400px" MaxLength="500">
                                        </telerik:RadTextBox><br />
                                    </td>
                                </tr>  
                                <tr>
                                    <td>
                                        Photo
                                    </td>
                                    <td style="width: 350px; vertical-align:top; padding-left: 5px; border: 1px dashed;">
                                        <div>                                        
                                            <asp:Image ID="Image1" runat="server" Height="150px" ImageUrl='<%# IIf(System.IO.File.Exists(MapPath(DataBinder.Eval(Container.DataItem, "FilePath"))), DataBinder.Eval(Container.DataItem, "FilePath"), "~/App_Themes/Default/images/nophoto.png")%>' />
                                        </div>
                                        <div style="margin: 5px 0 0 0" class="prod-up">
                                            <div style="float: left; width: 150px;">
                                                <telerik:RadTextBox ID="txtPhoto" Runat="server" Text='<%# Bind("FileName")%>' ReadOnly="true" 
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
                                    </td>
                                </tr> 
                                <tr>
                                    <td>
                                        </td>
                                    <td>                                              
                                        Sort <telerik:RadNumericTextBox ID="txtSort" Runat="server" DbValue='<%# Bind("Sort")%>' 
                                                Width="60px" MaxLength="3" MinValue="1">
                                                <NumberFormat AllowRounding="False" ZeroPattern="n" />                                    
                                                <ClientEvents OnBlur="RadNumericTextBox_OnBlur" />
                                            </telerik:RadNumericTextBox> Is Active?&nbsp;<asp:CheckBox ID="CheckBox2" runat="server" Checked='<%# Bind("IsActive") %>' />&nbsp;&nbsp;                                        
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2"> 
                                        <%# IIf((TypeOf (Container) Is GridEditFormInsertItem), "", "Created by <b>" + Eval("CreatedBy") + "</b> on <b>" + Eval("DateCreated") + "</b>")%>
                                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                        <%# IIf((TypeOf (Container) Is GridEditFormInsertItem), "", IIf(IsDBNull(Eval("ModifiedBy")), "", "Modified by <b>" + Eval("ModifiedBy") + "</b> on <b>" + Eval("DateModified") + "</b>"))%>

                                        <div>
                                            <asp:ValidationSummary ID="ValidationSummary1" runat="server" ValidationGroup="PhotoMgntValGroup" />
                                        </div>                    
                                        <div style="clear:both;"></div>
                                    </td>                 
                                </tr>           
                            </table>
                        
                        </div>        
                        <div style="float:right; clear: both;"> 
                            <asp:Button ID="btnCancel" runat="server" CausesValidation="False" 
                                CommandName="Cancel" Text="Cancel" />
                            &nbsp;<asp:Button ID="btnUpdate" runat="server" 
                                CommandName='<%# IIf((TypeOf(Container) is GridEditFormInsertItem), "PerformInsert", "Update")%>' 
                                Text='<%# IIf((TypeOf(Container) is GridEditFormInsertItem), "Insert", "Update") %>' 
                                ValidationGroup="PhotoMgntValGroup" />
                        </div>

                    </FormTemplate>
   
                    <PopUpSettings Height="550px" Modal="True" Width="700px" />
   
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
        <telerik:RadWindow ID="formsettings" runat="server" Width="700px" Height="550px"  Title="" Modal="true" />    
    </Windows>
</telerik:RadWindowManager>
</asp:Content>