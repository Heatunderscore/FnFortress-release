package;

import haxe.Json;
import flixel.input.gamepad.FlxGamepad;
import Controls.KeyboardScheme;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import io.newgrounds.NG;
import lime.app.Application;

#if windows
import Discord.DiscordClient;
#end

using StringTools;

class Piracy extends MusicBeatState
{
    var noPiracy:FlxText;

    override function create()
        {
            noPiracy = new FlxText(0, 0, 0, "why are you here?", 254);
            noPiracy.setFormat(Paths.font("tf2build.ttf"), 16, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE,FlxColor.BLACK);
            noPiracy.screenCenter();
            noPiracy.scale.set(2, 2);
            add(noPiracy);
            
            FlxG.sound.music.stop();

            FlxG.sound.play(Paths.sound('death/mtm', 'shared'));

            new FlxTimer().start(7 , function(tmr:FlxTimer)
                {
                    FlxG.sound.play(Paths.sound('death/mtm', 'shared'));
                }, 999);
            
            super.create();
        }
}