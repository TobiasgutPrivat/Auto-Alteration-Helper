const string PluginName = "Alteration Helper";
string validateFolder;
bool validating;
bool goNext;

void Main() {
   while(true){
      yield();
   
      if (validateFolder != ""){
         validating = true;
         array<string> maps = IO::IndexFolder(validateFolder,true);
         validateFolder = "";
         for (uint i = 0; i < maps.Length; i++)
         {
            if (!validating){break;}
            if(maps[i].SubStr(maps[i].Length - 8) == ".map.gbx"){
               openEditor(maps[i]);
               CGameCtnEditorFree@ editor = cast<CGameCtnEditorFree>(cast<CTrackMania>(GetApp()).Editor);
               editor.PluginMapType.UnvalidateGameplayInfo();
               goNext = false;
               while(!goNext){if (!validating){break;}yield();}
               // TODO optional auto exit (waits anyways)
               SaveMapSameName(editor);
               cast<CTrackMania>(GetApp()).BackToMainMenu();
               AwaitReturnToMenu();
            }
         }
         validating = false;
      }
   }
}

void awaitValidation(){
   while(true)
   {
      if (cast<CGameCtnApp>(GetApp()).CurrentPlayground != null && cast<CGameCtnApp>(GetApp()).Editor != null){
         if (cast<CGameCtnApp>(GetApp()).CurrentPlayground.UIConfigs[0].UISequence == CGamePlaygroundUIConfig::EUISequence::EndRound){
            return;
         }
      }
      yield();
   }
}

void exportInventory(){
   auto app = cast<CTrackMania>(GetApp());
   auto editor = cast<CGameCtnEditorFree>(app.Editor);
   Json::Value articles = Json::Array();
   RecursiveAddInventoryArticle(editor.PluginMapType.Inventory.RootNodes[0], "Block", CGameEditorPluginMap::EPlaceMode::Block, editor.PluginMapType.Inventory.RootNodes[1],@articles);
   Json::ToFile(IO::FromStorageFolder("Blocks.json"),articles);
   articles = Json::Array();
   RecursiveAddInventoryArticle(editor.PluginMapType.Inventory.RootNodes[3], "Item", CGameEditorPluginMap::EPlaceMode::Item, null,@articles);
   Json::ToFile(IO::FromStorageFolder("Items.json"),articles);
   articles = Json::Array();
   RecursiveAddInventoryArticle(editor.PluginMapType.Inventory.RootNodes[4], "Macroblock", CGameEditorPluginMap::EPlaceMode::Macroblock, null,@articles);
   Json::ToFile(IO::FromStorageFolder("Macroblocks.json"),articles);
   
   Json::Value blockModels = Json::Array();
   for (uint i = 0; i < editor.PluginMapType.BlockModels.Length; i++) {
    blockModels.Add(editor.PluginMapType.BlockModels[i].IdName);
   }
   Json::ToFile(IO::FromStorageFolder("BlockModels.json"),blockModels);

   Json::Value TerrainBlockModels = Json::Array();
   for (uint i = 0; i < editor.PluginMapType.TerrainBlockModels.Length; i++) {
    TerrainBlockModels.Add(editor.PluginMapType.TerrainBlockModels[i].IdName);
   }
   Json::ToFile(IO::FromStorageFolder("TerrainBlockModels.json"),TerrainBlockModels);

   Json::Value MacroblockModels = Json::Array();
   for (uint i = 0; i < editor.PluginMapType.MacroblockModels.Length; i++) {
    MacroblockModels.Add(editor.PluginMapType.MacroblockModels[i].IdName);
   }
   Json::ToFile(IO::FromStorageFolder("MacroblockModels.json"),MacroblockModels);
}
void RecursiveAddInventoryArticle(CGameCtnArticleNode@ current, const string&in name, CGameEditorPluginMap::EPlaceMode placeMode, CGameCtnArticleNode@ sister, Json::Value@ articles)
{
   CGameCtnArticleNodeDirectory@ currentDir = cast<CGameCtnArticleNodeDirectory>(current);
   CGameCtnArticleNodeDirectory@ sisterDir = cast<CGameCtnArticleNodeDirectory>(sister);
   if (currentDir !is null)
   {
         for (uint i = 0; i < currentDir.ChildNodes.Length; ++i)
         {
            CGameCtnArticleNode@ newDir = currentDir.ChildNodes[i];
            CGameCtnArticleNode@ newSisterDir = null;
            if (sisterDir !is null && i < sisterDir.ChildNodes.Length)
            {
               @newSisterDir = sisterDir.ChildNodes[i];

               if (tostring(newSisterDir.NodeName) != tostring(newDir.NodeName))
               {
                     @newSisterDir = null;
               }
            }

            if (newDir.IsDirectory)
            {
               RecursiveAddInventoryArticle(newDir, name + "/" + newDir.NodeName, placeMode, newSisterDir, @articles);

            }
            else
            {
               CGameCtnArticleNodeArticle@ currentArt = cast<CGameCtnArticleNodeArticle>(newDir);
               CGameCtnArticleNodeArticle@ currentSisterArt = cast<CGameCtnArticleNodeArticle>(newSisterDir);
               if (currentArt !is null)
               {
                     string articleName = name + "/" + currentArt.NodeName;
                     if (currentArt.NodeName.Contains("\\"))
                     {
                        auto splitPath = tostring(currentArt.NodeName).Split("\\");
                        if (splitPath.Length > 0)
                        {
                           articleName = name + "/" + splitPath[splitPath.Length-1];
                        }
                     }

                     if (currentSisterArt !is null && tostring(currentSisterArt.NodeName) != tostring(currentArt.NodeName))
                     {
                        @currentSisterArt = null;
                     }
                     articles.Add(currentArt.NodeName);//name + "/" + currentArt.NodeName
               }
            }
         }
   }
}