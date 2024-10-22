void SaveAndExitMap(string fileName) {
    auto app = cast<CTrackMania>(GetApp());
    auto editor = cast<CGameCtnEditorFree>(app.Editor);
    editor.PluginMapType.SaveMap(fileName);
    print("savemap");
    AwaitEditorReadyForRequest();
    print("ReadyForRequest");
    app.BackToMainMenu();
    AwaitReturnToMenu();
}

void AwaitEditorReadyForRequest() {
    CGameCtnEditorFree@ editor = cast<CGameCtnEditorFree>(cast<CTrackMania>(GetApp()).Editor);
    while (!editor.PluginMapType.IsEditorReadyForRequest) yield();
    return;
}

void AwaitReturnToMenu() {
    auto app = cast<CTrackMania>(GetApp());
    while (app.Switcher.ModuleStack.Length == 0 || cast<CTrackManiaMenus>(app.Switcher.ModuleStack[0]) is null) {
        yield();
    }
    while (!app.ManiaTitleControlScriptAPI.IsReady) {
        yield();
    }
}

void openEditor(string fileName) {
    cast<CTrackMania>(GetApp()).ManiaTitleControlScriptAPI.EditMap(fileName, "", "");
    AwaitEditor();
}

void AwaitEditor() {
    auto app = cast<CTrackMania>(GetApp());
    while (cast<CGameCtnEditorFree>(app.Editor) is null) yield();
    auto editor = cast<CGameCtnEditorFree>(GetApp().Editor);
    while (!editor.PluginMapType.IsEditorReadyForRequest) yield();
    print("actually opened");
}

string getCurrentSelectedBlockName(){
    auto editor = cast<CGameCtnEditorFree>(cast<CTrackMania>(GetApp()).Editor);
    try{
        return(editor.PluginMapType.Inventory.CurrentSelectedNode.Name);
    } catch{
        return "";
    }
}

bool SaveMapSameName(CGameCtnEditorFree@ editor) {
    string fileName = editor.Challenge.MapInfo.FileName;
    _restoreMapName = editor.Challenge.MapName;
    if (fileName.Length == 0) {
        print("Map must be saved, first.");
        return false;
    }
    editor.PluginMapType.SaveMap(fileName);
    startnew(_RestoreMapName);
    print('saved map');
    return true;
}

string _restoreMapName;
// set after calling SaveMapSameName
void _RestoreMapName() {
    yield();
    if (_restoreMapName.Length == 0) return;
    auto editor = cast<CGameCtnEditorFree>(GetApp().Editor);
    editor.Challenge.MapName = _restoreMapName;
    print('restored map name: ' + _restoreMapName);
}