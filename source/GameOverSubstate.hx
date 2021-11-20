package;

import flixel.text.FlxText;
import flixel.FlxBasic;
import flixel.FlxG;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.addons.text.FlxTypeText;
import flixel.FlxObject;
import flixel.FlxSubState;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

class GameOverSubstate extends MusicBeatSubstate
{
	var bf:Boyfriend;
	var camFollow:FlxObject;

	var stageSuffix:String = "";
	var daBf:String = '';
	var youFuckingSuck:FlxTypeText;
	var yesNo:FlxText;
	var firstTime:Bool = PlayState.firstDeath;

	public function new(x:Float, y:Float)
	{
		var daStage = PlayState.curStage;
		var daDad = PlayState.SONG.player2;

		switch (PlayState.SONG.player1)
		{
			case 'bf-pixel':
				stageSuffix = '-pixel';
				daBf = 'bf-pixel-dead';
			case 'medic-bf':
				daBf = 'medic-bf';
			default:
				daBf = 'bf';
		}

		super();

		Conductor.songPosition = 0;

		bf = new Boyfriend(x, y, daBf);
		add(bf);

		camFollow = new FlxObject(bf.getGraphicMidpoint().x, bf.getGraphicMidpoint().y, 1, 1);
		add(camFollow);

		Conductor.changeBPM(100);

		new FlxTimer().start(0.5, function(tmr:FlxTimer)
			{
				switch (daStage)
				{
					case 'twofort':
						FlxG.sound.play(Paths.soundRandom('death/scunt_', 1, 3),1);
					case 'entry' | 'honor':
						FlxG.sound.play(Paths.soundRandom('death/soldier_', 1, 4),1);
					case 'intel':
						FlxG.sound.play(Paths.soundRandom('death/pyro_', 1, 3),1);
					case 'barnblitz-demo' | 'degroot':
						FlxG.sound.play(Paths.soundRandom('death/demo_', 1, 3),1);
					case 'barnblitz-heavy':
						FlxG.sound.play(Paths.soundRandom('death/heavy_', 1, 4),1);
					case 'barnblitz-engi':
						if (!firstTime)
						    FlxG.sound.play(Paths.soundRandom('death/engi_', 1, 4),1);
					case 'snake-sniper':
						FlxG.sound.play(Paths.soundRandom('death/sniper_', 1, 3),1);
					case 'snake-medic':
						FlxG.sound.play(Paths.soundRandom('death/medic_', 1, 3),1);
					case 'snake-spy':
						FlxG.sound.play(Paths.soundRandom('death/spy_', 1, 3),1);
					case 'sax':
						if (PlayState.curSong == 'Meet The Team')
							FlxG.sound.play(Paths.sound('death/mtm'));
						else
							FlxG.sound.play(Paths.soundRandom('death/saxton_', 1, 3),1);
					default:
						if (PlayState.curSong == 'Skill Issue')
							{
								FlxG.sound.play(Paths.sound('death/skill'),1);
							}
				}
				// holy shit thats a lot of cases -tob
			});

			switch(daBf)
			{
			    case 'medic-bf':
				    FlxG.sound.play(Paths.sound('medicDeath'));
			    default:
		            FlxG.sound.play(Paths.sound('fnf_loss_sfx'),0.5);
			}

		// FlxG.camera.followLerp = 1;
		// FlxG.camera.focusOn(FlxPoint.get(FlxG.width / 2, FlxG.height / 2));
		FlxG.camera.scroll.set();
		FlxG.camera.target = null;

		bf.playAnim('firstDeath');

		if (PlayState.firstDeath && daStage == 'barnblitz-engi')
		{
			youFuckingSuck = new FlxTypeText(75, 20, 0, "Darn, might've gone a little too hard on ya. Still up for it?", 24);
			youFuckingSuck.font = 'TF2 Build';
			youFuckingSuck.color = 0xFFFFFFFF;
			youFuckingSuck.sounds = [FlxG.sound.load(Paths.sound('death/engineer'), 1)];
			youFuckingSuck.scrollFactor.set();
			add(youFuckingSuck);

			yesNo = new FlxText(0, 55, 0, "RESTART(7)         CONTINUE(8)", 24);
			yesNo.font = 'TF2 Build';
			yesNo.color = 0xFFFFFFFF;
			yesNo.scrollFactor.set();
			yesNo.screenCenter(X);
			yesNo.alpha = 0;
			add(yesNo);

			youFuckingSuck.start(0.06, true);
		}
	}
	var startVibin:Bool = false;
	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (PlayState.firstDeath)
		{
		    if (!youFuckingSuck._typing)
			{
				FlxTween.tween(yesNo, {alpha: 100}, 1.3, {ease: FlxEase.linear});
			}
		}


		if (controls.ACCEPT && !firstTime)
		{
			endBullshit();
		}

		if(FlxG.save.data.InstantRespawn && !firstTime)
			{
				LoadingState.loadAndSwitchState(new PlayState());
			}

		if (FlxG.keys.justPressed.EIGHT && firstTime)
			{
				FlxG.save.data.unlockedWeek = 2;
				FlxG.save.data.buttonUnlockingShit = 6;
				LoadingState.loadAndSwitchState(new Contract());
			}

		if (FlxG.keys.justPressed.SEVEN && firstTime)
		{
			endBullshit();
		}

		if (controls.BACK && !firstTime)
		{
			FlxG.sound.music.stop();

			if (PlayState.isStoryMode)
				FlxG.switchState(new Contract());
			else
				FlxG.switchState(new FreeplayState());
			PlayState.loadRep = false;
		}

		if (bf.animation.curAnim.name == 'firstDeath' && bf.animation.curAnim.curFrame == 12)
		{
			FlxG.camera.follow(camFollow, LOCKON, 0.01);
		}

		if (bf.animation.curAnim.name == 'firstDeath' && bf.animation.curAnim.finished)
		{
			FlxG.sound.playMusic(Paths.music('gameOver' + stageSuffix));

			startVibin = true;
		}

		if (FlxG.sound.music.playing)
		{
			Conductor.songPosition = FlxG.sound.music.time;
		}
	}

	override function beatHit()
	{
		super.beatHit();

		if (startVibin && !isEnding)
		{
			bf.playAnim('deathLoop', true);
		}

		FlxG.log.add('beat');
	}

	var isEnding:Bool = false;

	function endBullshit():Void
	{
		if (!isEnding)
		{
			isEnding = true;
			bf.playAnim('deathConfirm', true);
			FlxG.sound.music.stop();
			switch (daBf)
			{
				case 'medic-bf':
					FlxG.sound.play(Paths.sound('medicConfirm'));
				default:
					FlxG.sound.play(Paths.music('gameOverEnd' + stageSuffix));
			}
			new FlxTimer().start(0.7, function(tmr:FlxTimer)
			{
				FlxG.camera.fade(FlxColor.BLACK, 2, false, function()
				{
					PlayState.firstDeath = false;
					LoadingState.loadAndSwitchState(new PlayState());
				});
			});
		}
	}
}
