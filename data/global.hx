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
import funkin.backend.utils.NativeAPI;
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

static var initialized:Bool = false;
static var fromGame:Bool = false; // for things you can go to through the pause screen and whatever

// DEFAULT WINDOW POSITIONS
static var winX:Int = FlxG.stage.application.window.display.bounds.width / 6;
static var winY:Int = FlxG.stage.application.window.display.bounds.height / 6;

// MONITOR RESOLUTION
static var fsX:Int = Capabilities.screenResolutionX;
static var fsY:Int = Capabilities.screenResolutionY;

// WINDOW SIZE CHANGE VAR
static var resizex:Int = Capabilities.screenResolutionX / 1.5;
static var resizey:Int = Capabilities.screenResolutionY / 1.5;

// YOSHICRAFTER ENGINE STYLE LOGS REAL
var logsScript:Script = Script.create(Paths.script("data/modules/LogsOverlay"));

static var redirectStates:Map<FlxState, String> = [
	//MainMenuState => 'youtube/YTMainMenu',
	//StoryMenuState => 'youtube/YTStoryMenu',
	//FreeplayState => 'youtube/YTFreeplay'
]; 
 // not now bitch, i'll do those little menu state shit soon maybe

function new() {
	logsScript.load();
	logsScript.call("create", []);

	window.title = "Made with Codename Engine";
	var optionTube = FlxG.save.data;
	//if (optionTube.customCursor == null) optionTube.customCursor = true;

	// for the psych ui options
	if (optionTube.Splashes == null) optionTube.Splashes = 0;
	if (optionTube.PauseMusic == null) optionTube.PauseMusic = 0;
	if (optionTube.botplayOption == null) optionTube.botplayOption = false;
	if (optionTube.colouredBar == null) optionTube.colouredBar = false;
	if (optionTube.showBar == null) optionTube.showBar = false;
	if (optionTube.showTxt == null) optionTube.showTxt = false;
}

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
	var trimMyHair:String;
	return [for (line in text.split("\n")) if ((trimMyHair = StringTools.trim(line)) != "" && !StringTools.startsWith(trimMyHair, "#")) trimMyHair];
}

function postStateSwitch() {
	logsScript.call("postStateSwitch", []);
	Framerate.debugMode = 1;
}

function postUpdate(delta:Float)
{
	// here for debugging purposes i think
	#if windows if (FlxG.keys.justPressed.F6) NativeAPI.allocConsole(); #end // CONSOLE
	if (FlxG.keys.justPressed.F5) FlxG.resetState(); // RESETTING STATES
	//

	if (FlxG.keys.justPressed.F7) logsScript.call("toggle", []);
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
        final fileName = file.split('\\');
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
    FlxG.camera.bgColor = 0xFF000000;

	window.title = "Friday Night Funkin': YouTube Animation Peril - v1.0 DEMO";
	window.setIcon(Image.fromBytes(Assets.getBytes(Paths.image('ui/windowicons/default16'))));

	if (!initialized) {
		initialized = true;
	} else {
		for (redirectState in redirectStates.keys())
			if (FlxG.game._requestedState is redirectState)
				FlxG.game._requestedState = new ModState(redirectStates.get(redirectState));
	}
}
