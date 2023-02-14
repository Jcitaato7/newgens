Imports Telerik.Web.UI
Imports techCart.DAL

Public Class _Product_Categories_Default
    Inherits System.Web.UI.Page

    'Const MaxTotalBytes As Integer = 5242880 ' 5 MB
    'Dim totalBytes As Integer

    'Public Property IsRadAsyncValid() As System.Nullable(Of Boolean)
    '    Get
    '        If Session("IsRadAsyncValid") Is Nothing Then
    '            Session("IsRadAsyncValid") = True
    '        End If

    '        Return Convert.ToBoolean(Session("IsRadAsyncValid").ToString())
    '    End Get
    '    Set(ByVal value As System.Nullable(Of Boolean))
    '        Session("IsRadAsyncValid") = value
    '    End Set
    'End Property

    Public Shared ReadOnly Property ConnectionString() As String
        Get
            Return ConfigurationManager.ConnectionStrings("techCMSConn").ConnectionString
        End Get
    End Property

    Protected Overrides Sub OnLoad(ByVal e As EventArgs)
        MyBase.OnLoad(e)

        'IsRadAsyncValid = Nothing
    End Sub

    Protected Sub RadGrid1_InsertCommand(ByVal sender As Object, ByVal e As Telerik.Web.UI.GridCommandEventArgs) Handles RadGrid1.InsertCommand

        Dim curuser As MembershipUser = Membership.GetUser(HttpContext.Current.User.Identity.Name)
        Dim curUserName = curuser.UserName

        If Not curuser Is Nothing Then

            Dim editableItem = (DirectCast(e.Item, GridEditableItem))
            Dim values As New Hashtable()
            editableItem.ExtractValues(values)

            'Dim ddlCategory As DropDownList = editableItem.FindControl("ddlCategory")
            Dim vProductCategory As New ProductCategory
            'Dim radAsyncUpload As RadAsyncUpload = TryCast(editableItem.FindControl("AsyncUpload1"), RadAsyncUpload)
            'Dim photoFileName As String = ""

            'If radAsyncUpload.UploadedFiles.Count > 0 Then

            '    Dim file As UploadedFile = radAsyncUpload.UploadedFiles(0)

            '    photoFileName = file.FileName
            '    file.SaveAs(MapPath("~/modules/products/images/categories/") + photoFileName)

            'End If

            With vProductCategory
                .CategoryName = values("CategoryName")
                '.Keywords = values("Keywords")

                ' can't use values below because Eval (one-way) is use instead of Bind.
                ' can't use Bind due to error "Databinding methods such as Eval(), XPath(), and Bind() can only be used in the context..."
                .CategoryParentID = 0 'ddlCategory.SelectedValue 
                .ShortDescription = values("ShortDescription")
                '.FullDescription = values("FullDescription")

                'If photoFileName <> "" Then
                '    .CategoryPhoto = photoFileName
                'End If

                .CategorySort = CInt(values("CategorySort"))
                .IsActive = values("IsActive")
                .CreatedBy = curUserName
                .DateCreated = Date.Now
                .ModifiedBy = curUserName
                .DateModified = Date.Now
            End With

            ProductService.InsertProductCategory(vProductCategory)

        End If

    End Sub

    Protected Sub RadGrid1_ItemCommand(ByVal sender As Object, ByVal e As Telerik.Web.UI.GridCommandEventArgs) Handles RadGrid1.ItemCommand
        Dim vCommand As String = e.CommandName

        If vCommand = RadGrid.InitInsertCommandName Then ' Or e.Item.OwnerTableView.Name = "DetailTable" Then
            e.Canceled = True
            Dim newValues As System.Collections.Specialized.ListDictionary = New System.Collections.Specialized.ListDictionary()

            newValues("IsActive") = True
            newValues("CategorySort") = 1
            newValues("CategoryParentID") = 0

            e.Item.OwnerTableView.InsertItem(newValues)

        ElseIf vCommand = "Delete" Then

            Dim currentProductCategoryID As Integer = e.Item.OwnerTableView.DataKeyValues(e.Item.ItemIndex).Item("ProductCategoryID")

            ProductService.DeleteProductCategory(currentProductCategoryID)

            RadGrid1.Rebind()

        ElseIf vCommand = "IsActive" Then

            Dim currentProductCategoryID As Integer = e.Item.OwnerTableView.DataKeyValues(e.Item.ItemIndex).Item("ProductCategoryID")

            ProductService.ActivateProductCategory(currentProductCategoryID)

            RadGrid1.Rebind()

        End If

    End Sub

    Protected Sub RadGrid1_ItemCreated(ByVal sender As Object, ByVal e As Telerik.Web.UI.GridItemEventArgs) Handles RadGrid1.ItemCreated

        If (TypeOf e.Item Is GridEditFormItem And e.Item.IsInEditMode) Then

            Dim editableItem As GridEditFormItem = DirectCast(e.Item, GridEditFormItem)
            'Dim ddlCategory As DropDownList = editableItem.FindControl("ddlCategory")
            Dim currentCategoryID As Integer = 0

            If e.Item.ItemIndex >= 0 Then ' editing. do not include current category to the category dropdown
                currentCategoryID = e.Item.OwnerTableView.DataKeyValues(e.Item.ItemIndex).Item("ProductCategoryID")
            End If

            'ddlCategory.DataSource = ProductService.GetAllCategoriesforDropDown(currentCategoryID)

            'ddlCategory.DataTextField = "CategoryName"
            'ddlCategory.DataValueField = "ProductCategoryID"

            'ddlCategory.Items.Add(New ListItem("[ This is a Top Category. If not, select below ]", "0"))
            'ddlCategory.AppendDataBoundItems = True


        End If

    End Sub

    Protected Sub RadGrid1_NeedDataSource(ByVal sender As Object, ByVal e As Telerik.Web.UI.GridNeedDataSourceEventArgs) Handles RadGrid1.NeedDataSource

        RadGrid1.DataSource = ProductService.GetAllProductCategoriesAndParentCategories

    End Sub

    Protected Sub RadGrid1_UpdateCommand(ByVal sender As Object, ByVal e As Telerik.Web.UI.GridCommandEventArgs) Handles RadGrid1.UpdateCommand

        Dim curuser As MembershipUser = Membership.GetUser(HttpContext.Current.User.Identity.Name)

        If Not curuser Is Nothing Then

            Dim editableItem = (DirectCast(e.Item, GridEditableItem))
            'Dim ddlCategory As DropDownList = editableItem.FindControl("ddlCategory")
            'Dim radAsyncUpload As RadAsyncUpload = TryCast(editableItem.FindControl("AsyncUpload1"), RadAsyncUpload)
            'Dim photoFileName As String = ""

            'If radAsyncUpload.UploadedFiles.Count > 0 Then

            '    Dim file As UploadedFile = radAsyncUpload.UploadedFiles(0)

            '    photoFileName = file.FileName
            '    file.SaveAs(MapPath("~/modules/products/images/categories/") + photoFileName)
            'End If

            Dim vProductCategory As ProductCategory = ProductService.GetProductCategoryByID(DirectCast(editableItem.GetDataKeyValue("ProductCategoryID"), Integer))

            editableItem.UpdateValues(vProductCategory)

            With vProductCategory

                ' can't use values below because Eval (one-way) is use instead of Bind.
                ' can't use Bind due to error "Databinding methods such as Eval(), XPath(), and Bind() can only be used in the context..."
                .CategoryParentID = 0 'ddlCategory.SelectedValue

                'If photoFileName <> "" Then
                '    .CategoryPhoto = photoFileName
                'End If

                .ModifiedBy = curuser.UserName
                .DateModified = Date.Now
            End With

            ProductService.UpdateProductCategory(vProductCategory)

        End If

    End Sub

    'Public Sub RadAsyncUpload1_ValidatingFile(ByVal sender As Object, ByVal e As Telerik.Web.UI.Upload.ValidateFileEventArgs)
    '    If (totalBytes < MaxTotalBytes) AndAlso (e.UploadedFile.ContentLength < MaxTotalBytes) Then
    '        e.IsValid = True
    '        totalBytes += e.UploadedFile.ContentLength
    '        IsRadAsyncValid = True
    '    Else
    '        e.IsValid = False
    '        IsRadAsyncValid = False
    '    End If
    'End Sub

End Class
