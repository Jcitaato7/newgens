Imports System.IO
Imports System.Diagnostics
Imports System.Text
Imports System.Text.RegularExpressions
Imports System.Data
Imports techCart.DAL

Public Class wpsearchproduct
    Inherits System.Web.UI.UserControl
    Protected _clscode As clscode
    Private sSite As New Searchs.ProductSearch
    '*********************************************************************
    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        _clscode = New clscode

        If Not IsPostBack Then
            Dim strSearchWords As String = ""
            'Search.Attributes.Add("OnKeyPress", "javascript:if (event.keyCode == 13) __doPostBack('" + srchbtn.UniqueID + "','')")
            If Not Request.QueryString("kw") Is Nothing Then
                strSearchWords = Request.QueryString("kw").Trim
                PerformSearch(strSearchWords)
            End If
        End If
    End Sub

    Protected Sub srchbtn_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles srchbtn.Click
        Dim strSearchWords As String = ""
        If Not String.IsNullOrEmpty(Search.Text.Trim) Then
            strSearchWords = Search.Text.Trim
            PerformSearch(strSearchWords)
        Else
            Exit Sub
        End If
    End Sub

    Private Sub PerformSearch(searchwords As String)
        'If there is no words entered by the user to search for then dont carryout the file search routine
        pnlSearchResults.Visible = False

        If Not searchwords.Equals("") Then
            Searchs.Site.ApplicationPath = String.Format("http://{0}{1}", Request.ServerVariables("HTTP_HOST"), Request.ApplicationPath)

            sSite = SearchSite(searchwords)
            Session("Site") = sSite

            dgrdPages.CurrentPageIndex = 0
            DisplayContent()
        End If
    End Sub

    '*********************************************************************
    '
    ' SearchSite method
    '
    ' The  sSite.PageDataset is used to populate the datagrid.
    '
    '*********************************************************************
    Private Function SearchSite(ByVal strSearch As String) As Searchs.ProductSearch
        Dim srchSite As Searchs.ProductSearch
        srchSite = New Searchs.ProductSearch()
        'Read in all the search words into one variable
        srchSite.SearchWords = strSearch

        srchSite.Search()
        Return srchSite
    End Function

    '*********************************************************************
    '
    ' DisplayContent method
    '
    ' The  data is bound to the respective fields.
    '
    '*********************************************************************
    Private Sub DisplayContent()
        If Not IsNothing(sSite.PageDataset) Then
            'emptypanel.Visible = False
            pnlSearchResults.Visible = True
            lblSearchWords.Text = sSite.SearchWords

            'If dgrdPages.Items.Count = 0 Then
            '    pnlSearchResults.Visible = False
            '    emptypanel.Visible = True
            '    Exit Sub
            'End If
            BindDataGrid("PageId")
            'lblTotalFiles.Text = sSite.TotalFilesSearched
            lblFilesFound.Text = sSite.TotalProductsFound
            If sSite.TotalProductsFound = Nothing Then
                dgrdPages.PagerStyle.Visible = False
                emptypanel.Visible = True
            Else
                dgrdPages.PagerStyle.Visible = True
                emptypanel.Visible = False
            End If
        End If
    End Sub

    '*********************************************************************
    '
    ' BindDataGrid method
    '
    ' The  sSite.PageDataset is used to populate the datagrid.
    '
    '*********************************************************************
    Private Sub BindDataGrid(ByVal strSortField As String)
        Dim dvwPages As DataView
        dvwPages = sSite.PageDataset.Tables("Pages").DefaultView
        dvwPages.Sort = strSortField
        dgrdPages.DataSource = dvwPages
        dgrdPages.DataBind()
    End Sub

    '*********************************************************************


    '*********************************************************************
    '
    ' DisplayTitle method
    '
    ' Display title of searched pages 
    '
    '*********************************************************************
    Protected Function DisplayTitle(ByVal Title As String, ByVal Path As String) As String
        'Return String.Format("<a style='color:#003366' href='{1}/{2}'>{0}</a>", Title, Request.ApplicationPath, Path)
        'Return String.Format("<a class=""searchTitle"" href='{1}{2}'>{0}</a>", Title, "/modules/products/products.aspx#", _clscode.Slugify(Title))
        Return String.Format("<a class=""searchTitle"" href='{1}'>{0}</a>", Title, Path)
    End Function

    '*********************************************************************
    '
    ' DisplayPath method
    '
    ' Path of the file is returned 
    '
    '*********************************************************************
    Protected Function DisplayPath(ByVal Path As String, Title As String) As String
        'Return String.Format("<a style='color:#003366' href='{0}{1}'></a>", Request.ServerVariables("HTTP_HOST"), Request.ApplicationPath, Path)
        'Return String.Format("<a href='{1}{2}'>{0}{1}{2}</a>", Request.ServerVariables("HTTP_HOST"), "/modules/products/products.aspx#", _clscode.Slugify(Title))
        Return String.Format("<a href='{1}'>{0}</a>", Path.Replace("http://", ""), Path)
    End Function

    Protected Function SearchWords(ByVal resultword As String) As String
        Dim i As Integer
        Dim sarySearchWord As String() 'Array to hold the words to be searched for
        'Dim mtches As MatchCollection

        'Split each word to be searched up and place in an array
        sarySearchWord = Split(Trim(sSite.SearchWords), " ")
        Dim retstr As String = resultword


        'If AnyWords.Checked Then
        If sarySearchWord.Count > 1 Then
            For i = 0 To UBound(sarySearchWord)
                retstr = Regex.Replace(retstr, sarySearchWord(i), "<b>" & sarySearchWord(i).ToString & "</b>", RegexOptions.IgnoreCase)
            Next
        Else
            retstr = Regex.Replace(retstr, sarySearchWord(i), "<b>" & sarySearchWord(i).ToString & "</b>", RegexOptions.IgnoreCase)
        End If
        'Else
        'retstr = Regex.Replace(retstr, Search.Text.Trim, "<b>" & Search.Text.Trim & "</b>", RegexOptions.IgnoreCase)
        'End If

        Return retstr

    End Function

    'Protected Sub dgrdPages_SortCommand(ByVal s As Object, ByVal e As DataGridSortCommandEventArgs) Handles dgrdPages.SortCommand
    '    ViewState("SortExpression") = e.SortExpression
    '    DisplayContent()
    'End Sub

    'Protected Sub dgrdPages_PageIndexChanged(ByVal s As Object, ByVal e As DataGridPageChangedEventArgs) Handles dgrdPages.PageIndexChanged
    '    dgrdPages.CurrentPageIndex = e.NewPageIndex
    '    DisplayContent()
    'End Sub

End Class