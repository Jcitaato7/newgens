Imports techCMS.DAL
Public Class wpHeaderMenu
    Inherits System.Web.UI.UserControl

    Protected _clscode As clscode

    Private Sub Page_PreRender(sender As Object, e As System.EventArgs) Handles Me.PreRender
        _clscode = New clscode

        If Not IsPostBack Then
            Dim vRecords As Object

            vRecords = WebPageService.GetAllActivePagesForHeaderMenu

            If vRecords.Count > 0 Then

                rptMainItem.DataSource = vRecords
                rptMainItem.DataBind()
            Else
                rptMainItem.Visible = False
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

    Public Function GenerateListItemMarkup(ByVal childNodeCount As Integer, ByVal webPageType As Integer, ByVal webPageURL As String, ByVal webPageName As String, ByVal webPageFileName As String) As String
        Dim itemMarkup As String = "<li{0}> <a href=""{1}""{2}>{3}{4}</a>"
        Dim liClass As String = ""
        Dim url As String = FixURL(webPageType, webPageURL)
        Dim aClass As String = ""
        Dim caret As String = ""
        Dim fullPath As String = Request.Url.AbsolutePath
        Dim fileName As String = System.IO.Path.GetFileName(fullPath)

        If fileName.ToLower = webPageFileName.ToLower Then
            liClass = " class=""active"""
        End If

        If childNodeCount > 0 Then
            liClass = " class=""dropdown"""
            aClass = " class=""dropdown-toggle"" data-toggle=""dropdown"""
            caret = "&nbsp;<b class=""caret""></b>"
        End If

        itemMarkup = String.Format(itemMarkup, liClass, url, aClass, webPageName, caret)

        Return itemMarkup
    End Function
End Class