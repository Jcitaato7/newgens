<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Login.aspx.vb" Inherits="tfsCMS.Login" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>CMS Login</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
    <link href='http://fonts.googleapis.com/css?family=Fjalla+One' rel='stylesheet' type='text/css' />
<link href="css/login.css" rel="stylesheet" type="text/css" />
    <link href="../App_Themes/Default/bootstrap.min.css" rel="stylesheet" type="text/css" />
</head>
<body style="background-color: #012f5d;">
  
    <form id="form1" runat="server"   >

  <div class="modal-dialog">
  <div class="modal-content">
       <div class="modal-header">
            <asp:Image ID="Image1" class="displayed" runat="server" ImageUrl="~/App_Themes/Admin/images/logo2.png" AlternateText="Logo" />
              
       <h1 class="text-center">CONTENT MANAGEMENT SYSTEM</h1>
            </div>  
    <div class="login">
       <asp:Login ID="LoginUser" runat="server" EnableViewState="false" RenderOuterTable="false"  >
        <LayoutTemplate>
          <div class="modal-body">
             <div class="form-group">
              <asp:Label ID="UserNameLabel" runat="server" AssociatedControlID="UserName">Username</asp:Label> 
              <asp:TextBox ID="UserName" CssClass="form-control input-lg" runat="server"  placeholder=""  Width="100%"></asp:TextBox>
            </div>
             <div class="form-group">
                <asp:Label ID="PasswordLabel" runat="server" AssociatedControlID="Password">Password</asp:Label>
                 <asp:TextBox ID="Password" CssClass="form-control input-lg" runat="server" placeholder="" Width="100%" TextMode="Password"></asp:TextBox>
            </div>
               <div class="form-group">
                   <asp:Button ID="Button1" runat="server" CommandName="Login" Text="Log In" CssClass="btn btn-primary btn-lg btn-block"  ValidationGroup="LoginUserValidationGroup" />
               </div>
            <div class="form-group">
                    <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="UserName" 
                             CssClass="failureNotification" ErrorMessage="User Name is required." ToolTip="User Name is required." 
                             ValidationGroup="LoginUserValidationGroup" Display="Dynamic"></asp:RequiredFieldValidator>
                     <asp:RequiredFieldValidator ID="PasswordRequired" runat="server"  Display="Dynamic" ControlToValidate="Password" 
                             CssClass="failureNotification" ErrorMessage="Password is required." ToolTip="Password is required." 
                             ValidationGroup="LoginUserValidationGroup"></asp:RequiredFieldValidator>
            </div>
         </div>
        </LayoutTemplate>
    </asp:Login>
    </div> 
  </div>

  </div>
    </form>
       
</body>
</html>
