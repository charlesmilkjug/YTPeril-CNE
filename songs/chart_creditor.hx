/* 
    Charter "creditor"!
    It's meant to show more appreaction to the charter of the song(s) 
    and have - hopefully - more achknowledgement from players 
    without going to credits.
*/
import flixel.text.FlxTextBorderStyle;
import flixel.text.FlxText.FlxTextAlign;

var recharter:FunkinText = null;
var noteIco:Note;

function postCreate() {
    /* takes account of noteskins after being created */
    noteIco = new Note(playerStrums, {id: FlxG.random.int(0, 3)});
    noteIco.cameras = [camHUD];
    noteIco.setPosition(Std.int(healthBarBG.width / 2), healthBarBG.y - 80);
    noteIco.setGraphicSize(Std.int(noteIco.width * 0.32));
    insert(members.indexOf(iconP1) - 1, noteIco);

    recharter = new FunkinText(
        noteIco.x + noteIco.width - 35,
        noteIco.y + noteIco.height - 65,
        healthBarBG.width,
        recharter,
        null, false
    );

    recharter.setFormat(Paths.font("vcr.ttf"), 19, FlxColor.WHITE, "LEFT");
    recharter.setBorderStyle(FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, 1);
    recharter.cameras = [camHUD];
    insert(members.lastIndexOf(noteIco), recharter);

    noteIco.alpha = 0;
    recharter.alpha = 0;

    /****/

    switch(PlayState.SONG.meta.name) {
        // Do your songs here

case "scientifical": recharter.text = "Scientifical | CharlesCatYT";
case "hilarious": recharter.text = "Hilarious | Vencerist";
        case "idiot": recharter.text = "Idiot | Vencerist";
case "twenty two": recharter.text = "22 | lowkeykindly";
case "introvert": recharter.text = "Introvert | Vencerist";

        default: recharter.text = "";
    }

    /****/

    if (recharter.text == "" || recharter.text == null) disableScript();
}

function postUpdate() {
    if (recharter.text == "" || recharter.text == null) {
        noteIco.kill();
    }
}

function beatHit(curBeat) {
    if (curBeat % 1 == 0) {
        switch (noteIco.noteData) {
            case 0:
                for (a in [noteIco, recharter])
                    FlxTween.tween(a, {x: a.x - 5}, Conductor.crochet / 1000, {type: FlxTween.BACKWARD, ease: FlxEase.cubeInOut});
            case 1:
                for (a in [noteIco, recharter])
                    FlxTween.tween(a, {y: a.y + 5}, Conductor.crochet / 1000, {type: FlxTween.BACKWARD, ease: FlxEase.cubeInOut});
            case 2:
                for (a in [noteIco, recharter])
                    FlxTween.tween(a, {y: a.y - 5}, Conductor.crochet / 1000, {type: FlxTween.BACKWARD, ease: FlxEase.cubeInOut});
            case 3:
                for (a in [noteIco, recharter])
                    FlxTween.tween(a, {x: a.x + 5}, Conductor.crochet / 1000, {type: FlxTween.BACKWARD, ease: FlxEase.cubeInOut});
        }
    }
}

function onStartSong() {
    for (a in [noteIco, recharter]) FlxTween.tween(a, {alpha: 1}, Conductor.crochet / 4000);
}