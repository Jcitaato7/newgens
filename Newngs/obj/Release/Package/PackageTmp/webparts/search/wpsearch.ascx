<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="wpsearch.ascx.vb" Inherits="tfsCMS.wpsearch" %>
<div class="box">
    <div class="box-c-title">
        <h1>SEARCH RESULT</h1>
    </div>
    <div class="box-c-content">
        <div style="padding:0;width:100%">
                        <h2>
                            Search this site</h2>
            <div style="width:100%; vertical-align:middle ">
                            <asp:TextBox ID="Search" runat="server" Width="350px" cssclass="searchbox" ></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="Search" Display="Dynamic" ErrorMessage="*Required" ValidationGroup="search"></asp:RequiredFieldValidator>
                            <asp:Button ID="srchbtn" runat="server" Text="Search" CssClass="searchbutton" ValidationGroup="search" Style="width:65px;padding:0;height:28px;border:none" />
                       </div>  
                             Search On : 
                                <asp:RadioButton ID="AllWords" runat="server" Checked="True" GroupName="mode" 
                                    Text="All Words " />
                                <asp:RadioButton ID="AnyWords" runat="server" GroupName="mode" 
                                    Text="Any Words " />
                                <asp:RadioButton ID="Phrase" runat="server" GroupName="mode" Text="Phrase" /><br />
                                  <br />
                   	    <asp:panel id="pnlSearchResults" runat="server" Visible="false" BorderStyle="None"  >
				    <table class="SearchStatus"  width="98%" align="center"  
                                border="0" style="color: #003366; padding:0">
					    <tr>
						    <td>Searched the site for
							    <asp:Label id="lblSearchWords" runat="server" Font-Bold="True"></asp:Label>.&nbsp;&nbsp;&nbsp;
							    <asp:Label id="lblFilesFound" runat="server" Font-Bold="True">Label</asp:Label>&nbsp;Files 
							    found</td>
					    </tr>
				    </table> <br />
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
                                            <span style="font-weight:bold">
                                            <%# DisplayTitle(Eval("Title"), Eval("Path"))%></span>
                                            <br />
                                            <%# String.Format("{0}", SearchWords(Eval("Description")))%>
                                            <br><span class="Path"><%# String.Format("{0}", DisplayPath(Eval("Path")))%>
                                            </span>
                                            <br/>
                                          </div>
                                        </ItemTemplate>
                                    </asp:TemplateColumn>
                             
                                </Columns>
                          
                                <PagerStyle CssClass="GridPager" Mode="NumericPages" />
                            
                            </asp:DataGrid>

                        <table align="center" border="0" cellpadding="1" cellspacing="1" 
                            class="SearchStatus" width="98%"  style="color: #003366">
                            <tr>
                                <td height="18" width="47%">
                                    &nbsp;Searched
                                    <asp:Label ID="lblTotalFiles" runat="server" Font-Bold="True"></asp:Label>
                                    &nbsp;documents in total.</td>
                                <td align="right" height="18" width="53%">
                             
                                </td>
                            </tr>
                        </table>
                               <br />
                            </asp:panel>
                            <asp:panel id="emptypanel" CssClass="search-empty" runat="server"   >

                                         <h3>
                                        <b>Tips for using search effectively:</b></h3>
                                    <p>
                                    The search engine by default searches for all the given words and displays the 
                                    page which has all the given search words. Below is an example on how to use the search options.
                               </p> 
                                    <br />
                                <h3>Example result when <b>"Great Vehicle"</b> keyword is used:</h3>
                                    <h2>All Words</h2> 
                               Select <b>All Words</b> to find pages that contains both <b>Great</b> and <b>Vehicle</b> in a page. 
                                    <br /><br />   
                               <h2>Any Words</h2> 
                                  Select <b>Any Words</b> to find pages that contains at least one of these words. A page should contain either <b>Great</b> or <b>Vehicle</b> or both.
                                    <br />  <br />   
                                    <h2>Phrase</h2> 
                                      Select <b>Phrase</b> to find pages that contains <b>Great Vehicle</b> exact phrase.<br />
                                   <br />
                                 <br />
                                        </asp:panel>
                </div>
        </div>
    </div>
 
       
