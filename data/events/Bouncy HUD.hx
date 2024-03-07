
var bounce = false;
var intensity = 10;

function onEvent(boop) {
   if (boop.event.name == "Bouncy HUD") {
     bounce = boop.event.params[0];
     intensity = boop.event.params[1];
   }
}

function stepHit() {
    if (bounce){
      if (curStep % 4 == 0) {
          FlxTween.tween(camHUD, {y: 0}, 0.2, {ease: FlxEase.circOut});
      }
      if (curStep % 4 == 2) {
          FlxTween.tween(camHUD, {y: intensity}, 0.2, {ease: FlxEase.sineIn});
      }
    }
}



