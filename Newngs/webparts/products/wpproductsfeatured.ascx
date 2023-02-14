<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="wpproductsfeatured.ascx.vb" Inherits="tfsCMS.wpproductsfeatured" %>
<script type="text/javascript">
    $(document).ready(function () {
        initValues();
        lastPostFunc();

        $('#movetop').click(function () {
            $("html, body").animate({ scrollTop: 0 }, "slow");
            return false;
        });
    });

    function initValues() {
        $("#listIndex").val(0);
        $('#divPostsLoader').empty();
    }

    function lastPostFunc() {
        var listIndex = $("#listIndex").val();

        // if end of products has not yet reached
        if ($("#listIndex").val() != -1) {

            var baseUrl = "<%= ResolveUrl("~/") %>";
            var url = baseUrl + "CartWebService.svc/GetFeaturedProducts";


            $('#divPostsLoader').html('<img src="' + baseUrl + 'App_Themes/Default/images/loader.gif" /><br /><i>Loading products..</i>');
            $.ajax({
                type: "POST",
                url: url,
                data: '{}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {

                    if (data.d != '') {
                        //has products to load
                        DisplayProducts(data);
                        listIndex = parseInt(listIndex) + 1;
                        $("#listIndex").val(parseInt(listIndex));
                    } else {
                        if (listIndex == 0) {
                            //has no products to load
                            $('#divPostsLoader').html('<br /><i>No featured products yet.<i>');
                        } else if (listIndex == 1) {
                            //first batch was loaded and nothing comes next - empty the loading div
                            $('#divPostsLoader').empty();
                        } else {
                            $('#divPostsLoader').html('<br /><br /><a href="#" id="movetop">Go to Top</a>');
                        }
                        $("#listIndex").val(-1);
                    }

                },
                error: ServiceFailed
            });
        }
    }

    //Display Products
    function DisplayProducts(result) {
        if (result != "") {
            $(result.d).hide().appendTo('.divLoadData').fadeIn(1500);
        }
        $('#divPostsLoader').empty();

    }

    function ServiceFailed(xhr) {
        //alert('Service failed. Details:' + xhr.responseText);

        //if (xhr.responsetext) {
        //    var err = xhr.responsetext;
        //    if (err)
        //        error(err);
        //    else
        //        error({ message: "unknown server error." })
        //}

        return;
    }

</script>
<input id="listIndex" type="hidden" value="0" />
<div class="box-feature">
    <h5>Featured Products</h5>
    <div  class="prodbox">
        <div class="divLoadData">
        </div>
        <div id="divPostsLoader">        
        </div>
    </div>
</div>
<div class="box-feature-bottom"></div>
