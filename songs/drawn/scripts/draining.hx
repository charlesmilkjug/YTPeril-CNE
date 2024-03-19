static var drainMultiply:Float = 0.65;
static var dickHead:Bool = false;

function create() {
    dickHead = false;
}

function onDadHit(event) 
{
    if (dickHead)
    {
        if(drainMultiply > 0 && health > drainMultiply / 10 + 0.1)
            health -= drainMultiply / 10;
    }
}