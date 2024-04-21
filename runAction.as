void runAction(Json::Value Configuration) {
   if(Configuration.GetType() == Json::Type::Array){
      runArray(Configuration);
      return;
   }

   if (jsonHasProperty(Configuration,"AlterCampaign")) {
        print(Configuration["AlterCampaign"]);
   }
   if (jsonHasProperty(Configuration,"AlterMap")) {
        Altermap(Configuration["AlterMap"]);
   }
   if (jsonHasProperty(Configuration,"openEditor")) {
      EditorMgt::openEditor(Configuration["openEditor"]);
   }
   if (jsonHasProperty(Configuration,"saveMap")) {
      EditorMgt::SaveAndExitMap(Configuration["saveMap"]);
   }
   if (jsonHasProperty(Configuration,"deleteBlocks")) {
      deleteBlocks(Configuration["deleteBlocks"]);
   }
}

void runArray(Json::Value jsonArray)
{
   for (uint i = 0; i < jsonArray.Length; i++)
   {
      runAction(jsonArray[i]);
   }
}

void runConfFile(string path)
{
   Json::Value Configuration;
   if(!IO::FileExists(path)) {
      throw("File doesnt exist.\nMake sure to use a Filename of a json File without Fileextension\n(MyFileName.json -> MyFileName)");
   }
   Configuration = Json::FromFile(path);
   if(Json::Write(Configuration) == "null")
   {
      throw("File is not in json format");
   }
   runAction(Configuration);
}