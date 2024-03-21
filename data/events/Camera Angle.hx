function onEvent(eventEvent)
    if (eventEvent.event.name == "Camera Angle") {
FlxG.camera.angle = Std.parseFloat(eventEvent.event.params[0]);
            FlxTween.tween(FlxG.camera, {angle: 0}, 0.4, {ease: FlxEase.circOut});
    }