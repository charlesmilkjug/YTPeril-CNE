function new(){
  FlxG.mouse.visible = false;

  CoolUtil.playMenuSong();
  Conductor.bpm = 128;
}

function postCreate() {
FlxG.camera.followLerp = 0.01;
   FlxG.camera.zoom -= 0.1;
   Options.flashingMenu = false;
	var moreVersionShit:FunkinText = new FunkinText(5, 634, 0, '');
	moreVersionShit.scrollFactor.set();
	add(moreVersionShit);
	moreVersionShit.text = "YT Animation Peril v1.0 [DEMO]"; // i sadly cant extend the original versionShit text actually
	// so i had to work around that like this.
}

function postUpdate(elapsed) {
    menuItems.forEach(function(a:FlxSprite){
        a.x -= 320;
    });
}