void Altermap(Json::Value Configuration)
{
    // Format
    // {
    //     "mapPath", (String)
    //     "Actions", (Array)
    //     "savePath" (String)
    // }
    // EditorMgt::openEditor(Configuration["mapPath"]);
    Alter(Configuration["Actions"]);
    // EditorMgt::SaveAndExitMap(Configuration["savePath"]);
}

void Alter(Json::Value actions)
{        
    // auto editor = cast<CGameCtnEditorFree>(cast<CTrackMania>(GetApp()).Editor);
    // CGameEditorPluginMap@ map = cast<CGameEditorPluginMap>(editor.PluginMapType);
    // if(editor is null){
    //     throw("editor not available");
    // }
    // // Editor::MacroblockSpec@ Macroblock = Editor::GetMapAsMacroblock().macroblock;
    // Editor::BlockSpec@[]@ blocks = Macroblock.Blocks;
    // Editor::ItemSpec@[]@ items = Macroblock.Items;
    // Json::Value blockMapping = getBlockMapping(blocks);
    // Json::Value itemMapping = getItemMapping(items);
    // Editor::DeleteBlocksAndItems(Macroblock.Blocks,Macroblock.Items,true);
    
    // for (uint i = 0; i < actions.Length; i++)
    // {
    //     Json::Value action = actions[i];
    //     if (jsonHasProperty(action,"deleteBlocks")) {
    //         if (jsonHasProperty(blockMapping, action["deleteBlocks"]))
    //         {
    //             Json::Value blockselection = blockMapping.Get(action["deleteBlocks"]);
    //             for (int i = blockselection.Length - 1; i >= 0; i--)
    //             {
    //                 blocks.RemoveAt(blockselection[i]);
    //             }
    //         }
    //         if(jsonHasProperty(itemMapping, action["deleteBlocks"]))
    //         { 
    //             Json::Value itemselection = itemMapping.Get(action["deleteBlocks"]);
    //             for (int i = itemselection.Length - 1; i >= 0; i--)
    //             {
    //                 items.RemoveAt(itemselection[i]);
    //             }
    //         }
    //     }
    //     if (jsonHasProperty(action,"replaceBlocks")) {
    //         if (jsonHasProperty(blockMapping, action["replaceBlocks"]["source"]))
    //         {
    //             Json::Value blockselection = blockMapping.Get(action["replaceBlocks"]["source"]);
    //             for (int i = blockselection.Length - 1; i >= 0; i--)
    //             {
    //                 placeBlock(blocks[blockselection[i]],action["replaceBlocks"]["new"]);
    //             }
    //         }
    //         if(jsonHasProperty(itemMapping, action["replaceBlocks"]["source"]))
    //         { 
    //             Json::Value itemselection = itemMapping.Get(action["replaceBlocks"]["source"]);
    //             for (int i = itemselection.Length - 1; i >= 0; i--)
    //             {
    //                 // items[itemselection[i]].Model.MwRelease();
    //                 // items[itemselection[i]].Model = map.GetBlockModelFromName(action["replaceBlock"]["new"]);//action["replaceBlock"]["new"]
    //                 // items[itemselection[i]].Model.MwAddRef();
    //             }
    //         }
    //     }
    // }
    // Editor::PlaceBlocks(blocks,false);
    // Editor::PlaceItems(items,true);
}

void AlterCampaign(Json::Value Configuration)
{
    // Format
    // {
    //     "folderPath", (String)
    //     "Actions", (Object/Array)
    //     "saveFolderPath" (String)
    // }
    string[] files = IO::IndexFolder(IO::FromStorageFolder(""),true);
    for (uint i = 0; i < files.Length; i++)
    {
        if(files[i].SubStr(files[i].Length - 8) == ".Map.Gbx"){
            //TODO
        }
    }
}