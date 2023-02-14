Imports techCMS.DAL

Public Class wpBreadcrumb
    Inherits System.Web.UI.UserControl

    Private Sub Page_PreRender(sender As Object, e As System.EventArgs) Handles Me.PreRender
        'Dim webPartManager As WebPartManager
        'webPartManager = webPartManager.GetCurrentWebPartManager(Page)
        'If webPartManager.Personalization.CanEnterSharedScope Then
        '    webPartManager.WebParts(Me.ID).ChromeType = PartChromeType.None
        'End If

        If Not IsPostBack Then
            Dim vRecords As Object
            Dim fullPath As String = Request.Url.AbsolutePath
            Dim fileName As String = System.IO.Path.GetFileName(fullPath)

            vRecords = WebPageService.GetBreadCrumbItems(fileName)

            If vRecords.Count > 0 Then

                rptBreadCrumb.DataSource = vRecords
                rptBreadCrumb.DataBind()
            Else
                rptBreadCrumb.Visible = False
            End If
        End If
    End Sub

    Public Function FixURL(ByVal webPageType As Integer, ByVal webPageURL As String) As String
        Dim url As String = "#"

        Select Case webPageType
            Case 1
                url = ResolveUrl(webPageURL)
            Case 2
                url = "#"
            Case 3
                url = webPageURL
        End Select

        Return url
    End Function
End Class