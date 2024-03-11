// settings

var moveSpeed:Float = 0.2; // speed for how fast the window moves
var moveIntensity:Float = 25; // intensity for how much the window moves
var enableOnBf:Bool = false; // set to true to make bf move the window
var enableOnDad:Bool = true; // set to true to make dad move the window

// code area !!

var curWinX = window.x;
var curWinY = window.y;

function update(){
    if (dad.animation.curAnim.name == "idle" || dad.animation.curAnim.name == "idle-alt" && enableOnDad){
        window.x = FlxMath.lerp(window.x, curWinX, moveSpeed);
        window.y = FlxMath.lerp(window.y, curWinY, moveSpeed);
    }

    // if this gives out a whole bunch of errors in your console ignore it!!! it still works
    if (boyfriend.animation.curAnim.name == "idle" || boyfriend.animation.curAnim.name == "idle-alt" && enableOnBf){
        window.x = FlxMath.lerp(window.x, curWinX, moveSpeed);
        window.y = FlxMath.lerp(window.y, curWinY, moveSpeed);
    }
}

function onDadHit(e){
    if (enableOnDad)
        switch(e.direction){
            case 0:
                window.x = FlxMath.lerp(window.x, curWinX - moveIntensity, moveSpeed);
                window.y = FlxMath.lerp(window.y, curWinY, moveSpeed);
            case 1:
                window.x = FlxMath.lerp(window.x, curWinX, moveSpeed);
                window.y = FlxMath.lerp(window.y, curWinY + moveIntensity, moveSpeed);
            case 2:
                window.x = FlxMath.lerp(window.x, curWinX, moveSpeed);
                window.y = FlxMath.lerp(window.y, curWinY - moveIntensity, moveSpeed);
            case 3:
                window.x = FlxMath.lerp(window.x, curWinX + moveIntensity, moveSpeed);
                window.y = FlxMath.lerp(window.y, curWinY, moveSpeed);
        }
}

function onPlayerHit(e){
    if (enableOnBf)
        switch(e.direction){
            case 0:
                window.x = FlxMath.lerp(window.x, curWinX - moveIntensity, moveSpeed);
                window.y = FlxMath.lerp(window.y, curWinY, moveSpeed);
            case 1:
                window.x = FlxMath.lerp(window.x, curWinX, moveSpeed);
                window.y = FlxMath.lerp(window.y, curWinY + moveIntensity, moveSpeed);
            case 2:
                window.x = FlxMath.lerp(window.x, curWinX, moveSpeed);
                window.y = FlxMath.lerp(window.y, curWinY - moveIntensity, moveSpeed);
            case 3:
                window.x = FlxMath.lerp(window.x, curWinX + moveIntensity, moveSpeed);
                window.y = FlxMath.lerp(window.y, curWinY, moveSpeed);
        }
}

function destroy(){
    window.x = curWinX;
    window.y = curWinY;
}