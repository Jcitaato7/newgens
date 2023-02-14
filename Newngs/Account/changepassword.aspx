<%@ Page Title="Change Password" Language="vb" AutoEventWireup="false" MasterPageFile="~/Masterpages/CMSAdmin.Master" CodeBehind="changepassword.aspx.vb" Inherits="tfsCMS.changepassword" Theme="admin" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphbody" runat="server"><br />
    <div style="width:500px;margin:0 auto;">
     <h1>Change Your Password</h1>
    <asp:ChangePassword ID="ChangePassword1" runat="server"  >
         </asp:ChangePassword>
        </div>
</asp:Content>
