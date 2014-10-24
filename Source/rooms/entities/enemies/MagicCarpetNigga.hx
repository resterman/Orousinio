package rooms.entities.enemies;

import flash.events.Event;
import flash.geom.Rectangle;

import rooms.screens.GameStage;

class MagicCarpetNigga extends Enemy {

	private static var MAX_HEALTH:Float = 4;
	private static var MIN_HEALTH:Float = 3.5;
	private static var MAX_SPEED:Float = 2;
	private static var MIN_SPEED:Float = 2;
	private static var MAX_DAMAGE:Float = 2;
	private static var MIN_DAMAGE:Float = 1;
	private static var MAX_PARTICLES:Int = 6;
	private static var MIN_PARTICLES:Int = 4;

	private static var SPRITE_WIDTH:Int = 18;
	private static var SPRITE_HEIGHT:Int = 25;
	private static var SPRITE_PATH:String = 'assets/spritesheets/enemy6.png';
	private static var FPS:Int = 3;
	private static var ATTACK_FRAME:Int = 4;

	private static var INITIAL_Y:Int = 225;
	private static var ANGLE_UNIT:Float = Math.PI * 2 / 360;
	private static var APERTURE:Float = 20;

	private var startY:Float;
	private var angle:Float = 0;

	public function new(game:GameStage) {
		super(game);

		super.setStats(
			MAX_HEALTH, MIN_HEALTH,
			MAX_SPEED, MIN_SPEED,
			MAX_DAMAGE, MIN_DAMAGE,
			MAX_PARTICLES, MIN_PARTICLES
		);
		super.addCriticalZone(new Rectangle(5, 0, 6, 6));
		
		initSprite();
		
		addEventListener(Event.ADDED_TO_STAGE, init);
	}

	private function init(e:Event):Void {
		removeEventListener(Event.ADDED_TO_STAGE, init);

		startY = y = Math.random() * APERTURE + INITIAL_Y;
	}

	private function initSprite():Void {
		super.setSprite(SPRITE_WIDTH, SPRITE_HEIGHT, SPRITE_PATH, FPS);

		super.addState(Enemy.ATTACK_STATE, [3, 4]);
		super.addState(Enemy.WALK_STATE, [0, 1, 2, 3]);
		super.setState(Enemy.WALK_STATE);
		super.startAnimation();
	}

	override private function startAttack() {
		super.setState(Enemy.ATTACK_STATE);
		super.setCallback(ATTACK_FRAME, function() {
			game.enemyAttack(damage);
		});
	}

	override public function update():Void {
		super.update();

		angle += ANGLE_UNIT;
		y = startY + Math.sin(angle) * APERTURE; 
	}

}
