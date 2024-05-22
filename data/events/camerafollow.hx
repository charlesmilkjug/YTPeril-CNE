import funkin.game.PlayState;
import funkin.game.StrumLine;
import funkin.game.NoteGroup;

function onEvent(eventEvent) {
	if (eventEvent.event.name == "camerafollow")
		{
	if (eventEvent.event.params[0] == 0 && eventEvent.event.params[1] == 0)
		{
        }
		else
			{
				lockedIn = true;
				curCameraTarget = -1;
				camFollow.x = eventEvent.event.params[0];
				camFollow.y = eventEvent.event.params[1];
			}
		}
		if (eventEvent.event.name == "Camera Movement")
			{
				lockedIn = false;
			}
}


