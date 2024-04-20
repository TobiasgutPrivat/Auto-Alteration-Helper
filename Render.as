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
    if (UI::Begin(PluginName, showInterface, UI::WindowFlags::AlwaysAutoResize)) {
        renderJsonFiles();
        // UI::Text("Enter Configuration FileName");
        // ConfigurationPath = UI::InputText("##ConfigurationPath", ConfigurationPath, UI::InputTextFlags::None);
        // UI::SameLine();
        // if (UI::Button("Enter")){
        //     //Start Alterationprocess
        //     runFromPath(IO::FromStorageFolder(ConfigurationPath) + ".json");
        // };  
    };
    // UI::Separator();
    UI::Text("Response:");
    for(uint i = 0; i < response.Length; i++){
        UI::Text(response[i]);
    }
    if (UI::Button("Clear")){
        response = Json::Array();
    };  
    UI::End();
}

void sendError(string message){
    print("Error: " + message);
    response.Add("Error: " + message);
}
void sendResponse(string message){
    response.Add(message);
}

void renderJsonFiles()
{
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
                runFromPath(files[i]);
            };  
        }
    }
    UI::Separator();
}