'==========================================================================================
'**
'** FILE  : PagesDataset.vb
'** Author: Stevan Rodrigues
'**
'**==========================================================================================
'**
'** (c) The contents of this file , and of any file or document derived from it , are copyright 
'** to Stevan. You are free to use and modify it. My only request is that you send me a email at  
'** stevanrin@hotmail.com. I would be happy that I have been a help to someone.
'**
'**==========================================================================================
Imports System.Data
Namespace Searchs

    '*********************************************************************
    '
    ' PagesDataset Class
    '
    ' Defines shared methods to create and add records to dataset
    '
    '*********************************************************************
    Public Class PagesDataset

        '*********************************************************************
        '
        ' Create Method - Shared method
        '
        ' Creates a datset for the pages and returns the result
        '
        '*********************************************************************
        Public Shared Function Create() As DataSet
            'Objects are defined
            Dim pgDataSet As New DataSet()
            Dim keys(1) As DataColumn

            'Table is created and added to table collection
            pgDataSet.Tables.Add(New DataTable("Pages"))

            'Schema of table is defined
            pgDataSet.Tables("Pages").Columns.Add("PageId", System.Type.GetType("System.Int32"))
            pgDataSet.Tables("Pages").Columns.Add("Title", System.Type.GetType("System.String"))
            pgDataSet.Tables("Pages").Columns.Add("Description", System.Type.GetType("System.String"))
            pgDataSet.Tables("Pages").Columns.Add("Path", System.Type.GetType("System.String"))
            pgDataSet.Tables("Pages").Columns.Add("MatchCount", System.Type.GetType("System.Int32"))
            pgDataSet.Tables("Pages").Columns.Add("Size", System.Type.GetType("System.Decimal"))

            'PageId is defined as indentity
            pgDataSet.Tables("Pages").Columns("PageID").AutoIncrement = True
            pgDataSet.Tables("Pages").Columns("PageID").AutoIncrementSeed = 1

            'PageId is defined as the primary key
            keys(0) = pgDataSet.Tables("Pages").Columns("PageId")
            pgDataSet.Tables("Pages").PrimaryKey = keys

            Return pgDataSet
        End Function

        '*********************************************************************
        '
        ' StoreFile Method - Shared method
        '
        ' Creates a datset for the pages and returns the result
        '
        '*********************************************************************
        Public Shared Sub StoreFile(ByVal dstPgs As DataSet, ByVal srchPg As Searchs.Page)
            'Objects are defined
            Dim pageRow As DataRow

            'New row is created
            pageRow = dstPgs.Tables("Pages").NewRow()

            'Data is added
            pageRow("Title") = srchPg.Title
            pageRow("Description") = srchPg.Description
            pageRow("Path") = srchPg.Path
            pageRow("MatchCount") = srchPg.MatchCount
            pageRow("Size") = srchPg.Size

            'Row is added to the dataset
            dstPgs.Tables("Pages").Rows.Add(pageRow)
        End Sub
    End Class
End Namespace