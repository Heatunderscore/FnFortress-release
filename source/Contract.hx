package;

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

class Contract extends MusicBeatState
{
	var curSelected:Int = 0;

	var menuItems:FlxTypedGroup<FlxSprite>;
    var menuItemText:FlxTypedGroup<FlxSprite>;

	#if !switch
	var optionShit:Array<String> = ['one', 'two', 'complete', 'hale', 'freeplay'];
	#else
	var optionShit:Array<String> = ['week1', 'week2', 'week3', 'freeplay'];
	#end

	var newGaming:FlxText;
	var newGaming2:FlxText;
	public static var firstStart:Bool = true;

	public static var nightly:String = "";

    public static var curBg:Int = 1;

    public var curLock:Int = 0;

    var curWeek:Int = 1;
    
    var contracter:FlxSprite;
    var weekThing:FlxSprite;

	public static var kadeEngineVer:String = "FNF VS MANNCO (1.5.4 EK)" + nightly;
	public static var gameVer:String = "0.2.7.1";

	var magenta:FlxSprite;
	var camFollow:FlxObject;
	public static var finishedFunnyMove:Bool = false;

	override function create()
	{
        var bg:FlxSprite = new FlxSprite(-100).loadGraphic(Paths.image('menuBG'));
		bg.scrollFactor.x = 0;
		bg.scrollFactor.y = 0.10;
		bg.setGraphicSize(Std.int(bg.width * 1.1));
		bg.updateHitbox();
		bg.screenCenter();
		bg.antialiasing = true;
		add(bg);

        contracter = new FlxSprite(0, 12).loadGraphic(Paths.image('fortress/contract/contracter', 'shared'));
		contracter.antialiasing = true;
		add(contracter);

        menuItems = new FlxTypedGroup<FlxSprite>();

        for(i in 0...optionShit.length) 
            {
                var buttonThing:FlxSprite = new FlxSprite(0, 130);
                buttonThing.ID = i;
                buttonThing.frames = Paths.getSparrowAtlas('fortress/contract/contracterButtons', 'shared');
                buttonThing.animation.addByPrefix('idle', optionShit[i] + ' idle', 24, true);
                buttonThing.animation.addByPrefix('hover', optionShit[i] + ' press', 24, true);
                buttonThing.animation.play('idle');
                buttonThing.antialiasing = true;
                buttonThing.updateHitbox();
                buttonThing.screenCenter(X);
                buttonThing.scrollFactor.set();
                switch(i) 
                {
                    case 0:
                        buttonThing.setPosition(232, 230);
                    case 1:
                        buttonThing.setPosition(485, 173);
                    case 2:
                        buttonThing.setPosition(790, 255);
                    case 3:
                        buttonThing.setPosition(597, 372);
                    case 4:
                        buttonThing.setPosition(231, 427);
                }
                menuItems.add(buttonThing);
            }
            add(menuItems);

        for (i in 0...optionShit.length)
            {
                var textShit:FlxSprite = new FlxSprite(0, 0);
                textShit.ID = i;
                textShit.frames = Paths.getSparrowAtlas('fortress/contract/contracterText', 'shared');
                textShit.animation.addByPrefix('title', optionShit[i] + ' title', 24, true);
                textShit.animation.play('title');
                textShit.antialiasing = true;
                textShit.updateHitbox();
                textShit.screenCenter(X);
                textShit.scrollFactor.set();
                switch(i) 
                {
                    case 0:
                        textShit.setPosition(230, 302);
                    case 1:
                        textShit.setPosition(480, 243);
                    case 2:
                        textShit.setPosition(790, 325);
                    case 3:
                        textShit.setPosition(221, 491);
                    case 4:
                        textShit.setPosition(607, 432);
                }
                add(textShit);
                

            }


        weekThing = new FlxSprite(914, 288);
        weekThing.frames = Paths.getSparrowAtlas('fortress/contract/weekthings', 'shared');
        weekThing.animation.addByPrefix('idle1','week1', 24, true);
        weekThing.animation.addByPrefix('idle2','week2', 24, true);
        weekThing.animation.addByPrefix('idle3','week3', 24, true);
        weekThing.animation.addByPrefix('idle4','week4', 24, true);
        weekThing.animation.play('idle1');
        weekThing.antialiasing = true;
        add(weekThing);

        FlxG.mouse.visible = true;

        super.create();
    }

    var selectedSomethin:Bool = false;

	var canClick:Bool = true;
	var usingMouse:Bool = false;

    override function update(elapsed:Float)
    {
        if (FlxG.sound.music.volume < 0.8)
            {
                FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
            }
    
            menuItems.forEach(function(spr:FlxSprite)
            {
                if(usingMouse)
                {
                    if(!FlxG.mouse.overlaps(spr))
                        spr.animation.play('idle');
                }
        
                if (FlxG.mouse.overlaps(spr))
                {
                    if(canClick)
                    {
                        curSelected = spr.ID;
                        usingMouse = true;
                        spr.animation.play('hover');
                        curWeek = Math.floor(spr.ID + 1);

                        remove(weekThing);
                        weekThing.antialiasing = true;
                        add(weekThing);
                        weekThing.animation.play('idle' + curWeek);
                    }
                        
                    if(FlxG.mouse.pressed && canClick)
                    {
                        selectSomething();
                    }
                }
        
                spr.updateHitbox();
            });
    
            if (!selectedSomethin)
            {
                var gamepad:FlxGamepad = FlxG.gamepads.lastActive;
    
                if (controls.BACK)
                {
                    FlxG.switchState(new TitleState());
                }
            }
    
            super.update(elapsed);
    }

    function selectSomething()
        {
            selectedSomethin = true;
            FlxG.sound.play(Paths.sound('confirmMenu'));
                
            canClick = false;
    
            menuItems.forEach(function(spr:FlxSprite)
            {
                new FlxTimer().start(1, function(tmr:FlxTimer)
                    {
                        goToState();
                    });
            });
        }
    function goToState()
        {
            var daChoice:String = optionShit[curSelected];
    
            switch (daChoice)
            {
                case 'one':
                    FlxG.sound.play(Paths.sound('burp'));
                case 'two':
                    FlxG.sound.play(Paths.sound('burp'));
                case 'complete':
                    FlxG.sound.play(Paths.sound('burp'));
                case 'hale':
                    FlxG.sound.play(Paths.sound('burp'));
                case 'freeplay':
                    FlxG.switchState(new FreeplayState());
            }		
        }
    function changeItem(huh:Int = 0)
        {
            if (finishedFunnyMove)
            {
                curSelected += huh;
    
                if (curSelected >= menuItems.length)
                    curSelected = 0;
                if (curSelected < 0)
                    curSelected = menuItems.length - 1;
            }
            menuItems.forEach(function(spr:FlxSprite)
            {
                spr.animation.play('idle');
    
                if (spr.ID == curSelected && finishedFunnyMove)
                {
                    spr.animation.play('hover');
                }
    
                spr.updateHitbox();
            });
        }
}