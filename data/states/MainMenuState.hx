import youtube.ThisCursorIsStupid;

var myCursor:ThisCursorIsStupid; // lol

function postCreate() {
	var moreVersionShit:FunkinText = new FunkinText(5, 634, 0, '');
	moreVersionShit.scrollFactor.set();
	add(moreVersionShit);
	moreVersionShit.text = "YT Animation Peril v1.0 [DEMO]"; // i sadly cant extend the original versionShit text actually
	// so i had to work around that like this.

	// anyway, cursor.

	myCursor = new ThisCursorIsStupid(0.4, 0.4);
	add(myCursor);
}
