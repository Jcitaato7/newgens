Imports techCart.DAL

Public Class wpproductslist
    Inherits clswebpart
    Implements IWebActionable

    Dim webPartManager As WebPartManager
    Protected _clscode As clscode

    Public Sub New()
        MyBase.New()
        'Me.Title = "Untitled"
    End Sub

    Public ReadOnly Property Verbs() As WebPartVerbCollection Implements IWebActionable.Verbs
        Get

            Dim moduleURL = ResolveClientUrl("~/modules/products/admin/product-categories.aspx")
            Dim verbModuleLink As New WebPartVerb("verbModuleLink", "javascript: navigateURL('" & moduleURL & "');")
            verbModuleLink.Text = "Products Module"
            verbModuleLink.Description = "Manage Product Categories"
            verbModuleLink.ImageUrl = "~/app_themes/admin/images/module.gif"

            Dim ret As New WebPartVerbCollection(New WebPartVerb() {verbModuleLink})
            Return ret
        End Get
    End Property

    Private Sub Page_Init(sender As Object, e As EventArgs) Handles Me.Init
        'Me.Page.Title = urlHash.Value
        'Me.Page.MetaDescription = urlHash.Value
        'Me.Page.MetaKeywords = urlHash.Value

    End Sub

    Private Sub Page_PreRender(sender As Object, e As System.EventArgs) Handles Me.PreRender
        'Dim webPartManager As WebPartManager
        'webPartManager = webPartManager.GetCurrentWebPartManager(Page)
        'If webPartManager.Personalization.CanEnterSharedScope Then
        '    webPartManager.WebParts(Me.ID).ChromeType = PartChromeType.None
        'End If
        _clscode = New clscode

        If Not IsPostBack Then
            Dim vRecords As Object

            vRecords = ProductService.GetProductsByCategories


            If vRecords.Count > 0 Then

                rptMainItem.DataSource = vRecords
                rptMainItem.DataBind()

            End If
        End If
    End Sub
End Class