import funkin.backend.scripting.Script;
import openfl.system.Capabilities;
import funkin.backend.utils.NdllUtil;
import lime.graphics.Image;
import lime.ui.FileDialog;
import lime.ui.FileDialogType;
import openfl.net.FileReference;
import flixel.system.ui.FlxSoundTray;
import funkin.backend.system.framerate.Framerate;
import flixel.util.FlxSpriteUtil;
import flixel.util.FlxGradient;
import funkin.backend.MusicBeatState;
import funkin.options.Options;
import Xml;
import haxe.Json;
import sys.FileSystem;
import sys.io.File;
import funkin.options.OptionsMenu;
import funkin.editors.charter.Charter;
import funkin.editors.EditorTreeMenu;
import funkin.options.TreeMenu;

#if linux
@:cppInclude('./external/gamemode_client.h')
@:cppFileCode('
	#define GAMEMODE_AUTO
')
#end

// ndll by ne_eo, thx! (oh and check out mario madness v2 its great)
static var hideIcon = NdllUtil.getFunction('ndll-mario', 'hide_window_icon', 0);
static var showIcon = NdllUtil.getFunction('ndll-mario', 'show_window_icon', 0);

// YOSHICRAFTER ENGINE STYLE LOGS REAL
var logsScript:Script = Script.create(Paths.script("data/modules/LogsOverlay"));
logsScript.load();
logsScript.call("create", []);

static var initialized:Bool = false;
static var fromGame:Bool = false; // for things you can go to through the pause screen and whatever

/* 
static var redirectStates:Map<FlxState, String> = [
	MainMenuState => 'youtube/YTMainMenu',
	StoryMenuState => 'youtube/YTStoryMenu',
	FreeplayState => 'youtube/YTFreeplay'
]; 
*/ // not now bitch, i'll do those little menu state shit soon maybe

static function convertTime(steps:Float, beats:Float, sections:Float):Float {
	return ((Conductor.stepCrochet * steps) / 1000 + (Conductor.stepCrochet * (beats * 4)) / 1000 + (Conductor.stepCrochet * (sections * 16)) / 1000) - 0.01;
}

static function getInnerData(xml:Xml) {
	var it = xml.iterator();
	if (!it.hasNext()) return null;
	var v = it.next();
	if (it.hasNext()) {
		var n = it.next();
		if (v.nodeType == Xml.PCData && n.nodeType == Xml.CData && StringTools.trim(v.nodeValue) == "")
		{
			if (!it.hasNext()) return n.nodeValue;
			var n2 = it.next();
			if (n2.nodeType == Xml.PCData && StringTools.trim(n2.nodeValue) == "" && !it.hasNext()) return n.nodeValue;
		}
		return null;
	}
	if (v.nodeType != Xml.PCData && v.nodeType != Xml.CData) return null;
	return v.nodeValue;
}

static function gradientText(text:FlxText, colors:Array<FlxColor>)
	return FlxSpriteUtil.alphaMask(text, FlxGradient.createGradientBitmapData(text.width, text.height, colors), text.pixels);

static function coolText(text:String):Array<String>
{
	var trim:String;
	return [for (line in text.split("\n")) if ((trim = StringTools.trim(line)) != "" && !StringTools.startsWith(trim, "#")) trim];
}

function new() {
	// for the psych ui options
	if (FlxG.save.data.Splashes == null) FlxG.save.data.Splashes = 0;
	if (FlxG.save.data.PauseMusic == null) FlxG.save.data.PauseMusic = 0;
	if (FlxG.save.data.botplayOption == null) FlxG.save.data.botplayOption = false;
	if (FlxG.save.data.colouredBar == null) FlxG.save.data.colouredBar = false;
	if (FlxG.save.data.showBar == null) FlxG.save.data.showBar = false;
	if (FlxG.save.data.showTxt == null) FlxG.save.data.showTxt = false;
}

function postStateSwitch() {
	logsScript.call("postStateSwitch", []);
	Framerate.debugMode = 0;
}

function postUpdate(delta:Float)
{
	// here for debugging purposes i think
	if (FlxG.keys.justPressed.F6) NativeAPI.allocConsole(); // CONSOLE
	if (FlxG.keys.justPressed.F5) FlxG.resetState(); // RESETTING STATES
	//

	if (FlxG.keys.justPressed.F6) logsScript.call("toggle", []);
	logsScript.call("update", [delta]);
}

function onDestroy() {
	logsScript.call("onDestroy", []);
	logsScript.destroy();
}

function psychConverter()
{
	var fDial = new FileDialog();
	fDial.onSelect.add((file) -> {
        var fileName = file.split('\\');
		fileName = fileName[fileName.length - 1].split('.');
		fileName = fileName[fileName.length - 2];
		var json = CoolUtil.parseJsonString(File.getContent(file));
		var xmlNew = '<!DOCTYPE codename-engine-character> <!-- converted using WizardMantis\' Psych2CNE conversion tool, just to make it simpler -->\n<character x="'
			+ json.position[0]
			+ '" y="'
			+ json.position[1]
			+ '" icon="'
			+ json.healthicon
			+ '" flipX="'
			+ json.flip_x
			+ '" camx="'
			+ json.camera_position[0]
			+ '" camy="'
			+ json.camera_position[1]
			+ '" holdTime="'
			+ json.sing_duration
			+ '" scale="'
			+ json.scale
			+ '">\n';
		for (i in 0...json.animations.length) {
			xmlNew += '\t<anim name="'
				+ json.animations[i].anim + '" anim="' + json.animations[i].name + '" fps="' + json.animations[i].fps + '" loop="' + json.animations[i].loop
					+ '" x="'
					+ (json.animations[i].offsets[0] / json.scale)
					+ '" y="'
					+ (json.animations[i].offsets[1] / json.scale)
					+ '"';
			if (json.animations[i].indices.length > 0) xmlNew += ' indices="' + json.animations[i].indices + '"/>\n'; // note to self fix indices to not have brackets :(
			else xmlNew += '/>\n';
		}
		xmlNew += '</character>';
		new FileReference().save(xmlNew, fileName + '.xml');
	});
	fDial.browse(FileDialogType.OPEN, 'json', null, 'open a psych character json file');
}

function preStateSwitch() {
	window.title = "Friday Night Funkin': YouTube Animation Peril - v1.0 DEMO";
	window.setIcon(Image.fromBytes(Assets.getBytes(Paths.image('ui/windowsicons/default16'))));

	for (redirectState in redirectStates.keys()) if (FlxG.game._requestedState is redirectState)
			FlxG.game._requestedState = new ModState(redirectStates.get(redirectState));
}
