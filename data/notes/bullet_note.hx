function onPlayerHit(e)
    {
        if(e.noteType == 'bullet_note')
            {
                e.animCancelled = true;
                e.showSplash = true;
                FlxG.sound.play(Paths.sound('bulletSound'));
                boyfriend.playAnim("shot");
                health = health + 0.2;
                FlxG.camera.shake(0.02, 0.2);
                camGame.zoom = 0.8;
            }
    }
function onPlayerMiss(e) {
    if (e.noteType == "bullet_note") {
        e.healthGain -= 0.2;
        FlxG.sound.play(Paths.sound('bulletSound'));
        deleteNote(e.note); 
        }
    }
function onNoteCreation(e) {
    if(e.noteType == 'bullet_note')
        {
            e.note.wasGoodHit = true;
				e.noteSprite = "game/notes/bullet";
		}
}