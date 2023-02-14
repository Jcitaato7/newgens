Public Class wpcontent
    Inherits clswebpart
    Implements IWebActionable
    Dim cls As New clscode
    Dim webPartManager As WebPartManager
    Private _contenId As Int64
    Private _chrometype As PartChromeType
    Public Sub New()
        MyBase.New()
        'Me.Title = "Untitled"
    End Sub

    <Personalizable(True)> _
    Public Property ContentId() As Int64
        Get
            Return Me._contenId
        End Get
        Set(ByVal value As Int64)
            Me._contenId = value
        End Set
    End Property

    <Personalizable(True), _
         WebBrowsable(True)> _
    Public Property chrometype() As PartChromeType
        Get
            Return Me._chrometype
        End Get
        Set(ByVal value As PartChromeType)
            Me._chrometype = value
        End Set
    End Property

    Protected Sub Page_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreRender
        webPartManager = webPartManager.GetCurrentWebPartManager(Page)
        If webPartManager.Personalization.CanEnterSharedScope Then
            If webPartManager.DisplayMode.Equals(webPartManager.BrowseDisplayMode) Then
                FormView1.ChangeMode(FormViewMode.ReadOnly)
            ElseIf webPartManager.DisplayMode.Equals(webPartManager.EditDisplayMode) Then
                If _contenId = Nothing Then
                    FormView1.ChangeMode(FormViewMode.Insert)
                End If
            Else
                If _contenId = Nothing Then
                    FormView1.ChangeMode(FormViewMode.Insert)
                End If
            End If
            Dim partType As PartChromeType = Me.chrometype
            If partType = PartChromeType.None Then
                FormView1.CellSpacing = 0
            Else
                FormView1.CellSpacing = 5
            End If
            webPartManager.WebParts(Me.ID).ChromeType = partType
        End If

    End Sub

    Protected Sub dscontent_Inserted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles dscontent.Inserted
        Dim NewId As Object = e.Command.Parameters("@NewID").Value
        'Dim ContentName As Object = e.Command.Parameters("@content_name").Value
        If Not NewId Is Nothing Then
            ContentId = NewId
            'Me.Title = ContentName
            Dim showborder As CheckBox = FormView1.FindControl("chkborder")
            chrometype = IIf(showborder.Checked = True, PartChromeType.BorderOnly, PartChromeType.None)
            FormView1.DefaultMode = FormViewMode.ReadOnly
        End If
    End Sub
    Protected Sub dscontent_Selecting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceSelectingEventArgs) Handles dscontent.Selecting
        e.Command.Parameters("@content_id").Value = _contenId
    End Sub

    Public ReadOnly Property Verbs() As WebPartVerbCollection Implements IWebActionable.Verbs
        Get
            Dim editverb As New WebPartVerb("verbEdit", New WebPartEventHandler(AddressOf EditContent))
            editverb.Text = "Edit"
            editverb.Description = "Edit this content"
            editverb.ImageUrl = "~/app_themes/admin/images/edit.gif"

            Dim fileMgrURL = ResolveClientUrl("~/Admin/filemanager/files.aspx")
            Dim filemgrverb As New WebPartVerb("verbfilemgr", "javascript:navigateURL('" & fileMgrURL & "');")
            filemgrverb.Text = "File Manager"
            filemgrverb.Description = "Manage Files"
            filemgrverb.ImageUrl = "~/app_themes/admin/images/filemgr.png"

            Dim ret As New WebPartVerbCollection(New WebPartVerb() {editverb, filemgrverb})
            Return ret
        End Get
    End Property

    Private Sub EditContent(ByVal sender As Object, ByVal e As WebPartEventArgs)
        Dim btn As WebPartVerb = sender
        If _contenId = Nothing Then
            FormView1.ChangeMode(FormViewMode.Insert)
        Else
            FormView1.ChangeMode(FormViewMode.Edit)
        End If
        btn.Visible = False
    End Sub


    Private Sub dscontent_Updated(sender As Object, e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles dscontent.Updated
        Dim showborder As CheckBox = FormView1.FindControl("chkborder")
        chrometype = IIf(showborder.Checked = True, PartChromeType.BorderOnly, PartChromeType.None)
    End Sub

    Private Sub FormView1_DataBound(sender As Object, e As System.EventArgs) Handles FormView1.DataBound
        If FormView1.CurrentMode = FormViewMode.Edit Then
            Dim showborder As CheckBox = FormView1.FindControl("chkborder")
            Dim partType As PartChromeType = Me.chrometype
            showborder.Checked = IIf(partType = PartChromeType.None, False, True)
        End If
    End Sub
End Class