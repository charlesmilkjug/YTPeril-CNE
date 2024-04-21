var daStrumID:Int = 0; // strumline thats having the note skin

// notes
function onNoteCreation(e)
    // if (e.strumLineID == daStrumID)
        e.noteSprite = "game/notes/shadeless_notes"; // add your note skin file name here!
// strums
function onStrumCreation(e)
    // if (e.player == daStrumID)
        e.sprite = "game/notes/shadeless_notes"; // add your note skin file name here!