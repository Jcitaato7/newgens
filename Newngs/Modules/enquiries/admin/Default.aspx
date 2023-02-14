<%@ Page Title="Enquiries" Language="vb" AutoEventWireup="false" MasterPageFile="~/Masterpages/CMSAdmin.Master" CodeBehind="Default.aspx.vb" Inherits="tfsCMS._Default6" Theme="admin" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphbody" runat="server">
<script type="text/javascript">
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
        window.radopen("../../common/settings.aspx?code=" + code, "formsettings");
        return false;
    }
</script>
<div style="padding:10px;">
 <div class="box" style="width:1100px; margin:0 auto; padding:10px;">
    <h1>
        Enquiries
    </h1>
    <div style="width:100%; text-align:right"><a onclick="return UpdateSettings('EF');" class="button blue" >Notification Settings</a></div>
  <br /><asp:SqlDataSource ID="dsenquiries" runat="server" 
         ConnectionString="<%$ ConnectionStrings:tfsCMSconn %>" 
         DeleteCommand="DELETE FROM [enquiries] WHERE [id] = @id" 
          
         SelectCommand="SELECT enquiries.id, enquiries.name, enquiries.company,  enquiries.address, enquiries.email,enquiries.company, enquiries.phone, enquiries.mobile, enquiries.message, enquiries.datesubmitted, enquiries.subject  FROM enquiries ORDER BY enquiries.id DESC" 
         UpdateCommand=" ">
         <DeleteParameters>
             <asp:Parameter Name="id" Type="Int32" />
         </DeleteParameters>
     </asp:SqlDataSource>

     <telerik:RadGrid ID="RadGrid1" runat="server" AutoGenerateColumns="False" 
         CellSpacing="0" DataSourceID="dsenquiries" GridLines="None" 
         AllowAutomaticDeletes="True" AllowPaging="True" PageSize="15" Skin="Metro">
<ClientSettings>
<Selecting CellSelectionMode="None" AllowRowSelect="True"></Selecting>
</ClientSettings>

<MasterTableView DataKeyNames="id" DataSourceID="dsenquiries" EditMode="PopUp">
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
         
        <telerik:GridBoundColumn DataField="email" 
            FilterControlAltText="Filter email column" HeaderText="Email" 
            SortExpression="email" UniqueName="email">
        </telerik:GridBoundColumn>
         <telerik:GridBoundColumn DataField="company" 
            FilterControlAltText="Filter company column" HeaderText="Organization" 
            SortExpression="company" UniqueName="company">
        </telerik:GridBoundColumn>
                 <telerik:GridBoundColumn DataField="mobile" 
            FilterControlAltText="Filter mobile column" HeaderText="Contact No" 
            SortExpression="mobile" UniqueName="mobile">
        </telerik:GridBoundColumn>
