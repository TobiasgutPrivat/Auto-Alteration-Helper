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
    configurationPaths = IO::IndexFolder(IO::FromStorageFolder("") + scriptFolder,true);
    alterationPaths = IO::IndexFolder(IO::FromStorageFolder("") + alterationFolder,true);
}

void renderJsonFiles(){
    if (UI::Button("Reload")){
        loadConfigurations();
    };
    UI::Separator();
    UI::Text("Configurations: ");
    for (uint i = 0; i < configurationPaths.Length; i++)
    {
        if((configurationPaths[i].SubStr(configurationPaths[i].Length - 5) == ".json") && !(configurationPaths[i].SubStr(configurationPaths[i].Length - 16) == ".alteration.json")){

            if (UI::Button("Run " + getFileName(configurationPaths[i]))){
                print(configurationPaths[i]);
                runPath = configurationPaths[i];
            };
        }
    }
    UI::Text("Alterations: ");
    for (uint i = 0; i < alterationPaths.Length; i++)
    {
        if(alterationPaths[i].SubStr(alterationPaths[i].Length - 5) == ".json"){
            if (UI::Button("Run " + getFileName(alterationPaths[i]))){
                print(alterationPaths[i]);
                runAlteration = alterationPaths[i];
            };
        }
    }
}

string getFileName(string path)
{
    string[] parts = path.Split("/");
    string fileName = parts[parts.Length - 1];
    return(fileName.Replace(".json", ""));
}