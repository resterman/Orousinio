package rooms.utils;

import flash.geom.Point;

class BloodParticle {

	private static var gravity:Float = 0.2;
	private static var friction:Float = 0.9;
	private static var power:Float = 5;
	
	private var xspeed:Float;
	private var yspeed:Float;

	private var _x:Float;
	private var _y:Float;

	public function new(x:Float, y:Float) {
		_x = x;
		_y = y;

		var angle:Float = Math.random() * Math.PI * 2;
		xspeed = Math.cos(angle) * power;
		yspeed = Math.sin(angle) * power;
	}

	public function update():Void {
		xspeed *= friction;
		yspeed += gravity;

		_x += xspeed;
		_y += yspeed;
	}

	public function getPos():Point {
		return new Point(_x, _y);
	}


}
