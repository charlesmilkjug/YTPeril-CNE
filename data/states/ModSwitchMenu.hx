function create()
{var bg = new FlxSprite(0, 0).makeSolid(FlxG.width, FlxG.height, 0xFF490000);
		bg.updateHitbox();
		bg.scrollFactor.set();
		add(bg);

		bg.alpha = 0;
		FlxTween.tween(bg, {alpha: 0.5}, 0.25, {ease: FlxEase.cubeOut});
}