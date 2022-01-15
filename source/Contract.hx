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
	var optionShit:Array<String> = ['week1', 'week2', 'week3', 'hale'];
	#else
	var optionShit:Array<String> = ['week1', 'week2', 'week3', 'freeplay'];
	#end

	var newGaming:FlxText;
	var newGaming2:FlxText;
	public static var firstStart:Bool = true;

	public static var nightly:String = "";

    public static var curBg:Int = 1;

    public var curLock:Int = 0;

    var weekData:Array<String> = [];
    var curWeek:Int = 1;

    var funnyLock:Int = 0;
    
    var contracter:FlxSprite;
    var weekThing:FlxSprite;

    var freeplayButton:FlxSprite;
    var mttButton:FlxSprite;

    var curCon:String = "";

    var funnyRoot:FlxSprite;
	public static var kadeEngineVer:String = "FNF VS MANNCO (1.5.4 EK)" + nightly;
	public static var gameVer:String = "0.2.7.1";

    var arrows:FlxSprite;
	var magenta:FlxSprite;
	var camFollow:FlxObject;
	public static var finishedFunnyMove:Bool = false;
    public static var shitUnlocked:Array<Bool> = [true];

	override function create()
	{
        trace(FlxG.save.data.buttonUnlockingShit);

        if (FlxG.save.data.buttonUnlockingShit == null)
        {
            FlxG.save.data.buttonUnlockingShit = 0;
            //basically creates the save file if you start for the first time -tob
        }
        trace(FlxG.save.data.buttonUnlockingShit);

        FlxG.save.data.funnyLock = FlxG.save.data.unlockedWeek;

        curLock = FlxG.save.data.funnyLock;

        funnyLock = FlxG.save.data.buttonUnlockingShit;
        trace(funnyLock);
        
        switch (curLock)
        {
            case 0:
                curCon = "normal";
                shitUnlocked = [true, false, false, false];
            case 1:
                curCon = "bronze";
                shitUnlocked = [true, true, false, false];
            case 2:
                curCon = "silver";
                shitUnlocked = [true, true, true, false];
            case 3 | 4:
                curCon = "gold";
                shitUnlocked = [true, true, true, true];
        }

        trace(shitUnlocked);

        if (FlxG.sound.music != null)
			{
				if (!FlxG.sound.music.playing)
					FlxG.sound.playMusic(Paths.music('freakyMenu'));
			}

        /*for (i in 0...curLock)
        {
            shitUnlocked.push(true);
        }*/

        //lmao heat -tob
        // oiuo8ihfighgeuhfeiguehgiuhtq8ty28935y32 -heat
        //lmao heat -tob

        var bg:FlxSprite = new FlxSprite(-100).loadGraphic(Paths.image('menuDesat'));
		bg.scrollFactor.x = 0;
		bg.scrollFactor.y = 0.10;
		bg.setGraphicSize(Std.int(bg.width * 1.1));
		bg.updateHitbox();
		bg.screenCenter();
		bg.antialiasing = true;
		add(bg);

        contracter = new FlxSprite(0, 12);
        contracter.frames = Paths.getSparrowAtlas('fortress/contract/contracter', 'shared');
        contracter.animation.addByPrefix('idle', 'contract ' + curCon, 24, true);
        contracter.animation.play('idle');
		contracter.antialiasing = true;
		add(contracter);

        menuItems = new FlxTypedGroup<FlxSprite>();

        for(i in 0...optionShit.length) 
            {
                // dont care if im missing something, im just too stupid for this -tob
                var buttonThing:FlxSprite = new FlxSprite(0, 130);
                buttonThing.ID = i;
                buttonThing.frames = Paths.getSparrowAtlas('fortress/contract/contracterButtons', 'shared');
                buttonThing.animation.addByPrefix('idle', optionShit[i] + ' button ' + funnyLock + ' idle', 24, true);
                buttonThing.animation.addByPrefix('hover', optionShit[i] + ' button ' + funnyLock + ' press', 24, true);
                buttonThing.animation.addByPrefix('locked', optionShit[i] + ' button lock', 24, true);
                if (!shitUnlocked[i])
                {
                    buttonThing.animation.play('locked');
                }
                else if (shitUnlocked[i])
                {
                    buttonThing.animation.play('idle');
                }

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
                }
                menuItems.add(buttonThing);

                var textShit:FlxSprite = new FlxSprite(0, 0);
                textShit.ID = i;
                textShit.frames = Paths.getSparrowAtlas('fortress/contract/contracterText', 'shared');
                textShit.animation.addByPrefix('title', optionShit[i] + ' title', 24, true);
                textShit.animation.play('title');
                textShit.antialiasing = true;
                textShit.updateHitbox();
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
                        textShit.setPosition(607, 432);
                }
                add(textShit);
            }
            add(menuItems);

        freeplayButton = new FlxSprite(231, 427);
        freeplayButton.frames = Paths.getSparrowAtlas('fortress/contract/freeplayB', 'shared');
        freeplayButton.animation.addByPrefix('idle','freeplay idle', 24, true);
        freeplayButton.animation.addByPrefix('hover','freeplay press', 24, true);
        freeplayButton.animation.play('idle');
        freeplayButton.antialiasing = true;
        add(freeplayButton);

        mttButton = new FlxSprite(431, 327);
        mttButton.frames = Paths.getSparrowAtlas('fortress/contract/freeplayB', 'shared');
        mttButton.animation.addByPrefix('idle','freeplay idle', 24, true);
        mttButton.animation.addByPrefix('hover','freeplay press', 24, true);
        mttButton.animation.play('idle');
        mttButton.antialiasing = true;
        if (curLock <= 3)
            add(mttButton);

        /*for (i in 0...optionShit.length)
            {
                var textShit:FlxSprite = new FlxSprite(0, 0);
                textShit.ID = i;
                textShit.frames = Paths.getSparrowAtlas('fortress/contract/contracterText', 'shared');
                textShit.animation.addByPrefix('title', optionShit[i] + ' title', 24, true);
                textShit.animation.play('title');
                textShit.antialiasing = true;
                textShit.updateHitbox();
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
                        textShit.setPosition(607, 432);
                }
                add(textShit);
                

            }*/
        
        var sx:FlxSprite = new FlxSprite(221, 491);
        sx.frames = Paths.getSparrowAtlas('fortress/contract/freeplayT', 'shared');
        sx.animation.addByPrefix('idle1','freeplay title', 24, true);
        sx.animation.play('idle');
        add(sx);

        var mttT:FlxSprite = new FlxSprite(355, 360).loadGraphic(Paths.image('fortress/contract/final_stand', 'shared'));
        if (curLock <= 3)
            add(mttT);

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
        
        arrows = new FlxSprite(-154, -12);
        arrows.frames = Paths.getSparrowAtlas('fortress/contract/arrows', 'shared');
        arrows.animation.addByPrefix('idle', curLock + ' unlocked');
        arrows.animation.play('idle');
        arrows.antialiasing = true;
        arrows.updateHitbox();
        add(arrows);

        funnyRoot = new FlxSprite(592, 128);
        funnyRoot.frames = Paths.getSparrowAtlas('fortress/contract/funnyRoot', 'shared');
        funnyRoot.animation.addByPrefix('idle','fnf text', 24, true);
        funnyRoot.animation.addByPrefix('idle1','week1 text', 24, true);
        funnyRoot.animation.addByPrefix('idle2','week2 text', 24, true);
        funnyRoot.animation.addByPrefix('idle3','week3 text', 24, true);
        funnyRoot.animation.addByPrefix('idle4','hale text', 24, true);
        funnyRoot.animation.addByPrefix('idle5','freeplay text', 24, true);
        funnyRoot.animation.play('idle');
        funnyRoot.antialiasing = true;
        add(funnyRoot);

        var discTxt = new FlxText(150, 10, 0, "Press Space To Join Our Discord Server!!!!!!!!");
        discTxt.color = FlxColor.RED;
        discTxt.scale.set(2, 2);
        if (curLock <= 3)
            add(discTxt);


        super.create();
    }

    var selectedSomethin:Bool = false;

	var canClick:Bool = true;
	var usingMouse:Bool = false;

    override function update(elapsed:Float)
    {
        if (FlxG.keys.justPressed.SPACE)
            FlxG.openURL("https://discord.gg/MeWmRvaFEK");

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
                        curWeek = Math.floor(spr.ID + 1);

                        remove(weekThing);
                        weekThing.antialiasing = true;
                        add(weekThing);

                        remove(funnyRoot);
                        funnyRoot.antialiasing = true;
                        add(funnyRoot);
                        if (shitUnlocked[curSelected]){
                            spr.animation.play('hover');
                            funnyRoot.animation.play('idle' + curWeek);
                            weekThing.animation.play('idle' + curWeek);
                        }
                    }
                        
                    if(FlxG.mouse.pressed && canClick)
                    {
                        selectSomething();
                    }
                }

                
        
                spr.updateHitbox();
            });

            if (FlxG.mouse.overlaps(freeplayButton) || FlxG.mouse.overlaps(mttButton))
                {
                    if(canClick)
                    {
                        usingMouse = true;

                        remove(funnyRoot);
                        funnyRoot.antialiasing = true;
                        add(funnyRoot);
                     
                        if (FlxG.mouse.overlaps(freeplayButton)) {
                            funnyRoot.animation.play('idle5');
                            freeplayButton.animation.play('hover');
                        }
                        if (FlxG.mouse.overlaps(mttButton))
                            mttButton.animation.play('hover');
                    }
                        
                    if(FlxG.mouse.pressed && canClick)
                    {
                        if (FlxG.mouse.overlaps(freeplayButton)) {
                            FlxG.switchState(new FreeplayState());
                        }
                        if (FlxG.mouse.overlaps(mttButton) && curLock <= 3)
                            FlxG.openURL("https://gamebanana.com/wips/64192");
                    }
                }
            else if(!FlxG.mouse.overlaps(freeplayButton) || !FlxG.mouse.overlaps(mttButton))
                {
                    if (!FlxG.mouse.overlaps(freeplayButton))
                        freeplayButton.animation.play('idle');
                    if (!FlxG.mouse.overlaps(mttButton))
                        mttButton.animation.play('idle');
                }

            

    
            if (!selectedSomethin)
            {
                var gamepad:FlxGamepad = FlxG.gamepads.lastActive;
    
                if (controls.BACK)
                {
                    FlxG.switchState(new SusState());
                }
            }
    
            super.update(elapsed);
    }

    function selectSomething()
        {
            if (shitUnlocked[curSelected])
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
                case 'week1':
                    weekData = ['Atomicpunch', 'Maggots', 'Inferno'];
                    startWeek();
                case 'week2':
                    weekData = ['Ironbomber', 'Ironcurtain', 'Frontierjustice'];
                    startWeek();
                case 'week3':
                    weekData = ['Clinicaltrial', 'Wanker', 'Infiltrator'];
                    startWeek();
                case 'hale':
                    weekData = ['Property Damage'];
                    startWeek();
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
                //spr.animation.play('idle');
    
                if (spr.ID == curSelected && finishedFunnyMove)
                {
                    spr.animation.play('hover');
                }
    
                spr.updateHitbox();
            });
        }
    function changeWeek(change:Int = 0):Void
    {
        curWeek += change;
    
        if (curWeek >= weekData.length)
            curWeek = 0;
        if (curWeek < 0)
            curWeek = weekData.length - 1;
    }
    function startWeek():Void
        {
            if (shitUnlocked[curSelected])
            {
                PlayState.storyPlaylist = weekData;
                PlayState.isStoryMode = true;
        
                PlayState.storyDifficulty = 2;
        
                // adjusting the song name to be compatible
                var songFormat = StringTools.replace(PlayState.storyPlaylist[0], " ", "-");
                switch (songFormat) {
                    case 'Dad-Battle': songFormat = 'Dadbattle';
                    case 'Philly-Nice': songFormat = 'Philly';
                }
        
                var poop:String = Highscore.formatSong(songFormat, 2);
                PlayState.sicks = 0;
                PlayState.bads = 0;
                PlayState.shits = 0;
                PlayState.goods = 0;
                PlayState.campaignMisses = 0;
                PlayState.SONG = Song.loadFromJson(poop, PlayState.storyPlaylist[0]);
                PlayState.storyWeek = curWeek;
                PlayState.campaignScore = 0;
                new FlxTimer().start(1, function(tmr:FlxTimer)
                {
                    LoadingState.loadAndSwitchState(new PlayState(), true);
                });
            }
        }
}