const string alterationFolder = "Alterations\\";
const string scriptFolder = "Scripts\\";
const string PluginName = "Auto Alteration";
// auto app = cast<CTrackMania>(GetApp());
array<string> configurationPaths = IO::IndexFolder(IO::FromStorageFolder("") + scriptFolder,true);
array<string> alterationPaths = IO::IndexFolder(IO::FromStorageFolder("") + alterationFolder,true);
string runPath;
string runAlteration;

void Main() {
   while(true){
      if(runPath != "")
      {
         runAction(loadJsonFile(runPath));
         runPath = "";
      }
      if(runAlteration != "")
      {
         AlterationSet(runAlteration).run();
         runAlteration = "";
      }
      yield();
   }
}