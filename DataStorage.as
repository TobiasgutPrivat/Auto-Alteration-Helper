namespace DataStorage
{
    Json::Value readTimes(string mapId)
    {
        string path = getFilePath(mapId);
        if(!IO::FileExists(path)) return Json::Array();
        auto json = Json::FromFile(path);
        return json;
    }

    void writeTimes(string mapId,Json::Value times)
    {
        string path = getFilePath(mapId);
        Json::ToFile(path,times);
    }

    string getFilePath(string mapId) {
        return IO::FromStorageFolder(mapId + ".json");
    }
}