<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Login.aspx.vb" Inherits="tfsCMS.Login" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>CMS Login</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
    <link href='http://fonts.googleapis.com/css?family=Fjalla+One' rel='stylesheet' type='text/css' />
<link href="css/login.css" rel="stylesheet" type="text/css" />
</head>
<body>
  
    <form id="form1" runat="server"   >
        <div style="height: 100px;"></div>
          <div class="bglogin">
  <div class="boxlogin">
  	<div class="boxlayout"> 
        <div class="login-logowrapper">
            <asp:Image ID="Image1" runat="server" ImageUrl="~/App_Themes/Admin/images/logo.png" AlternateText="Logo" />
        </div>        
        <div class="title-cms">CONTENT MANAGEMENT SYSTEM</div>
    <div class="login">
       <asp:Login ID="LoginUser" runat="server" EnableViewState="false" RenderOuterTable="false"  >
        <LayoutTemplate>
           <table width="80%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td width="20%"><asp:Label ID="UserNameLabel" runat="server" AssociatedControlID="UserName">Username</asp:Label> </td>
              <td><asp:TextBox ID="UserName" runat="server"  placeholder=""  Width="100%"></asp:TextBox></td>
            </tr>
            <tr>
              <td><asp:Label ID="PasswordLabel" runat="server" AssociatedControlID="Password">Password</asp:Label></td>
              <td><asp:TextBox ID="Password" runat="server" placeholder="" Width="100%" TextMode="Password"></asp:TextBox></td>
            </tr>
               <tr><td colspan="2" style="text-align:right; padding-top: 5px"><asp:Button ID="Button1" runat="server" CommandName="Login" Text="Log In" CssClass="button"  ValidationGroup="LoginUserValidationGroup" /></td></tr>
         <tr><td colspan="2"><asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="UserName" 
                             CssClass="failureNotification" ErrorMessage="User Name is required." ToolTip="User Name is required." 
                             ValidationGroup="LoginUserValidationGroup" Display="Dynamic"></asp:RequiredFieldValidator>
                     <asp:RequiredFieldValidator ID="PasswordRequired" runat="server"  Display="Dynamic" ControlToValidate="Password" 
                             CssClass="failureNotification" ErrorMessage="Password is required." ToolTip="Password is required." 
                             ValidationGroup="LoginUserValidationGroup"></asp:RequiredFieldValidator>
 </td></tr>
                </table>
        </LayoutTemplate>
    </asp:Login>
    </div> </div>
  </div>

  </div>
    </form>
       
</body>
</html>
