// bool saveMap(string fileName) {
//     print(fileName);
//     CGameCtnEditorFree@ editor = cast<CGameCtnEditorFree>(GetApp().Editor);
//     print((editor is null));
//     editor.PluginMapType.SaveMap(fileName);
//     startnew(CoroutineFunc(_awaitsave()));
//     print("saved");
//     return true;
// }
//     // set after calling SaveMapSameName
//     void _awaitsave() {
//         yield();
//         auto editor = cast<CGameCtnEditorFree>(GetApp().Editor);
//         print((editor is null));
//     }

bool saveMap(string fileName) {
    CGameCtnEditorFree@ editor = cast<CGameCtnEditorFree>(GetApp().Editor);
    print(editor.Challenge.MapName);
    print(fileName);
    editor.PluginMapType.SaveMap(fileName);
    startnew(_RestoreMapName);
    print("done");
    return true;
}

string _restoreMapName;
// set after calling SaveMapSameName
void _RestoreMapName() {
    yield();
    auto editor = cast<CGameCtnEditorFree>(GetApp().Editor);
    print(editor.Challenge.MapName);
    print("done as well");
}


void BackToMainMenu(){
    app.BackToMainMenu();
} 

CGameCtnEditorFree getCurrentEditor(){
    return cast<CGameCtnEditorFree>(app.Editor);
}

void openEditor(string fileName) {
    app.ManiaTitleControlScriptAPI.EditMap(fileName, "", "");
    print("opened");
    startnew(_AwaitEditor);
}

void _AwaitEditor() {
    auto app = cast<CTrackMania>(GetApp());
    while (cast<CGameCtnEditorFree>(app.Editor) is null) sleep(5000);
    auto editor = cast<CGameCtnEditorFree>(GetApp().Editor);
    while (!editor.PluginMapType.IsEditorReadyForRequest) sleep(5000);
}

