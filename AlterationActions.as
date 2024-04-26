// https://github.com/XertroV/tm-editor-plus-plus/blob/master/src/Editor/MacroblockManip_ExportCode.as
// Editor::Function()

// Do Stuff
// import bool PlaceBlocksAndItems(const BlockSpec@[]@ blocks, const ItemSpec@[]@ items, bool addUndoRedoPoint = false) from "Editor";
// import bool DeleteBlocksAndItems(const BlockSpec@[]@ blocks, const ItemSpec@[]@ items, bool addUndoRedoPoint = false) from "Editor";
// import bool DeleteBlocks(CGameCtnBlock@[]@ blocks, bool addUndoRedoPoint = false) from "Editor";
// import bool PlaceBlocks(BlockSpec@[]@ blocks, bool addUndoRedoPoint = false) from "Editor";

// returns a const version of the cached octree for all blocks/items in the map
// import const OctTreeNode@ GetCachedMapOctTree() from "Editor";

void deleteBlocks(Json::Value conf)
{
    print("deleteBlocks");
    auto editor = cast<CGameCtnEditorFree>(cast<CTrackMania>(GetApp()).Editor);
    if(editor is null){
        throw("editor not available");
    }
    Editor::MacroblockSpec@ Macroblock = Editor::GetMapAsMacroblock().macroblock;
    Editor::BlockSpec@[]@ blocks = Macroblock.Blocks;
    Editor::ItemSpec@[]@ items = Macroblock.Items;
    Editor::DeleteBlocksAndItems(blocks,items,true);
    Json::Value blockMapping = getBlockMapping(blocks);
    Json::Value itemMapping = getItemMapping(items);
    print(Json::Write(blockMapping));
    // print(Json::Write(itemMapping));
    Json::Value Road = blockMapping["TrackWallToRoadDirt"];
    
    for (uint i = 0; i < Road.Length; i++)
    {
        blocks[Road[i]].coord.x = 30;
    }
    Editor::PlaceBlocks(blocks);
    Editor::PlaceItems(items);
}

Json::Value getBlockMapping(Editor::BlockSpec@[]@ blocks)
{
    Json::Value blockMapping = Json::Object();
    for (uint i = 0; i < blocks.Length; i++)
    {
        if (!jsonHasProperty(blockMapping,blocks[i].name)){
            blockMapping[blocks[i].name] = Json::Array();
        }
        blockMapping[blocks[i].name].Add(i);
    }
    return blockMapping;
}

Json::Value getItemMapping(Editor::ItemSpec@[]@ items)
{
    Json::Value itemMapping = Json::Object();
    for (uint i = 0; i < items.Length; i++)
    {
        if (!jsonHasProperty(itemMapping,items[i].name)){
            itemMapping[items[i].name] = Json::Array();
        }
        itemMapping[items[i].name].Add(i);
    }
    return itemMapping;
}

string getCurrentSelectedBlockName(){
    auto editor = cast<CGameCtnEditorFree>(cast<CTrackMania>(GetApp()).Editor);
    return(editor.PluginMapType.Inventory.CurrentSelectedNode.Name);
}