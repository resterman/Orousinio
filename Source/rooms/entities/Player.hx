package rooms.entities;

import flash.events.Event;
import flash.events.MouseEvent;
import flash.events.TimerEvent;
import flash.net.SharedObject;
import flash.utils.Timer;
import openfl.display.Sprite;

import rooms.screens.GameStage;

class Player extends Sprite {

	private inline static var PARTICLES:Int = 20;
	private inline static var POWER_SHOOTING:Int = 4;
	private inline static var APERTURE:Int = 5;
	private inline static var UPGRADE_DURATION:Int = 10000;

	private var sprite:AnimSprite;
	private var game:GameStage;

	public var health:Float;

	public var maxHealth:Int;
	private var shootFrequency:Int;
	private var shootSpeed:Float;
	private var shootDamage:Float;
	public var criticalMultiplier:Float;
	
	private var isShooting:Bool = false;
	private var canShoot:Bool = true;
	private var shootTimer:Timer;

	private var tripleShooting:Bool = false;
	private var tripleShootingTimer:Timer;
	private var powerShooting:Bool = false;
	private var powerShootingTimer:Timer;
	private var protected:Bool = false;
	private var protectedTimer:Timer;

	public function new(game:GameStage, maxHealth:Int, shootFrequency:Int,
			shootSpeed:Float, shootDamage:Float, criticalMultiplier:Float) {
		super();

		this.game = game;
		this.health = this.maxHealth = maxHealth;
		this.shootFrequency = shootFrequency;
		this.shootSpeed = shootSpeed;
		this.shootDamage = shootDamage;
		this.criticalMultiplier = criticalMultiplier;

		sprite = new AnimSprite(13, 24, 'assets/spritesheets/player.png', 1);
		sprite.addState('idle', [0]);
		sprite.addState('throw', [1, 2, 3]);
		sprite.setState('idle');
		sprite.setCallback(3, function(){
			sprite.setState('idle', 1);
		}, true);
		
		addChild(sprite);

		addEventListener(Event.ADDED_TO_STAGE, init);
	}

	private function init(e:Event):Void {
		removeEventListener(Event.ADDED_TO_STAGE, init);

		sprite.start();

		shootTimer = new Timer(1000 / shootFrequency);
		shootTimer.addEventListener(TimerEvent.TIMER,
				onShootTimer);

		stage.addEventListener(MouseEvent.MOUSE_DOWN,
				onMouseDown);

		stage.addEventListener(MouseEvent.MOUSE_UP,
				onMouseUp);

		tripleShootingTimer = new Timer(UPGRADE_DURATION);
		tripleShootingTimer.addEventListener(TimerEvent.TIMER, 
				stopTripleShot);
		
		powerShootingTimer = new Timer(UPGRADE_DURATION);
		powerShootingTimer.addEventListener(TimerEvent.TIMER, 
				stopPowerShot);

		protectedTimer = new Timer(UPGRADE_DURATION);
		protectedTimer.addEventListener(TimerEvent.TIMER, 
				stopProtected);

	}

	private function shoot():Void {
		var xdif = stage.mouseX - x;
		var ydif = stage.mouseY - y;
		var angle = Math.atan2(ydif, xdif);

		shootRock(angle);

		if (tripleShooting) {
			shootRock(angle + Math.PI / 180 * APERTURE);
			shootRock(angle - Math.PI / 180 * APERTURE);
		}

		sprite.setState('throw', shootFrequency * 4);
	}

	private function shootRock(angle:Float):Void {
		var damage = shootDamage * (powerShooting ? POWER_SHOOTING : 1);
		
		var rock:Rock = new Rock(angle, shootSpeed, damage);
		rock.powerShot = powerShooting;
		rock.x = x;
		rock.y = y;

		game.addRock(rock);
	}

	private function widthBomb() {
		var i = 0;
		while (i < GameStage.BARRIER_X) {
			i += 40;
		}
	}

	public function takeDamage(damage:Float):Void {
		if (!isAlive() || protected) return;

		health -= damage;

		if (!isAlive())
			die();
	}

	public function isAlive():Bool {
		return health > 0;
	}

	private function die():Void {
		game.playSound(Game.ENEMY_DEATH1_SOUND);
		game.addExplosion(x + width / 2, y + width / 2, PARTICLES);
		game.endGame();
		game.removePlayer();
	}

	public function startTripleShot():Void {
		if (tripleShooting) tripleShootingTimer.stop();

		tripleShootingTimer.start();
		tripleShooting = true;
	}

	private function stopTripleShot(e:TimerEvent):Void {
		tripleShootingTimer.stop();
		tripleShooting = false;
	}

	public function startProtection():Void {
		if (protected) protectedTimer.stop();

		protectedTimer.start();
		protected = true;
	}

	private function stopProtected(e:TimerEvent):Void {
		protectedTimer.stop();
		protected = false;
	}

	public function startPowerShot():Void {
		if (powerShooting) powerShootingTimer.stop();

		powerShootingTimer.start();
		powerShooting = true;
	}

	private function stopPowerShot(e:TimerEvent):Void {
		powerShootingTimer.stop();
		powerShooting = false;
	}

	public function destroy():Void {
		if (stage == null) return;

		stage.removeEventListener(MouseEvent.MOUSE_DOWN,
				onMouseDown);

		stage.removeEventListener(MouseEvent.MOUSE_UP,
				onMouseUp);

		shootTimer.stop();
		shootTimer.removeEventListener(TimerEvent.TIMER,
				onShootTimer);

		sprite.destroy();
	}

	private function onShootTimer(e:TimerEvent):Void {
		if (isShooting) shoot();
		else {
			canShoot = true;
			shootTimer.stop();
		}
	}

	private function onMouseDown(e:MouseEvent):Void {
		if (canShoot) shoot();

		isShooting = true;
		canShoot = false;
		shootTimer.start();
	}

	private function onMouseUp(e:MouseEvent):Void {
		isShooting = false;
	}

}
