auto app = cast<CTrackMania>(GetApp());

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

void runAction(Json::Value Configuration) {
// Format:
// {
//    "Action": "ActionName",
//    "Settings": {someJsonObject}
// }
   string action = jsonGetString(Configuration,"Action");
   if (action == "AlterCampaign")
   {
        response.Add("Alter Canpaign");
   }
   else if (action == 'AlterMap')
   {
        Altermap(jsonGetObject(Configuration, "Settings"));
   }
   else if (action == 'openEditor')
   {
      EditorMgt::openEditor(jsonGetString(Configuration, "Settings"));
   }
   else if (action == 'saveMap')
   {
      EditorMgt::SaveAndExitMap(jsonGetString(Configuration, "Settings"));
   }
   else
   {
      throw("No Valid ActionName: " + action);
   }
}

string jsonGetString(Json::Value json, string propertyName)
{
   string value = Json::Write(json[propertyName]);
   if(value == "null")
   {
      throw('There is no Porperty "' + propertyName + '"');
   }
   return json[propertyName];
}

Json::Value jsonGetObject(Json::Value json, string propertyName)
{
   string value = Json::Write(json[propertyName]);
   if(value == "null")
   {
      throw('There is no Porperty "' + propertyName + '" in ' + Json::Write(json));
   }
   return Json::Parse(value);
}