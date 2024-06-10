import flixel.text.FlxTextAlign;
import flixel.text.FlxTextBorderStyle;
import flixel.ui.FlxBar;
import flixel.ui.FlxBarFillDirection;

public var songLength:Float = inst.length;
public var timeLeft:Float = Conductor.songPosition / songLength;




function postCreate() {
timeTxt = new FlxText(-405, 688, FlxG.width, "sus");
timeTxt.setFormat(Paths.font("roboto/Roboto-Regular.ttf"), 20, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
timeTxt.camera = camHUD;
timeBarBG = new FlxSprite(0, FlxG.height-22).makeSolid(1, 1, 0xFF000000);
timeBarBG.setGraphicSize(FlxG.width, 22);
timeBarBG.scrollFactor.set();
timeBarBG.updateHitbox();
timeBar = new FlxBar(timeBarBG.x + 5, timeBarBG.y - 25, FlxBarFillDirection.LEFT_TO_RIGHT, Std.int(timeBarBG.width - 20), 7.5, null, '', 0, 1);
timeBar.scrollFactor.set();
timeBar.createFilledBar(0x60666666, 0xFFFF0000);
timeBar.numDivisions = 80000;
timeBar.unbounded = true;
timeBar.screenCenter(FlxAxes.X);
timeBar.camera = camHUD;
timeBarBG.camera = camHUD;
pause = new FlxSprite(0, 650).loadGraphic(Paths.image('game/ui/pause'));
pause.cameras = [camHUD];
pause.scale.set(0.5, 0.5);
nextVideo = new FlxSprite(50, 650).loadGraphic(Paths.image('game/ui/nextVideo'));
nextVideo.cameras = [camHUD];
nextVideo.scale.set(0.5, 0.5);
sound = new FlxSprite(100, 650).loadGraphic(Paths.image('game/ui/sound'));
sound.cameras = [camHUD];
sound.scale.set(0.5, 0.5);
//timeBar.alpha = 0.75;
//add(timeBarBG);
add(pause);
add(nextVideo);
add(sound);
add(timeTxt);
add(timeBar);
healthBar.y = healthBar.y -30;
scoreTxt.visible = false;
healthBarBG.visible = false;
iconP1.y = iconP1.y -30;
iconP2.y = iconP2.y -30;
missesTxt.y = missesTxt.y -25;
accuracyTxt.y = accuracyTxt.y -25;
}

function update(elapsed) {
}


function stepHit(curStep) {
    timeLeft = Conductor.songPosition / songLength;
    timeBar.percent = (timeLeft)*100;
    var timeElapsed = Std.int(Conductor.songPosition / 1000);
    var totalSongTime = Std.int(songLength / 1000);
    var secondsElapsed = CoolUtil.addZeros(Std.string(timeElapsed % 60), 2);
    var minutesElapsed = Std.int(timeElapsed / 60);
    var secondsTotal = CoolUtil.addZeros(Std.string(totalSongTime % 60), 2);
    var minutesTotal = Std.int(totalSongTime / 60);
    timeTxt.text = "0:00" + " / " + minutesTotal + ":" + secondsTotal;

    if (curStep > 0)
        timeTxt.text = minutesElapsed + ":" + secondsElapsed + " / " + minutesTotal + ":" + secondsTotal;
    //trace(timeLeft);
}


