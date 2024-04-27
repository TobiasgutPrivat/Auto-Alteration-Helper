bool jsonHasProperty(Json::Value json, string propertyName){
   string value = Json::Write(json[propertyName]);
   if(value == "null")
   {
      return false;
   }
   return true;
}

Json::Value loadJsonFile(string path)
{
   if(!IO::FileExists(path)) {
      throw("The File (" + path + ")doesnt exist.");
   }
   Json::Value content = Json::FromFile(path);
   if(Json::Write(content) == "null")
   {
      throw("File is not in json format");
   }
   return content;
}