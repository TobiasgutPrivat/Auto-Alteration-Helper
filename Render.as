const string PluginName = "Alteration Automation";
bool showInterface;
Json::Value response = Json::Array();

string ConfigurationPath;

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
        renderResponse();
    };
    UI::End();
}


void renderResponse(){
    UI::Text("Response:");
    for(uint i = 0; i < response.Length; i++){
        UI::Text(response[i]);
    }
    if (UI::Button("Clear")){
        response = Json::Array();
    };  
}

void renderJsonFiles(){
    UI::Text("Available Configurations:");
    array<string> files = IO::IndexFolder(IO::FromStorageFolder(""),true);

    for (uint i = 0; i < files.Length; i++)
    {
        if(files[i].SubStr(files[i].Length - 5) == ".json"){
            string[] parts = files[i].Split("/");
            string fileName = parts[parts.Length - 1];
            string confname = fileName.Replace(".json", "");
            UI::Text(confname);
            UI::SameLine();
            if (UI::Button("Run")){
                try {
                    runFromPath(files[i]);
                } catch { 
                    response.Add("Error: " + getExceptionInfo());
                }
            };  
        }
    }
    UI::Separator();
}