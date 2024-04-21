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
    print(Json::Write(conf));
    // import BlockSpec@ MakeBlockSpec(CGameCtnBlock@ block) from "Editor";
}