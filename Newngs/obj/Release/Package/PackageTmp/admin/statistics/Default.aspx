<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Masterpages/CMSAdmin.Master" CodeBehind="Default.aspx.vb" Inherits="tfsCMS._Default12" Theme="admin" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
       <script type="text/javascript" src="/Scripts/jquery-1.9.0.min.js"></script>
    <script type="text/javascript" src="/Scripts/oocharts.js"></script>
    	 
    <script type='text/javascript'>
        oo.setOOId("9f6124d1842941cc94738089665fdbad");
			
        //load reqs
        oo.load(function()
        {
        var tl = new oo.Timeline("62132859", new Date("1/1/2013"), new Date("5/10/2013"));

        tl.addMetric('ga:visitors', 'Visits');
        tl.addMetric('ga:newVisits', 'New Visits');

        tl.setOption('title', 'Visits Chart');
        tl.setOption('colors', ['orange', 'green', '#0072c6']);

        tl.draw("timeline-div");
        });
		</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphbody" runat="server">
     
    <div id="timeline-div"></div>
  
</asp:Content>
