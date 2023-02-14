<%@ Page Title="File-Manager" Language="vb" AutoEventWireup="false" MasterPageFile="~/Masterpages/CMSAdmin.Master" CodeBehind="default.aspx.vb" Inherits="tfsCMS.files" Theme="admin" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
   <script type="text/javascript">
       //function OnClientDelete(oExplorer, args) {
       //    var item = args.get_item();
       //    var itemPath = item.get_path().toLowerCase();

       //    if (item.isDirectory() && (itemPath == "/puti/files/documents" || itemPath == "/puti/files/flash" || itemPath == "/puti/files/images")) {
       //        args.set_cancel(true);
       //        alert("This folder is being used by the system. You cannot delete, rename or move this folder.");
       //    }
       //}

       function OnClientMove(oExplorer, args) {         
           var item = args.get_item();
           var itemPath = item.get_path().toLowerCase();
           
           if (item.isDirectory() && (itemPath == "/files/documents" || itemPath == "/files/flash" || itemPath == "/files/images")) {
               args.set_cancel(true);
               alert("This folder is a system folder. You cannot delete, rename or move this folder.");
           }
       }


       function OnClientFolderLoaded(sender, args) {
           var radExplorer = $find('<%= RadFileExplorer1.ClientID %>');
           var getGrid = radExplorer.get_grid();

           var table = getGrid.get_masterTableView();
           var rows = table.get_dataItems();

           for (var i = 0; i < rows.length; i++) {
               var row = rows[i];
               var sizeInBytes = row.get_cell("Size").innerHTML;
               var inegerValue = -1;
               try {
                   inegerValue = parseInt(sizeInBytes);
               }
               catch (err) {
                   inegerValue = -1;
               }
               if (inegerValue > 0) {
                   var textInKB = Math.round(inegerValue / 1024);
                   if (textInKB < 1) {
                       textInKB = 1;
                   }
                   textInKB = textInKB + " KB";
                   row.get_cell("Size").innerHTML = textInKB;
               }

           }
       }

       // disable rename, copy, and delete menu for system folders
       // http://www.telerik.com/forums/how-to-disable-rename-functionality-for-root-node-in-rad-file-explorer
       function OnClientContextMenuShown(oTreeView, args) {
           var pathToItem = args.get_node().get_value().toLowerCase();

           if (pathToItem == "/files/documents" || pathToItem == "/files/flash" || pathToItem == "/files/images") {
               var treeContextMenuItems = args.get_menu().get_allItems();

               for (var i = 0; i < treeContextMenuItems.length; i++) {
                   var menuItem = treeContextMenuItems[i];
                   if (menuItem.get_value() == "Rename" || menuItem.get_value() == "Copy" || menuItem.get_value() == "Delete") {
                       menuItem.set_enabled(false);
                   }
               }
           }
       }
</script>
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphbody" runat="server">
<div style="padding:10px;">
 <div class="box" style="width:1000px; margin:0 auto;padding:10px">
  <h1>Manage Files</h1>
    <table  style="width:100%; margin:0 auto;">
       
        <tr>
           <td colspan="2"></td>
            
        </tr>
        <tr>
           <td colspan="2" style="text-align: left; vertical-align: top;padding:10px">
               <i>These files are used in the <b>Content Editor widget</b>. The following widget icons are paths to its corresponding folder:</i><br /><br />
               Image Manager -> <b>images</b> Folder<br />
               Document Manager -> <b>documents</b> folder<br /> 
               Flash Manager -> <b>flash</b> folder<br /><br />
               <telerik:RadFileExplorer ID="RadFileExplorer1" Runat="server"  
                   DisplayUpFolderItem="True" EnableCreateNewFolder="True" Height="350px" 
                   OnClientMove="OnClientMove"
                   Width="100%" onclientfolderloaded="OnClientFolderLoaded"
                   ExplorerMode="Thumbnails">
<Configuration SearchPatterns="*.*" DeletePaths="~/files/" UploadPaths="~/files/" 
                       ViewPaths="~/files/" MaxUploadFileSize="5242880"></Configuration>
               </telerik:RadFileExplorer>
           </td>
        </tr>
        <tr>
            <td class="style3">
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
    </table>
    </div>
     </div>
</asp:Content>
