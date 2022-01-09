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

class SusState extends MusicBeatState
{
	var curSelected:Int = 0;

	var menuItems:FlxTypedGroup<FlxSprite>;

	#if !switch
	var optionShit:Array<String> = ['contracter', 'credits', 'leave', 'logo', 'skill issue', 'options'];
	#else
	var optionShit:Array<String> = ['contracter', 'credits', 'leave', 'options'];
	#end

	var newGaming:FlxText;
	var newGaming2:FlxText;
	public static var firstStart:Bool = true;

	public static var nightly:String = "";

    public static var curBg:Int = 1;

    var sinep:Float = 0;

    var counter:Int = 0;

    var funnyArrow:FlxSprite;

    var theFunny:Int = 0;

	public static var kadeEngineVer:String = "FNF VS MANNCO (1.5.4 EK)" + nightly;
	public static var gameVer:String = "0.2.7.1";

	var magenta:FlxSprite;
	var camFollow:FlxObject;
	public static var finishedFunnyMove:Bool = false;

	override function create()
	{

        // creating save states for when you play for the first time -tob
        if (FlxG.save.data.funniSounds == null)
        {
            FlxG.save.data.funniSounds = true;
        }

        if (FlxG.save.data.flash == null)
        {
            FlxG.save.data.flash = true;
        }

        if (FlxG.save.data.epl == null)
        {
            FlxG.save.data.epl = true;
        }

        if (FlxG.save.data.unlockedWeek == null)
        {
            FlxG.save.data.unlockedWeek = 0;
        }
        
        if (FlxG.save.data.stupid == null)
        {
            FlxG.save.data.stupid = true;
        }

        if (FlxG.save.data.unlockedBonus == null)
        {
            FlxG.save.data.unlockedBonus = false;
        }

        curBg = FlxG.random.int(1, 4);

        trace(curBg);

        var behinBg:FlxSprite = new FlxSprite(-100).loadGraphic(Paths.image('fortress/menu/$curBg', 'shared'));
        behinBg.screenCenter();
		behinBg.antialiasing = true;
		add(behinBg);

        var bg:FlxSprite = new FlxSprite(-100).loadGraphic(Paths.image('fortress/menu/menuBG', 'shared'));
		bg.screenCenter();
		bg.antialiasing = true;
		add(bg);

        FlxG.mouse.visible = true;

        
        menuItems = new FlxTypedGroup<FlxSprite>();

		var tex = Paths.getSparrowAtlas('fortress/menu/all', 'shared');

		for(i in 0...optionShit.length) 
        {
			var testButton:FlxSprite = new FlxSprite(0, 130);
			testButton.ID = i;
			testButton.frames = Paths.getSparrowAtlas('fortress/menu/all', 'shared');
			testButton.animation.addByPrefix('idle', optionShit[i] + ' normal', 24, true);
			testButton.animation.addByPrefix('hover', optionShit[i] + ' press', 24, true);
			testButton.animation.play('idle');
			testButton.antialiasing = true;
			testButton.updateHitbox();
			testButton.screenCenter(X);
			testButton.scrollFactor.set();
			switch(i) {
				case 0:
					testButton.setPosition(1000, 52);
				case 1:
					testButton.setPosition(876, 0);
				case 2:
					testButton.setPosition(1211.35, -5.95);
				case 3:
					testButton.setPosition(27, 148);
                case 4:
                    testButton.setPosition(976, 1);
                case 5:
                    testButton.setPosition(826, 0);
			}
			menuItems.add(testButton);
		}		

        add(menuItems);

        if (FlxG.save.data.tutorial == null)
        {
            funnyArrow = new FlxSprite(820, 48);
            funnyArrow.frames = Paths.getSparrowAtlas('fortress/menu/funny', 'shared');
            funnyArrow.animation.addByPrefix('1', 'arrow point', 24, true);
            funnyArrow.animation.addByPrefix('2', 'arrow point aggressive', 24, true);
            funnyArrow.animation.play('1');
            funnyArrow.antialiasing = true;
            add(funnyArrow);
        }

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
                    if(!FlxG.mouse.overlaps(spr) && spr.ID != 4)
                        spr.animation.play('idle');
                }

                if (!FlxG.save.data.unlockedBonus && spr.ID == 4)
                    {
                        spr.animation.play('hover');
                    }
                else if (!FlxG.mouse.overlaps(spr) && spr.ID == 4)
                    {
                        spr.animation.play('idle');
                    }
        
                if (FlxG.mouse.overlaps(spr))
                {
                    if(canClick)
                    {
                        curSelected = spr.ID;
                        usingMouse = true;
                        spr.animation.play('hover');
                    }

                    if (!FlxG.save.data.unlockedBonus && spr.ID == 4)
                        {
                            counter += 1;
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
    
        if (FlxG.save.data.tutorial == null)
        {
            sinep += 180 * elapsed;
			funnyArrow.alpha = 1 - Math.sin((Math.PI * sinep) / 180);

            if (counter == 3)
            {
                funnyArrow.animation.play('2');
            }
        }
            super.update(elapsed);
    }
    function selectSomething()
        {
            if (optionShit[curSelected] == 'logo')
            {
                //pass
            }
            else
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
        }
        
        function goToState()
        {
            var daChoice:String = optionShit[curSelected];
    
            switch (daChoice)
            {
                case 'options':
                    FlxG.switchState(new OptionsMenu());
                case 'contracter':
                    if (FlxG.save.data.tutorial == null){FlxG.save.data.tutorial = false;}
                    FlxG.switchState(new Contract());
                case 'leave':
                    #if desktop
                    Sys.exit(0);
                    #else
                    FlxG.switchState(new Piracy());
                    #end
                case 'skill issue':
                    if (FlxG.save.data.unlockedBonus){
                    theFunny = FlxG.random.int(1, 3);
                    switch (theFunny)
                    {
                        case 1:
                            PlayState.SONG = Song.loadFromJson('skill-issue-easy', 'skill-issue');
                        case 2:
                            PlayState.SONG = Song.loadFromJson('skill-issue-hard', 'skill-issue');
                        case 3:
                            PlayState.SONG = Song.loadFromJson('skill-issue-bot', 'skill-issue');
                        default:
                            PlayState.SONG = Song.loadFromJson('skill-issue-bot', 'skill-issue');
                    }
                    PlayState.isStoryMode = false;
                    PlayState.storyWeek = 0;
                    trace('CUR WEEK' + PlayState.storyWeek);
                    LoadingState.loadAndSwitchState(new PlayState());
                }
                case 'credits':
                    FlxG.switchState(new Credits());
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