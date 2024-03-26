/* 
    no need of going into the credits menu, just composer credit thing
*/
import flixel.text.FlxTextBorderStyle;
import flixel.text.FlxText.FlxTextAlign;

var recharter:FunkinText = null;
var noteIco:Note;

function postCreate() {
    /* takes account of noteskins after being created */
    noteIco = new Note(playerStrums, {id: FlxG.random.int(0, 3)});
    noteIco.cameras = [camHUD];
    noteIco.setPosition(-25, 200);
    noteIco.setGraphicSize(Std.int(noteIco.width * 0.25));
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
case "narration": recharter.text = "Narration | Isaiah Mods";
case "crazy": recharter.text = "Crazy | Maicon/tbemusiga";
case "hilarious": recharter.text = "Hilarious | Vencerist";
case "nutshell": recharter.text = "Nutshell | CharlesCatYT";
case "idiot": recharter.text = "Idiot | Vencerist";
case "extraterrestrial": recharter.text = "Extraterrestrial | Maicon/tbemusiga";
case "explanation": recharter.text = "Explanation | Isaiah Mods";
case "never gonna get it": recharter.text = "Never Gonna Get It | CharlesCatYT";
case "hazardous": recharter.text = "Hazardous | Vencerist";
case "evocative": recharter.text = "Evocative | Isaiah Mods & CharlesCatYT";
case "twenty two": recharter.text = "22 | lowkeykindly";
case "introvert": recharter.text = "Introvert | Vencerist";
case "boisterous": recharter.text = "Boisterous | Vencerist";
case "contendedly": recharter.text = "Contendedly | Vencerist";
case "voler": recharter.text = "Voler | CharlesCatYT";
case "drawn": recharter.text = "Drawn | Isaiah Mods";
case "trampoline": recharter.text = "Trampoline | Isaiah Mods & CharlesCatYT";
case "brew": recharter.text = "Brew | Vencerist";
case "riggy roll": recharter.text = "Riggy Roll | Vencerist";
case "clone vpn": recharter.text = "Clone VPN | ???";
case "brainy": recharter.text = "Brainy | Isaiah Mods";
case "factual": recharter.text = "Factual | ???";
case "number one": recharter.text = "Number One | CharlesCatYT";
case "life hack": recharter.text = "Life Hack | Isaiah Mods";
case "chivi": recharter.text = "ChiVi | Maicon/tbemusiga";
case "popular path": recharter.text = "Popular Path | Vencerist";
case "rope struck": recharter.text = "Rope Struck | Vencerist";
case "bob": recharter.text = "Bob | ???";
case "cloning": recharter.text = "Cloning | ???";
case "tweekin": recharter.text = "Tweekin | ???";
case "knowledge": recharter.text = "Knowledge | CharlesCatYT";
case "voguish": recharter.text = "Voguish | CharlesCatYT";
case "stairs": recharter.text = "Stairs | ???"; // sweet bro and hella jeff, v1
case "nuggit": recharter.text = "Nuggit | Isaiah Mods";
case "big caboose": recharter.text = "Big Caboose | CharlesCatYT";
case "call": recharter.text = "Call | Isaiah Mods";
case "standby": recharter.text = "Standby | ???"; // planet dolan, v1.2
case "logic": recharter.text = "Logic | Isaiah Mods";
case "academic": recharter.text = "Academic | Isaiah Mods";
case "toony": recharter.text = "Toony | CharlesCatYT & TheAnimateMan";
case "old toony": recharter.text = "Toony (Old) | TheAnimateMan";
case "old drawn": recharter.text = "Drawn (Old) | Isaiah Mods";
case "old nutshell": recharter.text = "Nutshell (Old) | TheAnimateMan";
case "hornstromp": recharter.text = "Hornstromp | sibottle [Cover by Isaiah Mods]";
case "schooled": recharter.text = "Schooled | AmongBoy [Cover by Isaiah Mods]";
case "old call": recharter.text = "Call (Old) | Maicon/tbemusiga";
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