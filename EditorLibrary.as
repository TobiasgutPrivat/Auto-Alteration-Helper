namespace EditorMgt
{
    void SaveAndExitMap(string fileName) {
        auto app = cast<CTrackMania>(GetApp());
        auto editor = cast<CGameCtnEditorFree>(app.Editor);
        editor.PluginMapType.SaveMap(fileName);
        startnew(_AwaitEditorReadyForRequest);
        app.BackToMainMenu();
        startnew(_AwaitReturnToMenu);
    }

    void _AwaitEditorReadyForRequest() {
        CGameCtnEditorFree@ editor = cast<CGameCtnEditorFree>(app.Editor);
        while (!editor.PluginMapType.IsEditorReadyForRequest) yield();
        return;
    }

    void _AwaitReturnToMenu() {
        auto app = cast<CTrackMania>(GetApp());
        while (app.Switcher.ModuleStack.Length == 0 || cast<CTrackManiaMenus>(app.Switcher.ModuleStack[0]) is null) {
            yield();
        }
        while (!app.ManiaTitleControlScriptAPI.IsReady) {
            yield();
        }
    }


    void openEditor(string fileName) {
        app.ManiaTitleControlScriptAPI.EditMap(fileName, "", "");
        startnew(_AwaitEditor);
    }

    void _AwaitEditor() {
        auto app = cast<CTrackMania>(GetApp());
        while (cast<CGameCtnEditorFree>(app.Editor) is null) sleep(5000);
        auto editor = cast<CGameCtnEditorFree>(GetApp().Editor);
        while (!editor.PluginMapType.IsEditorReadyForRequest) sleep(5000);
        print("actually opened");
    }
}

