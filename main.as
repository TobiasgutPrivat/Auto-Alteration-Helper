const string PluginName = "Alteration Helper";
string validateFolder;


void Main() {
   while(true){
      yield();
   
      if (validateFolder != ""){
         array<string> maps = IO::IndexFolder(validateFolder,true);
         for (uint i = 0; i < maps.Length; i++)
         {
            if(maps[i].SubStr(maps[i].Length - 8) == ".map.gbx"){
               openEditor(maps[i]);
               CGameCtnEditorFree@ editor = cast<CGameCtnEditorFree>(cast<CTrackMania>(GetApp()).Editor);
               editor.SwitchToValidationFromScript_OnOk();
               awaitValidation();
               // TODO optional auto exit (waits anyways)
               SaveAndExitMap(maps[i].SubStr(MapsFolder.Length,maps[i].Length - MapsFolder.Length));
            }
         }
         validateFolder = "";
      }
   }
}

void awaitValidation(){
   while(true)
   {
      if (cast<CGameCtnApp>(GetApp()).CurrentPlayground != null && cast<CGameCtnApp>(GetApp()).Editor != null){
         if (cast<CGameCtnApp>(GetApp()).CurrentPlayground.UIConfigs[0].UISequence == CGamePlaygroundUIConfig::EUISequence::EndRound){
            return;
         }
         print(cast<CGameCtnApp>(GetApp()).CurrentPlayground.UIConfigs[0].UISequence);
      }
      yield();
   }
}