'==========================================================================================
'**
'** FILE  : CleanHtml.vb
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
Namespace Searchs
    '*********************************************************************
    '
    ' CleanHtml Class
    '
    ' Properties are used to store search data of the user
    '
    '*********************************************************************

    Public Class CleanHtml
        '*********************************************************************
        '
        ' CleanFileContent Method
        '
        ' Subroutine to the clean the file of html content
        '
        '*********************************************************************
        Public Shared Function Clean(ByVal Contents As String) As String
            Dim regexp As Regex
            Dim strPattern As String

            strPattern = ""
            regexp = New Regex(strPattern, RegexOptions.IgnoreCase)

            Contents = regexp.Replace(Contents, "<(select|option|script|style|title|nav)(.*?)>((.|\n)*?)</(select|option|script|style|title|nav)>", " ", RegexOptions.IgnoreCase)

            Contents = regexp.Replace(Contents, "&(nbsp|quot|copy);", "")

            'Contents = regexp.Replace(Contents, "<[^>]*>", "")

            Contents = regexp.Replace(Contents, "<([\s\S])+?>", " ", RegexOptions.IgnoreCase).Replace("  ", " ")

            'Contents = regexp.Replace(Contents, "<[^<>]+>", " ", RegexOptions.IgnoreCase)

            'Contents = regexp.Replace("(<(\w+)[^>]*?>(.*?)</\1>", "$1")

            Contents = regexp.Replace(Contents, "\W", " ")

            Contents = regexp.Replace(Contents, "<(div id=""top""|div id=""header""|div id=""navigation""|div id=""footer"")(.*?)>((.|\n)*?)</(div|div|div|div)>", "", RegexOptions.IgnoreCase)

            'Trace.Warn("File Contents", Contents)

            Return Contents

        End Function
    End Class

End Namespace

