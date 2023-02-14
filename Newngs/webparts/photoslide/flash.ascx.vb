Imports techCMS.DAL.PhotoManagement

Public Class wpphotoslide
    Inherits clswebpart
    Implements IWebActionable

    Public Sub New()
        MyBase.New()
        'Me.Title = "Untitled"
    End Sub

    Public ReadOnly Property Verbs() As WebPartVerbCollection Implements IWebActionable.Verbs
        Get
            ' Shortcut button for Photo Slider Module
            Dim moduleURL = ResolveClientUrl("~/modules/photo-gallery/admin/photo-slide-photos.aspx")
            Dim verbModuleLink As New WebPartVerb("verbModuleLink", "javascript: navigateURL('" & moduleURL & "');")
            verbModuleLink.Text = "Photo Slide Module"
            verbModuleLink.Description = "Manage Photos"
            verbModuleLink.ImageUrl = "~/app_themes/admin/images/module.gif"

            Dim ret As New WebPartVerbCollection(New WebPartVerb() {verbModuleLink})
            Return ret
        End Get
    End Property

    Private Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        If Not IsPostBack Then
            Dim vRecords As Object

            vRecords = PhotoGalleryService.GetAllActivePhotoGalleryPhotosByType(1)

            If vRecords.Count > 0 Then

                rptImages.DataSource = vRecords
                rptImages.DataBind()
                rptIndicators.DataSource = vRecords
                rptIndicators.DataBind()
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