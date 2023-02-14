Imports System.Data.SqlClient
Imports System.IO
Imports System.Web
Imports Telerik.Web.UI
Imports techCMS.DAL

Public Class wpHorizontalTabs
    Inherits clswebpart
    Implements IWebActionable

    Public Sub New()
        MyBase.New()
    End Sub

    Public ReadOnly Property Verbs() As WebPartVerbCollection Implements IWebActionable.Verbs
        Get

            Dim editPropertiesVerb As WebPartVerb = New WebPartVerb("editproperties", New WebPartEventHandler(AddressOf EditProperties))
            editPropertiesVerb.Text = "Edit Properties"
            editPropertiesVerb.Description = "Edit this content"
            editPropertiesVerb.ImageUrl = "~/app_themes/admin/images/edit.gif"

            Dim newVerbs(0) As WebPartVerb
            'Dim newVerbs As New ArrayList()
            'newVerbs.Add(editPropertiesVerb)
            newVerbs(0) = editPropertiesVerb
            'newVerbs(1) = dispContentVerb

            Dim m_Verbs As WebPartVerbCollection = New WebPartVerbCollection(newVerbs)

            Return m_Verbs
        End Get
    End Property


    Private Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        Dim tabContents = TabContentService.TabContents(Me.ID)
        If tabContents.Count > 0 Then
            rptTitles.DataSource = tabContents
            rptTitles.DataBind()
            rptContents.DataSource = tabContents
            rptContents.DataBind()
        Else
            TabContentService.InsertInitialTabContents(Me.ID)
        End If
    End Sub

    Public Sub EditProperties(ByVal sender As Object, ByVal args As WebPartEventArgs)
        EnsureChildControls()
        SetEditMode(True)
    End Sub

    Private Sub SetEditMode(ByVal show As Boolean)
        Me.wpDIVContent.Visible = Not show
        Me.wpDIVProps.Visible = show

        If show Then
            Dim tabContents = TabContentService.TabContents(Me.ID)
            If tabContents.Count > 0 Then
                rptEditTitles.DataSource = tabContents
                rptEditTitles.DataBind()
                rptEditContents.DataSource = tabContents
                rptEditContents.DataBind()
            End If
        End If
    End Sub

    Private Sub btnCancel_Click(sender As Object, e As EventArgs) Handles btnCancel.Click
        SetEditMode(False)
    End Sub

    Private Sub btnSave_Click(sender As Object, e As EventArgs) Handles btnSave.Click
        Dim tabControlContent(rptEditContents.Items.Count - 1) As TabControlContent
        Dim i As Integer = 0

        For Each item As RepeaterItem In rptEditContents.Items
            tabControlContent(i) = New TabControlContent

            tabControlContent(i).TabContentID = DirectCast(item.FindControl("TabContentID"), HiddenField).Value
            tabControlContent(i).WebPartID = Me.ID
            tabControlContent(i).Sort = DirectCast(item.FindControl("Sort"), HiddenField).Value
            tabControlContent(i).Title = DirectCast(item.FindControl("Title"), TextBox).Text
            tabControlContent(i).Content = DirectCast(item.FindControl("Content"), RadEditor).Content
            i += 1
        Next

        TabContentService.UpdateTabContents(tabControlContent)

        SetEditMode(False)
    End Sub
End Class