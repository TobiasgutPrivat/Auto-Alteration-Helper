void runFromPath(string path)
{
   Json::Value Configuration;
   if(!IO::FileExists(path)) {
      sendError("File doesnt exist.\nMake sure to use a Filename of a json File without Fileextension\n(MyFileName.json -> MyFileName)");
      return;
   }
   Configuration = Json::FromFile(path);
   if(Json::Write(Configuration) == "null")
   {
      sendError("File is not in json format");
      return;
   }
   runFromJson(Configuration);
}

void runFromJson(Json::Value Configuration) {
// Format:
// {
//    "Action": "ActionName",
//    "Settings": {someJsonObject}
// }

   if(Json::Write(Configuration["Action"]) == "null")
   {
      sendError('There is no Porperty "Action"');
      return;
   }

   if(Json::Write(Configuration["Settings"]) == "null")
   {
      sendError('There is no Porperty "Settings"');
      return;
   }

//Start
   string action = Configuration["Action"];
   if (action == "AlterCampaign")
   {
        sendResponse("Alter Canpaign");
   }
   else if (action == "AlterMap")
   {
        Altermap(Configuration["Configuration"]);
   }
   else
   {
      sendError("No Valid ActionName: " + action);
   }
}