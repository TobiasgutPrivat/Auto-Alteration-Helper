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
        //TODO Add available Configurations
        UI::Text("Enter Configuration FileName");
        ConfigurationPath = UI::InputText("##ConfigurationPath", ConfigurationPath, UI::InputTextFlags::None);
        UI::SameLine();
        if (UI::Button("Enter")){
            //Start Alterationprocess
            runFromPath(IO::FromStorageFolder(ConfigurationPath) + ".json");
        };  
    };
    UI::Separator();
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