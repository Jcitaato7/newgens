<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="wpHorizontalTabs.ascx.vb" Inherits="tfsCMS.wpHorizontalTabs" %>
<div class="col-lg-12">
    <div id="wpDIVProps" runat="server" visible="false">
        <asp:Repeater ID="rptEditTitles" runat="server">
            <HeaderTemplate>
                <ul id="myTab" class="nav nav-tabs nav-justified">
            </HeaderTemplate>
            <ItemTemplate>
                <li class='<%# IIf(Container.ItemIndex = 0,"active","") %>'><a href='<%# "#" & Me.ID.ToString & "-" & Eval("Sort").ToString %>' data-toggle="tab"><%# Eval("Title").ToString%></a></li>
            </ItemTemplate>
            <FooterTemplate>
                </ul>
            </FooterTemplate>
        </asp:Repeater> 
        <asp:Repeater ID="rptEditContents" runat="server">
            <HeaderTemplate>
                <div id="myTabContent" class="tab-content">
            </HeaderTemplate>
            <ItemTemplate>
                <asp:HiddenField ID="TabContentID" runat="server" Value='<%# Eval("TabContentID")%>' />
                <asp:HiddenField ID="Sort" runat="server" Value='<%# Eval("Sort")%>' />                
                <div class='<%# IIf(Container.ItemIndex = 0,"tab-pane fade active in","tab-pane fade") %>' id='<%# Me.ID.ToString & "-" & Eval("Sort").ToString %>'>
                        Header Title: <asp:TextBox ID="Title" runat="server" Text='<%# Eval("Title")%>' MaxLength="150" /><br />
                        Content:<br>
                        <telerik:RadEditor ID="Content" Runat="server" SkinID="tfsDefault" Width="100%"      
                            Content='<%# Eval("Content") %>' ToolbarMode="Floating" OnClientSubmit="RadEditorOnClientSubmit">
    <%--                        <CssFiles>
                                <telerik:EditorCssFile Value="~/webparts/radeditor/css/StyleSheet.css" />
                            </CssFiles>--%>                                  
                            <DocumentManager MaxUploadFileSize="10485760" UploadPaths="~/files/documents" ViewPaths="~/files/documents" />
                            <TemplateManager ViewPaths="~/webparts/radeditor/templates" UploadPaths="~/webparts/radeditor/templates"   />
                            <ImageManager MaxUploadFileSize="10485760" UploadPaths="~/files/images" ViewPaths="~/files/images" />                     
                            <FlashManager UploadPaths="~/files/flash" ViewPaths="~/files/flash" MaxUploadFileSize="10485760" />
                            <Modules>
                                <telerik:EditorModule Name="RadEditorStatistics"   />
                                <telerik:EditorModule Name="RadEditorDomInspector"  />
                                <%--<telerik:EditorModule Name="RadEditorNodeInspector"  />--%>
                                <telerik:EditorModule Name="RadEditorHtmlInspector" Visible="false"/>
                            </Modules>                  
                        </telerik:RadEditor>  
                </div>
            </ItemTemplate>
            <FooterTemplate>
                </ul>
            </FooterTemplate>
        </asp:Repeater> 
        <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn btn-primary" />&nbsp;<asp:Button ID="btnCancel" runat="server" CssClass="btn btn-primary" Text="Cancel" />
    </div>
    <div id="wpDIVContent" runat="server">
        <asp:Repeater ID="rptTitles" runat="server">
            <HeaderTemplate>
                <ul id="myTab" class="nav nav-tabs nav-justified">
            </HeaderTemplate>
            <ItemTemplate>
                <li class='<%# IIf(Container.ItemIndex = 0,"active","") %>'><a href='<%# "#" & Me.ID.ToString & "-" & Eval("Sort").ToString %>' data-toggle="tab"><%# Eval("Title").ToString%></a></li>
            </ItemTemplate>
            <FooterTemplate>
                </ul>
            </FooterTemplate>
        </asp:Repeater> 
        <asp:Repeater ID="rptContents" runat="server">
            <HeaderTemplate>
                <div id="myTabContent" class="tab-content">
            </HeaderTemplate>
            <ItemTemplate>
                <div class='<%# IIf(Container.ItemIndex = 0,"tab-pane fade active in","tab-pane fade") %>' id='<%# Me.ID.ToString & "-" & Eval("Sort").ToString %>'><%# Eval("Content").ToString%></div>
            </ItemTemplate>
            <FooterTemplate>
                </ul>
            </FooterTemplate>
        </asp:Repeater>         
    </div>
</div>