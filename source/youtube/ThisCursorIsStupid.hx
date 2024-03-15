class ThisCursorIsStupid extends flixel.FlxSprite
{
	public var mouseDoingInterest:Bool = false;
	public var shitDisabled:Bool = false;
	public var imWaitingBro:Bool = false;
	public var lockItOn:Bool = true;
	public var justUsingMyCursorsCamNoBigDeal:FlxCamera = new FlxCamera();

	public function new(sizex:Float, sizey:Float) {
		frames = Paths.getSparrowAtlas('ui/cursor');
		animation.addByPrefix("idle", "idle0", 1, true);
		animation.addByPrefix("idleClick", "idleClick", 1, true);
		animation.addByPrefix("hand", "hand0", 1, true);
		animation.addByPrefix("handClick", "handClick", 1, true);
		animation.addByPrefix("waiting", "waiting", 8, true);
		animation.addByPrefix("disabledClick", "disabledClick", 1, true);
		animation.addByPrefix("disabled", "disabled", 1, true);
		animation.play("idle");
		scrollFactor.set(0, 0); // you better not move around, mouse
		scale.set(sizex, sizey);
		updateHitbox();
	}

	override function update(elapsed:Float) {
		if (!shitDisabled) FlxG.mouse.visible = false;

		if (lockItOn) setPosition(FlxG.mouse.getScreenPosition().x - 7.5, FlxG.mouse.getScreenPosition().y - 7.5);

		if (imWaitingBro) animation.play("waiting");
		else {
			animation.play(mouseDoingInterest ? "hand" : "idle", true);
			if (shitDisabled) {
				animation.play("disabled", true);
				if (FlxG.mouse.pressed) animation.play("disabledClick", true);
				if (FlxG.mouse.justPressed) FlxG.sound.play(Paths.sound('xp/windowsXPding'), 0.6);
			} else {
				if (FlxG.mouse.pressed) animation.play(mouseDoingInterest ? "handClick" : "idleClick", true);
				if (FlxG.mouse.justPressed) FlxG.sound.play(Paths.sound('xp/windowsXPclick'), 1);
			}
		}
	}
}