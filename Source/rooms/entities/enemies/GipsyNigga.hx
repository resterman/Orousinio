package rooms.entities.enemies;

import flash.events.Event;
import flash.geom.Rectangle;

import rooms.screens.GameStage;

class GipsyNigga extends Enemy {

	private static var MAX_HEALTH:Float = 4;
	private static var MIN_HEALTH:Float = 3.5;
	private static var MAX_SPEED:Float = 3;
	private static var MIN_SPEED:Float = 2.5;
	private static var MAX_DAMAGE:Float = 4.5;
	private static var MIN_DAMAGE:Float = 4;
	private static var MAX_PARTICLES:Int = 5;
	private static var MIN_PARTICLES:Int = 4;

	private static var SPRITE_WIDTH:Int = 8;
	private static var SPRITE_HEIGHT:Int = 24;
	private static var SPRITE_PATH:String = 'assets/spritesheets/enemy5.png';
	private static var FPS:Int = 1;
	private static var ATTACK_FRAME:Int = 0;

	public function new(game:GameStage) {
		super(game);
		
		super.setStats(
			MAX_HEALTH, MIN_HEALTH,
			MAX_SPEED, MIN_SPEED,
			MAX_DAMAGE, MIN_DAMAGE,
			MAX_PARTICLES, MIN_PARTICLES
		);
		super.addCriticalZone(new Rectangle(1, 0, 6, 6));

		initSprite();
		
		addEventListener(Event.ADDED_TO_STAGE, init);
	}

	private function init(e:Event):Void {
		removeEventListener(Event.ADDED_TO_STAGE, init);
	}

	private function initSprite():Void {
		super.setSprite(SPRITE_WIDTH, SPRITE_HEIGHT, SPRITE_PATH, FPS);

		super.addState(Enemy.WALK_STATE, [0]);
		super.setState(Enemy.WALK_STATE);
		super.startAnimation();
	}

	override private function startAttack():Void {
		super.setCallback(ATTACK_FRAME, function() {
			// TODO: draw attack
			game.enemyAttack(damage);
		});
	}

}
