const string PluginName = "Alteration Automation";
bool showInterface = true;

void RenderMenu() { 
    if (UI::MenuItem(PluginName)) {
        if (showInterface) {
            showInterface = false;
        } else {
            showInterface = true;
        }
    }
}

void RenderInterface() {
    if (!showInterface) {
        return;
    }
    if (UI::Begin(PluginName, showInterface, UI::WindowFlags::AlwaysAutoResize)) {
        renderJsonFiles();
    };
    UI::End();
}

void loadConfigurations()
{
    files = IO::IndexFolder(IO::FromStorageFolder(""),true);
}

void renderJsonFiles(){
    if (UI::Button("Reload")){
        loadConfigurations();
    };
    UI::Separator();
    UI::Text("Configurations: ");
    for (uint i = 0; i < files.Length; i++)
    {
        if(files[i].SubStr(files[i].Length - 5) == ".json"){
            string[] parts = files[i].Split("/");
            string fileName = parts[parts.Length - 1];
            string confname = fileName.Replace(".json", "");
            if (UI::Button("Run " + confname)){
                print(files[i]);
                runConfFile(files[i]);
            };
        }
    }
}