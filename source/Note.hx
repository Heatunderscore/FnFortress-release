package;

import flixel.addons.effects.FlxSkewedSprite;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.math.FlxMath;
import flixel.util.FlxColor;
#if polymod
import polymod.format.ParseRules.TargetSignatureElement;
#end
import PlayState;

using StringTools;

class Note extends FlxSprite
{
	public var strumTime:Float = 0;
	public var baseStrum:Float = 0;
	
	public var charterSelected:Bool = false;

	public var rStrumTime:Float = 0;

	public var mustPress:Bool = false;
	public var noteData:Int = 0;
	public var canBeHit:Bool = false;
	public var tooLate:Bool = false;
	public var wasGoodHit:Bool = false;
	public var prevNote:Note;
	public var modifiedByLua:Bool = false;
	public var noteType:Int = 0;
	public var sustainLength:Float = 0;
	public var isSustainNote:Bool = false;

	public var burning:Bool = false; //fire
	public var death:Bool = false;    //halo/death
	public var warning:Bool = false; //warning
	public var angel:Bool = false; //angel
	public var alt:Bool = false; //alt animation note
	public var bob:Bool = false; //bob arrow
	public var glitch:Bool = false; //glitch

	public var disguise:Bool = false;// disguise shit
	public var dad2:Bool = false;// heavy shit
	public var dad1:Bool = false;// medic shit
	public var bonk:Bool = false;//bonk shit
	public var fist:Bool = false;//fisting
	public var drunk:Bool = false;//drunndnknknrknknkrn
	public var snoiper:Bool = false;//snoiper shit
	public var rocket:Bool = false; //for soldier
	public var huntsman:Bool = false; //sniper
	public var katana:Bool = false; // katana
	public var saw:Bool = false; // mydickishard

	public var noteScore:Float = 1;
	public static var mania:Int = 0;
	public var noteYOff:Int = 0;

	public static var noteyOff1:Array<Float> = [4, 0, 0, 0, 0, 0];
	public static var noteyOff2:Array<Float> = [0, 0, 0, 0, 0, 0];
	public static var noteyOff3:Array<Float> = [0, 0, 0, 0, 0, 0];

	public static var swagWidth:Float;
	public static var noteScale:Float;
	public static var pixelnoteScale:Float;
	public static var PURP_NOTE:Int = 0;
	public static var GREEN_NOTE:Int = 2;
	public static var BLUE_NOTE:Int = 1;
	public static var RED_NOTE:Int = 3;
	public static var tooMuch:Float = 30;
	public static var hitCheck:Int = 0;
	public var rating:String = "shit";
	public var modAngle:Float = 0; // The angle set by modcharts
	public var localAngle:Float = 0; // The angle to be edited inside Note.hx

	public var isParent:Bool = false;
	public var parent:Note = null;
	public var spotInLine:Int = 0;
	public var sustainActive:Bool = true;
	public var noteColors:Array<String> = ['purple', 'blue', 'green', 'red', 'white', 'yellow', 'violet', 'black', 'dark', 'darkred', 'orange'];
	var pixelnoteColors:Array<String> = ['purple', 'blue', 'green', 'red', 'white', 'yellow', 'violet', 'black', 'dark'];

	public var children:Array<Note> = [];


