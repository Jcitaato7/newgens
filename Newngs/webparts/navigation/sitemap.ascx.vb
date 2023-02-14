Public Class sitemap1
    Inherits System.Web.UI.UserControl

    Private Sub Page_PreRender(sender As Object, e As System.EventArgs) Handles Me.PreRender
        Dim webPartManager As WebPartManager
        WebPartManager = WebPartManager.GetCurrentWebPartManager(Page)
        If WebPartManager.Personalization.CanEnterSharedScope Then
            WebPartManager.WebParts(Me.ID).ChromeType = PartChromeType.None
        End If
    End Sub

End Class