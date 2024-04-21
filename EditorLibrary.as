namespace EditorMgt
{
    bool mapopened = false;
    bool mapsaved = false;
    void SaveAndExitMap(string fileName) {
        auto app = cast<CTrackMania>(GetApp());
        auto editor = cast<CGameCtnEditorFree>(app.Editor);
        editor.PluginMapType.SaveMap(fileName);
        AwaitEditorReadyForRequest();
        app.BackToMainMenu();
        AwaitReturnToMenu();
    }

    void AwaitEditorReadyForRequest() {
        CGameCtnEditorFree@ editor = cast<CGameCtnEditorFree>(app.Editor);
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
        mapsaved = true;
    }

    void openEditor(string fileName) {
        app.ManiaTitleControlScriptAPI.EditMap(fileName, "", "");
        AwaitEditor();
    }

    void AwaitEditor() {
        auto app = cast<CTrackMania>(GetApp());
        while (cast<CGameCtnEditorFree>(app.Editor) is null) yield();
        auto editor = cast<CGameCtnEditorFree>(GetApp().Editor);
        while (!editor.PluginMapType.IsEditorReadyForRequest) yield();
        print("actually opened");
        mapopened = true;
    }
}

