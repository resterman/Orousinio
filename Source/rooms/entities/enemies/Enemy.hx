package rooms.entities.enemies;

import flash.events.Event;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.geom.Rectangle;
import openfl.display.Sprite;

import rooms.events.*;
import rooms.screens.GameStage;

class Enemy extends Sprite {

	public static var WALK_STATE:String = 'walk';
	public static var ATTACK_STATE:String = 'attack';

	private var health:Float;
	private var speed:Float;
	private var damage:Float;
	private var particles:Int;
	private var criticalZones:Array<Rectangle> = new Array<Rectangle>();
	private var limitPosition:Int = GameStage.BARRIER_X;
	private var birrsValue:Int = 1; // TODO: set value for every enemy
	
	private var game:GameStage;
	private var sprite:AnimSprite;
	private var deathSound:String;

	private var walking:Bool = true;

	public function new(game:GameStage) {
		super();

		this.game = game;
		this.health = Math.random() * 6 + .5;
	}

	public function update():Void {
		if (game.player.isAlive()) {
			if (walking) {
				if (x + width > limitPosition) {
					startAttack();
					walking = false;
				}
				
				x += this.speed;
			}
		} else {
			x += this.speed;
		}
	}

	public function takeDamage(damage:Float, rock:Rock) {
		var isHeadshot:Bool = isHeadshot(rock);
		if (isHeadshot) {
			health -= damage * game.player.criticalMultiplier;
			game.addExplosion(rock.x, rock.y, 3);

			dispatchEvent(new EnemyEvent(EnemyEvent.HEADSHOT));
		} else {
			health -= damage;
		}
		
		if (health <= 0) {
			if (isHeadshot)
				dispatchEvent(new EnemyEvent(EnemyEvent.HEADSHOT_KILLED));
			
			dispatchEvent(new EnemyEvent(EnemyEvent.KILLED));

			die();
		}
	}

	public function die():Void {
		var birrsMultiplier = 3 - Std.int(
			x / stage.stageWidth * 3
		);

		game.addBirrs(birrsValue * birrsMultiplier);
		game.playSound(deathSound);
		game.addExplosion(x, y, particles);
		game.removeEnemy(this);
	}

	public function destroy():Void {
		sprite.destroy();	
	}

	private function setSprite(spriteWidth:Int, spriteHeight:Int, path:String, fps:Int):Void {
		sprite = new AnimSprite(spriteWidth, spriteHeight, path, fps);
		addChild(sprite);
	}

	private function addState(state:String, frames:Array<Int>):Void {
		sprite.addState(state, frames);
	}

	private function setState(state:String, ?fps:Float):Void {
		sprite.setState(state, fps);
	}
	
	private function setCallback(frame:Int, callback:Dynamic, ?end:Bool=false) {
		sprite.setCallback(frame, callback, end);
	}

	private function startAnimation():Void {
		sprite.start();
	}

	private function setStats(
			maxHealth:Float, minHealth:Float,
			maxSpeed:Float, minSpeed:Float,
			maxDamage:Float, minDamage:Float,
			maxParticles:Int, minParticles:Int,
			?deathSound:String = Game.ENEMY_DEATH1_SOUND):Void {

		health = Math.random() * (maxHealth - minHealth)
			+ minHealth;

		speed = Math.random() * (maxSpeed - minSpeed)
			+ minSpeed;

		damage = Math.random() * (maxDamage - minDamage)
			+ minDamage;

		particles = Std.int(Math.random() 
			* (maxParticles - minParticles)	+ minParticles);

		this.deathSound = deathSound;
	}

	public function addCriticalZone(rect:Rectangle):Void {
		this.criticalZones.push(rect);
	}

	// rock cannot be smaller than enemy
	public function pixelHitTest(rock:Rock):Bool {
		var bmpData = new BitmapData(Std.int(rock.width),
				Std.int(rock.height), true, 0x00000000);
		bmpData.draw(rock);

		var bmp = new Bitmap(bmpData);

		if (!this.hitTestObject(rock))
			return false;

		var pixels:Array<UInt>, enemyBmp = sprite.getBmpData();
		var rockX = rock.x - this.x;
		var rockY = rock.y - this.y;

		if (rockY > 0) {
			pixels = enemyBmp.getVector(new Rectangle(rockX, rockY, rock.width, 1));
			for (px in pixels) {
				if ((px >> 24) & 0xFF == 0xFF)
					return true;
			}
		}

		if (rockY < this.width) {
			pixels = enemyBmp.getVector(new Rectangle(rockX, rockY + height, rock.width, 1));
			for (px in pixels) {
				if ((px >> 24) & 0xFF == 0xFF)
					return true;
			}
		}

		// Horizontal lines check
		if (rockX > 0) {
			pixels = enemyBmp.getVector(new Rectangle(rockX, rockY, 1, rock.height));
			for (px in pixels) {
				if ((px >> 24) & 0xFF == 0xFF)
					return true;
			}
		}

		if (rockY < this.width) {
			pixels = enemyBmp.getVector(new Rectangle(rockX + width, rockY, 1, rock.height));
			for (px in pixels) {
				if ((px >> 24) & 0xFF == 0xFF)
					return true;
			}
		}

		return false;
	}

	public function isHeadshot(rock:Rock):Bool {
		var rockX = rock.x - this.x;
		var rockY = rock.y - this.y;

		for (zone in criticalZones) {
			if (zone.x + zone.width < rockX) continue;
			if (zone.y + zone.height < rockY) continue;
			if (zone.x > rockX + rock.width) continue;
			if (zone.y > rockY + rock.height) continue;

			return true;
		}

		return false;
	}

	/* Abstract methods */
	private function startAttack() {}
}
