//
import funkin.options.OptionsMenu;
import flixel.text.FlxTextBorderStyle;
import funkin.menus.ModSwitchMenu;
import funkin.editors.EditorPicker;
import funkin.backend.utils.DiscordUtil;
import funkin.backend.MusicBeatState;
import funkin.menus.credits.CreditsMain;

var options:Array<String> = [
	'story mode',
	'freeplay',
	'donate',
	'options'
];

var optionsTexts:Map<String, String> = [
	'story mode' => "Play through the story of the mod!",
	'freeplay' => "Play any song as you wish and get new scores!",
	'discord' => "Join the official YT Animation Peril Discord!",
	'donate' => "Look at the people who have worked or contributed to the mod!",
	'options' => "Adjust game settings and keybinds."
];

var menuItems:FlxTypedGroup<FlxSprite>;
var curMainMenuSelected:Int;
var curSelected:Int = curMainMenuSelected;

var menuInfomation:FlxText;
var logoBl:FlxSprite;

function create() {
	PlayState.deathCounter = 0;
	DiscordUtil.changePresence('In the Menus', "Main Menu");
	CoolUtil.playMenuSong();

	var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menus/menuBG'));
	insert(1, bg);

	var menuBack:FlxSprite = new FlxSprite().makeSolid(600, 900, FlxColor.WHITE);
	insert(1, menuBack);

	logoBl = new FlxSprite();
	logoBl.frames = Paths.getSparrowAtlas('menus/titlescreen/logo');
	logoBl.animation.addByPrefix('bump', 'logo bumpin', 24,false);
	logoBl.animation.play('bump');
	logoBl.scale.set(0.35, 0.35);
	logoBl.updateHitbox();
	logoBl.x = 175;
	logoBl.y = 0;
	logoBl.antialiasing = true;
	insert(2, logoBl);

	menuInfomation = new FlxText(305, 675, FlxG.width, "Please select an option.", 28);
	menuInfomation.setFormat("fonts/vcr.ttf", 28, FlxColor.WHITE, "center");
	menuInfomation.setBorderStyle(FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, 5, 50);
	menuInfomation.borderSize = 2.35;
	insert(3,menuInfomation);

	menuItems = new FlxTypedGroup();
	insert(2,menuItems);

	for (i=>option in options)
	{
		var menuItem:FlxSprite = new FlxSprite(0, 0);
		menuItem.frames = Paths.getSparrowAtlas('menus/mainmenu/' + option);
		menuItem.animation.addByPrefix('idle', option + " basic", 24);
		menuItem.animation.addByPrefix('selected', option + " white", 24);
		menuItem.animation.play('idle');
		menuItem.updateHitbox();
		menuItem.antialiasing = true;

		menuItem.x = 600; // - menuItem.width - (100 + (i*50));
		var dude:Float = 245 + ((menuItem.ID = i) * 117);
		menuItem.y = dude;

		menuItems.add(menuItem);
	}

var versionShit:FunkinText = new FunkinText(FlxG.width - 200, -50, 0, 'YT Animation Peril v1.0 [DEMO]\nCodename Engine v0.1.0\n[TAB] Open Mod Selection Menu\n');
		versionShit.y += versionShit.height;
		versionShit.scrollFactor.set();
		add(versionShit);

	selectedSomthin = false;
	changeItem(0);

	menuInfomation.y += 25;
	FlxTween.tween(menuInfomation, {y: menuInfomation.y - 100}, (Conductor.stepCrochet / 1000) * 8, {ease: FlxEase.expoOut});

	logoBl.alpha = 0;
	FlxTween.tween(logoBl, {alpha: 1, x: 0}, (Conductor.stepCrochet / 1000) * 6, {ease: FlxEase.expoOut});

	menuItems.forEach((item:FlxSprite) -> {
		item.x = 600 - item.width;
		if (item.ID == curSelected) FlxTween.tween(item, {x: 600 - item.width + 15}, (Conductor.stepCrochet / 1000) * 4, {ease: FlxEase.expoOut});
		else FlxTween.tween(item, {x: 600 - item.width}, (Conductor.stepCrochet / 1000) * 4, {ease: FlxEase.expoOut});
	});
	selectedSomthin = false;
}

function changeItem(change:Int = 0) {
	curSelected = FlxMath.wrap(curSelected + change, 0, menuItems.length - 1);

	FlxG.sound.play(Paths.sound("menu/scroll"));

	menuItems.forEach(function(item:FlxSprite) {
		FlxTween.cancelTweensOf(item);
		item.animation.play(item.ID == curSelected ? 'selected' : 'idle');

		item.updateHitbox();

		if (item.ID == curSelected) FlxTween.tween(item, {x: 600 - item.width + 15}, (Conductor.stepCrochet / 1000), {ease: FlxEase.quadInOut});
		else FlxTween.tween(item, {x: 600 - item.width}, (Conductor.stepCrochet / 1000) * 1.5, {ease: FlxEase.circOut});
	});

	FlxG.camera.follow(menuItems[curMainMenuSelected]);
	menuInfomation.text = optionsTexts.get(options[curSelected]);
}

function goToItem() {
	selectedSomthin = true;

	var sound:FlxSound = new FlxSound().loadEmbedded(Paths.sound("menu/confirm")); sound.volume = 1; sound.play();
	switch (options[curSelected]) {
		case "story mode":  FlxG.switchState(new StoryMenuState());
		case "freeplay": FlxG.switchState(new FreeplayState());
		case "options": FlxG.switchState(new OptionsMenu());
		case "donate": FlxG.switchState(new CreditsMain());
		default: selectedSomthin = false;
	}
}

var tottalTime:Float = 0;
var selectedSomthin:Bool = false;
function update(elapsed:Float) {
	tottalTime += elapsed;

	if (FlxG.sound.music != null) Conductor.songPosition = FlxG.sound.music.time;

	if (FlxG.keys.justPressed.SEVEN) {
		persistentUpdate = !(persistentDraw = true);
		openSubState(new EditorPicker());
	}

	if (controls.SWITCHMOD) {
		openSubState(new ModSwitchMenu());
		persistentUpdate = !(persistentDraw = true);
	}

	if (selectedSomthin) return;

	if (controls.BACK) {
		var sound:FlxSound = new FlxSound().loadEmbedded(Paths.sound("menu/cancel")); sound.volume = 1; sound.play();
		FlxG.switchState(new TitleState());
	}
	if (controls.DOWN_P) changeItem(1);
	if (controls.UP_P) changeItem(-1);
	if (controls.ACCEPT) goToItem();
		
	}

var bgTween:FlxTween;

function beatHit(curBeat:Int) {
	logoBl.animation.play('bump',true);
}

function destroy() {FlxG.camera.bgColor = FlxColor.fromRGB(0,0,0); curMainMenuSelected = curSelected;}