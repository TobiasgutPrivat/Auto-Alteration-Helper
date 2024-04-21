namespace EditorMgt
{

    bool SaveMapSameName(CGameCtnEditorFree@ editor) {
        string fileName = editor.Challenge.MapInfo.FileName;
        _restoreMapName = editor.Challenge.MapName;
        if (fileName.Length == 0) {
            return false;
        }
        editor.PluginMapType.SaveMap(fileName + "test");
        startnew(_RestoreMapName);
        return true;
    }

    string _restoreMapName;
    // set after calling SaveMapSameName
    void _RestoreMapName() {
        yield();
        if (_restoreMapName.Length == 0) return;
        auto editor = cast<CGameCtnEditorFree>(GetApp().Editor);
        editor.Challenge.MapName = _restoreMapName;
    }

    void SaveAndExitMap() {
        auto app = cast<CTrackMania>(GetApp());
        auto editor = cast<CGameCtnEditorFree>(app.Editor);
        if (!SaveMapSameName(editor)) {
            return;
        }
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

