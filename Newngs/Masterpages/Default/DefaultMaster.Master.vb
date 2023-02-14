Public Class DefaultMaster
    Inherits System.Web.UI.MasterPage

    Private Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        If Not IsPostBack Then
            Page.Header.DataBind()
        End If
    End Sub
End Class