package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.math.FlxMath;
import flixel.util.FlxColor;
import flixel.FlxText;
import Math.random;

using StringTools;

class TextChat extends FlxText
{
    public var textList:Array<String> = [];
    public var curCharacter:String = '';
    public var texts:String = '';
    public var prevMsg:FlxText;
    

    public function new(texts:String = '', fadeTimer:Float, ?textColor:String, ?prevMsg)
    {
        super();

        this.textList = textList;
        this.texts = texts;
        if (prevNote == null)
			prevNote = this;
        this.prevMsg = prevMsg;


    }

    override function update(elapsed:Float)
    {
        super.update(elapsed);
    }

    function addNewDialogue():Void
    {

    }
}