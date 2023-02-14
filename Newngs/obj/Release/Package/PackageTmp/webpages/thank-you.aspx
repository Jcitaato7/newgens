<%@ Page Language="VB" MaintainScrollPositionOnPostback="true"  MasterPageFile="~/MasterPages/Default/DefaultMaster.master" AutoEventWireup="false"  CodeBehind="thank-you.aspx.vb" Inherits="tfsCMS.thankyou" title="Enquiries - Thank You!" %>
<%@ Register src="~/webparts/navigation/wpBreadCrumb.ascx" tagname="BreadCrumb" tagprefix="techCMS" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphbody" Runat="Server">
<div class="container">
    <div class="top-margin"></div>
    <div class="row">
        <div class="col-lg-12">
            <techCMS:BreadCrumb ID="BreadCrumb1" runat="server" Title="Breadcrumb" />
        </div>
    </div>
    <div class="row">
        <div class="col-lg-12">
            <h2>Thank you!</h2>
            <br /><br />
            <p style="height:250px"><asp:Literal ID="litmsg" runat="server"></asp:Literal>
            </p> 
        </div>
    </div>
</div> 
</asp:Content>