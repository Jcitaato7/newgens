Imports System.IO
Imports System.Diagnostics
Imports System.Text
Imports System.Text.RegularExpressions
Imports System.Data
 
Public Class searchbar
    Inherits System.Web.UI.UserControl
    
    Private Sub btnsearch_Click(sender As Object, e As EventArgs) Handles btnsearch.Click
        Response.Redirect("~/modules/products/search.aspx?kw=" & txtsearch.Text.Trim)
    End Sub
End Class