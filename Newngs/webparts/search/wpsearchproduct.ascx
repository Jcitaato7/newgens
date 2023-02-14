<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="wpsearchproduct.ascx.vb" Inherits="tfsCMS.wpsearchproduct" %>
<h1>Search Product</h1><br />
<div class="box">
    <div class="box-c-content">
        <div style="padding:0;width:100%">            
            <div style="width:100%; vertical-align:middle ">
                <asp:TextBox ID="Search" runat="server" Width="350px" cssclass="searchbox" ></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="Search" Display="Dynamic" ErrorMessage="*Required" ValidationGroup="search"></asp:RequiredFieldValidator>
                <asp:Button ID="srchbtn" runat="server" Text="Search" CssClass="searchbutton" ValidationGroup="search" />
            </div>  
            <asp:panel id="pnlSearchResults" runat="server" Visible="false" BorderStyle="None" CssClass="searchResult" >
				<table class="SearchStatus"  width="98%" align="center" border="0" style="color: #003366; padding:0">
					<tr>
						<td>Searched the products for
							"<asp:Label id="lblSearchWords" runat="server" Font-Bold="True"></asp:Label>".&nbsp;
							<asp:Label id="lblFilesFound" runat="server" Font-Bold="True">Label</asp:Label>&nbsp;records found.
						</td>
					</tr>
				</table>
                <asp:DataGrid ID="dgrdPages" Runat="Server" AllowPaging="True" 
                    AllowSorting="True" 
                    AutoGenerateColumns="False" BorderWidth="0" CellPadding="0" CellSpacing="0" 
                    DataKeyField="PageId"  
                    HorizontalAlign="Center" PagerStyle-Mode="NumericPages" PageSize="10" 
                    ShowHeader="False" Width="100%">
                    <Columns>
                        <asp:TemplateColumn>
                            <ItemTemplate >
                            <div style="min-height:70px;padding:5px;" class="box-section">
                                <br />
                                <span style="font-weight:bold">
                                <%# DisplayTitle(Eval("Title"), Eval("Path"))%></span>
                                <br />
                                <%# String.Format("{0}", SearchWords(Eval("Description")))%>
                                <br><span class="Path"><%# String.Format("{0}", DisplayPath(Eval("Path"), Eval("Title")))%>
                                </span>
                                <br/>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateColumn>
                             
                    </Columns>
                          
                    <PagerStyle CssClass="GridPager" Mode="NumericPages" />
                            
                </asp:DataGrid>
            </asp:panel>
            <asp:panel id="emptypanel" CssClass="search-empty" runat="server"   >
                <p>
                    No products found for the given search keywords. Try to use other keywords.
                </p>                                     
            </asp:panel>
        </div>
    </div>
</div>
 
       
