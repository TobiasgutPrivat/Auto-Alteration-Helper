Json::Value readFile(string path)
{
    if(!IO::FileExists(path)) return Json::Array();
    auto json = Json::FromFile(path);
    return json;
}