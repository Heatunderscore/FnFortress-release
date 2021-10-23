package;

import flixel.FlxG;
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

	public function new(x:Float, y:Float)
	{
		var daStage = PlayState.curStage;
		var daBf:String = '';
		var daDad = PlayState.SONG.player2;

		switch (PlayState.SONG.player1)
		{
			case 'bf-pixel':
				stageSuffix = '-pixel';
				daBf = 'bf-pixel-dead';
			default:
				daBf = 'bf';
		}

		super();

		Conductor.songPosition = 0;

		bf = new Boyfriend(x, y, daBf);
		add(bf);

		camFollow = new FlxObject(bf.getGraphicMidpoint().x, bf.getGraphicMidpoint().y, 1, 1);
		add(camFollow);

		FlxG.sound.play(Paths.sound('fnf_loss_sfx' + stageSuffix));
		Conductor.changeBPM(100);

		switch (daStage)
		{
			case 'twofort':
				FlxG.sound.play(Paths.soundRandom('death/scunt_', 1, 3),1);
			case 'entry':
				FlxG.sound.play(Paths.soundRandom('death/soldier_', 1, 4),1);
			case 'intel':
				FlxG.sound.play(Paths.soundRandom('death/pyro_', 1, 3),1);
			case 'barnblitz-demo':
				FlxG.sound.play(Paths.soundRandom('death/demo_', 1, 3),1);
			case 'barnblitz-heavy':
				FlxG.sound.play(Paths.soundRandom('death/heavy_', 1, 4),1);
			case 'barnblitz-engi':
				FlxG.sound.play(Paths.soundRandom('death/engi_', 1, 4),1);
			case 'snake-sniper':
				FlxG.sound.play(Paths.soundRandom('death/sniper_', 1, 3),1);
			case 'snake-medic':
				FlxG.sound.play(Paths.soundRandom('death/medic_', 1, 3),1);
			case 'snake-spy':
				FlxG.sound.play(Paths.soundRandom('death/spy_', 1, 3),1);
			case 'sax':
				FlxG.sound.play(Paths.soundRandom('death/saxton_', 1, 3),1);
			default:
				if (PlayState.curSong == 'Meet The Team')
				    FlxG.sound.play(Paths.sound('death/mtm'));
		}
		// holy shit thats a lot of cases -tob

		FlxG.sound.play(Paths.sound('fnf_loss_sfx'),0.5);

		// FlxG.camera.followLerp = 1;
		// FlxG.camera.focusOn(FlxPoint.get(FlxG.width / 2, FlxG.height / 2));
		FlxG.camera.scroll.set();
		FlxG.camera.target = null;

		bf.playAnim('firstDeath');
	}
	var startVibin:Bool = false;
	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (controls.ACCEPT)
		{
			endBullshit();
		}

		if(FlxG.save.data.InstantRespawn)
			{
				LoadingState.loadAndSwitchState(new PlayState());
			}

		if (controls.BACK)
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
			FlxG.sound.play(Paths.music('gameOverEnd' + stageSuffix));
			new FlxTimer().start(0.7, function(tmr:FlxTimer)
			{
				FlxG.camera.fade(FlxColor.BLACK, 2, false, function()
				{
					LoadingState.loadAndSwitchState(new PlayState());
				});
			});
		}
	}
}
