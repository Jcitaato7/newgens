Imports techCMS.DAL.PhotoManagement

Public Class wplogoslide
    Inherits clswebpart
    Implements IWebActionable

    Public Sub New()
        MyBase.New()
        'Me.Title = "Untitled"
    End Sub

    Public ReadOnly Property Verbs() As WebPartVerbCollection Implements IWebActionable.Verbs
        Get

            Dim moduleURL = ResolveClientUrl("~/modules/photo-gallery/admin/logo-slide-photos.aspx")
            Dim verbModuleLink As New WebPartVerb("verbModuleLink", "javascript: navigateURL('" & moduleURL & "');")
            verbModuleLink.Text = "Logo Slide Module"
            verbModuleLink.Description = "Manage Logos"
            verbModuleLink.ImageUrl = "~/app_themes/admin/images/module.gif"

            Dim ret As New WebPartVerbCollection(New WebPartVerb() {verbModuleLink})
            Return ret
        End Get
    End Property

    Private Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        If Not IsPostBack Then
            Dim vRecords As Object

            vRecords = PhotoGalleryService.GetAllActivePhotoGalleryPhotosByType(2)

            If vRecords.Count > 0 Then

                rptImages.DataSource = vRecords
                rptImages.DataBind()

            End If
        End If
    End Sub

    Private Sub Page_PreRender(sender As Object, e As System.EventArgs) Handles Me.PreRender
        Dim webPartManager As WebPartManager
        webPartManager = webPartManager.GetCurrentWebPartManager(Page)
        If webPartManager.Personalization.CanEnterSharedScope Then
            webPartManager.WebParts(Me.ID).ChromeType = PartChromeType.None
        End If
    End Sub

End Class