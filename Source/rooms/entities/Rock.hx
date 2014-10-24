package rooms.entities;

import flash.events.Event;
import flash.geom.Point;
import openfl.display.Sprite;

import rooms.screens.GameStage;
import rooms.entities.enemies.*;

class Rock extends Sprite {

	private var maxSpeed:Float;
	private var xspeed:Float;
	private var yspeed:Float;

	private var _damage:Float;
	private var weigth:Float = 0.1;
	private var xAirFriction:Float = 0.99;
	private var gravity:Float = 0.2;
	private var xFloorFriction:Float = 0.8;
	private var yFloorFriction:Float = -0.3;

	public var powerShot:Bool = false;

	public function new(angle:Float, speed:Float, damage:Float) {
		super();

		maxSpeed = speed;
		xspeed = Math.cos(angle) * speed;
		yspeed = Math.sin(angle) * speed;

		this._damage = damage;

		addEventListener(Event.ADDED_TO_STAGE, init);
	}

	private function init(e:Event):Void {
		removeEventListener(Event.ADDED_TO_STAGE, init);
		
		if (powerShot) graphics.beginFill(0xCCCCCC);
		else graphics.beginFill(0x333333);
		graphics.drawRect(0, 0, 3, 3);
		graphics.endFill();
	}

	public function update():Void {
		yspeed += gravity + weigth;

		x += xspeed;
		y += yspeed;

		if (y > GameStage.FLOOR_Y - height) {
			xspeed *= xFloorFriction;
			yspeed *= yFloorFriction;

			y = GameStage.FLOOR_Y - height;
		}
	}

	public function isStill():Bool {
		return Math.sqrt(yspeed * yspeed + xspeed * xspeed)
			< 0.1;
	}

	public function damage(enemy:Enemy, rock:Rock):Void {
		var currentSpeed = Math.sqrt(xspeed * xspeed + yspeed * yspeed);
		enemy.takeDamage(this._damage * currentSpeed / maxSpeed, rock);
	}

	public function getNextPosition():Point {
		return new Point(
			x + xspeed,
			y + yspeed + gravity + weigth
		);
	}

}