	public function new(strumTime:Float, noteData:Int, ?prevNote:Note, ?sustainNote:Bool = false, ?noteType:Int = 0, ?_mustPress:Bool = false, ?inCharter:Bool = false)
	{
		swagWidth = 160 * 0.7; //factor not the same as noteScale
		noteScale = 0.7;
		pixelnoteScale = 1;
		mania = 0;
		if (PlayState.SONG.mania == 1)
		{
			swagWidth = 120 * 0.7;
			noteScale = 0.6;
			pixelnoteScale = 0.83;
			mania = 1;
		}
		else if (PlayState.SONG.mania == 2)
		{
			swagWidth = 95 * 0.7;
			noteScale = 0.5;
			pixelnoteScale = 0.7;
			mania = 2;
		}
		else if (PlayState.SONG.mania == 3)
			{
				swagWidth = 130 * 0.7;
				noteScale = 0.65;
				pixelnoteScale = 0.9;
				mania = 3;
			}
		else if (PlayState.SONG.mania == 4)
			{
				swagWidth = 110 * 0.7;
				noteScale = 0.58;
				pixelnoteScale = 0.78;
				mania = 4;
			}
		else if (PlayState.SONG.mania == 5)
			{
				swagWidth = 100 * 0.7;
				noteScale = 0.55;
				pixelnoteScale = 0.74;
				mania = 5;
			}

		else if (PlayState.SONG.mania == 6)
			{
				swagWidth = 200 * 0.7;
				noteScale = 0.7;
				pixelnoteScale = 1;
				mania = 6;
			}
		else if (PlayState.SONG.mania == 7)
			{
				swagWidth = 180 * 0.7;
				noteScale = 0.7;
				pixelnoteScale = 1;
				mania = 7;
			}
		else if (PlayState.SONG.mania == 8)
			{
				swagWidth = 170 * 0.7;
				noteScale = 0.7;
				pixelnoteScale = 1;
				mania = 8;
			}
		else if (PlayState.SONG.mania == 9)
			{
				swagWidth = 85 * 0.7;
				noteScale = 0.5;
				pixelnoteScale = 0.7;
				mania = 9;
			}
		super();

		if (prevNote == null)
			prevNote = this;
		this.noteType = noteType;
		this.prevNote = prevNote; 
		isSustainNote = sustainNote;

		x += 50;
		if (PlayState.SONG.mania == 2 || PlayState.SONG.mania == 9)
			{
				x -= tooMuch;
			}
		// MAKE SURE ITS DEFINITELY OFF SCREEN?
		y -= 2000;
		if (Main.editor)
			this.strumTime = strumTime;
		else 
			this.strumTime = Math.round(strumTime);

		if (this.strumTime < 0 )
			this.strumTime = 0;

		this.noteData = noteData % 10;
		disguise = noteType == 1;
		dad2 = noteType == 2;
		dad1 = noteType == 3;
		snoiper = noteType == 4;
		bonk = noteType == 5;
		fist = noteType == 6;
		drunk = noteType == 7;
		rocket = noteType == 8;
		huntsman = noteType == 9;
		katana = noteType == 10;
		saw = noteType == 11;

		if (FlxG.save.data.noteColor != 'darkred' && FlxG.save.data.noteColor != 'black' && FlxG.save.data.noteColor != 'orange')
			FlxG.save.data.noteColor = 'darkred';

		var daStage:String = PlayState.curStage;

		//defaults if no noteStyle was found in chart
		var noteTypeCheck:String = 'normal';

		if (PlayState.SONG.noteStyle == null) {
			switch(PlayState.storyWeek) {case 6: noteTypeCheck = 'pixel';}
		} else {noteTypeCheck = PlayState.SONG.noteStyle;}

		switch (noteTypeCheck)
		{
			case 'pixel':
				loadGraphic(Paths.image('noteassets/pixel/arrows-pixels'), true, 17, 17);
				if (isSustainNote && noteType == 0)
					loadGraphic(Paths.image('noteassets/pixel/arrowEnds'), true, 7, 6);

				for (i in 0...9)
				{
					animation.add(pixelnoteColors[i] + 'Scroll', [i + 9]); // Normal notes
					animation.add(pixelnoteColors[i] + 'hold', [i]); // Holds
					animation.add(pixelnoteColors[i] + 'holdend', [i + 9]); // Tails
				}
				if (disguise)
					{
						loadGraphic(Paths.image('noteassets/pixel/glitch/arrows-pixels'), true, 17, 17);
						if (isSustainNote && glitch)
							loadGraphic(Paths.image('noteassets/pixel/glitch/arrowEnds'), true, 7, 6);
						for (i in 0...9)
							{
								animation.add(pixelnoteColors[i] + 'Scroll', [i + 9]); // Normal notes
								animation.add(pixelnoteColors[i] + 'hold', [i]); // Holds
								animation.add(pixelnoteColors[i] + 'holdend', [i + 9]); // Tails
							}
					}
				if (dad2)
					{
						loadGraphic(Paths.image('noteassets/pixel/glitch/arrows-pixels'), true, 17, 17);
						if (isSustainNote && glitch)
							loadGraphic(Paths.image('noteassets/pixel/glitch/arrowEnds'), true, 7, 6);
						for (i in 0...9)
							{
								animation.add(pixelnoteColors[i] + 'Scroll', [i + 9]); // Normal notes
								animation.add(pixelnoteColors[i] + 'hold', [i]); // Holds
								animation.add(pixelnoteColors[i] + 'holdend', [i + 9]); // Tails
							}
					}
				if (dad1)
					{
						loadGraphic(Paths.image('noteassets/pixel/glitch/arrows-pixels'), true, 17, 17);
						if (isSustainNote && glitch)
							loadGraphic(Paths.image('noteassets/pixel/glitch/arrowEnds'), true, 7, 6);
						for (i in 0...9)
							{
								animation.add(pixelnoteColors[i] + 'Scroll', [i + 9]); // Normal notes
								animation.add(pixelnoteColors[i] + 'hold', [i]); // Holds
								animation.add(pixelnoteColors[i] + 'holdend', [i + 9]); // Tails
							}
					}
				if (snoiper)
					{
						loadGraphic(Paths.image('noteassets/pixel/glitch/arrows-pixels'), true, 17, 17);
						if (isSustainNote && glitch)
							loadGraphic(Paths.image('noteassets/pixel/glitch/arrowEnds'), true, 7, 6);
						for (i in 0...9)
							{
								animation.add(pixelnoteColors[i] + 'Scroll', [i + 9]); // Normal notes
								animation.add(pixelnoteColors[i] + 'hold', [i]); // Holds
								animation.add(pixelnoteColors[i] + 'holdend', [i + 9]); // Tails
							}
					}
				if (bonk)
					{
						loadGraphic(Paths.image('noteassets/pixel/glitch/arrows-pixels'), true, 17, 17);
						if (isSustainNote && glitch)
							loadGraphic(Paths.image('noteassets/pixel/glitch/arrowEnds'), true, 7, 6);
						for (i in 0...9)
							{
								animation.add(pixelnoteColors[i] + 'Scroll', [i + 9]); // Normal notes
								animation.add(pixelnoteColors[i] + 'hold', [i]); // Holds
								animation.add(pixelnoteColors[i] + 'holdend', [i + 9]); // Tails
							}
					}
				if (fist)
					{
						loadGraphic(Paths.image('noteassets/pixel/glitch/arrows-pixels'), true, 17, 17);
						if (isSustainNote && glitch)
							loadGraphic(Paths.image('noteassets/pixel/glitch/arrowEnds'), true, 7, 6);
						for (i in 0...9)
							{
								animation.add(pixelnoteColors[i] + 'Scroll', [i + 9]); // Normal notes
								animation.add(pixelnoteColors[i] + 'hold', [i]); // Holds
								animation.add(pixelnoteColors[i] + 'holdend', [i + 9]); // Tails
							}
					}
				if (drunk)
					{
						loadGraphic(Paths.image('noteassets/pixel/glitch/arrows-pixels'), true, 17, 17);
						if (isSustainNote && glitch)
							loadGraphic(Paths.image('noteassets/pixel/glitch/arrowEnds'), true, 7, 6);
						for (i in 0...9)
							{
								animation.add(pixelnoteColors[i] + 'Scroll', [i + 9]); // Normal notes
								animation.add(pixelnoteColors[i] + 'hold', [i]); // Holds
								animation.add(pixelnoteColors[i] + 'holdend', [i + 9]); // Tails
							}
					}
				if (rocket)
					{
						loadGraphic(Paths.image('noteassets/pixel/glitch/arrows-pixels'), true, 17, 17);
						if (isSustainNote && glitch)
							loadGraphic(Paths.image('noteassets/pixel/glitch/arrowEnds'), true, 7, 6);
						for (i in 0...9)
							{
								animation.add(pixelnoteColors[i] + 'Scroll', [i + 9]); // Normal notes
								animation.add(pixelnoteColors[i] + 'hold', [i]); // Holds
								animation.add(pixelnoteColors[i] + 'holdend', [i + 9]); // Tails
							}
					}
				if (huntsman)
					{
						loadGraphic(Paths.image('noteassets/pixel/glitch/arrows-pixels'), true, 17, 17);
						if (isSustainNote && glitch)
							loadGraphic(Paths.image('noteassets/pixel/glitch/arrowEnds'), true, 7, 6);
						for (i in 0...9)
							{
								animation.add(pixelnoteColors[i] + 'Scroll', [i + 9]); // Normal notes
								animation.add(pixelnoteColors[i] + 'hold', [i]); // Holds
								animation.add(pixelnoteColors[i] + 'holdend', [i + 9]); // Tails
							}
					}
				if (katana)
					{
						loadGraphic(Paths.image('noteassets/pixel/glitch/arrows-pixels'), true, 17, 17);
						if (isSustainNote && glitch)
							loadGraphic(Paths.image('noteassets/pixel/glitch/arrowEnds'), true, 7, 6);
						for (i in 0...9)
							{
								animation.add(pixelnoteColors[i] + 'Scroll', [i + 9]); // Normal notes
								animation.add(pixelnoteColors[i] + 'hold', [i]); // Holds
								animation.add(pixelnoteColors[i] + 'holdend', [i + 9]); // Tails
							}
					}
				if (saw)
					{
						loadGraphic(Paths.image('noteassets/pixel/glitch/arrows-pixels'), true, 17, 17);
						if (isSustainNote && glitch)
							loadGraphic(Paths.image('noteassets/pixel/glitch/arrowEnds'), true, 7, 6);
						for (i in 0...9)
							{
								animation.add(pixelnoteColors[i] + 'Scroll', [i + 9]); // Normal notes
								animation.add(pixelnoteColors[i] + 'hold', [i]); // Holds
								animation.add(pixelnoteColors[i] + 'holdend', [i + 9]); // Tails
							}
					}


				

				setGraphicSize(Std.int(width * PlayState.daPixelZoom * pixelnoteScale));
				updateHitbox();
			default:
				frames = Paths.getSparrowAtlas('noteassets/NOTE_assets');
				for (i in 0...11)
					{
						animation.addByPrefix(noteColors[i] + 'Scroll', noteColors[i] + '0'); // Normal notes
						animation.addByPrefix(noteColors[i] + 'hold', noteColors[i] + ' hold piece'); // Hold
						animation.addByPrefix(noteColors[i] + 'holdend', noteColors[i] + ' hold end'); // Tails
					}	
				if (disguise || dad2 || dad1 || snoiper || bonk || fist || drunk || rocket || huntsman || katana || saw)
					{
						frames = Paths.getSparrowAtlas('noteassets/notetypes/NOTE_types');
						switch(noteType)
						{
							case 1: 
								for (i in 0...11)
									{
										animation.addByPrefix('greenScroll', 'spyU');
										animation.addByPrefix('redScroll', 'spyR');
										animation.addByPrefix('blueScroll', 'spyD');
										animation.addByPrefix('purpleScroll', 'spyL');
										animation.addByPrefix(noteColors[i] + 'hold', noteColors[i] + ' hold piece'); // Hold
										animation.addByPrefix(noteColors[i] + 'holdend', noteColors[i] + ' hold end'); // Tails
									}
							case 4: 
								for (i in 0...11)
									{
										animation.addByPrefix('greenScroll', 'green0');
										animation.addByPrefix('redScroll', 'red0');
										animation.addByPrefix('blueScroll', 'blue0');
										animation.addByPrefix('purpleScroll', 'purple0');
										animation.addByPrefix(noteColors[i] + 'hold', noteColors[i] + ' hold piece'); // Hold
										animation.addByPrefix(noteColors[i] + 'holdend', noteColors[i] + ' hold end'); // Tails
									}
							case 5: 
								for (i in 0...11)
									{
										animation.addByPrefix('greenScroll', 'bonkU');
										animation.addByPrefix('redScroll', 'bonkR');
										animation.addByPrefix('blueScroll', 'bonkD');
										animation.addByPrefix('purpleScroll', 'bonkL');
										animation.addByPrefix(noteColors[i] + 'hold', noteColors[i] + ' hold piece'); // Hold
										animation.addByPrefix(noteColors[i] + 'holdend', noteColors[i] + ' hold end'); // Tails
									}
							case 6: 
								for (i in 0...11)
									{
										animation.addByPrefix('greenScroll', 'fistU');
										animation.addByPrefix('redScroll', 'fistR');
										animation.addByPrefix('blueScroll', 'fistD');
										animation.addByPrefix('purpleScroll', 'fistL');
										animation.addByPrefix(noteColors[i] + 'hold', noteColors[i] + ' hold piece'); // Hold
										animation.addByPrefix(noteColors[i] + 'holdend', noteColors[i] + ' hold end'); // Tails
									}
							case 7: 
								for (i in 0...11)
									{
										animation.addByPrefix('greenScroll', 'drunkU');
										animation.addByPrefix('redScroll', 'drunkR');
										animation.addByPrefix('blueScroll', 'drunkD');
										animation.addByPrefix('purpleScroll', 'drunkL');
										animation.addByPrefix(noteColors[i] + 'hold', noteColors[i] + ' hold piece'); // Hold
										animation.addByPrefix(noteColors[i] + 'holdend', noteColors[i] + ' hold end'); // Tails
									}
						    case 8: 
								for (i in 0...11)
									{
										frames = Paths.getSparrowAtlas('noteassets/notetypes/NOTE_Soldier');
										animation.addByPrefix('greenScroll', 'cockU');
										animation.addByPrefix('redScroll', 'cockR');
										animation.addByPrefix('blueScroll', 'cockD');
										animation.addByPrefix('purpleScroll', 'cockL');
										animation.addByPrefix(noteColors[i] + 'hold', noteColors[i] + ' hold piece'); // Hold
										animation.addByPrefix(noteColors[i] + 'holdend', noteColors[i] + ' hold end'); // Tails
									}
							case 9:
								frames = Paths.getSparrowAtlas('noteassets/notetypes/NOTE_hunt');
								for (i in 0...11)
									{
										animation.addByPrefix('greenScroll', 'green');
										animation.addByPrefix('redScroll', 'red');
										animation.addByPrefix('blueScroll', 'blue');
										animation.addByPrefix('purpleScroll', 'purple');
										animation.addByPrefix(noteColors[i] + 'hold', noteColors[i] + ' hold piece'); // Hold
										animation.addByPrefix(noteColors[i] + 'holdend', noteColors[i] + ' hold end'); // Tails
									}
							case 10:
								frames = Paths.getSparrowAtlas('noteassets/notetypes/NOTE_conch');
								for (i in 0...11)
									{
										animation.addByPrefix('greenScroll', 'green');
										animation.addByPrefix('redScroll', 'red');
										animation.addByPrefix('blueScroll', 'blue');
										animation.addByPrefix('purpleScroll', 'purple');
										animation.addByPrefix(noteColors[i] + 'hold', noteColors[i] + ' hold piece'); // Hold
										animation.addByPrefix(noteColors[i] + 'holdend', noteColors[i] + ' hold end'); // Tails
									}
							case 11:
								frames = Paths.getSparrowAtlas('noteassets/notetypes/NOTE_saw');
								for (i in 0...11)
									{
										animation.addByPrefix('greenScroll', 'green');
										animation.addByPrefix('redScroll', 'red');
										animation.addByPrefix('blueScroll', 'blue');
										animation.addByPrefix('purpleScroll', 'purple');
										animation.addByPrefix(noteColors[i] + 'hold', noteColors[i] + ' hold piece'); // Hold
										animation.addByPrefix(noteColors[i] + 'holdend', noteColors[i] + ' hold end'); // Tails
									}
							default:
								frames = Paths.getSparrowAtlas('noteassets/NOTE_assets');
								for (i in 0...11)
									{
										animation.addByPrefix(noteColors[i] + 'Scroll', noteColors[i] + '0'); // Normal notes
										animation.addByPrefix(noteColors[i] + 'hold', noteColors[i] + ' hold piece'); // Hold
										animation.addByPrefix(noteColors[i] + 'holdend', noteColors[i] + ' hold end'); // Tails
									}	
						}
					}
				setGraphicSize(Std.int(width * noteScale));
				updateHitbox();
				antialiasing = true;
		}
		var frameN:Array<String> = ['purple', 'blue', 'green', 'red'];
		switch (mania)
		{
			case 1: 
				frameN = ['purple', 'green', 'red', 'yellow', 'blue', 'dark'];
			case 2: 
				if (noteTypeCheck == 'pixel')
					frameN = ['purple', 'blue', 'green', 'red', 'white', 'yellow', 'violet', 'black', 'dark'];
				else
					frameN = ['purple', 'blue', 'green', 'red', 'white', 'yellow', 'violet', FlxG.save.data.noteColor, 'dark'];
			case 3: 
				if (FlxG.save.data.gthc && noteTypeCheck != 'pixel')
					frameN = ['green', 'red', 'yellow', 'dark', 'orange'];
				else
					frameN = ['purple', 'blue', 'white', 'green', 'red'];
			case 4: 
				frameN = ['purple', 'green', 'red', 'white', 'yellow', 'blue', 'dark'];
			case 5: 
				if (noteTypeCheck == 'pixel')
					frameN = ['purple', 'blue', 'green', 'red', 'white', 'yellow', 'violet', 'black', 'dark'];
				else
					frameN = ['purple', 'blue', 'green', 'red', 'yellow', 'violet', FlxG.save.data.noteColor, 'dark'];
			case 6: 
				frameN = ['white'];
			case 7: 
				frameN = ['purple', 'red'];
			case 8: 
				frameN = ['purple', 'white', 'red'];
			case 9:
				frameN = ['purple', 'blue', 'green', 'red', 'orange', 'black', 'yellow', 'violet', 'darkred', 'dark'];

		}

		x += swagWidth * noteData;
		animation.play(frameN[noteData] + 'Scroll');

		// trace(prevNote);

		// we make sure its downscroll and its a SUSTAIN NOTE (aka a trail, not a note)
		// and flip it so it doesn't look weird.
		// THIS DOESN'T FUCKING FLIP THE NOTE, CONTRIBUTERS DON'T JUST COMMENT THIS OUT JESUS
		if (FlxG.save.data.downscroll && sustainNote) 
			flipY = true;

		var stepHeight = (0.45 * Conductor.stepCrochet * FlxMath.roundDecimal(PlayStateChangeables.scrollSpeed == 1 ? PlayState.SONG.speed : PlayStateChangeables.scrollSpeed, 2));


		if (isSustainNote && prevNote != null)
		{
			noteScore * 0.2;
			alpha = 0.6;

			x += width / 2;

			animation.play(frameN[noteData] + 'holdend');

			updateHitbox();

			x -= width / 2;

			if (PlayState.curStage.startsWith('school'))
				x += 30;

			if (prevNote.isSustainNote)
			{

				prevNote.animation.play(frameN[prevNote.noteData] + 'hold');
				prevNote.updateHitbox();



				prevNote.scale.y *= (stepHeight + 1) / prevNote.height; // + 1 so that there's no odd gaps as the notes scroll
				prevNote.updateHitbox();
				prevNote.noteYOff = Math.round(-prevNote.offset.y);

				// prevNote.setGraphicSize();

				noteYOff = Math.round(-offset.y);

				// prevNote.setGraphicSize();
			}
		}
	}


