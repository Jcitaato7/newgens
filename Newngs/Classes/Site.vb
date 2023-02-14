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
Imports System.Configuration
Namespace Searchs
    '*********************************************************************
    '
    ' Site Class
    '
    ' Properties are used to store configurations of the of the site
    '
    '*********************************************************************
    Public Class Site
        Private Shared m_ApplicationPath As String
        '*********************************************************************
        '
        ' FilesTypesToSearch ReadOnly Property
        '
        ' Retreive FilesTypesToSearch of the site
        '
        '*********************************************************************
        Public Shared ReadOnly Property FilesTypesToSearch() As String
            Get
                Return ConfigurationManager.AppSettings("FilesTypesToSearch")
            End Get
        End Property

        '*********************************************************************
        '
        ' DynamicFilesTypesToSearch ReadOnly Property
        '
        ' Retreive DynamicFilesTypesToSearch of the site
        '
        '*********************************************************************
        Public Shared ReadOnly Property DynamicFilesTypesToSearch() As String
            Get
                Return ConfigurationManager.AppSettings("DynamicFilesTypesToSearch")
            End Get
        End Property

        '*********************************************************************
        '
        ' BarredFolders ReadOnly Property
        '
        ' Retreive BarredFolders of the site
        '
        '*********************************************************************
        Public Shared ReadOnly Property BarredFolders() As String
            Get
                Return ConfigurationManager.AppSettings("BarredFolders")
            End Get
        End Property

        '*********************************************************************
        '
        ' BarredFiles ReadOnly Property
        '
        ' Retreive BarredFiles of the site
        '
        '*********************************************************************
        Public Shared ReadOnly Property BarredFiles() As String
            Get
                Return ConfigurationManager.AppSettings("BarredFiles")
            End Get
        End Property

        '*********************************************************************
        '
        ' EnglishLanguage Property
        '
        ' Retreive EnglishLanguage of the site
        '
        '*********************************************************************
        Public Shared ReadOnly Property EnglishLanguage() As String
            Get
                Return ConfigurationManager.AppSettings("EnglishLanguage")
            End Get
        End Property

        '*********************************************************************
        '
        ' Encoding Property
        '
        ' Retreive Encoding of the site
        '
        '*********************************************************************
        Public Shared ReadOnly Property Encoding() As String
            Get
                Return ConfigurationManager.AppSettings("Encoding")
            End Get
        End Property

        '*********************************************************************
        '
        ' ApplicationPath Property
        '
        ' Assign and retreive ApplicationPath of the site
        '
        '*********************************************************************
        Public Shared Property ApplicationPath() As String
            Get
                Return m_ApplicationPath
            End Get
            Set(ByVal Value As String)
                m_ApplicationPath = Value
            End Set
        End Property

    End Class
End Namespace

