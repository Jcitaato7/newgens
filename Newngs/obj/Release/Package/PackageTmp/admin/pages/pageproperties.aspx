<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="pageproperties.aspx.vb" Inherits="tfsCMS.pageproperties2" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Page Settings</title>
 
    <style type="text/css">
      body
{
     
    font-family: 'Lucida Grande' , 'Lucida Sans Unicode' , Tahoma, Arial, san-serif;
    font-size: 12px;
    
     }
     /*buttons*/
	.button,input[type="button"] {
    padding: 5px; margin:5px;
  background: #777 url(/App_Themes/admin/images/button.png) repeat-x bottom;
    border: none;
    color: #fff;
    cursor: pointer;
    -moz-border-radius: 3px;
    -webkit-border-radius: 3px;
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
 
 /*.button.orange,input[type="button"]
{
    background-color: #E48544;
}*/
 
.radiobuttonlist label 
{ cursor:pointer;}
 
.radiobuttonlist label:hover
{ color: #0066CC;}
 
.radiobuttonlist td
 {  text-align:left; width:120px; height:110px; padding:0 5px 0 5px;border: 1px solid #ffffff;}
 
 .radiobuttonlist td:hover
 { border: 1px solid #3399FF; background-color: #e2e2c6; -webkit-border-radius: 5px;
-moz-border-radius: 5px;
border-radius: 5px;}
   
 </style>
 
</head>
<body onload="AdjustRadWidow()">
    <form id="form1" runat="server">
      <telerik:RadScriptManager ID="RadScriptManager1" runat="server">
     </telerik:RadScriptManager>
         <script type="text/javascript">
          
        function GetRadWindow() {
            var oWindow = null;
            if (window.radWindow) oWindow = window.radWindow;
            else if (window.frameElement.radWindow) oWindow = window.frameElement.radWindow;
            return oWindow;
        }
        function returnToParent(newid) {
              //create the argument that will be returned to the parent page
            var oArg = new Object();

            //get the comboxbox clientid name 
            oArg.pageid = newid;

            //get a reference to the current RadWindow
            var oWnd = GetRadWindow();
       
            //Close the RadWindow and send the argument to the parent page
            if (oArg.pageid) {
                oWnd.close(oArg);
            }
            else {
                alert("Error Occured!");
            }
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
        function pagetypeSelected(id) {
          //  var weburl = document.getElementById('FormView1_txtweburl'); 
            if (id == '1') {
                var divtemplate = document.getElementById('divTemplate');
                var divURL = document.getElementById('divURL');
                var divseo = document.getElementById('divseo');
                divtemplate.style.display = '';
                divURL.style.display = 'none';
                divseo.style.display = ''; 
             //   $find('FormView1_txtweburl').set_value('');
            }
            if (id == '2') {
                var divtemplate = document.getElementById('divTemplate');
                var divURL = document.getElementById('divURL');
                var divseo = document.getElementById('divseo');
                divtemplate.style.display = 'none';
                divURL.style.display = 'none';
                divseo.style.display = 'none';
             //  $find('FormView1_txtweburl').set_value('');
            }
            if (id == '3') {
                var divtemplate = document.getElementById('divTemplate');
                var divURL = document.getElementById('divURL');
                var divseo = document.getElementById('divseo');
                divtemplate.style.display = 'none';
                divURL.style.display = '';
                divseo.style.display = 'none';

            }
            AdjustRadWidow();
        }
        function RestrictChar() {
            //get the keycode when the user pressed any key in application 
            var exp = String.fromCharCode(window.event.keyCode)
            //Below line will have the special characters that is not allowed you can add if you want more for some characters you need to add escape sequence 
            //var r = new RegExp("[-_,/'().0-9a-zA-Z \r]", "g"); 
            var r = new RegExp("[-_()0-9a-zA-Z \r]", "g");
            if (exp.match(r) == null) {
                window.event.keyCode = 0
                return false;
            }
        }
         function PageTitleValidation(oSrouce, args)
        { 
            var RBL = document.getElementById('FormView1_RadioButtonList1');
            var radio = RBL.getElementsByTagName("input");
           // var isChecked = false;
            var selectedvalue;
            for (var i = 0; i < radio.length; i++) {
                if (radio[i].checked) {

                    selectedvalue = radio[i].value;
                   
                    if (selectedvalue == 1) {
                      
                        if (isWhitespaceOrEmpty($find('FormView1_txtwebpagetitle').get_value()) == true)
                            args.IsValid = false;
                        else
                            args.IsValid = true;
                    }
                  //  isChecked = true;
                    break;
                }
            }
        }
        function RequiredURLRequiredValidation(oSrouce, args) {
            var RBL = document.getElementById('FormView1_RadioButtonList1');
            var radio = RBL.getElementsByTagName("input");
            // var isChecked = false;
            var selectedvalue;
            for (var i = 0; i < radio.length; i++) {
                if (radio[i].checked) {

                    selectedvalue = radio[i].value;

                    if (selectedvalue == 3) {

                        if (isWhitespaceOrEmpty($find('FormView1_txtweburl').get_value()) == true)
                            args.IsValid = false;
                        else
                            args.IsValid = true;
                    }
                    //  isChecked = true;
                    break;
                }
            }
        }

        function WebURLValidation(oSrouce, args) {
            var RBL = document.getElementById('FormView1_RadioButtonList1');
            var radio = RBL.getElementsByTagName("input");
            var weburl = $find('FormView1_txtweburl').get_value();
            // var isChecked = false;
            var selectedvalue;
            for (var i = 0; i < radio.length; i++) {
                if (radio[i].checked) {
                selectedvalue = radio[i].value;
                    if (!isWhitespaceOrEmpty(weburl) == true) {
                        if (selectedvalue == 3) {
                            if (!validateURL(weburl))
                                args.IsValid = false;
                            else
                                args.IsValid = true;
                        }
                    }
                    //  isChecked = true;
                    break;
                }
            }
        }
        function isWhitespaceOrEmpty(text) {
            return !/[^\s]/.test(text);
        }
        function CloseWindow() {
            GetRadWindow().Close();
        }
        function validateURL(value) {
            return /^(https?|ftp):\/\/(((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:)*@)?(((\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5]))|((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.?)(:\d*)?)(\/((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)+(\/(([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)*)*)?)?(\?((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)|[\uE000-\uF8FF]|\/|\?)*)?(\#((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)|\/|\?)*)?$/i.test(value);
        }
         </script>     
    <div style="padding:10px 10px 0;">
    
     <asp:FormView ID="FormView1" runat="server" DataKeyNames="webpageid" 
         DataSourceID="dspage"   Width="100%" 
    DefaultMode="ReadOnly" 
    Font-Names="font-family: Calibri,'Segoe UI','Trebuchet MS'; font-size:12px"    >
        <EditItemTemplate>                               
            <div style="width:700px; margin:0 auto;padding:10px">
                <asp:HiddenField ID="HiddenField1" runat="server" Value='<%# Bind("weburl")%>' /><asp:HiddenField ID="HiddenField2" runat="server" Value='<%# Bind("webpagefilename")%>' />
                <table style="vertical-align: top; text-align: left; padding:10px;" width="700px">
                    <tr>
                        <td  style="text-align: left; color: #666666; padding-bottom:5px; border-bottom-style: dotted; border-bottom-width: 1px; border-bottom-color: #C0C0C0;" 
                            class="style1" >
                            <span style="font-size:25px;">Edit Page</span><div style="float:right; text-align:center;">
                                <asp:Button ID="btncancel" runat="server" CssClass="button blue" Width="80px" OnClientClick="GetRadWindow().close();" CausesValidation="False" Text="Cancel" />&nbsp;<asp:Button ID="btnsave" runat="server" Width="80px" CommandName="Update" CssClass="button blue"   Text="Save" /> </div>
                                                
                        </td>
                    </tr>                               
                    <tr><td style="padding-top: 15px;" class="style1">Page Name
                        </td></tr>
                    <tr><td >
                        <telerik:RadTextBox ID="pagenametextbox" Runat="server" 
                                           
                            Font-Bold="true" MaxLength="100"  
                            Text='<%# Bind("webpagename") %>' Width="200px" 
                            style="top: -1px; left: 0px">
                        </telerik:RadTextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                            ControlToValidate="pagenametextbox" ErrorMessage="*Required"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                    </tr>
                                        
                                        
                    <tr>                                        
                        <td>
                            <asp:CheckBox ID="chkmenu" runat="server" 
                                Checked='<%# Bind("webpage_navigation") %>' 
                                Text="Show in navigation menu" />
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:CheckBox ID="chkshowfooter" runat="server"   
                                Checked='<%# Bind("webpage_infooteronly") %>' Text="Show in footer menu" />
                        </td>
                    </tr> 
                                            
                    <tr>
                        <td>
                            <%# IIF(Eval("webpage_isdefault")=0,"Page Type","Page Type [Default Page]") %></td>
                    </tr>
                    <tr>
                        <td>
<asp:RadioButtonList ID="RadioButtonList1" runat="server" 
AppendDataBoundItems="True" SelectedValue='<%# Bind("webpage_type") %>'  
                                Enabled='<%# IIF(Eval("webpage_isdefault")=0,1,0) %>' 
                                RepeatDirection="Horizontal" Width="350px" >
<asp:ListItem  Value="1" onclick="pagetypeSelected('1');">Normal Page</asp:ListItem>
<asp:ListItem Value="2" onclick="pagetypeSelected('2');">Page Group</asp:ListItem>
<asp:ListItem Value="3" onclick="pagetypeSelected('3');">Link</asp:ListItem>
</asp:RadioButtonList>
                        </td>
                    </tr>
                                        
                        <tr>
                        <td>
                        <div id="divURL"  <%#IIf(Eval("webpage_type")=3, "", "style='display:none;'") %>>
                            Page URL<br />
                                                 
                                <telerik:RadTextBox ID="txtweburl" Runat="server" MaxLength="100" 
                                    Width="350px" Font-Bold="True">
                            </telerik:RadTextBox>
                                    <asp:CustomValidator ID="CustomValidator3" ClientValidationFunction="RequiredURLRequiredValidation" runat="server" Display="Dynamic"
ErrorMessage="*Required" >*Required</asp:CustomValidator>
                                <asp:CustomValidator ID="CustomValidator1" ClientValidationFunction="WebURLValidation" runat="server"
ErrorMessage="*Required" >*Invalid URL</asp:CustomValidator>
                                </div>
                        </td>
                    </tr>
                                        
                                       
                    <tr>
                        <td>
<div id="divTemplate"  <%#IIf(Eval("webpage_type")=1, "", "style='display:none;'") %>  >
                                                  
                                                    
                            Design<br />
                                                
                                                    
                            <asp:RadioButtonList ID="RadioButtonList2" runat="server" CssClass="radiobuttonlist"
                                BackColor="WhiteSmoke"   
                                BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px"   AppendDataBoundItems="True"
                                DataSourceID="dscontenttype" DataTextField="template" 
                                DataValueField="template_id" RepeatDirection="Horizontal" 
                                SelectedValue='<%# Bind("webpage_template") %>' 
                                >
                            </asp:RadioButtonList>
                                                    
                            </div> 
     
                        </td>
                    </tr>
                    <tr><td>&nbsp;</td></tr>
                    <tr>
                        <td><strong>Editors</strong></td>
                    </tr>
                    <tr>
                        <td>
                            <telerik:RadComboBox ID="cbousers" Runat="server" CheckBoxes="True" DataSourceID="dsusers" DataTextField="fullname" DataValueField="username" Width="250px" EnableCheckAllItemsCheckBox="True">
                                <Items>
                                    <telerik:RadComboBoxItem runat="server" Selected="True" Text="" Value="" />
                                </Items>
                            </telerik:RadComboBox>
                        </td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td>
                        <div id="divseo"  <%#IIf(Eval("webpage_type")=1, "style='width:100%;padding:0;'", "style='display:none;width:100%;padding:0;'") %>  >
                    <table >
                        <tr>
                            <td style="font-weight: bold; color: #333333;">
                                Search Engine Optimization (SEO)</td>
                    </tr>
                                        
                        <tr>
                            <td>
                                Page Title</td>
                    </tr>
                    <tr>
                        <td>
                            <telerik:RadTextBox ID="txtwebpagetitle" Runat="server" Font-Bold="True" onkeypress="return RestrictChar()" 
                                MaxLength="100" Text='<%# Bind("webpagetitle") %>' Width="300px">
                            </telerik:RadTextBox><asp:CustomValidator ID="Custom1" ClientValidationFunction="PageTitleValidation" runat="server"
ErrorMessage="*Required" >*Required</asp:CustomValidator>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Meta Description</td>
                    </tr>
                    <tr>
                        <td>
                            <telerik:RadTextBox ID="txtdescription" Runat="server" Font-Bold="True" Height="30px" 
                                MaxLength="150" Skin="Telerik" Text='<%# Bind("webpagemetadesc") %>' 
                                TextMode="MultiLine" Width="400px">
                            </telerik:RadTextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Meta Keywords (separate each with a comma)</td>
                    </tr>
                    <tr>
                        <td>
                            <telerik:RadTextBox ID="txtkeywords" Runat="server" Font-Bold="True" Height="30px" 
                                MaxLength="250" Skin="Telerik" Text='<%# Bind("webpagemetakey") %>' 
                                TextMode="MultiLine" Width="500px">
                            </telerik:RadTextBox>
                        </td>
                    </tr>
                                       
                    </table>
                                        
                        </div>

                        </td>
                    </tr>
                                        
                                       
                </table>
                                     </div>
                                 
        </EditItemTemplate>
        <InsertItemTemplate>                                   
                                  <div style="width:700px">
                                   <div style="width:700px; margin:0 auto;">
                               <table style="vertical-align: top; text-align: left; padding:10px;" width="700px">
                                        <tr>
                                            <td class="style1" 
                                                style="text-align: left; color: #666666; padding-bottom: 5px; border-bottom-style: dotted; border-bottom-width: 1px; border-bottom-color: #C0C0C0;">
                                                <span style="font-size:25px;">New Page</span><div 
                                                    style="float:right; text-align:center;">
                                                    <asp:Button ID="btncancel" runat="server" CausesValidation="False" 
                                                        CommandName="Cancel" CssClass="button blue" Text="Cancel" Width="80px" />
                                                    &nbsp;<asp:Button ID="btnsave" runat="server" CommandName="Insert" 
                                                        CssClass="button blue" Text="Save" Width="80px" />
                                                </div>
                                            </td>
                                        </tr>                                     
       
                                       <tr><td style="padding-top: 15px;" >Page Name</td></tr>
                                        <tr><td>
                                         <telerik:RadTextBox ID="pagenametextbox" Runat="server" 
                                                                                              Font-Bold="true" MaxLength="100" 
                                                Text='<%# Bind("webpagename") %>' Width="200px">
                                            </telerik:RadTextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                                                ControlToValidate="pagenametextbox" ErrorMessage="*Required"></asp:RequiredFieldValidator>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                              
                                                  <asp:CheckBox ID="chkmenu" runat="server" 
                                                      Checked='<%# Bind("webpage_navigation") %>' Text="Show in navigation menu" />
                                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:CheckBox ID="chkshowfooter" runat="server"   
                                                    Checked='<%# Bind("webpage_infooteronly") %>' Text="Show in footer menu" />
                                            </td>
                                        </tr>                                         
                                        <tr>
                                            <td>
                                                Page Type</td>
                                        </tr>
                                        <tr>
                                            <td>
                                            <asp:RadioButtonList ID="RadioButtonList1" runat="server" 
  AppendDataBoundItems="True" SelectedValue='<%# Bind("webpage_type") %>'  
                                                    
                                                    RepeatDirection="Horizontal" Width="350px" >
<asp:ListItem  Value="1" onclick="pagetypeSelected('1');" Selected="True">Normal Page</asp:ListItem>
<asp:ListItem Value="2" onclick="pagetypeSelected('2');">Page Group</asp:ListItem>
 <asp:ListItem Value="3" onclick="pagetypeSelected('3');">Link</asp:ListItem>
 </asp:RadioButtonList>

                                               

                                            </td>
                                        </tr>
                                      
                                        <tr><td>
                                         

                                            <div id="divURL"  style="display:none;">
                                                Page URL<br />
                                                 <telerik:RadTextBox ID="txtweburl" Runat="server" MaxLength="100" Font-Bold="True"
                                                    Width="350px">
                                                </telerik:RadTextBox>
                                                 <asp:CustomValidator ID="CustomValidator3" ClientValidationFunction="RequiredURLRequiredValidation" runat="server" Display="Dynamic"
                ErrorMessage="*Required" >*Required</asp:CustomValidator>
                                                   <asp:CustomValidator ID="CustomValidator1" ClientValidationFunction="WebURLValidation" runat="server"
                ErrorMessage="*Required" >*Invalid URL</asp:CustomValidator>
                                                    </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                 
                                                 </td>
                                        </tr>
                                       
                                        <tr>
                                            <td>
                                            
                                    <div id="divTemplate"   >
                                           
                                                     Design<br />
                                                
                                                    
                                                <asp:RadioButtonList ID="RadioButtonList2" runat="server" BackColor="WhiteSmoke"  CssClass="radiobuttonlist"
                                                    BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px"     ondatabound="RadioButtonList2_DataBound"
                                                    DataSourceID="dscontenttype" DataTextField="template"  
                                                    DataValueField="template_id" RepeatDirection="Horizontal" 
                                                    SelectedValue='<%# Bind("webpage_template") %>'>
                                                   
                                                </asp:RadioButtonList>
                                                </div>
                                                     </td>
                                        </tr>
                                        <tr><td>&nbsp;</td></tr>
                                        <tr>
                                            <td><strong>Editors</strong></td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <telerik:RadComboBox ID="cbousers" Runat="server" CheckBoxes="True" DataSourceID="dsusers" DataTextField="fullname" DataValueField="username" Width="250px" EnableCheckAllItemsCheckBox="True">
                                                    <Items>
                                                        <telerik:RadComboBoxItem runat="server" Selected="True" Text="" Value="" />
                                                    </Items>
                                                </telerik:RadComboBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>&nbsp;</td>
                                        </tr>
                                        <tr>
                                             <td>
                                         <div id="divseo" style="width:100%;padding:0">
                                         <table>
                                           <tr>
                                             <td style="font-weight: bold; color: #333333;">
                                                 Search Engine Optimization (SEO)</td>
                                        </tr>
                                        
                                         <tr>
                                             <td>
                                                 Page Title</td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <telerik:RadTextBox ID="txtwebpagetitle" Runat="server" Font-Bold="True" onkeypress="return RestrictChar()" 
                                                    MaxLength="100" Text='<%# Bind("webpagetitle") %>' Width="300px">
                                                </telerik:RadTextBox>
<asp:CustomValidator ID="Custom1" ClientValidationFunction="PageTitleValidation" runat="server"
                ErrorMessage="*Required" >*Required</asp:CustomValidator>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                Meta Description</td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <telerik:RadTextBox ID="txtdescription" Runat="server" Font-Bold="True" Height="30px" 
                                                    MaxLength="150" Skin="Telerik" Text='<%# Bind("webpagemetadesc") %>' 
                                                    TextMode="MultiLine" Width="400px">
                                                </telerik:RadTextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                Meta Keywords (separate each with a comma)</td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <telerik:RadTextBox ID="txtkeywords" Runat="server" Font-Bold="True" Height="30px" 
                                                    MaxLength="250" Skin="Telerik" Text='<%# Bind("webpagemetakey") %>' 
                                                    TextMode="MultiLine" Width="500px">
                                                </telerik:RadTextBox>
                                            </td>
                                        </tr>
                                        </table>
                                         </div>
                                         </td>
                                        </tr>
                                        
                                       
                                        </table>
                                  </div>
                                      </div>              
                                </InsertItemTemplate>
                            
                                <EmptyDataTemplate>
                                  <div style="padding:20px;font-size:15px; width:350px; text-align:center">YOU DO NOT HAVE THE ACCESS RIGHT TO CREATE A PAGE OR EDIT PAGE SETTINGS</div>
                                </EmptyDataTemplate>
        
                            </asp:FormView>
 
        </div>
 
                <asp:SqlDataSource ID="dspage" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:tfsCMSconn %>" 
                    DeleteCommand="techCMS_spPageDelete" 
                    InsertCommand="techCMS_spPageInsert" 
                    SelectCommand="techCMS_spPageSelect" 
                    UpdateCommand="techCMS_spPageUpdate" 
                    SelectCommandType="StoredProcedure" InsertCommandType="StoredProcedure" 
                    UpdateCommandType="StoredProcedure" DeleteCommandType="StoredProcedure" 
                    >
                  
                      <SelectParameters>
                          <asp:QueryStringParameter DbType="Int64" DefaultValue="0" Name="webpageid" 
                              QueryStringField="webpageid" />
    </SelectParameters>
                    <DeleteParameters>
                        <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" DefaultValue="" Type="Int32" />
                        <asp:Parameter Name="webpageid" Type="Int32" />
                    </DeleteParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="RETURN_VALUE" Direction="ReturnValue" Type="Int32" />
                        <asp:Parameter Name="webpagename" Type="String" />
                        <asp:Parameter Name="webmodifiedby" Type="String" />
                        <asp:Parameter Name="webpage_navigation" Type="Boolean" />
                          <asp:Parameter Name="webpage_infooteronly" Type="Boolean" />
                        <asp:Parameter Name="webpage_type" Type="Int32" />
                        <asp:Parameter Name="webpageid" Type="Int32" />
                        <asp:Parameter Name="weburl" Type="String" />
                        <asp:Parameter Name="webpage_template" Type="String" />
                           <asp:Parameter Name="webpagetitle" Type="String" />
                        <asp:Parameter Name="webpagemetadesc" Type="String" DefaultValue="" />
                        <asp:Parameter Name="webpagemetakey" Type="String" DefaultValue=""/>
                        <asp:Parameter Name="webpagefilename" Type="String" DefaultValue=""/>
                      <asp:Parameter Name="webpageadmins" Type="String" DefaultValue=""/>   
                    </UpdateParameters>
                    <InsertParameters>
                        <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
                        <asp:Parameter Name="webpagename" Type="String"  />
                        <asp:Parameter Name="webcreatedby" Type="String"  />
                        <asp:Parameter Name="webpage_navigation" Type="Boolean" />
                          <asp:Parameter Name="webpage_infooteronly" Type="Boolean" />
                        <asp:Parameter Name="webpage_type" Type="Int32" />
                           <asp:Parameter Name="webpage_parentid" Type="Int32"/>
                        <asp:Parameter Name="weburl" Type="String"  />
                        <asp:Parameter Name="webpage_template" Type="String"  />
                        <asp:Parameter Name="webpagetitle" Type="String" DefaultValue="" />
                        <asp:Parameter Name="webpagemetadesc" Type="String" DefaultValue="" />
                        <asp:Parameter Name="webpagemetakey" Type="String" DefaultValue="" />
                        <asp:Parameter Name="webpagefilename" Type="String" DefaultValue="" />
                          <asp:Parameter Name="webpageadmins" Type="String" DefaultValue=""/>   
                    </InsertParameters>
                </asp:SqlDataSource>

    

    <asp:SqlDataSource ID="dscontenttype" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:tfsCMSconn %>" 
                    
    
    
    SelectCommand="SELECT template_id,  template_name,template_image,template ='&lt;span class=&quot;pagetemplate&quot;&gt;'+
template_name + '&lt;img    src=&quot;templates/images/' + template_image + '&quot; width=&quot;100px&quot; align=&quot;left&quot;/&gt;&lt;/span&gt;'

FROM [techCMS_templates] where [template_isactive] = 1 AND template_ismain = 1 ORDER BY [template_sort]">
                </asp:SqlDataSource>
         <asp:SqlDataSource ID="dsusers" runat="server" 
                ConnectionString="<%$ ConnectionStrings:tfsCMSconn %>" 
 SelectCommand="SELECT userinfo.username, userinfo.firstname + ' ' + userinfo.lastname as fullname FROM aspnet_Users INNER JOIN aspnet_Membership ON aspnet_Users.UserId = aspnet_Membership.UserId INNER JOIN userinfo ON aspnet_Users.UserName = userinfo.username where exists(select ir.userid from aspnet_UsersInRoles as ir where ir.RoleId='2112135a-bcc4-48e2-9b57-4e2136ea2239' and ir.userid=aspnet_Users.UserId)" 
 > 
            </asp:SqlDataSource>
    </form>
</body>
</html>
