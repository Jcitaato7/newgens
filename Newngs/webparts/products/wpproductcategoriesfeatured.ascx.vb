Imports techCart.DAL

Public Class wpproductcategoriesfeatured
    Inherits clswebpart
    Implements IWebActionable

    Dim webPartManager As WebPartManager

    Public Sub New()
        MyBase.New()
        'Me.Title = "Untitled"
    End Sub

    Public ReadOnly Property Verbs() As WebPartVerbCollection Implements IWebActionable.Verbs
        Get

            Dim moduleURL = ResolveClientUrl("~/modules/products/admin/default.aspx")
            Dim verbModuleLink As New WebPartVerb("verbModuleLink", "javascript: navigateURL('" & moduleURL & "');")
            verbModuleLink.Text = "Products Module"
            verbModuleLink.Description = "Manage Featured Product Categories"
            verbModuleLink.ImageUrl = "~/app_themes/admin/images/module.gif"

            Dim ret As New WebPartVerbCollection(New WebPartVerb() {verbModuleLink})
            Return ret
        End Get
    End Property

    Private Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        If Not IsPostBack Then
            Dim vRecords As Object

            vRecords = ProductService.GetFeaturedProductCategories()

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