import youtube.ThisCursorIsStupid;
import funkin.backend.system.framerate.Framerate;

var myCursor:ThisCursorIsStupid; // lol

function postCreate() {
    FlxTween.tween(Framerate.offset, {y: pathBG.height + 5}, .75, {ease: FlxEase.elasticOut});

	myCursor = new ThisCursorIsStupid(0.4, 0.4);
	add(myCursor);

    CoolUtil.playMusic(Paths.music("breakfast"), false, 1, true, 95);

    background = new FlxSprite(0, 0).loadGraphic(Paths.image('menus/menuDesat'));
    background.color = FlxColor.RED;
    background.screenCenter();
	background.scrollFactor.set();
    insert(1, background);
}
