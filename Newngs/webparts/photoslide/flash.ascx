<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="flash.ascx.vb" Inherits="tfsCMS.wpphotoslide" %>
<header id="main-slide" class="carousel slide" data-ride="carousel"> 
    <div class="overlay"></div>
    <!-- Indicators -->
    <asp:Repeater runat="server" ID="rptIndicators">            
        <HeaderTemplate>
            <ol class="carousel-indicators">
        </HeaderTemplate>
        <ItemTemplate>
            <li data-target="#main-slide" data-slide-to='<%# Container.ItemIndex %>' <%# IIf(Container.ItemIndex = 0, "class=""active""", "") %>></li>            
        </ItemTemplate>
        <FooterTemplate>
            </ol>
        </FooterTemplate>
    </asp:Repeater> 
<%--    <ol class="carousel-indicators">
        <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
        <li data-target="#myCarousel" data-slide-to="1"></li>
        <li data-target="#myCarousel" data-slide-to="2"></li>
    </ol>  --%>
    <!-- Wrapper for slides -->
    <asp:Repeater runat="server" ID="rptImages">            
        <HeaderTemplate>
            <div class="carousel-inner">
        </HeaderTemplate>
        <ItemTemplate>
            <div class='<%# IIf(Container.ItemIndex = 0, "item active", "item")%>'>
         
                 <img class="img-responsive" src='<%# ResolveUrl(IIf(System.IO.File.Exists(MapPath(Eval("FilePath"))), Eval("FilePath"), "~/App_Themes/Default/images/nophoto.png"))%>' alt="slider">
                <div class="slider-content" style=" top: 30% !important;"> 
                <div class="col-md-12 text-center">
                     <div class="container">
                    <h2 class="animated3" align="left" style="color: #fff; text-shadow: 5px 5px 5px rgba(0,0,0,0.5);"><%# Eval("AlternateText").ToString.Replace(Environment.NewLine,"<br />").Replace("--", "<b>").Replace("$$", "</b>")%></h2>
                    <h2 class="animated3" align="right" style="color: #fff; text-shadow: 5px 5px 5px rgba(0,0,0,0.5);"><%# Eval("Description").ToString.Replace(Environment.NewLine,"<br />").Replace("--", "<b>").Replace("$$", "</b>")%></h2>
                    </div>
                     </div>
                </div>
            </div>
        </ItemTemplate>
        <FooterTemplate>
            </div>
            	<!-- Controls -->
			<a class="left carousel-control" href="#main-slide" data-slide="prev">
		    	<span><i class="fa fa-angle-left"></i></span>
			</a>
			<a class="right carousel-control" href="#main-slide" data-slide="next">
		    	<span><i class="fa fa-angle-right"></i></span>
			</a>
        </FooterTemplate>
    </asp:Repeater>   
    <!-- Controls --> 
    <!--<a class="left carousel-control" href="#main-slide" data-slide="prev"> <span class="icon-prev"></span> </a> <a class="right carousel-control" href="#main-slide" data-slide="next"> <span class="icon-next"></span> </a> -->
</header>
 <script>
     $('.carousel').carousel({
         interval: 5000 //changes the speed
     })
</script>