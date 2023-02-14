<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="logoslide.ascx.vb" Inherits="tfsCMS.wplogoslide" %>
<script type="text/javascript" src='<%=ResolveUrl("~/Scripts/jCarouselLite/jcarousellite_1.0.1.min.js")%>'></script>
<script type="text/javascript">
    $(function () {
        var carouselLength = 7;

        $(".prodPhotos").jCarouselLite({
            btnNext: ".next",
            btnPrev: ".prev",
            circular: true,
            visible: carouselLength
        });

        if ($(".prodPhotos ul li").length < (carouselLength + 1)) {
            $(".carbtn").hide();
        }
    });
</script>
<div class="jcarWrapper"> <a href="#" class="carbtn prev"></a>
    <div class="prodPhotos">
        <asp:Repeater runat="server" ID="rptImages">            
            <HeaderTemplate>
                <ul>
            </HeaderTemplate>
            <ItemTemplate>                    
                    <li><asp:Image ID="Image1" runat="server" ImageUrl='<%# ResolveUrl(IIf(System.IO.File.Exists(MapPath(Eval("FilePath"))), Eval("FilePath"), "~/App_Themes/Default/images/nophoto.png"))%>' AlternateText='<%# Eval("AlternateText")%>'></asp:Image></li>
            </ItemTemplate>
            <FooterTemplate>
                </ul>
            </FooterTemplate>
        </asp:Repeater>   
    </div>
    <a href="#" class="carbtn next"></a>
    <div style="clear:both"></div>
</div>
 