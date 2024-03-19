import flixel.addons.display.FlxBackdrop;
import funkin.editors.ui.UISubstateWindow;
var charHasDances:Bool = false;
var backdropshit:FlxBackdrop;
var saves = FlxG.save.data;
function postCreate() {
	if(character.animation.exists("danceLeft") || character.animation.exists("danceRight") || character.isGF == true){ charHasDances = true;}
	backdropshit = new FlxBackdrop(Paths.image('editors/drawers2'));
	trace(charHasDances);

	insert(members.indexOf(character) - 1, backdropshit);
	add(backdropshit);
    backdropshit.alpha = 1;
	backdropshit.cameras = [charCamera];
	backdropshit.color = 0x113D3D3D ;
    FlxG.mouse.visible = true;
	// FlxG.sound.playMusic(Paths.music('offsetSong'), 1, true);
	Conductor.changeBPM(128.0);

	backdropshit.y = 700;
	// trace(backdropshit.x);
		characterBG.alpha = 0;
    backdropshit.x = character.x;
	backdropshit.y = character.y;


}

function update(){
	backdropshit.alpha = 0.5;
	 
	uiCamera.zoom = FlxG.save.data.charEditorUIZoom;
    if(FlxG.sound.music.playing == false){
			backdropshit.velocity.x = 0;
			// backdropshit.x = 0;
			characterBG.alpha = 0.5;
			// trace(backdropshit.x);
			switch(character.getAnimName()){
				case "idle":
					playAnimation("idle");
			}
	

	}
	if(FlxG.sound.music.playing == true){
			FlxG.sound.music.destroy();
				backdropshit.velocity.x = 10;
                characterBG.alpha = 1;
		
    }

}
var danceBool:Bool = false;
function beatHit(curBeat){
   	if(curBeat % 4 == 0 || curBeat == 0){
		backdropshit.scale.set(1.1,1.1);
		FlxTween.tween(backdropshit, {"scale.x": 1, "scale.y": 1}, Conductor.crochet / 1000, {ease: FlxEase.cubeOut});

		if(charHasDances == false){
	    	switch(character.getAnimName()){
                case "idle":
    		        playAnimation("idle");

			}
	    }
	}
    if(charHasDances == true && curBeat % 2 == 0){
	    	switch(character.getAnimName()){
                case "danceLeft":
					playAnimation("danceRight");
				case "danceRight":
					playAnimation("danceLeft");

	    }

	}

}

