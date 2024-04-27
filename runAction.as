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
   if (jsonHasProperty(Configuration,"getCurrBlockName")) {
      print(getCurrentSelectedBlockName());
   }
   if (jsonHasProperty(Configuration,"Alterations")){
      AlterationSet(Configuration["Alterations"]).run();
   }
}

void runArray(Json::Value jsonArray)
{
   for (uint i = 0; i < jsonArray.Length; i++)
   {
      runAction(jsonArray[i]);
   }
}