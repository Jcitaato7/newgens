Public Class thankyou1
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Request.QueryString("t") Is Nothing Then
            Dim ftype As String = Request.QueryString("t")
            Dim msg As String = ""
            Dim cls As New clscode
            msg = cls.ThankYouMsg(ftype)
            litmsg.Text = msg
        End If
    End Sub
End Class