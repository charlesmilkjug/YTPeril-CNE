import funkin.game.HudCamera;
import funkin.backend.scripting.events.NoteCreationEvent;

final camNotes:HudCamera;
final camSustains:HudCamera;
final camStrums:HudCamera;

function create(){
    camSustains = new HudCamera();
    camSustains.bgColor = '#00000000';

    camNotes = new HudCamera();
    camNotes.bgColor = '#00000000';

    camStrums = new HudCamera();
    camStrums.bgColor = '#00000000';

    camNotes.downscroll = downscroll;
    camSustains.downscroll = downscroll;
    camStrums.downscroll = downscroll;

    FlxG.cameras.add(camSustains, false);
    FlxG.cameras.add(camNotes, false);
    FlxG.cameras.add(camStrums, false);
}

function onNoteCreation(event:NoteCreationEvent){
    final note = event.note;
    final line  = note.strumLine;
    
    note.cameras = [note.isSustainNote ? camSustains : camNotes];
    
    for (strum in line.members) {
        strum.cameras = [camStrums];
    }
}