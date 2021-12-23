package;

import flixel.FlxSubState;
import lime.graphics.Image;
import flixel.input.keyboard.FlxKey;
import flixel.FlxG;
import flixel.FlxGame;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;

class Credits extends MusicBeatState
{
    var bg:FlxSprite;

    override public function create() 
    {
        bg = new FlxSprite().loadGraphic(Paths.image('fortress/menu/darker_yet_darker', 'shared'));
        bg.setGraphicSize(FlxG.width, FlxG.height);
        bg.antialiasing = true;
        bg.updateHitbox();
        add(bg);

        super.create();
    }

    override public function update(elapsed:Float)
    {
        if (controls.BACK)
            FlxG.switchState(new SusState());

        super.update(elapsed);
    }
}