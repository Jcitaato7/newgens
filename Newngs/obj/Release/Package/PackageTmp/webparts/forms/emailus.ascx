<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="emailus.ascx.vb" Inherits="tfsCMS.emailus" %>
<div class="col-md-8">
    <iframe src="https://www.google.com/maps/embed?pb=!1m14!1m8!1m3!1d31910.24070565882!2d103.70547647584257!3d1.3071268084827177!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31da0541ed5a0cf1%3A0xe6e6fe38c55e7559!2s28+Jalan+Buroh%2C+Singapore+619484!5e0!3m2!1sen!2sph!4v1412118291750" width="100%" height="400" frameborder="0" style="border:0"></iframe>               
</div>
<div class="col-md-4">
    <h3>Contact Details</h3>
    <p>
        <b>Universal Solution Pte Ltd</b><br>No 28 Jalan Buroh, Singapore 619484<br>
    </p>
    <p><i class="fa fa-phone"></i> 
        <abbr title="Phone">P</abbr>: +65 6265 9573</p>
        <p><i class="fa fa-fax"></i> 
        <abbr title="Fax">P</abbr>: 6265 9576</p>
    <p><i class="fa fa-envelope-o"></i> 
        <abbr title="Email">E</abbr>: <a href="mailto:name@example.com">sales@universalsolution.com.sg</a>
    </p>
    <p><i class="fa fa-clock-o"></i> 
        <abbr title="Hours">H</abbr>: Monday - Friday: 9:00 AM to 5:00 PM</p>
    <ul class="list-unstyled list-inline list-social-icons">
        <li>
            <a href="#"><i class="fa fa-facebook-square fa-2x"></i></a>
        </li>
        <li>
            <a href="#"><i class="fa fa-linkedin-square fa-2x"></i></a>
        </li>
        <li>
            <a href="#"><i class="fa fa-twitter-square fa-2x"></i></a>
        </li>
        <li>
            <a href="#"><i class="fa fa-google-plus-square fa-2x"></i></a>
        </li>
    </ul>
</div>
<div class="col-md-8">
    <h3>Send us a Message</h3>
    <div class="control-group form-group">
        <div class="controls">
            <label>Full Name: <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtfullname" Display="Dynamic" ErrorMessage="*" ValidationGroup="enquiry" />
            </label>
            <asp:TextBox ID="txtfullname" class="form-control" runat="server" MaxLength="50" />
            <p class="help-block"></p>
        </div>
    </div>
    <div class="control-group form-group">
        <div class="controls">
            <label>Phone Number: <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtcontactno" Display="Dynamic" ErrorMessage="*" ValidationGroup="enquiry" />
            </label>
            <asp:TextBox ID="txtcontactno" runat="server" CssClass="form-control" MaxLength="30" />
        </div>
    </div>
    <div class="control-group form-group">
        <div class="controls">
            <label>Email Address: <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="txtemail" Display="Dynamic" ErrorMessage="*" ValidationGroup="enquiry" /><asp:RegularExpressionValidator runat="server" ID="RegularExpressionValidator1" SetFocusOnError="true" Text="Example: username@gmail.com" ControlToValidate="txtemail" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" Display="Dynamic" ValidationGroup="enquiry"/>
            </label>
            <asp:TextBox ID="txtemail" runat="server" CssClass="form-control" MaxLength="30" /> 
        </div>
    </div>
    <div class="control-group form-group">
        <div class="controls">
            <label>Message: <asp:RequiredFieldValidator ID="rfvmsg" runat="server" ControlToValidate="txtmsg" Display="Dynamic" ErrorMessage="*" ValidationGroup="enquiry"></asp:RequiredFieldValidator>
            </label>
            <asp:TextBox ID="txtmsg" runat="server"  MaxLength="500" class="form-control" TextMode="MultiLine" Columns="100" Rows="10" style="resize:none" />                            
        </div>
    </div>
    <div id="success"></div>
    <!-- For success/fail messages -->
    <asp:Button ID="btnsend" CssClass="btn btn-primary" runat="server" Text="Send Message" ValidationGroup="enquiry" />
</div>
