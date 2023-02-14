<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="application.aspx.vb" Inherits="tfsCMS.application" Theme="Default" %>

<%@ Register src="job-application.ascx" tagname="job" tagprefix="uc1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Application Form</title>
    <style type="text/css">
        input[type=text]
        { 
	border-radius: 2px !important;
	background: #dedede !important;
	padding: 10px !important;
	border: #636363 0px solid !important;
	color: #434343 !important;
    moz-border-radius: 2px !important;
	 }
            input[type=button]
    {

	font-size: 12px !important;
	color: #fff !important;
	 
	text-decoration: none !important;
	font-weight: bold !important;
	padding: 0 !important;
	border: solid 0px #6b6b63  !important;
	margin-right: 10px  !important;
	background: #35c2de  !important;
	-moz-border-radius: 2px  !important;
	border-radius: 2px !important;
}
 Input[type=button]:hover {
	color: #fff  !important;
	background: #006e8a !important;
}
    </style>
</head>
<body>

    <form id="form1" runat="server">
        <telerik:RadScriptManager ID="RadScriptManager1" Runat="server">
        </telerik:RadScriptManager>
    <div style="margin:0 auto; min-width:400px;padding:10px;">
            <uc1:job ID="job1" runat="server" />
    </div>
    </form>
</body>
</html>
