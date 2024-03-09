defaultCamZoom = 1;

function postUpdate()
    if (curCameraTarget == 0)
        tweenCamZoom(1.3, 4, FlxEase.elasticInOut);
    else
        tweenCamZoom(1, 4, FlxEase.elasticInOut);

var cameraZoomTwn:FlxTween;
function tweenCamZoom(zoom:Float, steps:Int, ease:FlxEase)
    cameraZoomTwn = FlxTween.tween(FlxG.camera, {zoom: zoom}, (Conductor.stepCrochet * steps / 1000), {
        ease: ease,
        onComplete: function(twn:FlxTween){
            cameraZoomTwn = null;
        }
    });

function postCreate()
    if (cameraZoomTwn != null)
        cameraZoomTwn.cancel();