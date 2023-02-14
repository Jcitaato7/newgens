Imports Telerik.Web.UI
Imports techCart.DAL

Public Class _Products_Default
    Inherits System.Web.UI.Page

    Public Shared ReadOnly Property ConnectionString() As String
        Get
            Return ConfigurationManager.ConnectionStrings("tfsCMSconn").ConnectionString
        End Get
    End Property

    Protected Sub RadGrid1_InsertCommand(ByVal sender As Object, ByVal e As Telerik.Web.UI.GridCommandEventArgs) Handles RadGrid1.InsertCommand

        Dim curuser As MembershipUser = Membership.GetUser(HttpContext.Current.User.Identity.Name)
        Dim curUserName = curuser.UserName

        If Not curuser Is Nothing Then

            Dim editableItem = (DirectCast(e.Item, GridEditableItem))
            Dim values As New Hashtable()
            editableItem.ExtractValues(values)

            Dim ddlCategory As DropDownList = editableItem.FindControl("ddlCategory")

            Dim vProduct As New Product
            Dim dateNow As Date = Date.Now

            With vProduct
                '.ProductCode = values("ProductCode")
                .ProductName = values("ProductName")
                .ShortDescription = values("ShortDescription")
                .FullDescription = values("FullDescription")

                ' can't use values below because Eval (one-way) is use instead of Bind.
                ' can't use Bind due to error "Databinding methods such as Eval(), XPath(), and Bind() can only be used in the context..."
                .ProductCategoryID = ddlCategory.SelectedValue 'values("ProductCategoryID")                
                .ProductSort = 1 'CInt(values("ProductSort"))
                .PageTitle = values("PageTitle")
                .MetaDescription = values("MetaDescription")
                .MetaKeywords = values("MetaKeywords")
                .IsActive = values("IsActive")
                .EnableAddToCart = False 'values("EnableAddToCart")
                .IsFeatured = values("IsFeatured")
                .WithVariants = False
                .CreatedBy = curUserName
                .DateCreated = dateNow
                .ModifiedBy = curUserName
                .DateModified = dateNow
            End With

            ProductService.InsertProduct(vProduct)

        End If

    End Sub

    Protected Sub RadGrid1_ItemCommand(ByVal sender As Object, ByVal e As Telerik.Web.UI.GridCommandEventArgs) Handles RadGrid1.ItemCommand
        Dim vCommand As String = e.CommandName

        If vCommand = RadGrid.InitInsertCommandName Then ' Or e.Item.OwnerTableView.Name = "DetailTable" Then

            e.Canceled = True
            Dim newValues As System.Collections.Specialized.ListDictionary = New System.Collections.Specialized.ListDictionary()

            newValues("IsFeatured") = False
            newValues("IsActive") = True
            'newValues("EnableAddToCart") = True
            'newValues("OldPrice") = "0.00"
            'newValues("Price") = "0.00"
            'newValues("ProductSort") = 1
            newValues("ProductCategoryID") = 0

            e.Item.OwnerTableView.InsertItem(newValues)

        ElseIf vCommand = "Feature" Then

            Dim currentProductID As Integer = e.Item.OwnerTableView.DataKeyValues(e.Item.ItemIndex).Item("ProductID")

            ProductService.FeatureProduct(currentProductID)

            RadGrid1.Rebind()

        ElseIf vCommand = "Delete" Then

            Dim currentProductID As Integer = e.Item.OwnerTableView.DataKeyValues(e.Item.ItemIndex).Item("ProductID")

            ProductService.DeleteProduct(currentProductID)

            RadGrid1.Rebind()

        ElseIf vCommand = "IsActive" Then

            Dim currentProductID As Integer = e.Item.OwnerTableView.DataKeyValues(e.Item.ItemIndex).Item("ProductID")

            ProductService.ActivateProduct(currentProductID)

            RadGrid1.Rebind()

        End If


    End Sub

    Protected Sub RadGrid1_ItemCreated(ByVal sender As Object, ByVal e As Telerik.Web.UI.GridItemEventArgs) Handles RadGrid1.ItemCreated

        If (TypeOf e.Item Is GridEditFormItem And e.Item.IsInEditMode) Then 'e.Item = GridEditFormItem

            Dim editableItem As GridEditFormItem = DirectCast(e.Item, GridEditFormItem)
            Dim ddlCategory As DropDownList = editableItem.FindControl("ddlCategory")

            ddlCategory.Items.Clear()

            If ddlCategory.Items.Count = 0 Then
                ddlCategory.DataSource = ProductService.GetAllCategoriesforDropDown(0)
                ddlCategory.DataTextField = "CategoryName"
                ddlCategory.DataValueField = "ProductCategoryID"

                'If ddlCategory.SelectedValue <> -1 Or ddlCategory.SelectedValue <> 0 Then
                'ddlCategory.DataBind()
                'End If

                ddlCategory.Items.Add(New ListItem("[ Select Category ]", "0"))
                ddlCategory.AppendDataBoundItems = True
                ' On insert, ProductCategoryID is being set on RadGrid1_ItemCommand
                ddlCategory.SelectedValue = DataBinder.Eval(editableItem.DataItem, "ProductCategoryID")

                'If Not IsDBNull(DataBinder.Eval(editableItem.DataItem, "ProductCategoryID")) Then
                'Else
                'ddlCategory.SelectedValue = 0
                'End If

            End If
        End If
    End Sub

    Protected Sub RadGrid1_NeedDataSource(ByVal sender As Object, ByVal e As Telerik.Web.UI.GridNeedDataSourceEventArgs) Handles RadGrid1.NeedDataSource

        RadGrid1.DataSource = ProductService.GetAllProducts

    End Sub

    Protected Sub RadGrid1_UpdateCommand(ByVal sender As Object, ByVal e As Telerik.Web.UI.GridCommandEventArgs) Handles RadGrid1.UpdateCommand

        Dim curuser As MembershipUser = Membership.GetUser(HttpContext.Current.User.Identity.Name)

        If Not curuser Is Nothing Then

            Dim editableItem = (DirectCast(e.Item, GridEditableItem))

            Dim values As New Hashtable()
            editableItem.ExtractValues(values)

            Dim ddlCategory As DropDownList = editableItem.FindControl("ddlCategory")

            Dim vProduct As Product = ProductService.GetProductByID(DirectCast(editableItem.GetDataKeyValue("ProductID"), Integer))

            editableItem.UpdateValues(vProduct)

            With vProduct
                '.ProductCode = values("ProductCode")
                '.ProductName = values("ProductName")
                '.ShortDescription = values("ShortDescription")
                '.FullDescription = values("FullDescription")

                ' can't assign 'values("ProductCategoryID") below because Eval (one-way) is use instead of Bind.
                ' can't use Bind due to error "Databinding methods such as Eval(), XPath(), and Bind() can only be used in the context..."
                .ProductCategoryID = ddlCategory.SelectedValue

                'If docFileName <> "" Then
                '    .Brochure = docFileName
                'End If

                '.ProductSort = values("ProductSort")
                .IsActive = values("IsActive")
                .IsFeatured = values("IsFeatured")
                '.WithVariants = True
                .ModifiedBy = curuser.UserName
                .DateModified = Date.Now
            End With

            ProductService.UpdateProduct(vProduct)

        End If

    End Sub
End Class