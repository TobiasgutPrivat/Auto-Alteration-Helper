const string PluginName = "Alteration Helper";
string validateFolder;

void Main() {
   while(true){
      yield();
      if (validateFolder != ""){
         array<string> maps = IO::IndexFolder(validateFolder,true);
         //TODO
         validateFolder = "";
      }
   }
}