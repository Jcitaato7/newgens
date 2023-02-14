Imports techCMS.DAL
Public Class wpHeaderMenu
    Inherits System.Web.UI.UserControl

    Protected _clscode As clscode

    Private Sub Page_PreRender(sender As Object, e As System.EventArgs) Handles Me.PreRender
        _clscode = New clscode

        If Not IsPostBack Then
            Dim vRecords As Object
            Dim vParentPage As techCMS.DAL.WebPage
            Dim fullPath As String = Request.Url.AbsolutePath
            Dim fileName As String = System.IO.Path.GetFileName(fullPath)

            ' Get the parent page record
            vParentPage = WebPageService.GetParentPage(fileName)

            If Not vParentPage Is Nothing Then
                ' Pass the parent page's id to the data source and it will set the IsActiveParent value
                'vRecords = WebPageService.GetAllActivePagesForHeaderMenu(vParentPage.webpage_parentid)
                vRecords = WebPageService.GetAllActivePagesForHeaderMenu(0)
            Else
                vRecords = WebPageService.GetAllActivePagesForHeaderMenu(0)
            End If

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

    Public Function GenerateListItemMarkup(ByVal childNodeCount As Integer, ByVal webPageType As Integer, ByVal webPageURL As String, ByVal webPageName As String, ByVal webPageFileName As String, ByVal isActiveParent As Boolean) As String
        Dim itemMarkup As String = "<li{0}> <a href=""{1}""{2}>{3}</a>{4}"
        Dim liClass As String = ""
        Dim url As String = FixURL(webPageType, webPageURL)
        Dim aAttributes As String = ""
        Dim caret As String = ""
        Dim fullPath As String = Request.Url.AbsolutePath
        Dim fileName As String = System.IO.Path.GetFileName(fullPath)

        ' set menu as active
        If fileName.ToLower = webPageFileName.ToLower Then
            liClass = " class=""active"""
        ElseIf isActiveParent Then
            liClass = " class=""active"""
        Else
            liClass = " class="""""
        End If

        ' Show caret if current node has child nodes
    
        'If childNodeCount > 0 Then
        '    ' If current menu has no link (page group), both menu link and caret will show the child menus when they are clicked
        '    ' Menu link will redirect to its url when clicked.
        '    aAttributes = " class=""dropdown-toggle"" data-toggle=""dropdown""    "
        '    caret = " <i class=""fa fa-angle-down""></i> "
        'End If




        'If childNodeCount > 0 And (webPageType = 1 Or webPageType = 3) Then
        '    ' If current menu has a link (normal page or external page), only caret will show the child menus when clicked
        '    ' Menu link will redirect to its url when clicked.
        '    ' Put "disabled" in class attribute
        '    aAttributes = " class=""dropdown-toggle"" data-toggle=""dropdown"" "
        '    caret = " "
        'End If
        'If childNodeCount > 0 And webPageType = 2 Then
        '    ' If current menu has no link (page group), both menu link and caret will show the child menus when they are clicked
        '    ' Menu link will redirect to its url when clicked.
        '    aAttributes = " class=""dropdown-toggle"" data-toggle=""dropdown"" "
        '    caret = "  "
        'End If

        itemMarkup = String.Format(itemMarkup, liClass, url, aAttributes, webPageName, caret)

       


        Return itemMarkup
    End Function


    Protected Sub rptSubItems_ItemDataBound(sender As Object, e As RepeaterItemEventArgs)
        If (e.Item.ItemType = ListItemType.Header) Then

            Dim rpt As Repeater = sender
            'Dim dataSource As DataTable = TryCast(rpt.DataSource, DataTable)
            'If Not dataSource Is Nothing Then
            If rpt.Items.Count > 0 Then rpt.Visible = False
            'End If
        End If
    End Sub
End Class