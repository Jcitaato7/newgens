Public Class wpjobslist
    Inherits System.Web.UI.UserControl
    Private Sub Page_PreRender(sender As Object, e As System.EventArgs) Handles Me.PreRender
        Dim webPartManager As WebPartManager
        webPartManager = webPartManager.GetCurrentWebPartManager(Page)
        If webPartManager.Personalization.CanEnterSharedScope Then
            webPartManager.WebParts(Me.ID).ChromeType = PartChromeType.None
        End If
    End Sub

    Public Function GetUrl(item As Object) As String
        Dim url As String

        url = GetRouteUrl("jobvacanciesroute", New With {.ItemID = item("VacancyID"), .ItemName = FriendlyUrl.Slugify(item("VacancyName"))})

        Return url
    End Function
End Class