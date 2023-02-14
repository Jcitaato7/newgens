<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="wpproductcategoriesfeatured.ascx.vb" Inherits="tfsCMS.wpproductcategoriesfeatured" %>
<div class="col-lg-12">
    <h2 class="page-header">Welcome to Universal Solutions Pte Ltd</h2>
</div>
<asp:Repeater runat="server" ID="rptImages">            
    <HeaderTemplate>        
    </HeaderTemplate>
    <ItemTemplate>  
        <div class="col-md-3 col-sm-6">      
            <div class="panel panel-default text-center">
                <asp:Image ID="Image1" ImageUrl='<%# Eval("FilePath")%>' runat="server" CssClass="featImg" />
                <div class="panel-body">
                    <h4><%# Eval("CategoryName")%></h4>
                    <p><%# Eval("ShortDescription")%></p>
                    <a href="#" class="btn btn-primary">Learn More</a>
                </div>
            </div>
        </div>
    </ItemTemplate>
    <FooterTemplate>        
    </FooterTemplate>
</asp:Repeater>