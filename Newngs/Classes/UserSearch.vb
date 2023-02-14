'==========================================================================================
'**
'** FILE  : UserSearch.vb
'** Author: Stevan Rodrigues
'**
'**==========================================================================================
'**
'** (c) The contents of this file , and of any file or document derived from it , are copyright 
'** to Stevan. You are free to use and modify it. My only request is that you send me a email at  
'** stevanrin@hotmail.com. I would be happy that I have been a help to someone..
'**
'**==========================================================================================

Imports System.IO
Imports System.Diagnostics
Namespace Searchs

    '*********************************************************************
    '
    ' Site Class
    '
    ' Properties are used to store search data of the user
    '
    '*********************************************************************
    Public Class UserSearch
        Private m_totalFilesSearched As Integer = 0
        Private m_totalFilesFound As Integer = 0
        Private m_searchCriteria As Searchs.SearchCriteria = SearchCriteria.AllWords
        Private m_searchWords As String = ""
        'Private m_serverPath As String = ""
        Private m_dstPages As DataSet
        Private m_page As New System.Web.UI.Page()


        '*********************************************************************
        '
        ' TotalFilesSearched Property
        '
        ' Retreive TotalFilesSearched of the site
        '
        '*********************************************************************
        Public ReadOnly Property TotalFilesSearched() As Integer
            Get
                Return m_totalFilesSearched
            End Get
        End Property

        '*********************************************************************
        '
        ' TotalFilesFound Property
        '
        ' Retreive TotalFilesFound of the site
        '
        '*********************************************************************
        Public ReadOnly Property TotalFilesFound() As Integer
            Get
                Return m_totalFilesFound
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
        ' SearchCriteria Property
        '
        ' Assign and retreive SearchCriteria of the site
        '
        '*********************************************************************
        Public Property SearchCriteria() As Searchs.SearchCriteria
            Get
                Return m_searchCriteria
            End Get
            Set(ByVal Value As Searchs.SearchCriteria)
                m_searchCriteria = Value
            End Set
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
        Public Function Search(ByVal targetDirectory As String) As DataSet
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
            ProcessDirectory(targetDirectory)
            Return m_dstPages
        End Function

        '*********************************************************************
        '
        ' ProcessDirectory Method
        '
        ' Files in the directories are searched
        '
        '*********************************************************************
        Private Sub ProcessDirectory(ByVal targetDirectory As String)
            Dim fileEntries As String()
            Dim subdirectoryEntries As String()
            Dim filePath As String
            Dim subdirectory As String

            fileEntries = Directory.GetFiles(targetDirectory)

            ' Process the list of files found in the directory

            For Each filePath In fileEntries
                m_totalFilesSearched += 1
                ProcessFile(filePath)
            Next filePath

            subdirectoryEntries = Directory.GetDirectories(targetDirectory)
            ' Recurse into subdirectories of this directory

            For Each subdirectory In subdirectoryEntries

                'Check to make sure the folder about to be searched is not a barred folder if it is then don't search
                If Not InStr(1, Searchs.Site.BarredFolders, Path.GetFileName(subdirectory), vbTextCompare) > 0 Then
                    'Call the search sub prcedure to search the web site
                    ProcessDirectory(subdirectory)
                End If

            Next subdirectory

        End Sub 'ProcessDirectory

        '*********************************************************************
        '
        ' ProcessFile Method
        '
        ' Real logic for processing found files would go here.
        '
        '*********************************************************************
        Private Sub ProcessFile(ByVal FPath As String)
            Dim srchFile As Searchs.Page

            srchFile = GetInfo(FPath)
            If Not IsNothing(srchFile) Then

                srchFile.Search(m_searchWords, m_searchCriteria)
                If srchFile.MatchCount > 0 Then
                    m_totalFilesFound += 1
                    'Response.Write(srchFile.Contents)
                    srchFile.CheckDataInfo()
                    Searchs.PagesDataset.StoreFile(m_dstPages, srchFile)
                End If

            End If

        End Sub 'ProcessFile

        '*********************************************************************
        '
        ' GetInfo Method
        '
        ' File data is picked in this method
        '
        '*********************************************************************
        Private Function GetInfo(ByVal FPath As String) As Searchs.Page

            Dim fileInform As New FileInfo(FPath)
            Dim sr As StreamReader
            Dim srchFile As New Searchs.Page()

            Dim strFileURL As String  'Holds the path to the file on the site


            'Check the file extension to make sure the file is of the extension type to be searched

            If InStr(1, Searchs.Site.FilesTypesToSearch, fileInform.Extension, vbTextCompare) > 0 Then
                'm_page.Trace.Warn("File ext.", fileInform.Extension)
                'Check to make sure the file about to be searched is not a barred file if it is don't search the file
                If Not InStr(1, Searchs.Site.BarredFiles, Path.GetFileName(FPath), vbTextCompare) > 0 Then
                    'm_page.Trace.Warn("File", FPath)

                    If Not File.Exists(FPath) Then
                        'm_page.Trace.Warn("Error", String.Format("{0} does not exist.", FPath))
                        'Add throw excetion here
                        '
                        '
                        Return Nothing
                    End If

                    Searchs.FileContent.GetFileInfo(FPath, srchFile, m_searchWords)

                    Return srchFile

                End If
            End If
            Return Nothing
        End Function


    End Class

End Namespace
