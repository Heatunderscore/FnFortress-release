package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.animation.FlxBaseAnimation;
import flixel.graphics.frames.FlxAtlasFrames;

using StringTools;

class Character extends FlxSprite
{
	public var animOffsets:Map<String, Array<Dynamic>>;
	public var debugMode:Bool = false;

	public var isPlayer:Bool = false;
	public var curCharacter:String = 'bf';

	public var holdTimer:Float = 0;

	public function new(x:Float, y:Float, ?character:String = "bf", ?isPlayer:Bool = false)
	{
		super(x, y);

		animOffsets = new Map<String, Array<Dynamic>>();
		curCharacter = character;
		this.isPlayer = isPlayer;

		var tex:FlxAtlasFrames;
		antialiasing = true;

		switch (curCharacter)
		{
			case 'gf':
				// GIRLFRIEND CODE
				tex = Paths.getSparrowAtlas('characters/GF_assets');
				frames = tex;
				animation.addByPrefix('cheer', 'GF Cheer', 24, false);
				animation.addByPrefix('singLEFT', 'GF left note', 24, false);
				animation.addByPrefix('singRIGHT', 'GF Right Note', 24, false);
				animation.addByPrefix('singUP', 'GF Up Note', 24, false);
				animation.addByPrefix('singDOWN', 'GF Down Note', 24, false);
				animation.addByIndices('sad', 'gf sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
				animation.addByIndices('hairBlow', "GF Dancing Beat Hair blowing", [0, 1, 2, 3], "", 24);
				animation.addByIndices('hairFall', "GF Dancing Beat Hair Landing", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], "", 24, false);
				animation.addByPrefix('scared', 'GF FEAR', 24);

				addOffset('cheer');
				addOffset('sad', -2, -2);
				addOffset('danceLeft', 0, -9);
				addOffset('danceRight', 0, -9);

				addOffset("singUP", 0, 4);
				addOffset("singRIGHT", 0, -20);
				addOffset("singLEFT", 0, -19);
				addOffset("singDOWN", 0, -20);
				addOffset('hairBlow', 45, -8);
				addOffset('hairFall', 0, -9);

				addOffset('scared', -2, -17);

				playAnim('danceRight');

			case 'gf-christmas':
				tex = Paths.getSparrowAtlas('characters/gfChristmas');
				frames = tex;
				animation.addByPrefix('cheer', 'GF Cheer', 24, false);
				animation.addByPrefix('singLEFT', 'GF left note', 24, false);
				animation.addByPrefix('singRIGHT', 'GF Right Note', 24, false);
				animation.addByPrefix('singUP', 'GF Up Note', 24, false);
				animation.addByPrefix('singDOWN', 'GF Down Note', 24, false);
				animation.addByIndices('sad', 'gf sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
				animation.addByIndices('hairBlow', "GF Dancing Beat Hair blowing", [0, 1, 2, 3], "", 24);
				animation.addByIndices('hairFall', "GF Dancing Beat Hair Landing", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], "", 24, false);
				animation.addByPrefix('scared', 'GF FEAR', 24);

				addOffset('cheer');
				addOffset('sad', -2, -2);
				addOffset('danceLeft', 0, -9);
				addOffset('danceRight', 0, -9);

				addOffset("singUP", 0, 4);
				addOffset("singRIGHT", 0, -20);
				addOffset("singLEFT", 0, -19);
				addOffset("singDOWN", 0, -20);
				addOffset('hairBlow', 45, -8);
				addOffset('hairFall', 0, -9);

				addOffset('scared', -2, -17);

				playAnim('danceRight');

			case 'gf-car':
				tex = Paths.getSparrowAtlas('characters/gfCar');
				frames = tex;
				animation.addByIndices('singUP', 'GF Dancing Beat Hair blowing CAR', [0], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat Hair blowing CAR', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat Hair blowing CAR', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24,
					false);

				addOffset('danceLeft', 0);
				addOffset('danceRight', 0);

				playAnim('danceRight');

			case 'gf-pixel':
				tex = Paths.getSparrowAtlas('characters/gfPixel');
				frames = tex;
				animation.addByIndices('singUP', 'GF IDLE', [2], "", 24, false);
				animation.addByIndices('danceLeft', 'GF IDLE', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF IDLE', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);

				addOffset('danceLeft', 0);
				addOffset('danceRight', 0);

				playAnim('danceRight');

				setGraphicSize(Std.int(width * PlayState.daPixelZoom));
				updateHitbox();
				antialiasing = false;

			case 'dad':
				// DAD ANIMATION LOADING CODE
				tex = Paths.getSparrowAtlas('characters/DADDY_DEAREST', 'shared');
				frames = tex;
				animation.addByPrefix('idle', 'Dad idle dance', 24);
				animation.addByPrefix('singUP', 'Dad Sing Note UP', 24);
				animation.addByPrefix('singRIGHT', 'Dad Sing Note RIGHT', 24);
				animation.addByPrefix('singDOWN', 'Dad Sing Note DOWN', 24);
				animation.addByPrefix('singLEFT', 'Dad Sing Note LEFT', 24);

				addOffset('idle');
				addOffset("singUP", -6, 50);
				addOffset("singRIGHT", 0, 27);
				addOffset("singLEFT", -10, 10);
				addOffset("singDOWN", 0, -30);

				playAnim('idle');
				
			case 'scunt':
				// new scunt
				tex = Paths.getSparrowAtlas('characters/scunt', 'shared');
				frames = tex;
				animation.addByPrefix('idle', 'Scout_Idle', 24, false);
				animation.addByPrefix('singUP', 'Scout_Up', 24, false);
				animation.addByPrefix('singRIGHT', 'Scout_Right', 24, false);
				animation.addByPrefix('singDOWN', 'Scout_Down', 24, false);
				animation.addByPrefix('singLEFT', 'Scout_Left', 24, false);

				addOffset('idle');
				addOffset("singUP", 230, 30);
				addOffset("singRIGHT", 150, 0);
				addOffset("singLEFT", 20, 0);
				addOffset("singDOWN", 39, -92);

				playAnim('idle');

			case 'scunt-old':
				// old scunt
				tex = Paths.getSparrowAtlas('characters/scoutOLD', 'shared');
				frames = tex;
				animation.addByPrefix('idle', 'Scout_Idle', 24, false);
				animation.addByPrefix('singUP', 'Scout_Up', 24, false);
				animation.addByPrefix('singRIGHT', 'Scout_Right', 24, false);
				animation.addByPrefix('singDOWN', 'Scout_Down', 24, false);
				animation.addByPrefix('singLEFT', 'Scout_Left', 24, false);

				addOffset('idle');
				addOffset("singUP", 340, 0);
				addOffset("singRIGHT", 140, -30);
				addOffset("singLEFT", 20, -30);
				addOffset("singDOWN", 30, -150);

				playAnim('idle');

			case 'sexe':
				// SCARY!!!11!1oneeone
				tex = Paths.getSparrowAtlas('characters/scoutexe', 'shared');
				frames = tex;
				animation.addByPrefix('idle', 'exe idle', 24, true);
				animation.addByPrefix('singUP', 'exe up', 24, false);
				animation.addByPrefix('singRIGHT', 'exe right', 24, false);
				animation.addByPrefix('singDOWN', 'exe down', 24, false);
				animation.addByPrefix('singLEFT', 'exe left', 24, false);

				addOffset('idle');
				addOffset("singUP", -10, 166);
				addOffset("singRIGHT", 0, 38);
				addOffset("singLEFT", 512, 45);
				addOffset("singDOWN", 118, 49);

				playAnim('idle');

			case 'soldier':
				// soldier shitting on you
				tex = Paths.getSparrowAtlas('characters/soldier', 'shared');
				frames = tex;
				animation.addByPrefix('idle', 'soldier idle', 24, false);
				animation.addByPrefix('singUP', 'soldier up', 24, false);
				animation.addByPrefix('singRIGHT', 'soldier right', 24, false);
				animation.addByPrefix('singDOWN', 'soldier down', 24, false);
				animation.addByPrefix('singLEFT', 'soldier left', 24, false);
				// shit anim
				animation.addByPrefix('shit', 'soldier shoot', 24, false);

				addOffset('idle');
				addOffset("singUP", 70, 100);
				addOffset("singRIGHT", 20, -40);
				addOffset("singLEFT", 370, -80);
				addOffset("singDOWN", 70, -200);
				// shit offsets
				addOffset("shit", 41, 33);

				playAnim('idle');

			case 'soldierai':
					tex = Paths.getSparrowAtlas('characters/soldierai', 'shared');
					frames = tex;
					animation.addByPrefix('idle', 'soldierai idle', 24, false);
					animation.addByPrefix('singUP', 'soldierai up', 24, false);
					animation.addByPrefix('singRIGHT', 'soldierai right', 24, false);
					animation.addByPrefix('singDOWN', 'soldierai down', 24, false);
					animation.addByPrefix('singLEFT', 'soldierai left', 24, false);
					animation.addByPrefix('slash', 'soldierai slash', 24, false);

					animation.addByPrefix('idle-alt', 'soldierai idle alt', 24, false);
					animation.addByPrefix('singUP-alt', 'soldierai up alt', 24, false);
					animation.addByPrefix('singRIGHT-alt', 'soldierai right alt', 24, false);
					animation.addByPrefix('singDOWN-alt', 'soldierai down alt', 24, false);
					animation.addByPrefix('singLEFT-alt', 'soldierai left alt', 24, false);
					animation.addByPrefix('slash-alt', 'soldierai slash alt', 24, false);
	
					addOffset('idle');
					addOffset("singUP", 70, 100);
					addOffset("singRIGHT", 20, -40);
					addOffset("singLEFT", 370, -80);
					addOffset("singDOWN", 70, -200);
					addOffset("slash", 41, 33);

					addOffset('idle-alt');
					addOffset("singUP-alt", 70, 100);
					addOffset("singRIGHT-alt", 20, -40);
					addOffset("singLEFT-alt", 370, -80);
					addOffset("singDOWN-alt", 70, -200);
					addOffset("slash-alt", 41, 33);
	
					playAnim('idle');
			case 'sodier':
				// sod
				//
				//
				//
				// bottom text
				tex = Paths.getSparrowAtlas('characters/sodier', 'shared');
				frames = tex;
				animation.addByPrefix('idle', 'idle s', 24, false);
				animation.addByPrefix('singUP', 'up s', 24, false);
				animation.addByPrefix('singRIGHT', 'right s', 24, false);
				animation.addByPrefix('singDOWN', 'down s', 24, false);
				animation.addByPrefix('singLEFT', 'left s', 24, false);

				addOffset('idle');
				//420 lololololololo funny number omg omg omg
				addOffset("singUP", -420, 160);
				addOffset("singRIGHT", -350, -50);
				addOffset("singLEFT", -40, -50);
				addOffset("singDOWN", -40, -40);

				playAnim('idle');

			case 'pyro':
				tex = Paths.getSparrowAtlas('characters/Pyro', 'shared');
				frames = tex;
				animation.addByPrefix('idle', 'Pyro_Idle', 24, false);
				animation.addByPrefix('singUP', 'Pyro_Up', 24, false);
				animation.addByPrefix('singRIGHT', 'Pyro_Right', 24, false);
				animation.addByPrefix('singDOWN', 'Pyro_Down', 24, false);
				animation.addByPrefix('singLEFT', 'Pyro_Left', 24, false);

				animation.addByPrefix('idle-alt', 'PyroP_Idle', 24, true);
				animation.addByPrefix('singUP-alt', 'PyroP_Up', 24, false);
				animation.addByPrefix('singRIGHT-alt', 'PyroP_Right', 24, false);
				animation.addByPrefix('singDOWN-alt', 'PyroP_Down', 24, false);
				animation.addByPrefix('singLEFT-alt', 'PyroP_Left', 24, false);

				addOffset('idle');
                addOffset("singDOWN", 90, -154);
                addOffset("singRIGHT" , -80, -40);
                addOffset("singUP" , 99, 289);
                addOffset("singLEFT" , 61, -17);

				addOffset('idle-alt');
                addOffset("singDOWN-alt", 100, -154);
                addOffset("singRIGHT-alt" , -79, 0);
                addOffset("singUP-alt" , 62, 251);
                addOffset("singLEFT-alt" , 90, -16);

				playAnim('idle');

			case 'demo':
				tex = Paths.getSparrowAtlas('characters/demo', 'shared');
				frames = tex;
				animation.addByPrefix('idle', 'Demo Idle', 24, false);
				animation.addByPrefix('singUP', 'Demo Up', 24, false);
				animation.addByPrefix('singRIGHT', 'Demo Right', 24, false);
				animation.addByPrefix('singDOWN', 'Demo Down', 24, false);
				animation.addByPrefix('singLEFT', 'Demo Left', 24, false);

				addOffset('idle');
				addOffset("singUP", -115, 125);
				addOffset("singRIGHT", -137, -28);
				addOffset("singLEFT", -52, 10);
				addOffset("singDOWN", -26, -192);

				playAnim('idle');

			case 'heavy':
				tex = Paths.getSparrowAtlas('characters/heavy', 'shared');
				frames = tex;
				animation.addByPrefix('idle', 'Heavy_Idle', 24, false);
				animation.addByPrefix('singUP', 'Heavy_Up', 24, false);
				animation.addByPrefix('singRIGHT', 'Heavy_Right', 24, false);
				animation.addByPrefix('singDOWN', 'Heavy_Down', 24, false);
				animation.addByPrefix('singLEFT', 'Heavy_Left', 24, false);

				animation.addByPrefix('idle-alt', 'Heavyu_Idle', 24, true);
				animation.addByPrefix('singUP-alt', 'Heavyu_Up', 24, false);
				animation.addByPrefix('singRIGHT-alt', 'Heavyu_Right', 24, false);
				animation.addByPrefix('singDOWN-alt', 'Heavyu_Down', 24, false);
				animation.addByPrefix('singLEFT-alt', 'Heavyu_Left', 24, false);

				addOffset('idle');
                addOffset("singDOWN", -101, -35);
                addOffset("singRIGHT" , 144, -91);
                addOffset("singUP" , -6, 151);
                addOffset("singLEFT" , -8, 25);

				addOffset('idle-alt');
                addOffset("singDOWN-alt", -101, -35);
                addOffset("singRIGHT-alt" , 144, -91);
                addOffset("singUP-alt" , -6, 151);
                addOffset("singLEFT-alt" , -8, 25);

				playAnim('idle');

			case 'engi':
				tex = Paths.getSparrowAtlas('characters/engi', 'shared');
				frames = tex;
				animation.addByPrefix('idle', 'engi idle', 24, false);
				animation.addByPrefix('singUP', 'engi up', 24, false);
				animation.addByPrefix('singRIGHT', 'engi right', 24, false);
				animation.addByPrefix('singDOWN', 'engi down', 24, false);
				animation.addByPrefix('singLEFT', 'engi left', 24, false);

				// this was my idea heheeheehheheehhehehehehhehehhe -tob
				if (isPlayer)
				{
					addOffset('idle');
					addOffset("singDOWN", 180, -67);
					addOffset("singRIGHT" , 128, -3);
					addOffset("singUP" , 52, 278);
					addOffset("singLEFT" , 90, -7);
				}
				else
				{	
					addOffset('idle');
                    addOffset("singDOWN", 0, -67);
					addOffset("singRIGHT" , -83, -3);
					addOffset("singUP" , -28, 278);
					addOffset("singLEFT" , -32, -7);
				}


				playAnim('idle');

			case 'robo-engi':
				tex = Paths.getSparrowAtlas('characters/roboengi', 'shared');
				frames = tex;
				animation.addByPrefix('idle', 'robo engi idle', 24, false);
				animation.addByPrefix('singUP', 'robo engi up', 24, false);
				animation.addByPrefix('singRIGHT', 'robo engi right', 24, false);
				animation.addByPrefix('singDOWN', 'robo engi down', 24, false);
				animation.addByPrefix('singLEFT', 'robo engi left', 24, false);

				addOffset('idle');
                addOffset("singDOWN", 4, -38);
                addOffset("singRIGHT" , -6, -2);
                addOffset("singUP" , -6, 30);
                addOffset("singLEFT" , -2, -2);

				playAnim('idle');

			case 'medic':
				tex = Paths.getSparrowAtlas('characters/medic', 'shared');
				frames = tex;
				animation.addByPrefix('idle', 'medic_idle', 24, false);
				animation.addByPrefix('singUP', 'medic_up', 24, false);
				animation.addByPrefix('singRIGHT', 'medic_right', 24, false);
				animation.addByPrefix('singDOWN', 'medic_down', 24, false);
				animation.addByPrefix('singLEFT', 'medic_left', 24, false);

				animation.addByPrefix('idle-beam', 'medich_idle', 24, true);

				animation.addByPrefix('idle-alt', 'medicu_idle', 24, true);
				animation.addByPrefix('singRIGHT-alt', 'medicu_right', 24, false);
				animation.addByPrefix('singLEFT-alt', 'medicu_left', 24, false);

				addOffset('idle');
                addOffset("singDOWN", 52, -122);
                addOffset("singRIGHT" , -38, 51);
                addOffset("singUP" , -12, 20);
                addOffset("singLEFT" , 188, 51);

				addOffset('idle-beam');		

				addOffset('idle-alt');
                addOffset("singRIGHT-alt" , -40, 52);
                addOffset("singLEFT-alt" , 188, 51);

				playAnim('idle');

			case 'medic-bf':
				tex = Paths.getSparrowAtlas('characters/medicBF', 'shared');
				frames = tex;
				animation.addByPrefix('idle', 'medic_idle', 24, false);
				animation.addByPrefix('singUP', 'medic_up', 24, false);
				animation.addByPrefix('singRIGHT', 'medic_right', 24, false);
				animation.addByPrefix('singDOWN', 'medic_down', 24, false);
				animation.addByPrefix('singLEFT', 'medic_left', 24, false);

				animation.addByPrefix('firstDeath', "medic death", 24, false);
				animation.addByPrefix('deathLoop', "medic balls beat", 24, true);
				animation.addByPrefix('deathConfirm', "medic confirm", 24, false);

				if (isPlayer)
				{
					addOffset('idle');
					addOffset("singDOWN", -108, -122);
					addOffset("singRIGHT" , -142, 51);
					addOffset("singUP" , -132, 20);
					addOffset("singLEFT" , 97, 51);
				}
				else
				{
					addOffset('idle');
					addOffset("singDOWN", 52, -122);
					addOffset("singRIGHT" , -38, 51);
					addOffset("singUP" , -12, 20);
					addOffset("singLEFT" , 188, 51);
				}

				addOffset('firstDeath', 180, 100);
				addOffset('deathLoop', 180, -256);
				addOffset('deathConfirm', 230, 100);
	
				playAnim('idle');
			case 'sniper':
				tex = Paths.getSparrowAtlas('characters/sniper');
				frames = tex;
				animation.addByPrefix('idle', "idle", 24, false);
				animation.addByPrefix('singUP', 'up', 24, false);
				animation.addByPrefix('singDOWN', 'down', 24, false);
				// animator is a dum dum and swapped left and right 
				animation.addByPrefix('singRIGHT', 'left', 24, false);
				animation.addByPrefix('singLEFT', 'right', 24, false);
				animation.addByPrefix('singDOWN-alt', 'laugh', 24, false);


				addOffset('idle');
				addOffset("singUP", 76, 168);
				addOffset("singRIGHT", 7, 14);
				addOffset("singLEFT", 102, -15);
				addOffset("singDOWN", -54, -4);
				addOffset("singDOWN-alt", -54, -4);

				playAnim('idle');

			case 'snoiper':
				tex = Paths.getSparrowAtlas('characters/snoiper gaming');
				frames = tex;
				animation.addByPrefix('idle', "Pico Idle Dance", 24, false);
				animation.addByPrefix('singUP', 'pico Up note0', 24, false);
				animation.addByPrefix('singDOWN', 'Pico Down Note0', 24, false);
				animation.addByPrefix('singRIGHT', 'Pico Note Right0', 24, false);
				animation.addByPrefix('singLEFT', 'Pico NOTE LEFT0', 24, false);
				animation.addByPrefix('shot', 'shooting', 24, false);

				addOffset('idle');
				addOffset("singUP", -110, 290);
				addOffset("singRIGHT", -110, 70);
				addOffset("singLEFT", -10, -30);
				addOffset("singDOWN", -70, -90);
				addOffset("shot", -47, -90);

				playAnim('idle');

			case 'spy':
				tex = Paths.getSparrowAtlas('characters/spy', 'shared');
				frames = tex;
				animation.addByPrefix('idle', 'Spy Idle', 24, false);
				animation.addByPrefix('singUP', 'Spy Up', 24, false);
				animation.addByPrefix('singRIGHT', 'Spy Right', 24, false);
				animation.addByPrefix('singDOWN', 'Spy Down', 24, false);
				animation.addByPrefix('singLEFT', 'Spy Left', 24, false);

				addOffset('idle');
				addOffset("singUP", 0, 0);
				addOffset("singRIGHT", 0, 0);
				addOffset("singLEFT", 0, 0);
				addOffset("singDOWN", 0, 0);

				playAnim('idle');
			case 'saxton':
				tex = Paths.getSparrowAtlas('characters/saxtonhal', 'shared');
				frames = tex;
				animation.addByPrefix('idle', 'idle', 24);
				animation.addByPrefix('singUP', 'up', 24);
				animation.addByPrefix('singRIGHT', 'right', 24);
				animation.addByPrefix('singDOWN', 'down', 24);
				animation.addByPrefix('singLEFT', 'left', 24);
		
				addOffset('idle');
				addOffset("singUP", 44, 50);
				addOffset("singRIGHT", -70, -143);
				addOffset("singLEFT", 400, -20);
				addOffset("singDOWN", -80, -160);
		
				playAnim('idle');

			case 'bf':
				var tex = Paths.getSparrowAtlas('characters/BOYFRIEND', 'shared');
				frames = tex;

				trace(tex.frames.length);

				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
				animation.addByPrefix('hey', 'BF HEY!!', 24, false);
				animation.addByPrefix('hit', 'BF hit', 24, false);
				animation.addByPrefix('dodge', 'boyfriend dodge', 24, false);


				animation.addByPrefix('firstDeath', "BF dies", 24, false);
				animation.addByPrefix('deathLoop', "BF Dead Loop", 24, true);
				animation.addByPrefix('deathConfirm', "BF Dead confirm", 24, false);

				animation.addByPrefix('scared', 'BF idle shaking', 24);

				addOffset('idle', -5);
				addOffset("singUP", -29, 27);
				addOffset("singRIGHT", -38, -7);
				addOffset("singLEFT", 12, -6);
				addOffset("singDOWN", -10, -50);
				addOffset("singUPmiss", -29, 27);
				addOffset("singRIGHTmiss", -30, 21);
				addOffset("singLEFTmiss", 12, 24);
				addOffset("singDOWNmiss", -11, -19);
				addOffset("hey", 7, 4);
				addOffset("hit", 12, 20);
				addOffset("dodge", -10, -16);
				addOffset('firstDeath', 37, 11);
				addOffset('deathLoop', 37, 5);
				addOffset('deathConfirm', 37, 69);
				addOffset('scared', -4);

				playAnim('idle');

				flipX = true;

			case 'bf-pyro':
				var tex = Paths.getSparrowAtlas('characters/BOYFRIEND', 'shared');
				frames = tex;

				trace(tex.frames.length);

				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
				animation.addByPrefix('hey', 'BF HEY', 24, false);
				animation.addByPrefix('hit', 'BF hit', 24, false);
				animation.addByPrefix('dodge', 'boyfriend dodge', 24, false);


				animation.addByPrefix('firstDeath', "BF dies", 24, false);
				animation.addByPrefix('deathLoop', "BF Dead Loop", 24, true);
				animation.addByPrefix('deathConfirm', "BF Dead confirm", 24, false);

				animation.addByPrefix('scared', 'BF idle shaking', 24);

				addOffset('idle', -5);
				addOffset("singUP", -29, 27);
				addOffset("singRIGHT", -38, -7);
				addOffset("singLEFT", 12, -6);
				addOffset("singDOWN", -10, -50);
				addOffset("singUPmiss", -29, 27);
				addOffset("singRIGHTmiss", -30, 21);
				addOffset("singLEFTmiss", 12, 24);
				addOffset("singDOWNmiss", -11, -19);
				addOffset("hey", 7, 4);
				addOffset("hit", 7, 4);
				addOffset("dodge", 7, 4);
				addOffset('firstDeath', 37, 11);
				addOffset('deathLoop', 37, 5);
				addOffset('deathConfirm', 37, 69);
				addOffset('scared', -4);

				playAnim('idle');

				flipX = true;

			case 'bf-christmas':
				var tex = Paths.getSparrowAtlas('characters/bfChristmas');
				frames = tex;
				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
				animation.addByPrefix('hey', 'BF HEY', 24, false);

				addOffset('idle', -5);
				addOffset("singUP", -29, 27);
				addOffset("singRIGHT", -38, -7);
				addOffset("singLEFT", 12, -6);
				addOffset("singDOWN", -10, -50);
				addOffset("singUPmiss", -29, 27);
				addOffset("singRIGHTmiss", -30, 21);
				addOffset("singLEFTmiss", 12, 24);
				addOffset("singDOWNmiss", -11, -19);
				addOffset("hey", 7, 4);

				playAnim('idle');

				flipX = true;
			case 'bf-car':
				var tex = Paths.getSparrowAtlas('characters/bfCar');
				frames = tex;
				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);

				addOffset('idle', -5);
				addOffset("singUP", -29, 27);
				addOffset("singRIGHT", -38, -7);
				addOffset("singLEFT", 12, -6);
				addOffset("singDOWN", -10, -50);
				addOffset("singUPmiss", -29, 27);
				addOffset("singRIGHTmiss", -30, 21);
				addOffset("singLEFTmiss", 12, 24);
				addOffset("singDOWNmiss", -11, -19);
				playAnim('idle');

				flipX = true;
			case 'bf-pixel':
				frames = Paths.getSparrowAtlas('characters/bfPixel');
				animation.addByPrefix('idle', 'BF IDLE', 24, false);
				animation.addByPrefix('singUP', 'BF UP NOTE', 24, false);
				animation.addByPrefix('singLEFT', 'BF LEFT NOTE', 24, false);
				animation.addByPrefix('singRIGHT', 'BF RIGHT NOTE', 24, false);
				animation.addByPrefix('singDOWN', 'BF DOWN NOTE', 24, false);
				animation.addByPrefix('singUPmiss', 'BF UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF DOWN MISS', 24, false);

				addOffset('idle');
				addOffset("singUP");
				addOffset("singRIGHT");
				addOffset("singLEFT");
				addOffset("singDOWN");
				addOffset("singUPmiss");
				addOffset("singRIGHTmiss");
				addOffset("singLEFTmiss");
				addOffset("singDOWNmiss");

				setGraphicSize(Std.int(width * 6));
				updateHitbox();

				playAnim('idle');

				width -= 100;
				height -= 100;

				antialiasing = false;

				flipX = true;
			case 'bf-pixel-dead':
				frames = Paths.getSparrowAtlas('characters/bfPixelsDEAD');
				animation.addByPrefix('singUP', "BF Dies pixel", 24, false);
				animation.addByPrefix('firstDeath', "BF Dies pixel", 24, false);
				animation.addByPrefix('deathLoop', "Retry Loop", 24, true);
				animation.addByPrefix('deathConfirm', "RETRY CONFIRM", 24, false);
				animation.play('firstDeath');

				addOffset('firstDeath');
				addOffset('deathLoop', -37);
				addOffset('deathConfirm', -37);
				playAnim('firstDeath');
				// pixel bullshit
				setGraphicSize(Std.int(width * 6));
				updateHitbox();
				antialiasing = false;
				flipX = true;
		}

		dance();
		

		if (isPlayer)
		{
			flipX = !flipX;

			// Doesn't flip for BF, since his are already in the right place???
			if (!curCharacter.startsWith('bf'))
			{
				// var animArray
				var oldRight = animation.getByName('singRIGHT').frames;
				animation.getByName('singRIGHT').frames = animation.getByName('singLEFT').frames;
				animation.getByName('singLEFT').frames = oldRight;

				// IF THEY HAVE MISS ANIMATIONS??
				if (animation.getByName('singRIGHTmiss') != null)
				{
					var oldMiss = animation.getByName('singRIGHTmiss').frames;
					animation.getByName('singRIGHTmiss').frames = animation.getByName('singLEFTmiss').frames;
					animation.getByName('singLEFTmiss').frames = oldMiss;
				}
			}
		}
	}

