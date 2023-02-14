'==========================================================================================
'**
'** FILE  : Site.vb
'** Author: Stevan Rodrigues
'**
'**==========================================================================================
'**
'** (c) The contents of this file , and of any file or document derived from it , are copyright 
'** to Stevan. You are free to use and modify it. My only request is that you send me a email at  
'** stevanrin@hotmail.com. I would be happy that I have been a help to someone.
'**
'**==========================================================================================
Imports System.Text.RegularExpressions
Imports System.Diagnostics
Imports System.IO
Imports System.Text
Imports System.Net

Namespace Searchs
    '*********************************************************************
    '
    ' FileContent Class
    '
    ' Properties are used to get the contents of the file
    '
    '*********************************************************************

    Public Class FileContent
        Private Shared m_page As New System.Web.UI.Page()


        '*********************************************************************
        '
        ' GetFileInfo Method
        '
        ' File data is picked in this method
        '
        '*********************************************************************
        Public Shared Sub GetFileInfo(ByVal FPath As String, ByVal srchFile As Searchs.Page, ByVal searchwords As String)

            Dim fileInform As New FileInfo(FPath)
            Dim strBldFile As New StringBuilder()
            Dim fileSize As Decimal = fileInform.Length \ 1024
            Dim url As String = String.Empty
            'strHttpDir = System.Configuration.ConfigurationManager.AppSettings("pg_httpdir")
            srchFile.Size = fileSize


            GetFilePath(FPath, srchFile)
            'Path.GetFileName(FPath).Substring(0, Path.GetFileName(FPath).LastIndexOf("."))

            If InStr(1, Searchs.Site.DynamicFilesTypesToSearch, fileInform.Extension, vbTextCompare) > 0 Then
                m_page.Trace.Warn("Path", String.Format("{0}/{1}", "", srchFile.Path))
                GetDynamicFileContent(srchFile)
            Else
                GetStaticFileContent(FPath, srchFile)
            End If


            If Not srchFile.Contents.Equals("") Then
                'Read in the title of the file
                url = Searchs.Site.ApplicationPath + "/" + srchFile.Path
                Dim sitedesc As String = String.Empty
                srchFile.Title = PageTitle(url)
                'srchFile.Title = GetMetaContent(srchFile.Contents, "<title>", "</title>")
                'm_page.Trace.Warn("Page Title", strPageTitle)
                sitedesc = Searchs.CleanHtml.Clean(srchFile.Contents)
                'Read in the description meta tag of the file
                Dim strpos As Integer = InStr(sitedesc, searchwords)
                If strpos > 100 Then
                    srchFile.Description = "..." & Mid(sitedesc, strpos, 1000)
                Else
                    srchFile.Description = Mid(sitedesc, 1, 1000)
                End If
                'srchFile.Description = "..." & Mid(Searchs.CleanHtml.Clean(srchFile.Contents), strpos, 500) 'GetMetaContent(srchFile.Contents, "<meta name=""description"" content=""", """>")

                'srchFile.Description = Mid(sitedesc, strpos, 1000)
                'Summary(Searchs.CleanHtml.Clean(srchFile.Contents)) '
                'm_page.Trace.Warn("Page Desc", strPageDescription)

                'Read in the keywords of the file
                srchFile.Keywords = GetMetaContent(srchFile.Contents, "<meta name=""keywords"" content=""", """>")

                'm_page.Trace.Warn("Page Keywords", strPageKeywords)

                srchFile.Contents = Searchs.CleanHtml.Clean(srchFile.Contents)

                srchFile.Contents = strBldFile.AppendFormat("{0} {1} {2} {3}", srchFile.Contents, srchFile.Description, srchFile.Keywords, srchFile.Title).ToString.Trim()
                'm_page.Trace.Warn("File Info", strBldFile.ToString) 
            End If

        End Sub
        '*********************************************************************
        '
        ' GetFilePath Method
        '
        ' File path is modfied to be displayed as hyperlink in this method
        '
        '*********************************************************************
        Private Shared Sub GetFilePath(ByVal strFileURL As String, ByVal srchFile As Searchs.Page)
            'Turn the server path to the file into a URL path to the file

            strFileURL = Replace(strFileURL, m_page.Server.MapPath("~/"), "")
            'strFileURL = Replace(strFileURL, m_page.Server.MapPath("./"), "")
            'Replace the NT backslash with the internet forward slash in the URL to the file

            strFileURL = Replace(strFileURL, "\", "/")

            'Encode the file name and path into the URL code method

            strFileURL = m_page.Server.UrlEncode(strFileURL)

            'Just incase it's encoded any backslashes
            strFileURL = Replace(strFileURL.Trim(), "%2f", "/", vbTextCompare)
            srchFile.Path = strFileURL

            m_page.Trace.Warn("Url", srchFile.Path)
        End Sub



        '*********************************************************************
        '
        ' GetStaticFileContent Method
        '
        ' File Content is picked in this method
        '
        '*********************************************************************
        Private Shared Sub GetStaticFileContent(ByVal FPath As String, ByVal srchFile As Searchs.Page)
            Dim sr As StreamReader

            If Searchs.Site.Encoding.Equals("utf-8") Then
                sr = File.OpenText(FPath)
            Else
                sr = New StreamReader(FPath, Encoding.GetEncoding(Searchs.Site.Encoding))
            End If

            Try
                srchFile.Contents = sr.ReadToEnd()
                sr.Close()
            Catch ex As Exception
                m_page.Trace.Warn("Error", ex.Message)
                srchFile.Contents = ex.Message
            End Try
        End Sub

        '*********************************************************************
        '
        ' GetDynamicFileContent Method
        '
        ' File Content is picked in this method
        '
        '*********************************************************************
        Private Shared Sub GetDynamicFileContent(ByVal srchFile As Searchs.Page)
            Dim wcMicrosoft As System.Net.WebClient

            If Searchs.Site.Encoding.Equals("utf-8") Then
                GetDynamicFileContentUTF(srchFile)
            Else
                GetDynamicFileContentOther(srchFile)
            End If

        End Sub

        '*********************************************************************
        '
        ' GetDynamicFileContentOther Method
        '
        ' File Content is picked in this method according to the encoding provided
        '
        '*********************************************************************
        Private Shared Sub GetDynamicFileContentOther(ByVal srchFile As Searchs.Page)
            Dim wcMicrosoft As System.Net.WebClient
            Dim fileEncoding As System.Text.Encoding

            Try
                fileEncoding = System.Text.Encoding.GetEncoding(Searchs.Site.Encoding)
                srchFile.Contents = fileEncoding.GetString( _
                wcMicrosoft.DownloadData(String.Format("{0}/{1}", Searchs.Site.ApplicationPath, srchFile.Path)))
            Catch ex As System.Net.WebException
                m_page.Trace.Warn("Error", ex.Message)
                srchFile.Contents = ex.Message
            Catch ex As System.Exception
                m_page.Trace.Warn("Error", ex.Message)
                srchFile.Contents = ex.Message
            End Try

        End Sub

        '*********************************************************************
        '
        ' GetDynamicFileContentUTF Method
        '
        ' File Content is picked in this method according to the utf-8 encoding 
        '
        '*********************************************************************
        Private Shared Sub GetDynamicFileContentUTF(ByVal srchFile As Searchs.Page)
            Dim wcMicrosoft As System.Net.WebClient
            Dim objUTF8Encoding As System.Text.UTF8Encoding

            Try
                wcMicrosoft = New System.Net.WebClient()
                objUTF8Encoding = New UTF8Encoding()
                srchFile.Contents = objUTF8Encoding.GetString( _
                wcMicrosoft.DownloadData(String.Format("{0}/{1}", Searchs.Site.ApplicationPath, srchFile.Path)))
            Catch ex As System.Net.WebException
                m_page.Trace.Warn("Error", ex.Message)
                srchFile.Contents = ex.Message
            Catch ex As System.Exception
                m_page.Trace.Warn("Error", ex.Message)
                srchFile.Contents = ex.Message
            End Try

        End Sub

        '*********************************************************************
        '
        ' GetMetaContent Method
        '
        ' Metacontent is stripped in this method
        '
        '*********************************************************************
        Private Shared Function GetMetaContent(ByVal strFile As String, ByVal strMetaStart As String, ByVal strMetaEnd As String) As String
            'List the text between the title tags:
            Dim regexp As Regex
            Dim strMeta As String
            Dim strPattern As String
            Dim strInPattern As String

            'If no description or keywords are found then you may be using http-equiv= instead of name= in your meta tags
            If InStr(1, LCase(strFile), strMetaStart, 1) = 0 And InStr(strMetaStart, "name=") Then
                'Swap name= for http-equiv= 
                strMetaStart = Replace(strMetaStart, "name=", "http-equiv=")
            End If

            'Build Pattern
            strInPattern = "((.|\n)*?)"
            strPattern = String.Format("{0}{1}{2}", strMetaStart, strInPattern, strMetaEnd)
            regexp = New Regex(strPattern, RegexOptions.IgnoreCase)

            'Match Pattern
            strMeta = regexp.Match(strFile).ToString

            'Build Pattern
            strInPattern = "(.*?)"
            strPattern = String.Format("{0}{1}{2}", strMetaStart, strInPattern, strMetaEnd)

            'Get Pattern content
            strMeta = regexp.Replace(strMeta, strPattern, "$1", RegexOptions.IgnoreCase)

            Return strMeta
        End Function
        Private Shared Function PageTitle(ByVal url As String) As String
            Dim objRegex As Regex
            Dim strResult As String
            Dim strError As String = ""
            'Dim reg As String = "<html>(.|\n)*?</html>"
            Dim wClient As WebClient = New WebClient
            Dim read As StreamReader
            Try
                'Now extract each <html>...</html> group

                Dim data As Stream = wClient.OpenRead(url)
                read = New StreamReader(data)
                strResult = read.ReadToEnd()
                objRegex = New Regex("<title>(?<xtitle>(.|\n)*?)</title>", RegexOptions.IgnoreCase)

                strResult = objRegex.Match(strResult).Result("${xtitle}")


                If strResult = "" Then
                    strResult = "Untitled"
                    Return strResult
                Else
                    Return strResult
                End If
                read.Close()
            Catch ex As Exception
                strResult = ""
                Return ex.Message
                read.Close()
            End Try
        End Function




    End Class
End Namespace
