import funkin.backend.scripting.Script;

var logsScript:Script = Script.create(Paths.script("data/modules/LogsOverlay"));
logsScript.load();
logsScript.call("create", []);

function postUpdate(delta:Float) {
    if(FlxG.keys.justPressed.F5)
        FlxG.resetState();
    
    if(FlxG.keys.justPressed.F6)
        logsScript.call("toggle", []);

    logsScript.call("update", [delta]);
}

function onDestroy() {
    logsScript.call("onDestroy", []);
    logsScript.destroy();
}
