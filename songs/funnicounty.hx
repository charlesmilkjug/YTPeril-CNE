function onCountdown(countdownEvent) 
	{
	countdownEvent.scale = 1;
	}
	function onPostCountdown(countdownEvent) {
		if (countdownEvent.sprite != null) {
			countdownEvent.sprite.cameras = [camHUD];

		countdownEvent.spriteTween.cancel();
		FlxTween.tween(countdownEvent.sprite, {alpha: 0}, Conductor.crochet / 1000, {ease: FlxEase.cubeInOut});
	}
}
	