<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="settings.aspx.vb" Inherits="tfsCMS.settings" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Form Settings</title>
    <script type="text/javascript">
        function GetRadWindow() {
            var oWindow = null;
            if (window.radWindow) oWindow = window.radWindow;
            else if (window.frameElement.radWindow) oWindow = window.frameElement.radWindow;
            return oWindow;
        }


        function AdjustRadWidow() {
            var oWindow = GetRadWindow();
            setTimeout(function () { oWindow.autoSize(true); if ($telerik.isChrome || $telerik.isSafari) ChromeSafariFix(oWindow); }, 500);
        }

        //fix for Chrome/Safari due to absolute positioned popup not counted as part of the content page layout
        function ChromeSafariFix(oWindow) {
            var iframe = oWindow.get_contentFrame();
            var body = iframe.contentWindow.document.body;

            setTimeout(function () {
                var height = body.scrollHeight;
                var width = body.scrollWidth;

                var iframeBounds = $telerik.getBounds(iframe);
                var heightDelta = height - iframeBounds.height;
                var widthDelta = width - iframeBounds.width;

                if (heightDelta > 0) oWindow.set_height(oWindow.get_height() + heightDelta);
                if (widthDelta > 0) oWindow.set_width(oWindow.get_width() + widthDelta);
                oWindow.center();

            }, 310);
        }
        function CloseWindow() {
            //create the argument that will be returned to the parent page
            var oArg = new Object();
            //get a reference to the current RadWindow
            var oWnd = GetRadWindow();
                oWnd.close(oArg);
        }
    </script>
    <style type="text/css">
         body
{
     
    font-family: 'Lucida Grande' , 'Lucida Sans Unicode' , Tahoma, Arial, san-serif;
    font-size: 12px;
    
     }
     /*buttons*/
	.button {
    padding: 5px; margin:5px;
  background: #777 url(/images/button.png) repeat-x bottom;
    border: none;
    color: #fff;
    cursor: pointer;
    -moz-border-radius: 5px;
    -webkit-border-radius: 5px;
   font-family:Calibri, 'Lucida Sans Unicode', Tahoma, Arial, san-serif; 
	font-size: 12px;border-radius: 5px !important; text-decoration:none;}
    
.button:hover {
    background-position: 0 -48px;
    }
.button:active {
    background-position: 0 top;
    position: relative;
    top: 1px;
 
    }
 
.button.blue
{
    background-color: #3399FF;
}
 
    </style>
</head>
<body onload="AdjustRadWidow()">
    <form id="form1" runat="server">
    <telerik:RadScriptManager ID="RadScriptManager1" runat="server">
        <Scripts>
            <asp:ScriptReference Assembly="Telerik.Web.UI" 
                Name="Telerik.Web.UI.Common.Core.js">
            </asp:ScriptReference>
            <asp:ScriptReference Assembly="Telerik.Web.UI" 
                Name="Telerik.Web.UI.Common.jQuery.js">
            </asp:ScriptReference>
            <asp:ScriptReference Assembly="Telerik.Web.UI" 
                Name="Telerik.Web.UI.Common.jQueryInclude.js">
            </asp:ScriptReference>
        </Scripts>
    </telerik:RadScriptManager>
    
    <asp:FormView ID="FormView1" runat="server" DataKeyNames="notification_id"  Width="500px"
        DataSourceID="dssettings" EnableModelValidation="True" DefaultMode="Edit">
        <EditItemTemplate>
            <table  style="width:100%">
                <tr>
                    <td colspan="2"><%# Eval("notification_name")%></td>
                </tr>
                  
            <tr>
                <td width="60px">
                    Emails</td>
                <td>
                    <telerik:RadTextBox ID="txtemails" Runat="server" MaxLength="150" Width="325px" 
                        Text='<%# Bind("notification_sendto") %>' EnableSingleInputRendering="True" 
                        LabelWidth="64px" style="top: 0px; left: 0px">
                    </telerik:RadTextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" 
                        ControlToValidate="txtemails" ErrorMessage="*Required" 
                        ValidationGroup=" " Display="Dynamic"></asp:RequiredFieldValidator>
                    
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" 
                        runat="server"  Display="Dynamic"
                                           ControlToValidate="txtemails" 
                        ErrorMessage="*Invalid Email"  ValidationGroup=" "
                                           
                        ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*([,;]\s*\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*)*"></asp:RegularExpressionValidator>
                </td>
            </tr>
             <tr>
                                           <td>
                                                </td>
                                           <td style="font-size: 10px; font-style: italic">
                                               You can add multiple email address delimitted by semi colon (;)</td>
                                       </tr>
            <tr>
                <td>
                    Subject</td>
                <td>
                    <telerik:RadTextBox ID="txtsubject" Runat="server" DisplayText="" 
                        LabelWidth="80px" Text='<%# Bind("notification_subject") %>' type="text" 
                        value="" Width="200px">
                    </telerik:RadTextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" 
                        ControlToValidate="txtsubject" ErrorMessage="*Required"></asp:RequiredFieldValidator>
                </td>
                <tr>
                    <td>
                        Notify</td>
                    <td>
                        <asp:CheckBox ID="notification_isnotifyCheckBox" runat="server" 
                            Checked='<%# Bind("notification_isnotify") %>' />
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;</td>
                    <td>
                        &nbsp;</td>
                </tr>
                <tr>
                    <td>
                        &nbsp;</td>
                    <td align="right">
                        <asp:LinkButton ID="UpdateCancelButton" runat="server" CssClass="button blue" CausesValidation="False"  OnClientClick="CloseWindow(); return false;"
                            CommandName="Cancel" Text="Cancel" />
                        &nbsp;<asp:LinkButton ID="UpdateButton" runat="server" CssClass="button blue"  CausesValidation="True" 
                            CommandName="Update" Text="Update" />
                    </td>
                </tr>
            </table>
            <br />
            &nbsp;
        </EditItemTemplate>
       
    </asp:FormView>
    <asp:SqlDataSource ID="dssettings" runat="server" 
        ConnectionString="<%$ ConnectionStrings:tfsCMSconn %>" 
        SelectCommand="SELECT [notification_id], [notification_code], [notification_name], [notification_sendto], [notification_subject], [notification_isnotify], [notification_fromname], [notification_fromemail], [notification_note], [notification_isactive] FROM [notifications] WHERE ([notification_code] = @notification_code)" 
        UpdateCommand="UPDATE [notifications] SET   [notification_sendto] = @notification_sendto, [notification_subject] = @notification_subject, [notification_isnotify] = @notification_isnotify  WHERE [notification_id] = @notification_id">
        <SelectParameters>
            <asp:QueryStringParameter Name="notification_code" QueryStringField="code" 
                Type="String" />
        </SelectParameters>
        <UpdateParameters>
         <asp:Parameter Name="notification_sendto" Type="String" />
            <asp:Parameter Name="notification_subject" Type="String" />
            <asp:Parameter Name="notification_isnotify" Type="Boolean" />
             <asp:Parameter Name="notification_id" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    </form>
</body>
</html>
