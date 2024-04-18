import flixel.text.FlxTextBorderStyle;
import openfl.utils.Assets;

static var bg:FlxSprite;
static var songTxt:FlxText;
static var basedOnTxt:FlxText;
static var musicianTxt:FlxText;

var fontSize:Float = 24;

function onSongStart() {
	var camInfo:FlxCamera = new FlxCamera();
	camInfo.bgColor = 0x00000000;
	FlxG.cameras.add(camInfo, false);
	var info = Assets.getText(Paths.file('songs/' + PlayState.SONG.meta.name + '/info.txt')).split("\n");

	bg = new FlxSprite(-475, FlxG.height / 3).makeGraphic(325, 115, FlxColor.RED);
    bg.alpha = 0.75;

	songTxt = new FlxText(-465, bg.y + 10, 0, info[0], 25);
basedOnTxt = new FlxText(-465, bg.y + 45, 0, info[1], 25);
	musicianTxt = new FlxText(-465, bg.y + 80, 0, info[2], 25);

trace(songTxt.y + ", " + basedOnTxt.y + ", " + musicianTxt.y);

	for (i in [songTxt, basedOnTxt, musicianTxt]) i.setFormat(Paths.font("roboto/Roboto-Bold.ttf"), 24, FlxColor.WHITE, "left", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);

	for (i in [bg, songTxt, basedOnTxt, musicianTxt]) {
		i.cameras = [camInfo];
		add(i);
	}

    for (i in [bg, songTxt, basedOnTxt, musicianTxt]){
        FlxTween.tween(i, {x: i.x + 475}, 1, {ease: FlxEase.backInOut, onComplete: function(twn:FlxTween){
            FlxTween.tween(i, {x: i.x - 475}, 1, {ease: FlxEase.backInOut, startDelay: 2, onComplete: function(twn:FlxTween){ 
                i.destroy(); 
            }});
        }});
    }
}