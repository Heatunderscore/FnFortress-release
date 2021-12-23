package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.text.FlxTypeText;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxSpriteGroup;
import flixel.input.FlxKeyManager;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

using StringTools;

class DialogueBox extends FlxSpriteGroup
{
	var box:FlxSprite;

	var controlShit:Bool = false;
	var curCharacter:String = '';

	var dialogue:Alphabet;
	public var dialogueList:Array<String> = [];

	// SECOND DIALOGUE FOR THE PIXEL SHIT INSTEAD???
	public var swagDialogue:FlxTypeText;

	var dropText:FlxText;

	var delay:Float = 0.04;
	var skip:Int = 0;

	public var finishThing:Void->Void;

	var portraitLeft:FlxSprite;
	var portraitRight:FlxSprite;

	var handSelect:FlxSprite;
	var bgFade:FlxSprite;

	public function new(talkingRight:Bool = true, ?dialogueList:Array<String>)
	{
		super();

		switch (PlayState.SONG.song.toLowerCase())
		{
			default:
				FlxG.sound.playMusic(Paths.music('looking_for_a_server', 'shared'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
		}

		bgFade = new FlxSprite(-200, -200).makeGraphic(Std.int(FlxG.width * 5), Std.int(FlxG.height * 5), 0xFFB3DFd8);
		bgFade.scrollFactor.set();
		bgFade.alpha = 0;
		add(bgFade);

		new FlxTimer().start(0.83, function(tmr:FlxTimer)
		{
			bgFade.alpha += (1 / 5) * 0.7;
			if (bgFade.alpha > 0.7)
				bgFade.alpha = 0.7;
		}, 5);

		box = new FlxSprite(-20, 45);
		
		var hasDialog = false;
		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'atomicpunch' | 'maggots' | 'inferno' | 'ironbomber' | 'ironcurtain' | 'frontierjustice' | 'clinicaltrial'
			| 'wanker' | 'infiltrator' | 'property damage' | 'skill issue' |'honorbound':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/bubble');
				box.animation.addByPrefix('normalOpen', 'Speech Bubble Normal Open', 24, false);
				box.animation.addByIndices('normal', 'speech bubble normal', [11], "", 24);
				box.y += 300;
		}

		this.dialogueList = dialogueList;
		
		if (!hasDialog)
		{
			FlxG.sound.music.fadeOut(0.1, 0);
			return;
		}
			
		
		portraitLeft = new FlxSprite(-20, 40);
		portraitLeft.frames = Paths.getSparrowAtlas('weeb/scunt');
		portraitLeft.animation.addByPrefix('enter', 'scout talk', 24, false);
		portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.175));
		portraitLeft.updateHitbox();
		portraitLeft.scrollFactor.set();
		add(portraitLeft);
		portraitLeft.visible = false;

		portraitRight = new FlxSprite(0, 40);
		portraitRight.frames = Paths.getSparrowAtlas('weeb/bf');
		portraitRight.animation.addByPrefix('enter', 'BFportrait', 24, false);
		portraitRight.setGraphicSize(Std.int(portraitRight.width * PlayState.daPixelZoom * 0.175));
		portraitRight.updateHitbox();
		portraitRight.scrollFactor.set();
		portraitRight.x += 750;
		portraitRight.y += 55;
		add(portraitRight);
		portraitRight.visible = false;
		
		box.animation.play('normalOpen');
		box.setGraphicSize(Std.int(box.width * PlayState.daPixelZoom * 0.175));
		box.updateHitbox();
		add(box);

		box.screenCenter(X);
		portraitLeft.screenCenter(Y);

		handSelect = new FlxSprite(FlxG.width * 0.9, FlxG.height * 0.9).loadGraphic(Paths.image('weeb/pixelUI/hand_textbox'));

		if (!talkingRight)
		{
			// box.flipX = true;
		}

		dropText = new FlxText(242, 502, Std.int(FlxG.width * 0.6), "", 32);
		dropText.font = 'TF2 Build';
		dropText.color = 0xFFD89494;
		add(dropText);

		swagDialogue = new FlxTypeText(240, 500, Std.int(FlxG.width * 0.6), "", 32);
		swagDialogue.font = 'TF2 Build';
		swagDialogue.color = 0xFF3F2021;
		swagDialogue.sounds = [FlxG.sound.load(Paths.sound('pixelText'), 0.6)];
		add(swagDialogue);

		dialogue = new Alphabet(0, 80, "", false, true);
		// dialogue.x = 90;
		// add(dialogue);

