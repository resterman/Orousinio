package rooms.utils;

import rooms.entities.*;
import rooms.entities.enemies.*;

class StageBars {

	private var enemies:Array<Array<Enemy>>;
	private var barWidth:Float;
	private var stageWidth:Float;

	public function new(barWidth:Float, stageWidth:Float) {
		this.barWidth = barWidth;
		this.stageWidth = stageWidth;

		this.enemies = new Array<Array<Enemy>>();
	}

	public function clear():Void {
		var i:Float = 0;
		while (i < this.stageWidth) {
			enemies[Std.int(i / barWidth)]
				= new Array<Enemy>();

			i += this.barWidth;
		}
	}

	public function insertEnemy(enemy:Enemy) {
		if (enemy.x + enemy.width < 0 || enemy.x > stageWidth) return;

		var left = getBar(enemy.x);
		left = (left == null) ? 0 : left;
		var right = getBar(enemy.x + enemy.width);
		right = (right == null) ? 0 : right;

		var i = left;
		while (i <= right) {
			enemies[i].push(enemy);
			i++;
		}
	}

	public function getEnemies(bar:Int):Array<Enemy> {
		return enemies[bar];
	}

	public function getBar(x:Float):Null<Int> {
		if (x < 0 || x > stageWidth) return null;

		return Std.int(x / barWidth);
	}

}
