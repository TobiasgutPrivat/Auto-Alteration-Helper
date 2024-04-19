const string PluginName = "Alteration Automation";
bool showInterface;

string commandInput;

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
        commandInput = UI::InputText("##Command", commandInput, UI::InputTextFlags::None);
        UI::SameLine();
        if (UI::Button("Enter")){
            runCommand(commandInput);
        };  
    }
    UI::End();
}