Imports Telerik.Web.UI
Imports techCart.DAL

Public Class _Product_Photos_Default
    Inherits System.Web.UI.Page

    Const MaxTotalBytes As Integer = 5242880 ' 5 MB
    Dim totalBytes As Integer

    Public Property IsRadAsyncValid() As System.Nullable(Of Boolean)
        Get
            If Session("IsRadAsyncValid") Is Nothing Then
                Session("IsRadAsyncValid") = True
            End If

            Return Convert.ToBoolean(Session("IsRadAsyncValid").ToString())
        End Get
        Set(ByVal value As System.Nullable(Of Boolean))
            Session("IsRadAsyncValid") = value
        End Set
    End Property

    Public Shared ReadOnly Property ConnectionString() As String
        Get
            Return ConfigurationManager.ConnectionStrings("techCMSConn").ConnectionString
        End Get
    End Property

    Protected Overrides Sub OnLoad(ByVal e As EventArgs)
        MyBase.OnLoad(e)

        IsRadAsyncValid = Nothing
    End Sub

    Protected Sub RadGrid1_InsertCommand(ByVal sender As Object, ByVal e As Telerik.Web.UI.GridCommandEventArgs) Handles RadGrid1.InsertCommand

        Dim curuser As MembershipUser = Membership.GetUser(HttpContext.Current.User.Identity.Name)
        Dim curUserName = curuser.UserName

        If Not curuser Is Nothing Then

            Dim editableItem = (DirectCast(e.Item, GridEditableItem))
            Dim values As New Hashtable()
            editableItem.ExtractValues(values)
            Dim objPhoto As New Photo
            Dim objProductPhotoMapping As New Product_Photo_Mapping
            Dim radAsyncUpload As RadAsyncUpload = TryCast(editableItem.FindControl("AsyncUpload1"), RadAsyncUpload)
            Dim ddlProduct As DropDownList = editableItem.FindControl("ddlProduct")
            'Dim photoFileName As String = ""
            Dim photoFilePath As String = ""

            If radAsyncUpload.UploadedFiles.Count > 0 Then

                Dim file As UploadedFile = radAsyncUpload.UploadedFiles(0)

                'photoFileName = file.FileName
                photoFilePath = "~/modules/products/images/products/" + file.FileName
                file.SaveAs(MapPath(photoFilePath))

            End If

            With objPhoto
                .AlternateText = values("AlternateText")

                If photoFilePath <> "" Then
                    .FileName = values("FileName")
                    .FilePath = photoFilePath
                End If

                .IsActive = values("IsActive")
                .Sort = values("Sort")
                .CreatedBy = curUserName
                .DateCreated = Date.Now
                .ModifiedBy = curUserName
                .DateModified = Date.Now
            End With

            With objProductPhotoMapping
                .ProductID = ddlProduct.SelectedValue
            End With

            ProductService.InsertPhotoAndProductMapping(objPhoto, objProductPhotoMapping)

        End If

    End Sub

    Protected Sub RadGrid1_ItemCommand(ByVal sender As Object, ByVal e As Telerik.Web.UI.GridCommandEventArgs) Handles RadGrid1.ItemCommand
        Dim vCommand As String = e.CommandName

        If vCommand = RadGrid.InitInsertCommandName Then ' Or e.Item.OwnerTableView.Name = "DetailTable" Then
            e.Canceled = True
            Dim newValues As System.Collections.Specialized.ListDictionary = New System.Collections.Specialized.ListDictionary()

            newValues("IsActive") = True
            newValues("ProductID") = 0
            newValues("FilePath") = ""
            newValues("Sort") = 1

            e.Item.OwnerTableView.InsertItem(newValues)

        ElseIf vCommand = "Delete" Then

            Dim item As GridDataItem = e.Item

            Dim filePath = item("FilePath").Text
            Dim currentPhotoID As Integer = e.Item.OwnerTableView.DataKeyValues(e.Item.ItemIndex).Item("PhotoID")
            Dim currentProductID As Integer = e.Item.OwnerTableView.DataKeyValues(e.Item.ItemIndex).Item("ProductID")

            If System.IO.File.Exists(MapPath(filePath)) Then
                System.IO.File.Delete(MapPath(filePath))
            End If

            ProductService.DeletePhoto(currentPhotoID)

            RadGrid1.Rebind()

        ElseIf vCommand = "IsActive" Then

            Dim currentPhotoID As Integer = e.Item.OwnerTableView.DataKeyValues(e.Item.ItemIndex).Item("PhotoID")

            ProductService.ActivatePhoto(currentPhotoID)

            RadGrid1.Rebind()

        ElseIf vCommand = "Feature" Then

            Dim currentPhotoID As Integer = e.Item.OwnerTableView.DataKeyValues(e.Item.ItemIndex).Item("PhotoID")
            Dim currentProductID As Integer = e.Item.OwnerTableView.DataKeyValues(e.Item.ItemIndex).Item("ProductID")

            ProductService.FeaturePhoto(currentPhotoID, currentProductID)

            RadGrid1.Rebind()

        End If

    End Sub

    Protected Sub RadGrid1_ItemCreated(ByVal sender As Object, ByVal e As Telerik.Web.UI.GridItemEventArgs) Handles RadGrid1.ItemCreated

        If (TypeOf e.Item Is GridEditFormItem And e.Item.IsInEditMode) Then

            Dim editableItem As GridEditFormItem = DirectCast(e.Item, GridEditFormItem)
            Dim ddlProduct As DropDownList = editableItem.FindControl("ddlProduct")
            Dim currentPhotoID As Integer = 0

            If e.Item.ItemIndex >= 0 Then ' editing. do not include current Photo to the Photo dropdown
                currentPhotoID = e.Item.OwnerTableView.DataKeyValues(e.Item.ItemIndex).Item("PhotoID")
            End If

            ddlProduct.Items.Clear()

            If ddlProduct.Items.Count = 0 Then
                ddlProduct.DataSource = ProductService.GetAllActiveProductsforDropDown(0)
                ddlProduct.DataTextField = "ProductName"
                ddlProduct.DataValueField = "ProductID"

                'If ddlProduct.SelectedValue <> -1 Or ddlProduct.SelectedValue <> 0 Then
                'ddlProduct.DataBind()
                'End If

                ddlProduct.Items.Add(New ListItem("[ Select Product ]", "0"))
                ddlProduct.AppendDataBoundItems = True
                ' On insert, ProductCategoryID is being set on RadGrid1_ItemCommand
                ddlProduct.SelectedValue = DataBinder.Eval(editableItem.DataItem, "ProductID")

            End If
        End If

    End Sub

    Protected Sub RadGrid1_NeedDataSource(ByVal sender As Object, ByVal e As Telerik.Web.UI.GridNeedDataSourceEventArgs) Handles RadGrid1.NeedDataSource

        RadGrid1.DataSource = ProductService.GetAllProductPhotos

    End Sub

    Protected Sub RadGrid1_UpdateCommand(ByVal sender As Object, ByVal e As Telerik.Web.UI.GridCommandEventArgs) Handles RadGrid1.UpdateCommand

        Dim curuser As MembershipUser = Membership.GetUser(HttpContext.Current.User.Identity.Name)

        If Not curuser Is Nothing Then

            Dim editableItem = (DirectCast(e.Item, GridEditableItem))
            Dim radAsyncUpload As RadAsyncUpload = TryCast(editableItem.FindControl("AsyncUpload1"), RadAsyncUpload)
            Dim ddlProduct As DropDownList = editableItem.FindControl("ddlProduct")
            'Dim txtPhoto As RadTextBox = editableItem.FindControl("txtPhoto")
            'Dim photoFileName As String = txtPhoto.Text
            Dim photoFilePath As String = ""
            Dim newValues As New Hashtable
            Dim oldValues As New Hashtable

            If radAsyncUpload.UploadedFiles.Count > 0 Then

                Dim file As UploadedFile = radAsyncUpload.UploadedFiles(0)

                'photoFileName = file.FileName
                photoFilePath = "~/modules/products/images/products/" & file.FileName

                file.SaveAs(MapPath(photoFilePath))
            End If

            Dim objPhoto As Photo = ProductService.GetPhotoByID(DirectCast(editableItem.GetDataKeyValue("PhotoID"), Integer))
            Dim objProductPhotoMapping As Product_Photo_Mapping = ProductService.GetProductPhotoMappingByID(DirectCast(editableItem.GetDataKeyValue("ProductPhotoID"), Integer))

            editableItem.UpdateValues(objPhoto)

            With objPhoto

                If photoFilePath <> "" Then
                    '.FileName = photoFileName
                    .FilePath = photoFilePath
                End If

                .ModifiedBy = curuser.UserName
                .DateModified = Date.Now
            End With

            With objProductPhotoMapping
                .ProductID = ddlProduct.SelectedValue

            End With

            ProductService.UpdatePhoto(objPhoto, objProductPhotoMapping)

            e.Item.OwnerTableView.ExtractValuesFromItem(newValues, editableItem)
            oldValues = editableItem.SavedOldValues

            If newValues("FileName").ToString <> oldValues("FileName").ToString Then
                Dim oldFilePath As String = "~/modules/products/images/products/" & oldValues("FileName").ToString

                If System.IO.File.Exists(MapPath(oldFilePath)) Then
                    System.IO.File.Delete(MapPath(oldFilePath))
                End If
            End If
        End If

    End Sub

    Public Sub RadAsyncUpload1_ValidatingFile(ByVal sender As Object, ByVal e As Telerik.Web.UI.Upload.ValidateFileEventArgs)
        If (totalBytes < MaxTotalBytes) AndAlso (e.UploadedFile.ContentLength < MaxTotalBytes) Then
            e.IsValid = True
            totalBytes += e.UploadedFile.ContentLength
            IsRadAsyncValid = True
        Else
            e.IsValid = False
            IsRadAsyncValid = False
        End If
    End Sub

End Class
