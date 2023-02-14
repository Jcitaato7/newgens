Imports techCart.DAL

Public Class wpproductdetails
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

            Dim moduleURL = ResolveClientUrl("~/modules/products/admin/default.aspx")
            Dim verbModuleLink As New WebPartVerb("verbModuleLink", "javascript: navigateURL('" & moduleURL & "');")
            verbModuleLink.Text = "Products Module"
            verbModuleLink.Description = "Manage Products"
            verbModuleLink.ImageUrl = "~/app_themes/admin/images/module.gif"

            Dim ret As New WebPartVerbCollection(New WebPartVerb() {verbModuleLink})
            Return ret
        End Get
    End Property

    Private Sub Page_Init(sender As Object, e As EventArgs) Handles Me.Init
        'Me.Page.Title = urlHash.Value
        'Me.Page.MetaDescription = urlHash.Value
        'Me.Page.MetaKeywords = urlHash.Value
        'Me.Page.SetFocus = 
    End Sub

    Private Sub Page_PreRender(sender As Object, e As System.EventArgs) Handles Me.PreRender
        'Dim webPartManager As WebPartManager
        'webPartManager = webPartManager.GetCurrentWebPartManager(Page)
        'If webPartManager.Personalization.CanEnterSharedScope Then
        '    webPartManager.WebParts(Me.ID).ChromeType = PartChromeType.None
        'End If
        _clscode = New clscode

        If Not IsPostBack Then
            Dim vID As Integer = Page.RouteData.Values("ItemID")
            Dim vRecords As Object

            vRecords = ProductService.GetProductAndPhotosByProductID(vID)

            If vRecords.Count > 0 Then

                rptMainItem.DataSource = vRecords
                rptMainItem.DataBind()

                With vRecords.Item(0)
                    Dim pageTitle As String = IIf(.PageTitle Is Nothing, .ProductName, .PageTitle)
                    Dim metaDescription As String = IIf(.MetaDescription Is Nothing, .ShortDescription, .MetaDescription)

                    Me.Page.Title = pageTitle
                    Me.Page.MetaDescription = metaDescription
                    Me.Page.MetaKeywords = .MetaKeywords
                End With

            End If
        End If
    End Sub
End Class