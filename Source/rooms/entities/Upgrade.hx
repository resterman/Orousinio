package rooms.entities;

import flash.events.Event;
import flash.events.MouseEvent;
import openfl.display.Sprite;

import rooms.screens.*;

class Upgrade extends Sprite {

	public inline static var TRIPLE_SHOT:String = 'tripleShot';
	public inline static var POWER_SHOT:String = 'powerShot';
	public inline static var PROTECT:String = 'protect';
	private inline static var GRAVITY:Float = 0.5;

	private var game:GameStage;
	private var yspeed:Float = 0;

	public function new(game:GameStage) {
		super();

		this.game = game;

		addEventListener(Event.ADDED_TO_STAGE, init);
	}

	private function init(e:Event):Void {
		removeEventListener(Event.ADDED_TO_STAGE, init);

		addEventListener(MouseEvent.MOUSE_DOWN, onClick);
		addEventListener(Event.ENTER_FRAME, onEnter);
	}

	private function onClick(e:MouseEvent):Void {
		removeEventListener(Event.ENTER_FRAME, onEnter);
		removeEventListener(MouseEvent.MOUSE_DOWN, onClick);

		game.removeUpgrade(this);
	}

	private function onEnter(e:Event):Void {
		yspeed += GRAVITY;

		y += yspeed;

		if (y + height > GameStage.FLOOR_Y) {
			y = GameStage.FLOOR_Y - this.height;
			yspeed *= -0.2;
		}
	}

}
