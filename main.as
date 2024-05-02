const string PluginName = "Alteration Helper";
string validateFolder;
string lastGhostId;
bool first;


void Main() {
   while(true){
      yield();
   
      if (first){
         if (MLFeed::GetGhostData().NbGhosts != 0){
            lastGhostId = MLFeed::GetGhostData().Ghosts_V2[MLFeed::GetGhostData().NbGhosts - 1].IdName;
            first = false;
         }
      }

      if (validateFolder != ""){
         array<string> maps = IO::IndexFolder(validateFolder,true);
         print(validateFolder);
         print(maps.Length);
         for (uint i = 0; i < maps.Length; i++)
         {
            if(maps[i].SubStr(maps[i].Length - 8) == ".map.gbx"){
               openEditor(maps[i]);
               while(!newRun())
               {
                  yield();
               }
               SaveAndExitMap(maps[i]);
            }
         }
         validateFolder = "";
      }
   }
}

bool newRun(){
   auto GhostData = MLFeed::GetGhostData();
   if (GhostData !is null && GhostData.Ghosts_V2 !is null && GhostData.NbGhosts != 0) {
      auto lastGhost = @GhostData.Ghosts_V2[GhostData.NbGhosts - 1];
      if (lastGhostId != lastGhost.IdName) {
         lastGhostId = lastGhost.IdName;
         if (lastGhost.IsLocalPlayer) {
            return(true);
         }
      }
   }
   return false;
}