<%@ Page Title="MODULES" Language="vb" AutoEventWireup="false" MasterPageFile="~/Masterpages/CMSAdmin.Master" CodeBehind="default.aspx.vb" Inherits="tfsCMS._default7" Theme="admin" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphbody" runat="server">
    <br /><br />
 <div style="padding:10px;">
 <div class="box" style="width:550px; margin:0 auto; padding:10px; ">
    <h1>Available Modules</h1><br />
   <asp:ListView ID="ListView1" runat="server" DataSourceID="dsModules" style="width:100%" 
                    GroupItemCount="3">
                    <EmptyItemTemplate>
                        <td id="Td1" runat="server" />
                        </EmptyItemTemplate>
                        <ItemTemplate>
                            <td id="Td2" runat="server" style=" text-align:center;  width:150px;padding:15px;">
                               
                               <asp:HyperLink ID="HyperLink1"    runat="server" NavigateUrl='<%#Eval("module_dir") %>'   > <img src='<%# Eval("module_image") %>' border="0"  /></asp:HyperLink><br />
                             
                                <br />
                            </td>
                        </ItemTemplate>
                        <AlternatingItemTemplate>
                                    <td id="Td1" runat="server" style=" text-align:center; width:150px;padding:15px;">
                      
                               <asp:HyperLink ID="HyperLink1"   runat="server" NavigateUrl='<%#Eval("module_dir") %>' style="width:250px"><img src='<%# Eval("module_image") %>' border="0"  /></asp:HyperLink><br />
                           
                                <br />
                            </td>
                        </AlternatingItemTemplate>
                        <EmptyDataTemplate>
                            <table id="Table1" runat="server" style="">
                                <tr>
                                    <td>
                                        No data was returned.</td>
                                </tr>
                            </table>
                        </EmptyDataTemplate>
                        <InsertItemTemplate>
                            <td id="Td3" runat="server" style="">
                                 
                            </td>
                        </InsertItemTemplate>
                        <LayoutTemplate>
                            <table id="Table2" runat="server" style="font-size: 14px; font-weight: bold;">
                                <tr id="Tr1" runat="server">
                                    <td id="Td4" runat="server">
                                        <table ID="groupPlaceholderContainer" runat="server" border="0" cellspacing="30">
                                            <tr ID="groupPlaceholder" runat="server">
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr id="Tr2" runat="server">
                                    <td id="Td5" runat="server" style="">
                                    </td>
                                </tr>
                            </table>
                        </LayoutTemplate>
                        <EditItemTemplate>
                            <td id="Td6" runat="server" style="">
                              
                                 
                            </td>
                        </EditItemTemplate>
                        <GroupTemplate>
                            <tr ID="itemPlaceholderContainer" runat="server">
                                <td ID="itemPlaceholder" runat="server">
                                </td>
                            </tr>
                        </GroupTemplate>
                        <SelectedItemTemplate>
                         <td id="Td2" runat="server" style=" text-align:center; width:100px;padding:15px;">
   
                               <asp:HyperLink ID="HyperLink1"   runat="server" NavigateUrl='<%#Eval("module_dir") %>' style="width:250px"><img src='<%# Eval("module_image") %>' border="0"  /></asp:HyperLink><br />
                         
                                <br />
                            </td>
                        </SelectedItemTemplate>
                    </asp:ListView>
                                <asp:SqlDataSource ID="dsModules" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:tfsCMSconn %>" 
                    ProviderName="System.Data.SqlClient" 
                    
                    SelectCommand="SELECT [module_name],[module_image],[module_dir] FROM [techCMS_modules] WHERE ([module_isactive] = @module_isactive) order by module_sort">
                    <SelectParameters>
                        <asp:Parameter DefaultValue="true" Name="module_isactive" Type="Boolean" />
                    </SelectParameters>
                </asp:SqlDataSource>

    </div>
      </div>
      
</asp:Content>
