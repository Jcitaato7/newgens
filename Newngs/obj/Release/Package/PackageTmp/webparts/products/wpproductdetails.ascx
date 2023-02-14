<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="wpproductdetails.ascx.vb" Inherits="tfsCMS.wpproductdetails" %>
<script type="text/javascript" src='<%=ResolveUrl("~/scripts/fancyboxlite/jquery.fancybox-1.3.4.js")%>'></script>  
<link rel="stylesheet" type="text/css" href='<%=ResolveUrl("~/scripts/fancyboxlite/jquery.fancybox-1.3.4.css")%>' />
<link rel="stylesheet" type="text/css" href='<%=ResolveUrl("~/scripts/accordion/css/accordion.css")%>' />
<script type="text/javascript">

    jQuery(document).ready(function () {
        $('.fancybox').fancybox({
            'titleShow': false
        });
    });

</script>
<div>
    <div class="productUrlHashWrap"><asp:HiddenField ID="urlHash" runat="server" /></div>
<h1>Products & Services</h1>
<br/>
<p>UNIWES was incorporated in 1992 as a turnkey project specialist in the three phases of initiation, design and construction of numerous industrial activities. UNIWES provides customers with various services from the front-end Water Purification System to the Chemical Processing System and Wastewater Treatment System, as well as providing assistance in acquiring relevant accessories.</p>
</div>
<br/>
<br/>
<!---BOX END----> 
<!---BOX---->
<asp:Repeater ID="rptMainItem" runat="server">
    <ItemTemplate>        
        <div class="box">
            <h2><%# Eval("CategoryName").ToString.ToUpper%></h2>
            <div class="proddetails">
                <div id='<%#_clscode.Slugify(Eval("ProductName"))%>'> <a href="#" class="tab"><%# Eval("ProductName")%></a>
                    <div class="content">     
                        <p>
                            <asp:Repeater runat="server" ID="rptSubItems" DataSource='<%# Eval("ProductPhotos")%>'>
                                <ItemTemplate>                    
                                    <a class="fancybox" href='<%# ResolveUrl(Eval("FilePath").ToString) %>' data-fancybox-group="gallery" title='<%# Eval("AlternateText").ToString %>'><img src='<%# ResolveUrl(Eval("FilePath").ToString)%>' alt='<%# Eval("AlternateText").ToString %>' style="width: 150px; height: 110px" /></a>
                                </ItemTemplate>
                            </asp:Repeater>                                                       
                        </p>
                        <h1><%# Eval("ProductName").ToString.ToUpper%></h1>
                        <p><%# Eval("FullDescription")%></p>
                    </div>
                </div>
            </div>
        </div>
    </ItemTemplate>
</asp:Repeater> 