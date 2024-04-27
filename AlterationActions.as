// https://github.com/XertroV/tm-editor-plus-plus/blob/master/src/Editor/MacroblockManip_ExportCode.as
// Editor::Function()

// returns a const version of the cached octree for all blocks/items in the map
// import const OctTreeNode@ GetCachedMapOctTree() from "Editor";

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