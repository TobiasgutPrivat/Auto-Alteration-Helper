const string PluginName = "Alteration Automation";
bool showInterface;

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
        UI::Text("Enter Configuration FilePath");
        ConfigurationPath = UI::InputText("##ConfigurationPath", ConfigurationPath, UI::InputTextFlags::None);
        UI::SameLine();
        if (UI::Button("Enter")){
            runConfiguration(ConfigurationPath);
        };  
    }
    UI::End();
}