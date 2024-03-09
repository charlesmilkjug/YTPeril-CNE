var beginning:Bool = true;

function create() {
    black = new FlxSprite().makeSolid(FlxG.width * 2, FlxG.height * 2, FlxColor.BLACK);
	black.scrollFactor.set(0, 0);
    black.screenCenter();
    add(black);

FlxTween.tween(black, {alpha: 0}, 1.25, {ease: FlxEase.cubeOut});
}
