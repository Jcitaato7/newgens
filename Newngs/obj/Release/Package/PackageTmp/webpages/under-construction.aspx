<%@ Page Language="VB" MaintainScrollPositionOnPostback="true"  MasterPageFile="~/MasterPages/Default/DefaultMaster.master" AutoEventWireup="false"  CodeBehind="under-construction.aspx.vb" Inherits="tfsCMS.page_under_construction" title="Page Under Construction" %>
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
            <h2>Under Construction</h2>
            <br /><br />
            <p style="height:250px">Sorry, this page is under construction. But, still you can click any of the links above to get to know our company as well as our products.
            </p> 
        </div>
    </div>
</div>
</asp:Content>