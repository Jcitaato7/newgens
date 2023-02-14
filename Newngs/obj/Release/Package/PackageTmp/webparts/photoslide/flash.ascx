<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="flash.ascx.vb" Inherits="tfsCMS.wpphotoslide" %>
<header id="myCarousel" class="carousel slide"> 
    <!-- Indicators -->
    <ol class="carousel-indicators">
        <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
        <li data-target="#myCarousel" data-slide-to="1"></li>
        <li data-target="#myCarousel" data-slide-to="2"></li>
    </ol>  
    <!-- Wrapper for slides -->
    <asp:Repeater runat="server" ID="rptImages">            
        <HeaderTemplate>
            <div class="carousel-inner">
        </HeaderTemplate>
        <ItemTemplate>
            <div class='<%# IIf(Container.ItemIndex = 0, "item active", "item") %>'>
                <div class="fill" style='<%# "background-image:url(&#39;" & ResolveUrl(IIf(System.IO.File.Exists(MapPath(Eval("FilePath"))), Eval("FilePath"), "~/App_Themes/Default/images/nophoto.png")) & "&#39;);" %>'></div>
                <div class="carousel-caption">
                <h2><%# Eval("AlternateText")%></h2>
                </div>
            </div>
        </ItemTemplate>
        <FooterTemplate>
            </div>
        </FooterTemplate>
    </asp:Repeater>   
    <!-- Controls --> 
    <a class="left carousel-control" href="#myCarousel" data-slide="prev"> <span class="icon-prev"></span> </a> <a class="right carousel-control" href="#myCarousel" data-slide="next"> <span class="icon-next"></span> </a> 
</header>
 <script>
     $('.carousel').carousel({
         interval: 5000 //changes the speed
     })
</script>