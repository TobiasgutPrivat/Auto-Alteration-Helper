class AlterationSet
{
    string[] deleteEntries;
    Json::Value[] placeOnBlockEntries;
    Editor::BlockSpec@[] blocksToDelete;
    Editor::ItemSpec@[] itemsToDelete;
    
    Editor::MacroblockSpec@ Macroblock;
    Editor::BlockSpec@[]@ blocks;
    Editor::ItemSpec@[]@ items;
    Json::Value blockMapping;
    Json::Value itemMapping;

    AlterationSet(){}

    AlterationSet(string path)
    {
        loadAlteration(loadJsonFile(path));
    }

    AlterationSet(Json::Value alterations)
    {
        for (uint i = 0; i < alterations.Length; i++)
        {
            string path = IO::FromStorageFolder(alterationFolder + string(alterations[i]) + ".json");
            Json::Value alteration = loadJsonFile(path);
            loadAlteration(alteration);
        }
    }

    void loadAlteration(Json::Value alteration) {
        for (uint i = 0; i < alteration.Length; i++)
        {
            Json::Value action = alteration[i];
            if (jsonHasProperty(action,"place")) {
                placeOnBlockEntries.InsertLast(action["place"]);
            }
            if (jsonHasProperty(action,"replace")) {
                placeOnBlockEntries.InsertLast(action["replace"]);
                deleteEntries.InsertLast(action["replace"]["Source"]);
            }
            if (jsonHasProperty(action,"delete")) {
                deleteEntries.InsertLast(action["delete"]);
            }
        }
    }

    void run()
    {
        @Macroblock = Editor::GetMapAsMacroblock().macroblock;
        @blocks = Macroblock.Blocks;
        @items = Macroblock.Items;
        blockMapping = getBlockMapping(blocks);
        itemMapping = getItemMapping(items);

        for (uint i = 0; i < placeOnBlockEntries.Length; i++)
        {
            print("placeOnBlock:" + Json::Write(placeOnBlockEntries[i]));
            placeOnBlocks(placeOnBlockEntries[i]);
        }
        for (uint i = 0; i < deleteEntries.Length; i++)
        {
            print("delete:" + Json::Write(deleteEntries[i]));
            delete(deleteEntries[i]);
        }
        Editor::DeleteBlocksAndItems(blocksToDelete,itemsToDelete,true);
    }

    private void placeOnBlocks(Json::Value placeOnBlock)
    {
        if (jsonHasProperty(blockMapping, placeOnBlock["Source"]))
        {
            Json::Value blockselection = blockMapping.Get(placeOnBlock["Source"]);
            for (int i = blockselection.Length - 1; i >= 0; i--)
            {
                placeBlock(blocks[blockselection[i]],placeOnBlock["Block"]);
            }
        } else if(jsonHasProperty(blockMapping, placeOnBlock["Source"])) {
            print("Item Placement not implemented yet.");
        }
    }

    private void delete(string blockName)
    {
        if (jsonHasProperty(blockMapping, blockName))
        {
            Json::Value blockselection = blockMapping.Get(blockName);
            for (int i = blockselection.Length - 1; i >= 0; i--)
            {
                blocksToDelete.InsertLast(@blocks[blockselection[i]]);
            }
        } else if(jsonHasProperty(itemMapping, blockName))
        { 
            Json::Value itemselection = itemMapping.Get(blockName);
            for (int i = itemselection.Length - 1; i >= 0; i--)
            {
                itemsToDelete.InsertLast(items[itemselection[i]]);
            }
        }
    }

    private void placeBlock(Editor::BlockSpec blockspec, string newblock)
    {
        CGameEditorPluginMap@ map = cast<CGameEditorPluginMap>(cast<CGameCtnEditorFree>(cast<CTrackMania>(GetApp()).Editor).PluginMapType);
        int3 coords = int3(blockspec.coord.x,blockspec.coord.y+1,blockspec.coord.z);
        map.PlaceGhostBlock(map.GetBlockModelFromName(newblock),coords,CGameEditorPluginMap::ECardinalDirections::North);
    }
}