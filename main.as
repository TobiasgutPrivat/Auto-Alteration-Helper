void runConfiguration(string path)
{
   Json::Value Configuration;
    if(IO::FileExists(path)) {
        Configuration = Json::FromFile(path);
    } else {
        sendError("File doesnt exist");
        return;
    }

   if(Json::Write(Configuration) == "null")
   {
      sendError("File is not in json format");
      return;
   }

   if(Json::Write(Configuration["Action"]) == "null")
   {
      sendError("There is no Porperty Action");
      return;
   }

   string action = Configuration["Action"];
   if (action == "AlterCampaign")
   {
        sendResponse("Alter Canpaign");
   }
   else if (action == "AlterMap")
   {
        sendResponse("Alter map");
   }
   else
   {
      sendError("no valid Action");
   }
}