	override function update(elapsed:Float)
	{
		if (!curCharacter.startsWith('bf') && !curCharacter.startsWith('medic-bf') && !curCharacter.startsWith('engi'))
		{
			if (animation.curAnim.name.startsWith('sing'))
			{
				holdTimer += elapsed;
			}

			var dadVar:Float = 4;

			if (curCharacter == 'dad')
				dadVar = 6.1;
			if (holdTimer >= Conductor.stepCrochet * dadVar * 0.001)
			{
				//trace('dance');
				dance();
				holdTimer = 0;
			}
		}

		switch (curCharacter)
		{
			case 'gf':
				if (animation.curAnim.name == 'hairFall' && animation.curAnim.finished)
					playAnim('danceRight');
		}

		super.update(elapsed);
	}

	private var danced:Bool = false;

	/**
	 * FOR GF DANCING SHIT
	 */
	public function dance()
	{
		if (!debugMode)
		{
			switch (curCharacter)
			{
				case 'gf':
					if (!animation.curAnim.name.startsWith('hair'))
					{
						danced = !danced;

						if (danced)
							playAnim('danceRight');
						else
							playAnim('danceLeft');
					}

				case 'gf-christmas':
					if (!animation.curAnim.name.startsWith('hair'))
					{
						danced = !danced;

						if (danced)
							playAnim('danceRight');
						else
							playAnim('danceLeft');
					}

				case 'gf-car':
					if (!animation.curAnim.name.startsWith('hair'))
					{
						danced = !danced;

						if (danced)
							playAnim('danceRight');
						else
							playAnim('danceLeft');
					}
				case 'gf-pixel':
					if (!animation.curAnim.name.startsWith('hair'))
					{
						danced = !danced;

						if (danced)
							playAnim('danceRight');
						else
							playAnim('danceLeft');
					}

				case 'spooky':
					danced = !danced;

					if (danced)
						playAnim('danceRight');
					else
						playAnim('danceLeft');
				default:
					playAnim('idle');
			}
		}
	}

