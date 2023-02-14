'==========================================================================================
'**
'** FILE  : Page.vb
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
    ' SearchCriteria enumeration
    '
    ' An enumeration to the save the type of search
    '
    '*********************************************************************
    Public Enum SearchCriteria As Short
        AllWords
        AnyWords
        Phrase
    End Enum

    '*********************************************************************
    '
    ' Page class
    '
    ' Page class to store data of individual files on the website
    '
    '*********************************************************************
    Public Class Page
        'Private 
        Private m_path As String = ""
        Private m_title As String = ""
        Private m_keywords As String = ""
        Private m_description As String = ""
        Private m_contents As String = ""
        Private m_matchcount As Integer = 0
        Private m_size = 0
        Dim m_pagename As String

        '*********************************************************************
        '
        ' Size Property
        '
        ' Assign and retreive Size of the file
        '
        '*********************************************************************
        Public Property Size() As Decimal
            Get
                Return m_size
            End Get
            Set(ByVal Value As Decimal)
                m_size = Value
            End Set
        End Property

        '*********************************************************************
        '
        ' Path Property
        '
        ' Assign and retreive path of the file
        '
        '*********************************************************************

        Public Property Path() As String
            Get
                Return m_path
            End Get
            Set(ByVal Value As String)
                m_path = Value
            End Set
        End Property

        '*********************************************************************
        '
        ' Title Property
        '
        'Assign and retreive title of the file
        '
        '*********************************************************************
        Public Property Title() As String
            Get
                Return m_title
            End Get
            Set(ByVal Value As String)
                m_title = Value
            End Set
        End Property

        '*********************************************************************
        '
        ' Keywords Property
        '
        ' Assign and retreive Keywords ( meta tags ) of the file
        '
        '*********************************************************************
        Public Property Keywords() As String
            Get
                Return m_keywords
            End Get
            Set(ByVal Value As String)
                m_keywords = Value
            End Set
        End Property


        '*********************************************************************
        '
        ' Description Property
        '
        ' Assign and retreive description ( meta tags ) of the file
        '
        '*********************************************************************
        Public Property Description() As String
            Get
                Return m_description
            End Get
            Set(ByVal Value As String)
                m_description = Value
            End Set
        End Property

        '*********************************************************************
        '
        ' Contents Property
        '
        ' Assign and retreive contents of the file
        '
        '*********************************************************************
        Public Property Contents() As String
            Get
                Return m_contents
            End Get
            Set(ByVal Value As String)
                m_contents = Value
            End Set
        End Property


        '*********************************************************************
        '
        ' Contents Property
        '
        ' Assign and retreive MatchCount of the file
        '
        '*********************************************************************
        Public Property MatchCount() As Integer
            Get
                Return m_matchcount
            End Get
            Set(ByVal Value As Integer)
                m_matchcount = Value
            End Set
        End Property
        Public Property PageName() As String
            Get
                Return m_matchcount
            End Get
            Set(ByVal Value As String)
                m_pagename = Value
            End Set
        End Property

        '*********************************************************************
        '
        ' CheckDataInfo method
        '
        ' Subroutine to the check the file contains title and decription 
        '
        '*********************************************************************
        Public Sub CheckDataInfo()

            'If the page contains no title then Page Title variable the appropriate message to display
            'If IsNothing(m_title) Or m_title.Trim().Equals("") Then
            '    m_title = "No Title"
            'End If

            If IsNothing(m_title) Or m_title.Trim().Equals("") Then
                m_title = "No Title"
            End If

            'If the page contains no title then Page Description variable the appropriate message to display
            If IsNothing(m_description) Or m_description.Trim().Equals("") Then
                If IsNothing(m_contents) Or m_contents.Trim().Equals("") Then
                    m_description = "No description is available."
                Else
                    If m_contents.Length > 200 Then
                        m_description = m_contents.Substring(0, 200)
                    Else
                        m_description = m_contents
                    End If
                End If
            End If
        End Sub

        '*********************************************************************
        '
        ' Search method
        '
        ' Subroutine to the search file 
        '
        '*********************************************************************
        Public Sub Search(ByVal strSearchWords As String, ByVal SrchCriteria As SearchCriteria)

            'If the user has choosen to search by phrase 
            If SrchCriteria = SearchCriteria.Phrase Then
                SearchPhrase(strSearchWords)
                'Else the search is either by all or any words
            Else
                SearchWords(strSearchWords, SrchCriteria)
            End If

        End Sub

        '*********************************************************************
        '
        ' SearchPhrase method
        '
        ' Subroutine to the search file 
        '
        '*********************************************************************
        Private Sub SearchPhrase(ByVal strSearchWords As String)

            Dim mtches As MatchCollection

            mtches = SearchPattern(strSearchWords)

            'Check to see if the phrase has been found
            If mtches.Count > 0 Then
                'Get the number of times the phrase is matched
                m_matchcount = mtches.Count
            End If
        End Sub

        '*********************************************************************
        '
        ' SearchWords method
        '
        ' Subroutine to the search file 
        '
        '*********************************************************************
        Private Sub SearchWords(ByVal strSearchWords As String, ByVal SrchCriteria As SearchCriteria)
            Dim intSearchLoopCounter As Integer
            Dim sarySearchWord As String() 'Array to hold the words to be searched for
            Dim mtches As MatchCollection

            'Split each word to be searched up and place in an array
            sarySearchWord = Split(Trim(strSearchWords), " ")

            'Loop round to search for each word to be searched
            For intSearchLoopCounter = 0 To UBound(sarySearchWord)

                'Set the pattern to search for
                mtches = SearchPattern(sarySearchWord(intSearchLoopCounter))

                If SrchCriteria = SearchCriteria.AnyWords Then
                    m_matchcount = m_matchcount + mtches.Count
                ElseIf SrchCriteria = SearchCriteria.AllWords Then
                    'Check to see if any of the words have been found
                    If mtches.Count > 0 Then
                        'Get the number of times the search word is matched

                        If m_matchcount = 0 Or (m_matchcount > 0 And m_matchcount > mtches.Count) Then
                            m_matchcount = mtches.Count
                        End If
                    Else
                        'If the search word is not found then set the search found variable back to false as one of the words has not been found
                        m_matchcount = 0
                        Exit Sub

                    End If
                End If
            Next
        End Sub

        '*********************************************************************
        '
        ' SearchPattern method
        '
        ' Subroutine to the search file 
        '
        '*********************************************************************
        Private Function SearchPattern(ByVal strSearchWord As String) As MatchCollection
            Dim regexp As Regex
            Dim strPattern

            'Set the pattern to search for
            regexp = New Regex("", RegexOptions.IgnoreCase)

            'Search the file for the phrase
            If Searchs.Site.Encoding.Equals("utf-8") Then
                strPattern = "\b{0}\b"
            Else
                strPattern = "{0}"
            End If

            Return Regex.Matches(m_contents, String.Format(strPattern, strSearchWord), RegexOptions.IgnoreCase)

        End Function


    End Class

End Namespace
