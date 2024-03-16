static var healthOverlay:FlxSprite;

function postCreate() {
    healthOverlay = new FlxSprite(healthBarBG.x - 31, healthBarBG.y - 26).loadGraphic(Paths.image("game/bars"));
    healthOverlay.cameras = [camHUD];
    insert(members.indexOf(icoP2), healthOverlay);
    healthBarBG.visible = true;
} 