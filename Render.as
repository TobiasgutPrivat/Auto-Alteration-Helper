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
        UI::InputText("selectedBlock",EditorLib::getCurrentSelectedBlockName());
    };
    UI::End();
}