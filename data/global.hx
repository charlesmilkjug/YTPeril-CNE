import funkin.backend.scripting.Script;
import openfl.system.Capabilities;
import funkin.backend.utils.NdllUtil;
import lime.graphics.Image;

// ndll by ne_eo, thx! (oh and check out mario madness v2 its great)
static var hideIcon = NdllUtil.getFunction('ndll-mario', 'hide_window_icon', 0);
static var showIcon = NdllUtil.getFunction('ndll-mario', 'show_window_icon', 0);

var logsScript:Script = Script.create(Paths.script("data/modules/LogsOverlay"));
logsScript.load();
logsScript.call("create", []);

function new() {
// for the psych ui options,.
    if (FlxG.save.data.Splashes == null) FlxG.save.data.Splashes = 0;
    if (FlxG.save.data.PauseMusic == null) FlxG.save.data.PauseMusic = 0;
    if (FlxG.save.data.botplayOption == null) FlxG.save.data.botplayOption = false;
    if (FlxG.save.data.colouredBar == null) FlxG.save.data.colouredBar = false;
    if (FlxG.save.data.showBar == null) FlxG.save.data.showBar = false;
    if (FlxG.save.data.showTxt == null) FlxG.save.data.showTxt = false;
}

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

function preStateSwitch() {
    window.title = "Friday Night Funkin': YouTube Animation Peril - DEMO";
    window.setIcon(Image.fromBytes(Assets.getBytes(Paths.image('icon16'))));

    for (redirectState in redirectStates.keys())
        if (FlxG.game._requestedState is redirectState)
            FlxG.game._requestedState = new ModState(redirectStates.get(redirectState));
}