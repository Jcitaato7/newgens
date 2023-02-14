Public Class wpGoToTop
    Inherits System.Web.UI.UserControl

    Private Sub Page_PreRender(sender As Object, e As System.EventArgs) Handles Me.PreRender
        Dim webPartManager As WebPartManager
        webPartManager = webPartManager.GetCurrentWebPartManager(Page)
        If webPartManager.Personalization.CanEnterSharedScope Then
            webPartManager.WebParts(Me.ID).ChromeType = PartChromeType.None
        End If
    End Sub

End Class