		var funnyHelp:FlxText = new FlxText(0, 0, 0, 'Press ESCAPE to skip the dialogue', 24);
		funnyHelp.font = 'TF2 Build';
		add(funnyHelp);
	}

	var dialogueOpened:Bool = false;
	var dialogueStarted:Bool = false;
	var diaSkip:Bool = false;
	var targetnumalpha:Float = 0;

	override function update(elapsed:Float)
	{
		// HARD CODING CUZ IM STUPDI
		if (PlayState.SONG.song.toLowerCase() == 'roses')
			portraitLeft.visible = false;
		if (PlayState.SONG.song.toLowerCase() == 'thorns')
		{
			portraitLeft.color = FlxColor.BLACK;
			swagDialogue.color = FlxColor.WHITE;
			dropText.color = FlxColor.BLACK;
		}

		//fuck you haxe -tob
		dropText.text = swagDialogue.text;

		if (box.animation.curAnim != null)
		{
			if (box.animation.curAnim.name == 'normalOpen' && box.animation.curAnim.finished)
			{
				box.animation.play('normal');
				dialogueOpened = true;
			}
		}

		if (dialogueOpened && !dialogueStarted)
		{
			startDialogue();
			dialogueStarted = true;
		}

		if (PlayerSettings.player1.controls.ACCEPT && dialogueStarted == true)
		{
			remove(dialogue);
				
			FlxG.sound.play(Paths.sound('clickText'), 0.8);

			if (dialogueList[1] == null && dialogueList[0] != null)
			{
				if (!isEnding)
				{
					isEnding = true;

					FlxG.sound.music.fadeOut(1, 0);

					new FlxTimer().start(0.2, function(tmr:FlxTimer)
					{
						box.alpha -= 1 / 5;
						bgFade.alpha -= 1 / 5 * 0.7;
						portraitLeft.visible = false;
						portraitRight.visible = false;
						swagDialogue.alpha -= 1 / 5;
						dropText.alpha = swagDialogue.alpha;
					}, 5);

					new FlxTimer().start(1.2, function(tmr:FlxTimer)
					{
						finishThing();
						kill();
					});
				}
			}
			else
			{
				dialogueList.remove(dialogueList[0]);
				startDialogue();
			}
		}
		else if (FlxG.keys.justPressed.ESCAPE && dialogueStarted == true)
			{
				if (!isEnding)
					{
						isEnding = true;
	
						FlxG.sound.music.fadeOut(1, 0);
	
						new FlxTimer().start(0.2, function(tmr:FlxTimer)
						{
							box.alpha -= 1 / 5;
							bgFade.alpha -= 1 / 5 * 0.7;
							portraitLeft.visible = false;
							portraitRight.visible = false;
							swagDialogue.alpha -= 1 / 5;
							dropText.alpha = swagDialogue.alpha;
						}, 5);
	
						new FlxTimer().start(1.2, function(tmr:FlxTimer)
						{
							finishThing();
							kill();
						});
					}
			}

		/*
		this shit makes the portraits loop until no more dialogue is typed
		private access LMAO -tob
		*/
		@:privateAccess
		if (swagDialogue._typing && delay < 1)
			{
				portraitLeft.animation.play('enter');
				portraitRight.animation.play('enter');
			}
		else if (!swagDialogue._typing && delay >= 1)
			{
				portraitLeft.animation.stop;
				portraitRight.animation.stop;
			}
		
		@:privateAccess
		if (!swagDialogue._typing && skip == 1)
		{
			remove(dialogue);
			FlxG.sound.play(Paths.sound('clickText'), 0.8);
			dialogueList.remove(dialogueList[0]);
			startDialogue();
		}
		//curDad = PlayState.SONG.player2;

		super.update(elapsed);
	}

	var isEnding:Bool = false;

	function startDialogue():Void
	{
		cleanDialog();

		swagDialogue.resetText(dialogueList[0]);
		swagDialogue.start(delay, true);

		switch (curCharacter)
		{
			case 'scunt':
				box.flipX = true;
				if (PlayState.dad.curCharacter == 'scunt')
				{
					portraitLeft.visible = false;
					portraitRight.visible = false;
					portraitLeft.frames = Paths.getSparrowAtlas('dialogue/scunt');
					portraitLeft.animation.addByPrefix('enter', 'scunt talk', 24, false);
					swagDialogue.color = 0xFF000000;
					swagDialogue.sounds = [FlxG.sound.load(Paths.sound('dialogue/scout'), 0.6)];
					if (!portraitLeft.visible)
					{
						portraitLeft.visible = true;
						portraitLeft.animation.play('enter');
					}
				}
				else if (PlayState.dad.curCharacter == 'scunt-old')
				{
					portraitLeft.visible = false;
					portraitRight.visible = false;
					portraitLeft.frames = Paths.getSparrowAtlas('dialogue/old');
					portraitLeft.animation.addByPrefix('enter', 'scout-old talk', 24, false);
					swagDialogue.color = 0xFF000000;
					swagDialogue.sounds = [FlxG.sound.load(Paths.sound('dialogue/scout'), 0.6)];
					if (!portraitLeft.visible)
					{
						portraitLeft.visible = true;
						portraitLeft.animation.play('enter');
					}
				}
				
			case 'soldier':
				box.flipX = true;
				portraitLeft.visible = false;
				portraitRight.visible = false;
				portraitLeft.frames = Paths.getSparrowAtlas('dialogue/soldier');
				portraitLeft.animation.addByPrefix('enter', 'soldier talk', 24, false);
				swagDialogue.color = 0xFF000000;
				swagDialogue.sounds = [FlxG.sound.load(Paths.sound('dialogue/soldier'), 0.6)];
				if (!portraitLeft.visible)
				{
					portraitLeft.visible = true;
					portraitLeft.animation.play('enter');
				}
			case 'soldierai':
				box.flipX = true;
				portraitLeft.visible = false;
				portraitRight.visible = false;
				portraitLeft.frames = Paths.getSparrowAtlas('dialogue/soldierai');
				portraitLeft.animation.addByPrefix('enter', 'soldierai talk', 24, false);
				swagDialogue.color = 0xFF000000;
				swagDialogue.sounds = [FlxG.sound.load(Paths.sound('dialogue/soldier'), 0.6)];
				if (!portraitLeft.visible)
				{
					portraitLeft.visible = true;
					portraitLeft.animation.play('enter');
				}
			case 'pyro':
				box.flipX = true;
				portraitLeft.visible = false;
				portraitRight.visible = false;
				portraitLeft.frames = Paths.getSparrowAtlas('dialogue/pyro', 'shared');
				portraitLeft.animation.addByPrefix('enter', 'pyro talk', 24, false);
				swagDialogue.color = 0xFF000000;
				swagDialogue.sounds = [FlxG.sound.load(Paths.sound('dialogue/pyro'), 0.6)];
				if (!portraitLeft.visible)
				{
					portraitLeft.visible = true;
					portraitLeft.animation.play('enter');
				}

			case 'demo':
				box.flipX = true;
				portraitLeft.visible = false;
				portraitRight.visible = false;
				portraitLeft.frames = Paths.getSparrowAtlas('dialogue/demo');
				portraitLeft.animation.addByPrefix('enter', 'demo talk', 24, false);
				swagDialogue.color = 0xFF8B4513;
				swagDialogue.sounds = [FlxG.sound.load(Paths.sound('dialogue/demo'), 0.6)];
				if (!portraitLeft.visible)
				{
					portraitLeft.visible = true;
					portraitLeft.animation.play('enter');
				}

			case 'heavy':
				box.flipX = true;
				portraitLeft.visible = false;
				portraitRight.visible = false;
				portraitLeft.frames = Paths.getSparrowAtlas('dialogue/heavy');
				portraitLeft.animation.addByPrefix('enter', 'heavy talk', 24, false);
				swagDialogue.color = 0xFF000000;
				swagDialogue.sounds = [FlxG.sound.load(Paths.sound('dialogue/heavy'), 0.6)];	
				if (!portraitLeft.visible)
				{
					portraitLeft.visible = true;
					portraitLeft.animation.play('enter');
				}

			case 'engi':
				box.flipX = true;
				portraitLeft.visible = false;
				portraitRight.visible = false;
				portraitLeft.frames = Paths.getSparrowAtlas('dialogue/engi');
				portraitLeft.animation.addByPrefix('enter', 'engi talk', 24, false);
				swagDialogue.color = 0xFF000000;
				swagDialogue.sounds = [FlxG.sound.load(Paths.sound('dialogue/engineer'), 0.6)];	
				if (!portraitLeft.visible)
				{
					portraitLeft.visible = true;
					portraitLeft.animation.play('enter');
				}

			case 'medic':
				box.flipX = true;
				portraitLeft.visible = false;
				portraitRight.visible = false;
				portraitLeft.frames = Paths.getSparrowAtlas('dialogue/medic');
				portraitLeft.animation.addByPrefix('enter', 'medic talk', 24, false);
				swagDialogue.color = 0xFF000000;
				swagDialogue.sounds = [FlxG.sound.load(Paths.sound('dialogue/medic'), 0.6)];	
				if (!portraitLeft.visible)
				{
					portraitLeft.visible = true;
					portraitLeft.animation.play('enter');
				}

			case 'sniper':
				box.flipX = true;
				portraitLeft.visible = false;
				portraitRight.visible = false;
				portraitLeft.frames = Paths.getSparrowAtlas('dialogue/sniper');
				portraitLeft.animation.addByPrefix('enter', 'sniper talk', 24, false);
				swagDialogue.color = 0xFF000000;
				swagDialogue.sounds = [FlxG.sound.load(Paths.sound('dialogue/sniper'), 0.6)];	
				if (!portraitLeft.visible)
				{
					portraitLeft.visible = true;
					portraitLeft.animation.play('enter');
				}

			case 'spy':
				box.flipX = true;
				portraitLeft.visible = false;
				portraitRight.visible = false;
				portraitLeft.frames = Paths.getSparrowAtlas('dialogue/spy');
				portraitLeft.animation.addByPrefix('enter', 'spy talk', 24, false);
				swagDialogue.color = 0xFF000000;
				swagDialogue.sounds = [FlxG.sound.load(Paths.sound('dialogue/spy'), 0.6)];
				if (!portraitLeft.visible)
				{
					portraitLeft.visible = true;
					portraitLeft.animation.play('enter');
				}

			case 'saxton':
				box.flipX = true;
				portraitLeft.visible = false;
				portraitRight.visible = false;
				portraitLeft.frames = Paths.getSparrowAtlas('dialogue/saxton');
				portraitLeft.animation.addByPrefix('enter', 'saxton talk', 24, false);
				swagDialogue.color = 0xFF000000;
				swagDialogue.sounds = [FlxG.sound.load(Paths.sound('dialogue/saxton_hale'), 0.6)];
				if (!portraitLeft.visible)
				{
					portraitLeft.visible = true;
					portraitLeft.animation.play('enter');
				}

			case 'bf':
				box.flipX = false;
				portraitRight.visible = false;
				portraitLeft.visible = false;
				portraitRight.frames = Paths.getSparrowAtlas('dialogue/bf');
				portraitRight.animation.addByPrefix('enter', 'bf talk', 24, false);
				swagDialogue.color = 0xFF00FFFF;
				swagDialogue.sounds = [FlxG.sound.load(Paths.sound('dialogue/bf'), 0.6)];
				if (!portraitRight.visible)
				{
					portraitRight.visible = true;
					portraitRight.animation.play('enter');
				}
				
			case 'gf':
				box.flipX = false;
				portraitRight.visible = false;
				portraitLeft.visible = false;
				portraitRight.frames = Paths.getSparrowAtlas('dialogue/gf');
				portraitRight.animation.addByPrefix('enter', 'gf talk', 24, false);
				swagDialogue.color = 0xFFFF0000;
				swagDialogue.sounds = [FlxG.sound.load(Paths.sound('dialogue/gf'), 0.6)];
				if (!portraitRight.visible)
				{
					portraitRight.visible = true;
					portraitRight.animation.play('enter');
				}
			case 'snoiper':
				box.flipX = true;
				portraitRight.visible = false;
				portraitLeft.visible = false;
				portraitRight.frames = Paths.getSparrowAtlas('dialogue/snoiper', 'shared');
				swagDialogue.color = 0xFF000000;
				portraitRight.animation.addByPrefix('enter', 'bot talk', 24, false);
				swagDialogue.sounds = [FlxG.sound.load(Paths.sound('dialogue/sniper'), 0.6)];
				if (!portraitLeft.visible)
				{
					portraitLeft.visible = true;
					portraitLeft.animation.play('enter');
				}
			case 'none':
				box.flipX = true;
				portraitRight.visible = false;
				portraitLeft.visible = false;
				swagDialogue.color = 0xFF000000;
				swagDialogue.sounds = [FlxG.sound.load(Paths.sound('pixelText'), 0.6)];
			case 'no':
				box.flipX = true;
				portraitRight.visible = false;
				portraitLeft.visible = false;
				swagDialogue.color = 0xFF8B4513;
				swagDialogue.sounds = [FlxG.sound.load(Paths.sound('dialogue/demo'), 0.6)];
		}
	}

	function cleanDialog():Void
	{
		var splitName:Array<String> = dialogueList[0].split(":");
		curCharacter = splitName[1];
		dialogueList[0] = dialogueList[0].substr(splitName[1].length + 2).trim();

		// made it dynamic so i can use floats
		var splitDelay:Array<Dynamic> = dialogueList[0].split("!");
		delay = splitDelay[1];
		dialogueList[0] = dialogueList[0].substr(splitDelay[1].length + 2).trim();

		// made it dynamic so i can use integer
		var splitSkip:Array<Dynamic> = dialogueList[0].split(";");
		skip = splitSkip[1];
		dialogueList[0] = dialogueList[0].substr(splitSkip[1].length + 2).trim();

		// fuck off
		if (splitDelay == null)
		{
			delay = 0.04;
		}
		// fuck off x2
		if (splitSkip == null)
		{
			skip = 0;
		}
	}
}
