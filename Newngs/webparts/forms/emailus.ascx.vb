Imports System.Data.SqlClient
Imports System.IO
Imports System.Web
Imports System.Net
Imports System.Web.Script.Serialization

Public Class emailus
    Inherits clswebpart
    Implements IWebActionable

    Public Sub New()
        MyBase.New()
    End Sub

    Public ReadOnly Property Verbs() As WebPartVerbCollection Implements IWebActionable.Verbs
        Get

            Dim moduleURL = ResolveClientUrl("~/modules/enquiries/admin/default.aspx")
            Dim verbModuleLink As New WebPartVerb("verbModuleLink", "javascript: navigateURL('" & moduleURL & "');")
            verbModuleLink.Text = "Enquiries Module"
            verbModuleLink.Description = "Manage Enquiries"
            verbModuleLink.ImageUrl = "~/app_themes/admin/images/module.gif"

            Dim ret As New WebPartVerbCollection(New WebPartVerb() {verbModuleLink})
            Return ret
        End Get
    End Property

    Private Sub Page_PreRender(sender As Object, e As EventArgs) Handles Me.PreRender

    End Sub

    Protected Sub btnsend_Click(sender As Object, e As EventArgs) Handles btnsend.Click
        If (capValidate()) Then
            Dim sqlinsert As String
            Dim cls As New clscode
            Dim name As String = txtfullname.Text.Trim
            Dim email As String = txtemail.Text.Trim
            Dim org As String = "" 'txtorg.Text.Trim
            Dim contactno As String = txtcontactno.Text.Trim
            Dim enqmsg As String = txtmsg.Text.Trim
            Dim msg As String = String.Empty
            Dim msgplain As String = String.Empty

            sqlinsert = "Insert into enquiries (name,email,company,mobile,message,form, datesubmitted) values "
            sqlinsert += "('" & HttpUtility.HtmlEncode(name) & "','" & HttpUtility.HtmlEncode(email) & "','" & HttpUtility.HtmlEncode(org) & "','" & HttpUtility.HtmlEncode(contactno) & "','" & HttpUtility.HtmlEncode(enqmsg) & "','Emailus',getdate())"

            cls.ExecNonQuery(sqlinsert)

            Dim sendto As String = ""
            Dim subject As String = ""
            Dim dr As SqlDataReader

            dr = cls.ExecReader("Select notification_subject,notification_sendto from techCMS_notifications where notification_code='EF' and notification_isnotify='True'")

            If dr.HasRows Then
                dr.Read()
                sendto = dr("notification_sendto")
                subject = dr("notification_subject")
                Using reader As StreamReader = New StreamReader(Server.MapPath("~/webparts/forms/emailbody.html"))
                    msg = reader.ReadToEnd
                End Using
                msg = msg.Replace("{Name}", name)
                msg = msg.Replace("{Email}", email)
                msg = msg.Replace("{Organization}", org)
                msg = msg.Replace("{Contactno}", contactno)
                msg = msg.Replace("{Enquiry}", enqmsg)
                msgplain = "New Enquiry \r\n From: " & name & "Email: " & email & "\nOrganization: " & org & "\nContact No: " & contactno & "\nEnquiry:" & enqmsg
                cls.Send(name, email, sendto.Substring(0, sendto.IndexOf("@")), sendto, subject, msg, msgplain)
            End If

            dr.Close()

            Response.Redirect("~/webpages/thank-you.aspx?t=enq")
        Else

        End If
    End Sub



    Public Function capValidate() As Boolean
        Dim Response As String = Request("g-recaptcha-response")
        Dim Valid As Boolean = False
        Dim req As HttpWebRequest = DirectCast(WebRequest.Create(Convert.ToString("https://www.google.com/recaptcha/api/siteverify?secret=6Ler-q8UAAAAAHGbIfxZdIielacvwo4vmb2pMjc0&response=") & Response), HttpWebRequest)

        Try
            Using wResponse As WebResponse = req.GetResponse()

                Using readStream As New StreamReader(wResponse.GetResponseStream())
                    Dim jsonResponse As String = readStream.ReadToEnd()
                    Dim js As New JavaScriptSerializer()
                    Dim data As MyObject = js.Deserialize(Of MyObject)(jsonResponse)

                    Valid = Convert.ToBoolean(data.success)
                    Return Valid
                End Using
            End Using
        Catch ex As Exception
            Return False
        End Try
    End Function

    Public Class MyObject
        Public Property success() As String
            Get
                Return m_success
            End Get
            Set(value As String)
                m_success = value
            End Set
        End Property
        Private m_success As String


    End Class






End Class