<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="job-application.ascx.vb" Inherits="tfsCMS.job_application" %>
  <script>
      function validateRadUpload(source, e) {
          e.IsValid = false;

          var upload = $find("AsyncUpload1");
          e.IsValid = upload.getUploadedFiles().length != 0;
}
  </script>
<asp:Panel ID="Panel1" runat="server">
<div class="app-form" style="width:80%;margin:0 auto">
    <h2>Apply Online</h2>
     <label for="name">Position</label><br />
     <asp:DropDownList ID="ddlposition" Runat="server" CssClass="dropdown" 
                            AppendDataBoundItems="True" DataSourceID="dspositions" 
                            DataTextField="VacancyName" DataValueField="VacancyID">
            <asp:ListItem Selected="True" Value="-1">[Select]</asp:ListItem>
                         </asp:DropDownList>
                      
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"  ControlToValidate="ddlposition"
                   Display="Dynamic" ErrorMessage="*Required"  InitialValue="-1"
                            ValidationGroup="jobapplication" ></asp:RequiredFieldValidator>
    <br />
      <label for="name">Full Name</label>
     <br /> <asp:TextBox ID="txtname" runat="server" CssClass="textbox-search" MaxLength="50" 
                Width="250px" /><asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                            ControlToValidate="txtname" Display="Dynamic" ErrorMessage="*Required" 
                            ValidationGroup="jobapplication"></asp:RequiredFieldValidator>
      <br /> <label for="name">Email Address</label>
     <br /> <asp:TextBox ID="txtemail" runat="server" CssClass="textbox-search" MaxLength="30" 
                Width="250px" /> 
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
                            ControlToValidate="txtemail" Display="Dynamic" ErrorMessage="*Required" 
                            ValidationGroup="jobapplication"></asp:RequiredFieldValidator>
    <asp:RegularExpressionValidator runat="server" ID="RegularExpressionValidator23"
            SetFocusOnError="true" Text="Example: username@gmail.com" ControlToValidate="txtemail"
            ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" Display="Dynamic" ValidationGroup="jobapplication"/>
    <br /><label for="name">Contact Number</label>  
   <br />  <asp:TextBox ID="txtphone" runat="server" CssClass="textbox-search" MaxLength="30" 
                Width="250px" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" 
                            ControlToValidate="txtphone" Display="Dynamic" ErrorMessage="*Required" 
                            ValidationGroup="jobapplication"></asp:RequiredFieldValidator>
    <br /><label for="name">Attach Resume</label>  
    <br /> <telerik:RadAsyncUpload ID="AsyncUpload1" runat="server" MaxFileInputsCount="1" AllowedFileExtensions="doc,docx,pdf"   
                            MaxFileSize="1048576" Width="150px"   ClientIDMode="Static" >
                        <FileFilters>
        <telerik:FileFilter Description="Documents(doc;docx;pdf)" Extensions="doc,docx,pdf" />
    </FileFilters>    
</telerik:RadAsyncUpload>
    <asp:CustomValidator ID="CustomValidator1" runat="server" ErrorMessage="*Required" ValidationGroup="jobapplication" ClientValidationFunction="validateRadUpload"></asp:CustomValidator><br />
    
    Select documents to upload (doc, docx, pdf)<br />
    File size limit is 1 MB.<br />
   <asp:Button ID="btnapply" CssClass="button"  runat="server" Text="Submit" CausesValidation="true"  ValidationGroup="jobapplication"  Width="70px"/>
</div>
<br />
</asp:Panel>
<asp:SqlDataSource ID="dspositions" runat="server" 
        ConnectionString="<%$ ConnectionStrings:tfsCMSConn %>" 
        
        SelectCommand="SELECT [VacancyID], [VacancyName] FROM [techCMS_Vacancies] WHERE isactive = 1 ">
    </asp:SqlDataSource>