	public function maniaSwitch(newMania:Int) //copy pasted shit so it works
	{
		swagWidth = 160 * 0.7; //factor not the same as noteScale
		noteScale = 0.7;
		pixelnoteScale = 1;
		mania = 0;
		if (newMania == 1)
		{
			swagWidth = 120 * 0.7;
			noteScale = 0.6;
			pixelnoteScale = 0.83;
			mania = 1;
		}
		else if (newMania == 2)
		{
			swagWidth = 95 * 0.7;
			noteScale = 0.5;
			pixelnoteScale = 0.7;
			mania = 2;
		}
		else if (newMania == 3)
			{
				swagWidth = 130 * 0.7;
				noteScale = 0.65;
				pixelnoteScale = 0.9;
				mania = 3;
			}
		else if (newMania == 4)
			{
				swagWidth = 110 * 0.7;
				noteScale = 0.58;
				pixelnoteScale = 0.78;
				mania = 4;
			}
		else if (newMania == 5)
			{
				swagWidth = 100 * 0.7;
				noteScale = 0.55;
				pixelnoteScale = 0.74;
				mania = 5;
			}

		else if (newMania == 6)
			{
				swagWidth = 200 * 0.7;
				noteScale = 0.7;
				pixelnoteScale = 1;
				mania = 6;
			}
		else if (newMania == 7)
			{
				swagWidth = 180 * 0.7;
				noteScale = 0.7;
				pixelnoteScale = 1;
				mania = 7;
			}
		else if (newMania == 8)
			{
				swagWidth = 170 * 0.7;
				noteScale = 0.7;
				pixelnoteScale = 1;
				mania = 8;
			}
		else if (newMania == 9)
			{
				swagWidth = 85 * 0.7;
				noteScale = 0.5;
				pixelnoteScale = 0.7;
				mania = 9;
			}

			var frameN:Array<String> = ['purple', 'blue', 'green', 'red'];
			switch (mania)
			{
				case 1: 
					frameN = ['purple', 'green', 'red', 'yellow', 'blue', 'dark'];
				case 2: 
					frameN = ['purple', 'blue', 'green', 'red', 'white', 'yellow', 'violet', 'black', 'dark'];
				case 3: 
					frameN = ['purple', 'blue', 'white', 'green', 'red'];
				case 4: 
					frameN = ['purple', 'green', 'red', 'white', 'yellow', 'blue', 'dark'];
				case 5: 
					frameN = ['purple', 'blue', 'green', 'red', 'yellow', 'violet', 'black', 'dark'];
				case 6: 
					frameN = ['white'];
				case 7: 
					frameN = ['purple', 'red'];
				case 8: 
					frameN = ['purple', 'white', 'red'];
				case 9: 
					frameN = ['purple', 'blue', 'green', 'red', 'orange', 'black', 'yellow', 'violet', 'black', 'dark'];
			}
	
			//x += swagWidth * noteData;
			animation.play(frameN[noteData] + 'Scroll');
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
		angle = modAngle + localAngle;

		if (!modifiedByLua)
		{
			if (!sustainActive)
			{
				alpha = 0.3;
			}
		}

		if (mustPress)
		{
			if (isSustainNote)
				{
					if (strumTime - Conductor.songPosition <= ((166 * Conductor.timeScale) * 0.5)
						&& strumTime - Conductor.songPosition >= (-166 * Conductor.timeScale) && hitCheck == 0)
						canBeHit = true;
					else
						canBeHit = false;
				}
				else if (burning || death)
				{
					if (strumTime - Conductor.songPosition <= (100 * Conductor.timeScale)
						&& strumTime - Conductor.songPosition >= (-50 * Conductor.timeScale) && hitCheck == 0)
						canBeHit = true;
					else
						canBeHit = false;	
				}
				else
				{
					if (strumTime - Conductor.songPosition <= (166 * Conductor.timeScale)
						&& strumTime - Conductor.songPosition >= (-166 * Conductor.timeScale) && hitCheck == 0)
						canBeHit = true;
					else
						canBeHit = false;
				}
				if (strumTime - Conductor.songPosition < -166 && !wasGoodHit)
					tooLate = true;
			}
			else
			{
				canBeHit = false;
	
				if (strumTime <= Conductor.songPosition)
					wasGoodHit = true;
			}
	
			if (tooLate && !wasGoodHit)
			{
				if (alpha > 0.3)
					alpha = 0.3;
			}
	}
}