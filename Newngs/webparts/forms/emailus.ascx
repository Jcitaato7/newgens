<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="emailus.ascx.vb" Inherits="tfsCMS.emailus" %>
 <script src="https://www.google.com/recaptcha/api.js" async defer></script>
    <div class="row">
    <div class="col-md-4">
        <div class="form-group">
            <label style="font-weight:normal;">Name: <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtfullname" Display="Dynamic" ErrorMessage="*" ValidationGroup="enquiry" />
            </label>
            <asp:TextBox ID="txtfullname" class="form-control" runat="server" MaxLength="50" />
            <p class="help-block"></p>
        </div>
    </div>
    <div class="col-md-4">
        <div class="form-group">
            <label style="font-weight:normal;">Phone Number: <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtcontactno" Display="Dynamic" ErrorMessage="*" ValidationGroup="enquiry" />
            </label>
            <asp:TextBox ID="txtcontactno" runat="server" CssClass="form-control" MaxLength="30" />
        </div>
    </div>
    <div class="col-md-4">
        <div class="form-group">
            <label style="font-weight:normal;">Email Address: <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="txtemail" Display="Dynamic" ErrorMessage="*" ValidationGroup="enquiry" /><asp:RegularExpressionValidator runat="server" ID="RegularExpressionValidator1" SetFocusOnError="true" Text="Example: username@gmail.com" ControlToValidate="txtemail" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" Display="Dynamic" ValidationGroup="enquiry"/>
            </label>
            <asp:TextBox ID="txtemail" runat="server" CssClass="form-control" MaxLength="30" /> 
        </div>
    </div>
    </div>
    <div class="form-group">
            <label style="font-weight:normal;">Message: <asp:RequiredFieldValidator ID="rfvmsg" runat="server" ControlToValidate="txtmsg" Display="Dynamic" ErrorMessage="*" ValidationGroup="enquiry"></asp:RequiredFieldValidator>
            </label>
            <asp:TextBox ID="txtmsg" runat="server"  MaxLength="500" class="form-control" TextMode="MultiLine" Columns="100" Rows="10" style="resize:none" />                            
   </div>
  <div class="g-recaptcha" data-sitekey="6Ler-q8UAAAAAB3bfcHVk5KY6GViwnqMz0ABriTn"></div>
   

    <div id="success"></div>
    <!-- For success/fail messages -->
    <div class="text-right"><br>
    <asp:Button ID="btnsend" CssClass="btn btn-primary solid blank" runat="server" Text="Send Message" ValidationGroup="enquiry" />
    </div>


