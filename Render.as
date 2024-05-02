bool showInterface = true;
string MapsFolder = IO::FromUserGameFolder("Maps\\");
string folderInput;

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
        UI::Text("Selected Block");
        UI::InputText(" ",getCurrentSelectedBlockName());
        UI::Separator();
        if (UI::Button("Fast Validate")){
            validateFolder = MapsFolder + folderInput;
        };
        UI::Text(MapsFolder);
        UI::SameLine();
        folderInput = UI::InputText("  ",folderInput);
    };
    UI::End();
}