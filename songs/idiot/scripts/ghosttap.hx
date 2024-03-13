/*
	if you put [DISABLE_GHOST] anywhere in the name of your note types, it'll disable this until
	the player hits a normal note!!!!
*/

if (!Options.ghostTapping) disableScript(); // this script only works with ghost tapping enabled!!

var curChars:Array<Character> = null;
var specialNote:Bool = false; // ohh youre soo specialllll
var animSuffix:String = "";

function onInputUpdate(event) {
	if (!specialNote) {
		var chars:Array<Character> = curChars != null ? curChars : [event.strumLine.characters[0]];

		for (index => value in event.pressed)
			if (value)
				for (i in chars)
					i.playSingAnim(index, animSuffix);

		for (value in event.justReleased)
			if (value)
				for (i in chars)
					i.animation.curAnim.curFrame += 2;
	}
}

function onPlayerHit(event:NoteHitEvent) {
	specialNote = StringTools.contains(event.noteType, "[DISABLE_GHOST]");
	if (!specialNote) {
		event.preventAnim();
		animSuffix = event.animSuffix;
		curChars = event.characters;
	}
}