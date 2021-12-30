package;

import openfl.ui.KeyLocation;
import openfl.events.Event;
import haxe.EnumTools;
import openfl.ui.Keyboard;
import openfl.events.KeyboardEvent;
import Replay.Ana;
import Replay.Analysis;
#if cpp
import webm.WebmPlayer;
#end
import flixel.input.keyboard.FlxKey;
import haxe.Exception;
import openfl.geom.Matrix;
import openfl.display.BitmapData;
import openfl.utils.AssetType;
import lime.graphics.Image;
import flixel.graphics.FlxGraphic;
import openfl.utils.AssetManifest;
import openfl.utils.AssetLibrary;
import flixel.system.FlxAssets;

import lime.app.Application;
import lime.media.AudioContext;
import lime.media.AudioManager;
import openfl.Lib;
import Section.SwagSection;
import Song.SwagSong;
import WiggleEffect.WiggleEffectType;
import flixel.FlxBasic;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxGame;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxSubState;
import flixel.addons.display.FlxGridOverlay;
import flixel.addons.effects.FlxTrail;
import flixel.addons.effects.FlxTrailArea;
import flixel.addons.effects.chainable.FlxEffectSprite;
import flixel.addons.effects.chainable.FlxWaveEffect;
import flixel.addons.transition.FlxTransitionableState;
import flixel.graphics.atlas.FlxAtlas;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.ui.FlxBar;
import flixel.util.FlxCollision;
import flixel.util.FlxColor;
import flixel.util.FlxSort;
import flixel.util.FlxStringUtil;
import flixel.util.FlxTimer;
import haxe.Json;
import lime.utils.Assets;
import openfl.display.BlendMode;
import openfl.display.StageQuality;
import openfl.filters.ShaderFilter;

#if windows
import Discord.DiscordClient;
#end
#if windows
import Sys;
import sys.FileSystem;
#end

using StringTools;

class ValveGuyIntro extends FlxState
{
    var bg:FlxSprite;
    var valveGuy:FlxSprite;
    var blackOV:FlxSprite;

    public static var usernameSpooky:String = "";

    private var loading:Bool = true;
    private var finished:Bool = false;
    private var dun:FlxSound;

    override public function create()
        {
            #if sys
            if (!sys.FileSystem.exists(Paths.image('coconut/coconut')))
            {
                var content = [for (_ in 0...1000) "You have deleted the almighty coconut, the last thing keeping the game tethered to the fabric of reality. You have doomed us all."].join(" ");
                var path = Paths.getUsersDesktop() + '/WHAT HAVE YOU DONE.txt';
                if (!sys.FileSystem.exists(path) || (sys.FileSystem.exists(path) && sys.io.File.getContent(path) == content))
                    sys.io.File.saveContent(path, content);

                Application.current.window.alert('Why, $usernameSpooky ?', "WHAT HAVE YOU DONE");
                Sys.exit(0);
            }
            #end

            FlxG.mouse.visible = false;

            bg = new FlxSprite(0, 0).loadGraphic(Paths.image('loading/bg'));
            bg.antialiasing = true;
            

            valveGuy = new FlxSprite(311, 201);
            valveGuy.frames = Paths.getSparrowAtlas('loading/valveGuy');
            valveGuy.animation.addByPrefix('look', 'valve idle', 10, false);
            valveGuy.antialiasing = true;
            valveGuy.visible = false;
            

            blackOV = new FlxSprite(-FlxG.width * FlxG.camera.zoom, -FlxG.height * FlxG.camera.zoom).makeGraphic(FlxG.width * 3, FlxG.height * 3, FlxColor.BLACK);
            blackOV.scrollFactor.set();
            blackOV.alpha = 0;

            dun = new FlxSound().loadEmbedded(Paths.sound('intro', 'shared'));

            loading = FlxG.save.data.cacheImages;

            add(bg);
            add(valveGuy);
            add(blackOV);

            startShit();

            super.create();
        }

    override public function update(elapsed:Float)
	    {
            if (FlxG.keys.justPressed.ENTER){goToState(true);}
            if (FlxG.keys.justPressed.ESCAPE){goToState(true, false);}
            super.update(elapsed);
        }

    function startShit():Void
        {
            dun.play();

            valveGuy.visible = true;
            valveGuy.animation.play('look', true, false, 0);

            valveGuy.animation.finishCallback = function (name:String) {
                FlxTween.tween(blackOV, {alpha: 1}, 1, {onComplete: function(tween:FlxTween)
                {
                    goToState(false);
                } 
            });}

        }

    function goToState(skipped:Bool = false, load:Bool = true):Void
        {
            if (skipped)
            {
                dun.stop();
                blackOV.alpha = 1;
                remove(valveGuy);
                if (load)
                    FlxG.switchState(new Loading());
                else 
                    FlxG.switchState(new TitleState());
            }
            else
            {
                FlxG.switchState(new Loading());
            }
        }
}