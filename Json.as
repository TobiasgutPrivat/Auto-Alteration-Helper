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

bool jsonHasProperty(Json::Value json, string propertyName){
   string value = Json::Write(json[propertyName]);
   if(value == "null")
   {
      return false;
   }
   return true;
}