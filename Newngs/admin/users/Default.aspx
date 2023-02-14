<%@ Page Title="Manage Users" Language="vb" AutoEventWireup="false" MasterPageFile="~/Masterpages/CMSAdmin.Master" CodeBehind="Default.aspx.vb" Inherits="tfsCMS._Default10" Theme="admin" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

  <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
            <script type="text/javascript">
                var popUp;
                function PopUpShowing(sender, eventArgs) {

                    var myWidth = 0, myHeight = 0;
                    if (typeof (window.innerWidth) == 'number') {
                        //Non-IE
                        myWidth = window.innerWidth;
                        myHeight = window.innerHeight;
                    } else if (document.documentElement && (document.documentElement.clientWidth || document.documentElement.clientHeight)) {
                        //IE 6+ in 'standards compliant mode'
                        myWidth = document.documentElement.clientWidth;
                        myHeight = document.documentElement.clientHeight;
                    } else if (document.body && (document.body.clientWidth || document.body.clientHeight)) {
                        //IE 4 compatible
                        myWidth = document.body.clientWidth;
                        myHeight = document.body.clientHeight;
                    }

                    popUp = eventArgs.get_popUp();

                    var popUpWidth = popUp.style.width.substr(0, popUp.style.width.indexOf("px"));
                    var popUpHeight = popUp.style.height.substr(0, popUp.style.height.indexOf("px"));
                    popUp.style.left = ((myWidth - popUpWidth) / 2 + sender.get_element().offsetLeft).toString() + "px";
                    popUp.style.top = ((myHeight - popUpHeight) / 2 + sender.get_element().offsetTop).toString() + "px";

                }
                function mngRequestStarted(sender, args) {
                    if (args.get_eventTarget().indexOf("btnCancel") != -1)
                        args.set_enableAjax(false);
                }
                function onKeyPressing(sender, eventArgs) {
                    var e = eventArgs.get_domEvent();
                    var keyCode = e.keyCode || e.which;

                    if (keyCode == 9) {
                        var item = sender.get_highlightedItem();
                        if (item) setTimeout(function () { item.select(); });
                    }
                }
                function ShowDropDownFunction(sender) {
                    sender.showDropDown();
                }
                function validateCombo(source, args) {
                    args.IsValid = false;

                    var combo = $find(source.controltovalidate);
                    var text = combo.get_text();

                    if (text.length < 1) {
                        args.IsValid = false;

                    }
                    else {
                        var node = combo.findItemByText(text);
                        if (node) {
                            args.IsValid = true;
                        }
                        else {
                            args.IsValid = false;
                        }
                    }
                }
                
              </script>

        </telerik:RadCodeBlock>
    <style type="text/css">
        input[type="button"] {padding:5px 10px !important;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphbody" runat="server">
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" RestoreOriginalRenderDelegate="false" 
        DefaultLoadingPanelID="RadAjaxLoadingPanel1">
                <AjaxSettings>
                    <telerik:AjaxSetting AjaxControlID="RadAjaxManager1">
                        <UpdatedControls>
                            <telerik:AjaxUpdatedControl ControlID="RadGrid1" />
                        </UpdatedControls>
                    </telerik:AjaxSetting>      
                    <telerik:AjaxSetting AjaxControlID="RadGrid1">
                        <UpdatedControls>
                            <telerik:AjaxUpdatedControl ControlID="RadGrid1" />
                        </UpdatedControls>
                    </telerik:AjaxSetting>                                  
                </AjaxSettings>
            </telerik:RadAjaxManager>
 <div style="padding:10px;">
 <div class="box" style="width:1100px; margin:0 auto; padding:10px;">
    <h1>Manage Users  </h1>               
    <table style="width:100%">
        <tr>
            <td colspan="2">
                <telerik:RadGrid ID="RadGrid1" runat="server" AutoGenerateColumns="False" 
                    DataSourceID="dsuserlist" GridLines="None"  Skin="Metro"
                    AllowAutomaticDeletes="True" AllowAutomaticUpdates="True"  
                    AllowPaging="True" AllowAutomaticInserts="True" CellSpacing="0" 
                    PageSize="20">
                     
                    <ClientSettings>
       <ClientEvents OnPopUpShowing="PopUpShowing" />
       <Selecting AllowRowSelect="true" />
   </ClientSettings>
                    <AlternatingItemStyle Font-Names="Calibri" />
                    <ItemStyle Font-Names="Calibri" />
<MasterTableView datasourceid="dsuserlist" EditMode="PopUp" DataKeyNames="Username" CommandItemDisplay="Top" CommandItemStyle-HorizontalAlign="Right" >
<RowIndicatorColumn>
<HeaderStyle Width="20px"></HeaderStyle>
</RowIndicatorColumn>

<ExpandCollapseColumn>
<HeaderStyle Width="20px"></HeaderStyle>
</ExpandCollapseColumn>
<CommandItemSettings ExportToPdfText="Export to Pdf" 
        AddNewRecordText="Add new user"></CommandItemSettings>
    <Columns>
  
        <telerik:GridBoundColumn DataField="UserName" HeaderText="Username" 
            SortExpression="UserName" UniqueName="UserName">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="firstname" HeaderText="First Name" 
            SortExpression="firstname" UniqueName="firstname">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="lastname" HeaderText="Last Name" 
            SortExpression="lastname" UniqueName="lastname">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="Email" 
            FilterControlAltText="Filter Email column" HeaderText="Email" 
            SortExpression="Email" UniqueName="Email">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="phone" HeaderText="Contact No" 
            SortExpression="phone" UniqueName="phone">
        </telerik:GridBoundColumn>
         <telerik:GridTemplateColumn FilterControlAltText="Filter IsApproved column" 
            HeaderText="Status" UniqueName="status" DataField="IsApproved" 
            SortExpression="IsApproved">
              <ItemTemplate>
  <%# IIF(Eval("locked")=True,IIf(Eval("IsApproved") = True, "Active", "Inactive"),"") %>
                  <asp:LinkButton ID="lnkbtnstatus" runat="server" CommandName="ChangeStatus" Visible='<%# Eval("locked")<>True %>'  OnClientClick='<%# "return confirm(""" + IIF(Eval("IsApproved")=True,"Deactivate User","Activate User") + "?"");" %>'  ><%# IIf(Eval("IsApproved") = True, "Active", "Inactive")%></asp:LinkButton>
                   
              </ItemTemplate>
        </telerik:GridTemplateColumn>
          <telerik:GridTemplateColumn DataField="IsLockedOut" 
            FilterControlAltText="Filter IsLockedOut column" HeaderText="Locked Out" 
            SortExpression="IsLockedOut" UniqueName="IsLockedOut">
              <ItemTemplate>
                  <asp:LinkButton ID="lnkbtnlock" runat="server"  Enabled='<%# IIF(Eval("locked")=True or Eval("IsLockedOut")=False,"False","True") %>' CommandName="LockUnlock"  OnClientClick='<%# IIF(Eval("IsLockedOut")=True,"return confirm(""Unlock User?"");","")  %>'   ><%# IIf(Eval("isLockedOut") = True, "Yes", "No")%></asp:LinkButton>

                
              </ItemTemplate>
        </telerik:GridTemplateColumn>
         
        <telerik:GridTemplateColumn  
            FilterControlAltText="Filter userpwdreset column" HeaderText="" 
            SortExpression="userpwdreset" UniqueName="userpwdreset">
              <ItemTemplate>
                                     <asp:ImageButton ID="imgbtnreset" runat="server"  Enabled='<%# IIF(Eval("IsLockedOut")=False,"True","False") %>'  PostBackUrl='<%#Eval("UserName","~/admin/users/recovery.aspx?uname={0}") %>' ImageUrl="~/app_themes/admin/images/reset.png" ToolTip="Password Reset"></asp:ImageButton>    
                              </ItemTemplate>
                               <HeaderStyle Width="2%"   />

 
        </telerik:GridTemplateColumn>
         <telerik:GridEditCommandColumn ButtonType="ImageButton" EditImageUrl="~/app_themes/admin/images/edit.gif"  >
                        <HeaderStyle Width="3%" />
                    </telerik:GridEditCommandColumn>
 
            <telerik:GridButtonColumn UniqueName="DeleteColumn"
            CommandName="Delete" ConfirmDialogType="RadWindow" ConfirmTitle="Sure?" 
            ButtonType="ImageButton"  ImageUrl="~/app_themes/admin/images/delete.gif"  ItemStyle-Width="24px"  
            ConfirmText="Are you sure you want to delete this user?">
                        <HeaderStyle Width="2%"   />

<ItemStyle Width="24px"></ItemStyle>

                    </telerik:GridButtonColumn>
     
    
    </Columns>

   <EditFormSettings EditFormType="Template"  >
<EditColumn FilterControlAltText="Filter EditCommandColumn column"></EditColumn>
      
    <FormTemplate>
    <div style="padding:10px">
        <asp:CreateUserWizard ID="CreateUserWizard" runat="server" Font-Names="Calibri" Visible='<%# IIf((TypeOf(Container) is GridEditFormInsertItem), "True", "False") %>'
        LoginCreatedUser="False" Height="170px" Width="488px"   
            oncreateduser="CreateUserWizard_CreatedUser"  
            onfinishbuttonclick="CreateUserWizard_FinishButtonClick" 
             onnextbuttonclick="CreateUserWizard_NextButtonClick" 
            oncreatinguser="CreateUserWizard_CreatingUser" AutoGeneratePassword="True">
            <StartNavigationTemplate>
                <asp:Button ID="StartNextButton" runat="server" CommandName="MoveNext"  CausesValidation="true"
                    Text="Next" ValidationGroup="CreateUserWizardStep0"   />
            </StartNavigationTemplate>
            <StepNavigationTemplate>
                <asp:Button ID="StepPreviousButton" runat="server" CausesValidation="False" 
                    CommandName="MovePrevious" Text="Previous" />
                <asp:Button ID="StepNextButton" runat="server" CommandName="MoveNext" 
                    Text="Next" />
            </StepNavigationTemplate>
                <MailDefinition Priority="High" Subject="CMS User account" BodyFileName="~/admin/users/emailbody.txt"   />
            <WizardSteps>
                <asp:WizardStep runat="server"  ID="CreateUserWizardStep0" 
                    Title="Personal Details" StepType="Start">
                  <table border="0"  style="width: 511px; font-family: 'Trebuchet MS'; font-size: 12px;">
                            <tr>
                                <td align="left" style="font-weight: bold; color: #333333;" colspan="2">
                                    PERSONAL DETAILS</td>
                            </tr>
                            <tr>
                                <td   class="style1">
                                    First Name</td>
                                <td class="style1">
                                    <asp:TextBox ID="txtfirstname" runat="server"   MaxLength="50" 
                                        Width="248px"></asp:TextBox>

                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" 
                                        ControlToValidate="txtfirstname" ErrorMessage="First Name is required." 
                                        ToolTip="First Name is required." 
                                        ForeColor="Red" ValidationGroup="CreateUserWizardStep0">*Required</asp:RequiredFieldValidator>
                                     
                                </td>
                            </tr>
                            <tr>
                                <td  >
                                    Last Name</td>
                                <td>
                                    <asp:TextBox ID="txtlastname" runat="server" MaxLength="50" Width="247px"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" 
                                        ControlToValidate="txtlastname" ErrorMessage="*Required" 
                                       ForeColor="Red" ValidationGroup="CreateUserWizardStep0"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td  style="vertical-align: top">
                                    Address</td>
                                <td>
                                    <asp:TextBox ID="txtAdd" runat="server" Height="70px" TextMode="MultiLine" 
                                        Width="338px" MaxLength="200"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td  >
                                    Contact Number</td>
                                <td>
                                    <asp:TextBox ID="txtcontactno" runat="server" MaxLength="50" Width="307px"></asp:TextBox>
                                </td>
                            </tr>
                           
                            <tr>
                                <td align="right">
                                    &nbsp;</td>
                                <td>
                                    &nbsp;</td>
                            </tr>

                        </table>
                </asp:WizardStep>
                
                <asp:CreateUserWizardStep ID="CreateUserWizardStep1" runat="server" Title="Create New User">
                    <ContentTemplate>
                          <table border="0"  style="width: 511px; font-family: 'Trebuchet MS'; font-size: 12px;">
                                               <tr>
                                <td align="right" style="font-weight: bold; color: #333333">
                                    Account Details</td>
                                <td>
                                    &nbsp;</td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Label ID="UserNameLabel" runat="server" AssociatedControlID="UserName">User 
                                    Name:</asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="UserName" runat="server" Width="198px" MaxLength="30" style="text-transform:none"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" 
                                        ControlToValidate="UserName" ErrorMessage="User Name is required." 
                                        ToolTip="User Name is required." ValidationGroup="CreateUserWizard1" 
                                        ForeColor="Red">*Required</asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Label ID="EmailLabel" runat="server" AssociatedControlID="Email">E-mail:</asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="Email" runat="server" Width="256px" MaxLength="50" style="text-transform:none"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="EmailRequired" runat="server" 
                                        ControlToValidate="Email" ErrorMessage="E-mail is required." 
                                        ToolTip="E-mail is required." ValidationGroup="CreateUserWizard1" 
                                        ForeColor="Red">*Required</asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" 
                                        ControlToValidate="Email" ErrorMessage="Invalid Email" 
                                        ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" 
                                        ForeColor="Red" ValidationGroup="CreateUserWizard1"></asp:RegularExpressionValidator>
                                </td>
                            </tr>
                            <tr>
                                <td align="center" colspan="2">
                                    &nbsp;</td>
                            </tr>
                            
                           
                            <tr>
                                <td align="center" colspan="2" style="color:Red;">
                                    <asp:Literal ID="ErrorMessage" runat="server" EnableViewState="False"></asp:Literal>
                                </td>
                            </tr>
                            <tr>
                               <td align="right" colspan="2">
                                     <asp:Label ID="Label1" runat="server" EnableViewState="False" Font-Bold="False" 
                                         Font-Underline="True" ForeColor="#FF0033"></asp:Label>
                                </td>
                            </tr>
                   </table>
                       
                      
                    </ContentTemplate>
                </asp:CreateUserWizardStep>
               <asp:WizardStep ID="WizardStep1" runat="server" Title="Add Role">
                <table class="style1" width="100%">
                        <tr>
                            <td colspan="2">
                                Please select the role of the new user created.</td>
                        </tr>
                        <tr>
                            <td style="text-align: right">
                                Role</td>
                            <td>
                              
                                <asp:CheckBoxList ID="chkuserroles" runat="server">
                                </asp:CheckBoxList>
                               
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: right">
                                &nbsp;</td>
                            <td>
                                &nbsp;</td>
                        </tr>
                        <tr>
                            <td colspan="2" style="font-size: small; vertical-align: bottom;">
                                <br />
                                &nbsp;</td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <asp:Label ID="errmsg" runat="server" EnableViewState="False" Font-Bold="False" 
                                    Font-Underline="True" ForeColor="#FF0033"></asp:Label>
                            </td>
                        </tr>
                    </table>
                </asp:WizardStep>
                <asp:CompleteWizardStep ID="CompleteWizardStep1" runat="server" >
                    <ContentTemplate>
                    <div style="font-family:Calibri;font-size:14px; width:100%; text-align:center">
                    <b>Complete</b><br /> <br />
                   
                     New user has been successfully created.<br />
                     
                                </div>
                    </ContentTemplate>
                </asp:CompleteWizardStep>
            </WizardSteps>
        </asp:CreateUserWizard>
        <asp:Panel runat="server" ID="PanelEdit" width="100%" Visible='<%# IIf((TypeOf(Container) is GridEditFormInsertItem), "False", "True")%>'>
          <table border="0" 
          style="width: 100%; font-family: 'Calibri'; font-size: 12px;" >
        <tr>
            <td align="right" class="style1" style="text-transform:uppercase;">
               <h2><%# Eval("username") %></h2> 
            </td>
             <td class="style1"></td>
        </tr>
        <tr >
            <td style="text-align:right;width:120px;" >
                First Name</td>
            <td >
                <asp:TextBox ID="firstnameTextBox" runat="server" Text='<%# Bind("firstname") %>' 
                            Width="250px" MaxLength="50"/>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
                    ControlToValidate="firstnameTextBox" ErrorMessage="*Required" 
                    ForeColor="Red"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td align="right"  >
                Last Name</td>
            <td>
                <asp:TextBox ID="lastnameTextBox" runat="server" MaxLength="50" Text='<%# Bind("lastname") %>' 
                           Width="250px" />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                    ControlToValidate="lastnameTextBox" ErrorMessage="*Required" 
                    ForeColor="Red"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td align="right" style="vertical-align: top">
                Address</td>
            <td>
                <asp:TextBox ID="txtaddress" runat="server" Height="70px" TextMode="MultiLine" Text='<%# Bind("address") %>'  
                            Width="338px" MaxLength="200"  ></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td align="right">
                Contact Number</td>
            <td >
                <asp:TextBox ID="phoneTextBox" runat="server"  Text='<%# Bind("phone") %>'  
                            Width="200px" MaxLength="50" />
            </td>
        </tr>
        <tr>
            <td align="right">
                Email</td>
            <td>
                <asp:TextBox ID="Email" runat="server" Width="256px" MaxLength="50" style="text-transform:none"></asp:TextBox>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" 
                            ControlToValidate="Email" ErrorMessage="*Invalid Email" 
                    ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" 
                    Display="Dynamic" ForeColor="Red"></asp:RegularExpressionValidator>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                    ControlToValidate="Email" ErrorMessage="*" Display="Dynamic" 
                    ForeColor="Red"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td align="right">
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
           
        <tr>
            <td style="text-align:right;vertical-align:top;">
                Roles</td>
            <td>
                <asp:CheckBoxList ID="chklRoles" runat="server" RepeatDirection="Horizontal">
                </asp:CheckBoxList> 
               </td>
        </tr>
        <tr>
            <td align="right" style="vertical-align: top" colspan="2">
           <asp:Button ID="btnCancel" Text="Cancel" runat="server" CausesValidation="False" CssClass="button blue"
CommandName="Cancel"></asp:Button>&nbsp;<asp:Button ID="btnUpdate" CssClass="button blue" ValidationGroup="editform"  Text='<%# IIf((TypeOf(Container) is GridEditFormInsertItem), "Insert", "Update") %>'
                                        runat="server" CommandName='<%# IIf((TypeOf(Container) is GridEditFormInsertItem), "PerformInsert", "Update")%>'>
                                    </asp:Button>
&nbsp;</td>
        </tr>
              <tr><td></td><td><div style="border: 1px solid #C0C0C0; font-size:11px; width:95%;padding:5px;margin-top:5px">
                 <b>Super Admin</b> - Full right permission<br />
                <b>Module Admin</b> - Able to manage all Modules (News, Enquiries, Testimonials, Job Applications and Products)<br />
                   <%--<b>Contributor</b> - Able to add/edit or delete page and page contents<br />--%>
                <b>Editor</b> - Able to edit page but it has to be set first by the Super Admin in the page settings<br />
           </div></td></tr>
        <tr>
            <td align="right" style="vertical-align: top">
                &nbsp;</td>
            <td>
                <asp:Label ID="lblmsg" runat="server" ForeColor="Red"></asp:Label>
            </td>
        </tr>
    </table>
    </asp:Panel>
    </div>
    </FormTemplate>

 
<PopUpSettings Modal="True" Height="500px" Width="650px"></PopUpSettings>

 
</EditFormSettings>

<CommandItemStyle HorizontalAlign="Right"></CommandItemStyle>
   
</MasterTableView>

                    <HeaderStyle Font-Names="Calibri" />

<FilterMenu EnableTheming="True">
<CollapseAnimation Type="OutQuint" Duration="200"></CollapseAnimation>
</FilterMenu>


 
<HeaderContextMenu EnableImageSprites="True" CssClass="GridContextMenu GridContextMenu_Default"></HeaderContextMenu>


 
                </telerik:RadGrid>
                </td>
        </tr>
        <tr>
            <td style="vertical-align: top">
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td>
            <asp:SqlDataSource ID="dsuserlist" runat="server" 
                ConnectionString="<%$ ConnectionStrings:tfsCMSconn %>" 
 SelectCommand="SELECT userinfo.username, userinfo.address, userinfo.phone, userinfo.firstname, userinfo.lastname, ISNULL(userinfo.locked, 0) AS locked, aspnet_Membership.Email, ISNULL(aspnet_Membership.IsApproved,0) as IsApproved, ISNULL(aspnet_Membership.IsLockedOut,0) as IsLockedOut FROM aspnet_Users INNER JOIN aspnet_Membership ON aspnet_Users.UserId = aspnet_Membership.UserId INNER JOIN userinfo ON aspnet_Users.UserName = userinfo.username" 
UpdateCommand="UPDATE userinfo SET address = @address, phone = @phone, firstname = @firstname, lastname = @lastname 
WHERE (username= @username)">
                <UpdateParameters>
                    <asp:Parameter Name="address" />
                    <asp:Parameter Name="phone" />
                    <asp:Parameter Name="firstname" />
                    <asp:Parameter Name="lastname" />
                    <asp:Parameter Name="username" />
                 
                </UpdateParameters>
            </asp:SqlDataSource>
            
           
            
                <telerik:RadWindowManager ID="RadWindowManager1" runat="server">
                </telerik:RadWindowManager>
            
           
            
            </td>
            <td>
                &nbsp;</td>
        </tr>
    </table>
  
        <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" Runat="server"  >
        </telerik:RadAjaxLoadingPanel>
</div></div>
</asp:Content>
