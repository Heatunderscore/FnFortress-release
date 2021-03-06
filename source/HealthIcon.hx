package;

import flixel.FlxSprite;

class HealthIcon extends FlxSprite
{
	/**
	 * Used for FreeplayState! If you use it elsewhere, prob gonna annoying
	 */
	public var sprTracker:FlxSprite;

	public function new(char:String = 'bf', isPlayer:Bool = false)
	{
		super();
		
		loadGraphic(Paths.image('iconGrid'), true, 150, 150);

		antialiasing = true;
		animation.add('bf', [0, 1], 0, false, isPlayer);
		animation.add('bf-sfm', [0, 1], 0, false, isPlayer);
		animation.add('bf-bot', [58, 59], 0, false, isPlayer);
		animation.add('bf-pyro', [46, 44], 0, false, isPlayer);
		animation.add('bf-pyroland', [45, 45], 0, false, isPlayer);
		animation.add('dad', [12, 13], 0, false, isPlayer);
		//animation.add('tob', [10, 11], 0, false, isPlayer);
		//animation.add('tobuh', [12, 13], 0, false, isPlayer);
		//animation.add('tobmad', [14, 15], 0, false, isPlayer);
		animation.add('scunt', [24, 25], 0, false, isPlayer);
		animation.add('scunt-old', [24, 25], 0, false, isPlayer);
		animation.add('sexe', [50, 51], 0, false, isPlayer);
		animation.add('scoutexe', [49, 49], 0, false, isPlayer);
		animation.add('soldier', [40, 41], 0, false, isPlayer);
		animation.add('sodier', [12, 13], 0, false, isPlayer);
		animation.add('trolldier', [12, 13], 0, false, isPlayer);
		animation.add('pyro', [32, 33], 0, false, isPlayer);
		animation.add('pyroland', [56, 57], 0, false, isPlayer);
		animation.add('demo', [26, 27], 0, false, isPlayer);
		animation.add('demo-sfm', [26, 27], 0, false, isPlayer);
		animation.add('heavy', [30, 31], 0, false, isPlayer);
		animation.add('heavy-uber', [30, 31], 0, false, isPlayer);
		animation.add('heavy-box', [50, 51], 0, false, isPlayer);
		animation.add('engi', [34, 35], 0, false, isPlayer);
		animation.add('robo-engi', [34, 35], 0, false, isPlayer);
		animation.add('medic', [36, 37], 0, false, isPlayer);
		animation.add('heavy-uber', [30, 31], 0, false, isPlayer);
		animation.add('medic-bf', [36, 37], 0, false, isPlayer);
		animation.add('sniper', [38, 39], 0, false, isPlayer);
		animation.add('snoiper', [42, 43], 0, false, isPlayer);
		animation.add('spy', [28, 29], 0, false, isPlayer);
		animation.add('senpai', [22, 22], 0, false, isPlayer);
		animation.add('senpai-angry', [22, 22], 0, false, isPlayer);
		animation.add('spirit', [23, 23], 0, false, isPlayer);
		animation.add('bf-old', [14, 15], 0, false, isPlayer);
		animation.add('gf', [16], 0, false, isPlayer);
		animation.add('gf-christmas', [16], 0, false, isPlayer);
		animation.add('gf-pixel', [16], 0, false, isPlayer);
		animation.add('parents-christmas', [17, 18], 0, false, isPlayer);
		animation.add('monster', [19, 20], 0, false, isPlayer);
		animation.add('monster-christmas', [19, 20], 0, false, isPlayer);
		animation.add('saxton', [47, 48], 0, false, isPlayer);
		animation.add('soldierai', [52, 53], 0, false, isPlayer);
		animation.add('demoknight', [54, 55], 0, false, isPlayer);
		animation.play(char);

		/*switch(char)
		{
			case 'bf-pixel' | 'senpai' | 'senpai-angry' | 'spirit' | 'gf-pixel':
				antialiasing = false;
		}*/ 
		//:trol:

		scrollFactor.set();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (sprTracker != null)
			setPosition(sprTracker.x + sprTracker.width + 10, sprTracker.y - 30);
	}
}
