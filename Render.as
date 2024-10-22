bool showInterface = true;
string MapsFolder = IO::FromUserGameFolder("Maps\\");
string folderInput;
string placeBlock;

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
        UI::InputText(" ",getCurrentSelectedBlockName());//articles
        UI::Separator();
        if (UI::Button("Unvalidate")){
            CGameCtnEditorFree@ editor = cast<CGameCtnEditorFree>(cast<CTrackMania>(GetApp()).Editor);
            editor.PluginMapType.UnvalidateGameplayInfo();
        };
        UI::Separator();
        if (UI::Button("Get Inventory")){
            exportInventory();
        };
        UI::Text("Storage Folder");
        UI::InputText("  ",IO::FromStorageFolder(""));//articles
        
        // if (!validating){
        //     if (UI::Button("Fast Validate")){
        //         validateFolder = MapsFolder + folderInput;
        //     };
        //     UI::Text(MapsFolder);
        //     UI::SameLine();
        //     folderInput = UI::InputText("  ",folderInput);
        // } else {
        //     if (UI::Button("Stop Validate")){
        //         validating = false;
        //     };            
        // }
        // if (!goNext && validating)
        // {
        //     if (UI::Button("Load Next Map")){
        //         goNext = true;
        //     };
        // }
    };
    UI::End();
}