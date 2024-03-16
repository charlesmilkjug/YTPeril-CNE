class ThisCursorIsStupid extends flixel.FlxSprite
{
	public var mouseDoingInterest:Bool = false;
	public var shitDisabled:Bool = false;
	public var imWaitingBro:Bool = false;
	public var lockItOn:Bool = false;
	public var justUsingMyCursorsCamNoBigDeal:FlxCamera = new FlxCamera();

	public function new(sizex:Float, sizey:Float, canon:FlxCamera) {
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
      if (canon == null) cameras = [FlxG.camera];
      else cameras = [canon];
		scale.set(sizex, sizey);

		updateHitbox();
	}

	override function update(elapsed:Float) {
		if (FlxG.save.data.customCursor) FlxG.mouse.visible = true;
		else FlxG.mouse.visible = true;

		visible = FlxG.save.data.customCursor;

		if (lockItOn) {
         x = FlxG.mouse.getScreenPosition(canon).x;
         y = FlxG.mouse.getScreenPosition(canon).y;
      }

		if (imWaitingBro) animation.play("waiting", true);
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