<%--       <telerik:GridTemplateColumn FilterControlAltText="Filter TemplateColumn column" 
            HeaderText="Enquiry" UniqueName="TemplateColumn">
            <ItemTemplate>
                 <%# cls.Truncate(Eval("Message"), 50)%>
                 <asp:LinkButton ID="lnkbtndetails" runat="server" Visible='<%# IIf(Len(Eval("Message")) >= 50, True, False)%>' Font-Underline="False" ForeColor="#0033CC" Font-Bold="true"  Font-Size="10px">read more</asp:LinkButton>
                <telerik:RadToolTip ID="RadToolTip1" runat="server" Height="120px" 
                    ManualClose="True" ShowEvent="OnClick" Width="350px" 
                     TargetControlID="lnkbtndetails" Modal="True" Position="Center" 
                     RelativeTo="BrowserWindow">
                   <%# Eval("Message") %>
                </telerik:RadToolTip>
            </ItemTemplate>
        </telerik:GridTemplateColumn>--%>
        <telerik:GridBoundColumn DataField="datesubmitted" 
            DataFormatString="{0:dd/MM/yyyy}" DataType="System.DateTime" 
            FilterControlAltText="Filter datesubmitted column" HeaderText="Date Submitted" 
            SortExpression="datesubmitted" UniqueName="datesubmitted">
        </telerik:GridBoundColumn>
        <telerik:GridEditCommandColumn ButtonType="ImageButton" EditImageUrl="~/app_themes/admin/images/view.png">
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
                <h3>Enquiry Details</h3>
                <table width="100%" border="0" cellspacing="0" cellpadding="3">
                    <tr>
                        <td width="30%" style="padding-right: 50px;" valign="top">
                            <label for="name">Full name</label>
                            <asp:TextBox ID="txtfullname"  CssClass="forminput" runat="server" MaxLength="50"
                                ReadOnly="True" Text='<%# Bind("Name")%>' />
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" 
                                        ControlToValidate="txtfullname" Display="Dynamic" ErrorMessage="*" 
                                        ValidationGroup="enquiry"></asp:RequiredFieldValidator>
                            <br/>
                            <label for="email">Company</label>
                            <asp:TextBox ID="txtorg"  runat="server" CssClass="forminput" MaxLength="100"
                                ReadOnly="True" Text='<%# Bind("Company")%>' />
                            <br/>
                            <label for="email">Telephone</label>
                            <asp:TextBox ID="txtcontactno" runat="server" CssClass="forminput" MaxLength="30"
                                ReadOnly="True" Text='<%# Bind("Mobile")%>' /> 
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                                            ControlToValidate="txtcontactno" Display="Dynamic" ErrorMessage="*" 
                                            ValidationGroup="enquiry"></asp:RequiredFieldValidator>
                            <br/>
                            <label for="email">Email</label>
                            <asp:TextBox ID="txtemail" runat="server" CssClass="forminput" MaxLength="30" 
                                ReadOnly="True" Text='<%# Bind("Email")%>' /> 
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" 
                                        ControlToValidate="txtemail" Display="Dynamic" ErrorMessage="*" 
                                        ValidationGroup="enquiry"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator runat="server" ID="RegularExpressionValidator1"
                                        SetFocusOnError="true" Text="Example: username@gmail.com" ControlToValidate="txtemail"
                                        ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" Display="Dynamic" ValidationGroup="enquiry"/>
                        <br/></td>
                        <td width="70%" valign="top">
                            <label for="message">Message:</label>
                            <br/>
                            <asp:TextBox ID="txtmsg" runat="server"  MaxLength="150" CssClass="formtextarea" TextMode="MultiLine" Height="120px" Columns="65" Rows="12" 
                                ReadOnly="True" Text='<%# Bind("Message")%>' />
                                    <asp:RequiredFieldValidator ID="rfvmsg" runat="server" 
                                        ControlToValidate="txtmsg" Display="Dynamic" ErrorMessage="*" 
                                        ValidationGroup="enquiry"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                </table>
                <div style="float:right">
                    <asp:Button ID="btnCancel" runat="server" CausesValidation="False" 
                        CommandName="Cancel" Text="Close" />
                </div>
                <div style="clear:both;"></div>
            </div>
        </FormTemplate>
        <PopUpSettings Modal="True" Height="300px" Width="800px" />
</EditFormSettings>

<PagerStyle PageSizeControlType="RadComboBox"></PagerStyle>
</MasterTableView>

<PagerStyle PageSizeControlType="RadComboBox"></PagerStyle>
<ClientSettings>
    <ClientEvents OnPopUpShowing="PopUpShowing" />
    <Selecting AllowRowSelect="true" />
</ClientSettings>
<FilterMenu EnableImageSprites="False"></FilterMenu>
     </telerik:RadGrid>
    </div> 
    </div>
       <telerik:RadWindowManager ID="RadWindowManager1" runat="server" 
             Behavior="Close"
            Skin="Metro" Style="z-index:10000"
                  Modal="True" VisibleStatusbar="False"  DestroyOnClose="true"
            Behaviors="Close">
        <Windows>
                   <telerik:RadWindow ID="formsettings" runat="server" Width="800px" Height="500px"  Title="" Modal="true"   />
    
        </Windows>
        </telerik:RadWindowManager> 
</asp:Content>
