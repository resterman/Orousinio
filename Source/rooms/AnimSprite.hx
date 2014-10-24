package rooms;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.events.Event;
import flash.events.TimerEvent;
import flash.geom.Rectangle;
import flash.geom.Point;
import flash.utils.Timer;
import haxe.ds.StringMap;
import haxe.ds.IntMap;
import openfl.Assets;
import openfl.display.Sprite;

class AnimSprite extends Sprite {

	private var _width:UInt;
	private var _height:UInt;
	private var sprite:Bitmap;
	private var spritesheet:BitmapData;

	private var currentFrame:Int = 0;

	private var aRect:Rectangle;
	private var aPoint:Point;

	private var state:String;
	private var states:StringMap<Array<Int>>;
	private var _startCallbacks:IntMap<Dynamic>;
	private var _endCallbacks:IntMap<Dynamic>;

	private var timer:Timer;

	public function new(w:UInt, h:UInt, path:String, fps:Float) {
		super();
	
		this._width = w;
		this._height = h;
		this.spritesheet = Assets.getBitmapData(path);

		this.aRect = new Rectangle(0, 0, this._width, this._height);
		this.aPoint = new Point(0, 0);
		this.states = new StringMap<Array<Int>>();

		this._startCallbacks = new IntMap<Dynamic>();
		this._endCallbacks = new IntMap<Dynamic>();

		sprite = new Bitmap(new BitmapData(_width, _height, true, 0x00FFFFFF));
		addChild(sprite);

		timer = new Timer(Std.int(1000 / fps));
		timer.addEventListener(TimerEvent.TIMER, onTimer);
	}

	public function getBmpData():BitmapData {
		return sprite.bitmapData;
	}

	public function addState(name:String, frames:Array<Int>):AnimSprite {
		states.set(name, frames);

		return this;
	}

	public function getState():String {
		return this.state;
	}

	public function setState(name:String, ?fps:Float):AnimSprite {
		this.state = name;
		this.currentFrame = states.get(name)[0];
		drawCurrentFrame();

		if (fps != null) {
			timer.delay = Std.int(1000 / fps);
		}

		return this;
	}

	public function setCallback(frame:Int, callback:Dynamic, ?end:Bool = false):Void {
		if (!end)
			_startCallbacks.set(frame, callback);
		else
			_endCallbacks.set(frame, callback);
	}
	
	private function drawCurrentFrame():Void {
		aRect.x = _width * currentFrame;
		sprite.bitmapData.copyPixels(
			spritesheet, aRect, aPoint, false
		);
	}
	
	public function start():Void {
		timer.start();
	}

	private function onTimer(e:TimerEvent):Void {
		// Executing callback at the end of the frame
		if (_endCallbacks.exists(currentFrame)) {
			(_endCallbacks.get(currentFrame))();
		}

		var frames = states.get(state);
		currentFrame++;
		if (currentFrame > frames[frames.length - 1]) {
			currentFrame = frames[0];
		}

		drawCurrentFrame();
	
		// Executing callback at the start of the frame
		if (_startCallbacks.exists(currentFrame)) {
			(_startCallbacks.get(currentFrame))();
		}
	}

	public function destroy():Void {
		timer.stop();
		timer.removeEventListener(TimerEvent.TIMER, onTimer);
	}

}
