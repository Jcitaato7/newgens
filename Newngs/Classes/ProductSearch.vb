'==========================================================================================
'**
'** FILE  : ProductSearch.vb
'** Author: Joel Ballesta
'**
'**==========================================================================================

Imports System.IO
Imports System.Diagnostics
Imports techCart.DAL

Namespace Searchs
    '*********************************************************************
    '
    ' Site Class
    '
    ' Properties are used to store search data of the user
    '
    '*********************************************************************
    Public Class ProductSearch
        Private m_totalProductsSearched As Integer = 0
        Private m_totalProductsFound As Integer = 0
        Private m_searchWords As String = ""
        Private m_dstPages As DataSet
        Private m_page As New System.Web.UI.Page()

        Protected _clscode As clscode

        '*********************************************************************
        '
        ' TotalProductsSearched Property
        '
        ' Retreive TotalProductsSearched of the site
        '
        '*********************************************************************
        Public ReadOnly Property TotalProductsSearched() As Integer
            Get
                Return m_totalProductsSearched
            End Get
        End Property

        '*********************************************************************
        '
        ' TotalProductsFound Property
        '
        ' Retreive TotalProductsFound of the site
        '
        '*********************************************************************
        Public ReadOnly Property TotalProductsFound() As Integer
            Get
                Return m_totalProductsFound
            End Get
        End Property

        '*********************************************************************
        '
        ' PageDataset Shared Property
        '
        ' Retreive data of tzh entire site of the site
        '
        '*********************************************************************
        Public ReadOnly Property PageDataset() As DataSet
            Get
                Return m_dstPages
            End Get
        End Property

        '*********************************************************************
        '
        ' SearchWords Property
        '
        'Assign and retreive SearchWords of the site
        '
        '*********************************************************************
        Public Property SearchWords() As String
            Get
                Return m_searchWords
            End Get
            Set(ByVal Value As String)
                m_searchWords = Value
            End Set
        End Property



        '*********************************************************************
        '
        ' Search Method
        '
        ' Search the entire site
        '
        '*********************************************************************
        Public Function Search() As DataSet
            'If the site is in English then use the server HTML encode method
            If Searchs.Site.EnglishLanguage = True Then
                'Replace any HTML tags with the HTML codes for the same characters (stops people entering HTML tags)
                m_searchWords = m_page.Server.HtmlEncode(m_searchWords)
                'If the site is not english just change the script tags
            Else
                'Just replace the script tag <> with HTML encoded &lt; and &gt;
                m_searchWords = Replace(m_searchWords, "<", "&lt;", 1, -1, 1)
                m_searchWords = Replace(m_searchWords, ">", "&gt;", 1, -1, 1)
            End If
            If m_dstPages Is Nothing Then
                m_dstPages = Searchs.PagesDataset.Create()
            End If

            SearchProducts()
            'ProcessDirectory(targetDirectory)

            Return m_dstPages
        End Function

        '*********************************************************************
        '
        ' SearchProducts Method
        '
        ' Real logic for processing found Products would go here.
        '
        '*********************************************************************
        Private Sub SearchProducts()
            Dim srchProductPage As New Searchs.Page

            Dim vRecords As Object

            _clscode = New clscode

            vRecords = ProductService.SearchProducts(m_searchWords)

            If vRecords.Count > 0 Then
                Dim vAppPath As String

                If Searchs.Site.ApplicationPath.ToString.EndsWith("/") Then
                    vAppPath = Searchs.Site.ApplicationPath.ToString
                Else
                    vAppPath = Searchs.Site.ApplicationPath.ToString & "/"
                End If

                ' loop through the products
                For Each record In vRecords
                    With srchProductPage
                        .Contents = record.FullDescription
                        .Description = record.ShortDescription
                        .MatchCount = record.Rank
                        .PageName = record.ProductName
                        .Path = vAppPath & "product/" & _clscode.Slugify(record.ProductID.ToString) & "/" & _clscode.Slugify(record.ProductName) & ".aspx"
                        .Title = record.ProductName
                    End With
                    ' check/validate title and description
                    srchProductPage.CheckDataInfo()
                    Searchs.PagesDataset.StoreFile(m_dstPages, srchProductPage)
                    m_totalProductsFound += 1
                Next

            End If

        End Sub 'SearchProducts

    End Class

End Namespace
