<%@ Page Title="Reset Password" Language="vb" AutoEventWireup="false" MasterPageFile="~/Masterpages/CMSAdmin.Master" CodeBehind="Recovery.aspx.vb" Inherits="tfsCMS.Recovery" Theme="admin" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphbody" runat="server">
<div style="padding:10px;">
 <div class="box" style="width:1100px; margin:0 auto; padding:20px;">    
 <table style="border: 1px solid #CCCCCC;padding:10px;width:400px;margin:0 auto;">
        <tr>
            <td  colspan="2"  >
               <h1>Reset User Password</h1></td>
            
        </tr>
        <tr>
            <td >
                Username</td>
            <td  >
                <asp:Label ID="lblusername" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="style2"  >
                New Password</td>
            <td  >
                <telerik:RadTextBox ID="txtpwd" Runat="server" MaxLength="10" Width="120px">
                </telerik:RadTextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                    ControlToValidate="txtpwd" ErrorMessage="*Required"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td class="style2"  >
                &nbsp;</td>
            <td   >
                <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" 
                    ControlToValidate="txtpwd" ErrorMessage="Minimum of 6 characters" 
                    ValidationExpression="^[a-zA-Z0-9\s\-\,]{5,}.\*?$"></asp:RegularExpressionValidator>
            </td>
        </tr>
        <tr>
            <td class="style2"  >
                &nbsp;</td>
            <td align="left"  >
                <asp:Button ID="btnback" runat="server" CausesValidation="false" CssClass="button blue" OnClientClick="history.go(-1); return false;" 
                    Text="BACK" />
                <asp:Button ID="btnreset" runat="server" CssClass="button blue" 
                    Text="RESET" />
            </td>
        </tr>
        <tr>
            <td colspan="2" >
                <asp:Label ID="lblmsg" runat="server" ForeColor="Red" Text=""></asp:Label>
            </td>
        </tr>
    </table>
    </div> 
    </div> 
</asp:Content>
