<%@ Application Language="VB" %>
<%@ Import Namespace="System.Web.Routing" %>
<%@ Import Namespace="techCart.DAL" %>

<script runat="server">

    Sub Application_Start(ByVal sender As Object, ByVal e As EventArgs)
        ' Code that runs on application startup

        RegisterRoutes(RouteTable.Routes)
        
        ' Code that runs on application startup
        CartConfig.Init()

        'initialize task manager
        TaskManager.Instance.Initialize(CartConfig.ScheduleTasks)
        TaskManager.Instance.Start()
        
    End Sub

    Sub Application_EndRequest(ByVal sender As Object, ByVal e As EventArgs)
        ' Code that runs on application shutdown
        If Response.StatusCode = 401 And Request.IsAuthenticated Then
            Response.ClearContent()
            Response.Redirect("/webpages/error/NoAccess.htm")
        End If
    End Sub
   
    Sub Application_End(ByVal sender As Object, ByVal e As EventArgs)
        ' Code that runs on application shutdown

    End Sub
        
    Sub Application_Error(ByVal sender As Object, ByVal e As EventArgs)
        ' Code that runs when an unhandled error occurs
    End Sub

    Sub Session_Start(ByVal sender As Object, ByVal e As EventArgs)
        ' Code that runs when a new session is started
    End Sub

    Sub Session_End(ByVal sender As Object, ByVal e As EventArgs)
        ' Code that runs when a session ends. 
        ' Note: The Session_End event is raised only when the sessionstate mode
        ' is set to InProc in the Web.config file. If session mode is set to StateServer 
        ' or SQLServer, the event is not raised.
    End Sub
    
    Shared Sub RegisterRoutes(routes As RouteCollection)
                
        routes.MapPageRoute("productdetailroute", _
            "product/{ItemID}/{ItemName}.aspx", _
            "~/modules/products/product-details.aspx")
        
    End Sub   
</script>
