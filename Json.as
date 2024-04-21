bool jsonHasProperty(Json::Value json, string propertyName){
   string value = Json::Write(json[propertyName]);
   if(value == "null")
   {
      return false;
   }
   return true;
}