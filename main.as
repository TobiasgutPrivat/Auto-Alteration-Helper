auto app = cast<CTrackMania>(GetApp());
array<string> files = IO::IndexFolder(IO::FromStorageFolder(""),true);
string runPath;

void Main() {
   while(true){
      if(runPath != "")
      {
         runConfFile(runPath);
         runPath = "";
      }
      yield();
   }
}