void Altermap(Json::Value Configuration)
{
    // Format
    // {
    //     "mapPath", (String)
    //     "Actions", (Object/Array)
    //     "savePath" (String)
    // }
    EditorMgt::openEditor(Configuration["mapPath"]);
    runAction(Configuration["Actions"]);
    EditorMgt::SaveAndExitMap(Configuration["savePath"]);
}

void AlterCampaign(Json::Value Configuration)
{
    // Format
    // {
    //     "folderPath", (String)
    //     "Actions", (Object/Array)
    //     "saveFolderPath" (String)
    // }
    files = IO::IndexFolder(IO::FromStorageFolder(""),true);
    for (uint i = 0; i < files.Length; i++)
    {
        if(files[i].SubStr(files[i].Length - 8) == ".Map.Gbx"){
            //TODO
        }
    }
}