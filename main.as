string lastGhostId = "";
string lastMapId = "";

void Main()
{
   while(true) {
      Loop();
   }
}

void Loop()
{
	sleep(1000);
   CTrackMania@ app = cast<CTrackMania>(GetApp());

   auto GhostData = MLFeed::GetGhostData();
   if (GhostData !is null && GhostData.Ghosts_V2 !is null && GhostData.NbGhosts != 0) {
      auto lastGhost = @GhostData.Ghosts_V2[GhostData.NbGhosts - 1];
      if (lastGhostId != lastGhost.IdName) {
            lastGhostId = lastGhost.IdName;
            if (lastGhost.IsLocalPlayer) {
               OnNewRun(lastGhost);
            }
      }
   }

   if (app !is null) {
      auto map = @app.RootMap;
      if (map !is null && lastMapId != map.MapInfo.MapUid) {
            lastMapId = map.MapInfo.MapUid;
            OnMapChange(map);
      }
   }
}

void OnNewRun(const MLFeed::GhostInfo_V2@ ghost)
{
   int RunTime = ghost.Result_Time;
   print(RunTime);
}

void OnMapChange(CGameCtnChallenge@ map)
{
   print("Mapchange");
}

int getPlacement(string MapId, int Time)
{
   //API Call
}

// void LoadURLConfig(){
//         Net::HttpRequest@ req = Net::HttpRequest();
//         req.Url = "openplanet.dev/plugin/extraleaderboardpositions/config/urls";
//         req.Method = Net::HttpMethod::Get;
        
//         req.Start();
//         while(!req.Finished()){
//             yield();
//         }
//         if(req.ResponseCode() != 200){
//             warn("Error loading plugin config : " + req.ResponseCode() + " - " + req.Error());
//             Active = false;
//             return;
//         }

//         // get the json object from the response
//         auto response = Json::Parse(req.String());
//         auto externalAPI = response["api"];
//         // if the json's "active" is true, set the url, else disable the api calls
//         if(externalAPI["active"] == "true"){
//             API_URL = externalAPI["url"];
//             Active = true;
//         }else{
//             warn("External API is disabled by config for now");
//             Active = false;
//         }
//     }