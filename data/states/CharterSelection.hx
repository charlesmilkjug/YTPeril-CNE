import funkin.editors.charter.Charter;
import youtube.ThisCursorIsStupid;

var myCursor:ThisCursorIsStupid; // lol

function postCreate(){
    myCursor = new ThisCursorIsStupid(0.4, 0.4);
    add(myCursor);
}