	public function idleEnd(?ignoreDebug:Bool = false)
		{
			if (!debugMode || ignoreDebug)
			{
				switch (curCharacter)
				{
					case 'gf' | 'gf-car' | 'gf-christmas' | 'gf-pixel' | "spooky":
						playAnim('danceRight', true, false, animation.getByName('danceRight').numFrames - 1);
					default:
						playAnim('idle', true, false, animation.getByName('idle').numFrames - 1);
				}
			}
		}

	public function playAnim(AnimName:String, Force:Bool = false, Reversed:Bool = false, Frame:Int = 0):Void
	{
		animation.play(AnimName, Force, Reversed, Frame);

		var daOffset = animOffsets.get(AnimName);
		if (animOffsets.exists(AnimName))
		{
			offset.set(daOffset[0], daOffset[1]);
		}
		else
			offset.set(0, 0);

		if (curCharacter == 'gf')
		{
			if (AnimName == 'singLEFT')
			{
				danced = true;
			}
			else if (AnimName == 'singRIGHT')
			{
				danced = false;
			}

			if (AnimName == 'singUP' || AnimName == 'singDOWN')
			{
				danced = !danced;
			}
		}
	}

	public function addOffset(name:String, x:Float = 0, y:Float = 0)
	{
		animOffsets[name] = [x, y];
	}
}
