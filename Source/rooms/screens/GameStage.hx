package rooms.screens;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.events.TimerEvent;
import flash.geom.Point;
import flash.net.SharedObject;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;
import flash.utils.Timer;
import openfl.Assets;
import openfl.display.Sprite;

import rooms.entities.*;
import rooms.entities.enemies.*;
import rooms.events.*;
import rooms.screens.gui.*;
import rooms.utils.*;

class GameStage extends Screen {

	private inline static var MENU_BG_SRC:String
		= 'assets/img/menuBackground.png';
	private inline static var MAIN_MENU_BUTTON_SRC:String
		= 'assets/img/mainMenuButton.png';

	private inline static var SIMPLE_ENEMY_ID:String = 'simple';
	private inline static var SHIELD_ENEMY_ID:String = 'shield';
	private inline static var KING_ENEMY_ID:String = 'king';
	private inline static var WATERMELON_ENEMY_ID:String = 'watermelon';
	private inline static var GIPSY_ENEMY_ID:String = 'gipsy';
	private inline static var TOWER_ENEMY_ID:String = 'tower';
	private inline static var MAGIC_CARPET_ENEMY_ID:String = 'magic_carpet';

	private inline static var DEFAULT_MAX_HEALTH:Int = 100;
	private inline static var DEFAULT_SHOOT_FREQUENCY:Int = 1;
	private inline static var DEFAULT_SHOOT_SPEED:Int = 10;
	private inline static var DEFAULT_SHOOT_DAMAGE:Int = 1;
	private inline static var DEFAULT_CRITICAL_MULTIPLIER:Float = 2;
	private inline static var DEFAULT_BIRRS:Int = 0;
	private inline static var DEFAULT_LEVEL:Int = 0;

	public inline static var FLOOR_Y:Int = 314;
	public inline static var BARRIER_X:Int = 710;
	private inline static var BAR_WIDTH:Int = 40;
	private inline static var BLOOD_COLOR:UInt = 0xFF663333;
	private inline static var MARGIN:Int = 10;
	
	private var stageBars:StageBars;
	private var enemiesContainer:Sprite;

	private var enemies:Array<Enemy> = new Array<Enemy>();
	private var enemiesWaiting:Array<Enemy> = new Array<Enemy>();
	private var enemiesReleaser:Timer;

	private var rocks:Array<Rock> = new Array<Rock>();

	private var bloodParticles:Array<BloodParticle> 
		= new Array<BloodParticle>();
	private var bloodBitmapData:BitmapData;
	private var bloodBitmap:Bitmap;

	private var upgradesContainer:Sprite;
	private var upgrades:Array<Upgrade>;
	private var upgradeTimer:Timer;

	private var mainMenuButton:Sprite;

	private var gui:GUI;
	public var player:Player;
	private var birrs:Int;

	private var currentLevel:{
		enemies:Array<{id:String, amount:Int}>,
		frequency:Int
	};
	private var levelNum:Int;
	private var isLastLevel:Bool;

	public function new(game:Game, levelNum:Int) {
		super(game);

		var levels:Array<Dynamic> = haxe.Json.parse(
				Assets.getText('assets/levels/normal.json'));

		this.levelNum = levelNum;
		this.isLastLevel = (levels.length - 1 == levelNum);
		this.currentLevel = levels[levelNum];

		var so:SharedObject = SharedObject.getLocal('data');
		if (so.data.maxHealth == null)
			so.data.maxHealth = DEFAULT_MAX_HEALTH;
		
		if (so.data.shootFrequency == null)
			so.data.shootFrequency = DEFAULT_SHOOT_FREQUENCY;
		
		if (so.data.shootSpeed == null)
			so.data.shootSpeed =DEFAULT_SHOOT_SPEED;
		
		if (so.data.shootDamage == null)
			so.data.shootDamage = DEFAULT_SHOOT_DAMAGE;

		if (so.data.criticalMultiplier == null)
			so.data.criticalMultiplier = DEFAULT_CRITICAL_MULTIPLIER;

		if (so.data.birrs == null)
			so.data.birrs = DEFAULT_BIRRS;

		if (so.data.level == null)
			so.data.level = DEFAULT_LEVEL;

		so.flush();

		this.birrs = so.data.birrs;

		addEventListener(Event.ADDED_TO_STAGE, init);
	}

	private function init(e:Event):Void {
		removeEventListener(Event.ADDED_TO_STAGE, init);

		stageBars = new StageBars(BAR_WIDTH, stage.stageWidth);
		rocks = new Array<Rock>();
		
		drawBackground();
		drawEnemiesContainer();
		drawPlayer();
		drawGUI();
		drawBloodContainer();
		drawUpgradeContainer();

		addEnemies();

		addEventListener(Event.ENTER_FRAME, onEnter);
	}

	private function drawBackground():Void {
		addChild(new Bitmap(Assets.getBitmapData(MENU_BG_SRC)));
	}

	private function drawEnemiesContainer():Void {
		enemiesContainer = new Sprite();
		addChild(enemiesContainer);
	}

	private function drawPlayer():Void {
		var so:SharedObject = SharedObject.getLocal('data');
		player = new Player(
				this,
				(so.data.maxHealth != null) 
					? so.data.maxHealth 
					: DEFAULT_MAX_HEALTH,
				(so.data.shootFrequency != null) 
					? so.data.shootFrequency 
					: DEFAULT_SHOOT_FREQUENCY,
				(so.data.shootSpeed != null)
					? so.data.shootSpeed
					: DEFAULT_SHOOT_SPEED,
				(so.data.shootDamage != null)
					? so.data.shootDamage
					: DEFAULT_SHOOT_DAMAGE,
				(so.data.criticalMultiplier != null)
					? so.data.criticalMultiplier
					: DEFAULT_CRITICAL_MULTIPLIER
		);

		player.x = 780;
		player.y = 279 - player.height;
		addChild(player);
	}

	private function drawGUI():Void {
		gui = new GUI(this, levelNum, player.maxHealth);
		addChild(gui);

		gui.updateBirrs(birrs);
	}

	private function drawUpgradeContainer():Void {
		upgradesContainer = new Sprite();
		upgrades = new Array<Upgrade>();

		upgradeTimer = new Timer(30000);
		upgradeTimer.addEventListener(TimerEvent.TIMER, releaseUpgrade);
		upgradeTimer.start();

		addChild(upgradesContainer);
	}

	private function drawBloodContainer():Void {
		bloodBitmapData = new BitmapData(
				stage.stageWidth, stage.stageHeight, true, 0x00FFFFFF);

		bloodBitmap = new Bitmap(bloodBitmapData);
		addChild(bloodBitmap);
	}


	private function drawGameOver():Void {
		var gameOverLabel:TextField = new TextField();
		gameOverLabel.defaultTextFormat = new TextFormat('04b03', 45, 0x766854);
		gameOverLabel.x = MARGIN;
		gameOverLabel.y = 330;
		gameOverLabel.autoSize = TextFieldAutoSize.LEFT;
		gameOverLabel.width = gameOverLabel.textWidth;
		gameOverLabel.embedFonts = true;
		gameOverLabel.selectable = false;
		gameOverLabel.text = "GAME OVER";
		gameOverLabel.width = gameOverLabel.textWidth;

		addChild(gameOverLabel);

		mainMenuButton = new Sprite();
		mainMenuButton.addChild(new Bitmap(
			Assets.getBitmapData(MAIN_MENU_BUTTON_SRC)
		));
		mainMenuButton.x = stage.stageWidth - mainMenuButton.width - MARGIN;
		mainMenuButton.y = 330;
		addChild(mainMenuButton);
		mainMenuButton.addEventListener(MouseEvent.CLICK,
				goToMainMenu);
	}

	private function goToMainMenu(e:MouseEvent):Void {
		mainMenuButton.removeEventListener(MouseEvent.CLICK,
				goToMainMenu);
		
		this.destroy();

		game.changeScreen(new MainMenu(game));
	}

	private function addEnemies():Void {
		for (enemy in currentLevel.enemies)
			for (i in 0...enemy.amount)
				addEnemy(enemy.id);

		enemiesReleaser = new Timer(1000 / currentLevel.frequency);
		enemiesReleaser.addEventListener(TimerEvent.TIMER, releaseEnemy);
		enemiesReleaser.start();
	}

	private function addEnemy(enemyId:String):Void {
		var enemy:Enemy;

		switch (enemyId) {
			case SIMPLE_ENEMY_ID:
				enemy = new SimpleNigga(this);
			case SHIELD_ENEMY_ID:
				enemy = new ShieldNigga(this);
			case KING_ENEMY_ID:
				enemy = new KingNigga(this);
			case WATERMELON_ENEMY_ID:
				enemy = new WatermelonNigga(this);
			case GIPSY_ENEMY_ID:
				enemy = new GipsyNigga(this);
			case MAGIC_CARPET_ENEMY_ID:
				enemy = new MagicCarpetNigga(this);
			case TOWER_ENEMY_ID:
				enemy = new TowerNigga(this);
			default:
				enemy = new SimpleNigga(this);
		}

		enemy.x = Math.random() * 50 - (50 + enemy.width);
		enemy.y = FLOOR_Y - enemy.height;

		enemy.addEventListener(EnemyEvent.KILLED, onEnemyKilled);
		enemy.addEventListener(EnemyEvent.HEADSHOT, onEnemyHeadshot);
		enemy.addEventListener(EnemyEvent.HEADSHOT_KILLED, onEnemyHeadshotKilled);

		enemiesWaiting.push(enemy);
	}

	private function destroyEnemy(enemy:Enemy):Void {
		enemy.destroy();

		enemy.removeEventListener(EnemyEvent.KILLED, onEnemyKilled);
		enemy.removeEventListener(EnemyEvent.HEADSHOT, onEnemyHeadshot);
		enemy.removeEventListener(EnemyEvent.HEADSHOT_KILLED, onEnemyHeadshotKilled);
	}

	public function removeEnemy(enemy:Enemy):Void {
		destroyEnemy(enemy);

		enemies.remove(enemy);
		enemiesContainer.removeChild(enemy);
	}

	private function releaseEnemy(e:TimerEvent):Void {
		if (enemiesWaiting.length == 0) {
			enemiesReleaser.stop();
			return;
		}

		var index = Std.int(Math.random() * enemiesWaiting.length);
		var enemy = enemiesWaiting.splice(index, 1)[0];

		enemies.push(enemy);
		enemiesContainer.addChild(enemy);
	}

	public function addRock(rock:Rock):Void {
		rocks.push(rock);
		addChild(rock);
	}

	public function removeRock(rock:Rock):Void {
		rocks.remove(rock);
		removeChild(rock);
	}

	public function removePlayer():Void {
		removeChild(player);
	}

	public function enemyAttack(damage:Float):Void {
		if (player != null) {
			player.takeDamage(damage);
			gui.updateHealth(player.health);
		}
	}

	public function addExplosion(x:Float, y:Float, particles:Int):Void {
		for (i in 0...particles) {
			bloodParticles.push((new BloodParticle(x, y)));
		}
	}

	public function addBirrs(birrsValue:Int):Void {
		this.birrs += birrsValue;
		gui.updateBirrs(this.birrs);
	}

	public function addUpgrade(upgrade:Upgrade):Void {
		upgrade.x = Math.random() * 500;
		upgrade.y = -upgrade.height;

		upgradesContainer.addChild(upgrade);
		upgrades.push(upgrade);
	}

	public function removeUpgrade(upgrade:Upgrade):Void {
		upgradesContainer.removeChild(upgrade);
		upgrades.remove(upgrade);
	}

	private function releaseUpgrade(e:TimerEvent):Void {
		var u = Std.int(Math.random() * 3);

		switch (u) {
			case 0:
				addUpgrade(new TripleShotUpgrade(this));
			case 1:
				addUpgrade(new PowerShotUpgrade(this));
			case 2:
				addUpgrade(new ProtectionUpgrade(this));
		}
	}
			
	public function activateUpgrade(power:String):Void {
		switch (power) {
			case Upgrade.TRIPLE_SHOT:
				player.startTripleShot();
			case Upgrade.POWER_SHOT:
				player.startPowerShot();
			case Upgrade.PROTECT:
				player.startProtection();
		}
	}

	private function endLevel():Void {
		trace("Level won");
		this.destroy();
	
		var so:SharedObject = SharedObject.getLocal('data');
		so.data.birrs = this.birrs;
		so.data.level = this.levelNum + 1;
		so.flush();

		// TODO add winning screen
		if (!isLastLevel)
			game.changeScreen(new UpgradeMenu(game, levelNum + 1));
		else
			drawGameOver();
	}

	public function endGame():Void {
		trace("Game over.");

		this.destroy();

		var so:SharedObject = SharedObject.getLocal('data');
		so.data.birrs = this.birrs;
		so.flush();

		game.changeScreen(new UpgradeMenu(game, levelNum));
	}

	private function onEnter(e:Event):Void {
		if (enemiesWaiting.length == 0 && enemies.length == 0) {
			endLevel();
			return;
		}

		stageBars.clear();
		for (enemy in enemies) {
			enemy.update();
			stageBars.insertEnemy(enemy);
		}

		var auxiliarRock = new Rock(0, 0, 0);
		auxiliarRock.alpha = 0;

		var _enemies, left, right;
		var nextPosition, xdif, ydif, angle, dist;
		var enemyBmp:BitmapData;

		for (rock in rocks) {
			if (rock.x < 0 || rock.x > stage.stageWidth) {
				removeRock(rock);
				continue;
			}

			nextPosition = rock.getNextPosition();
			xdif = nextPosition.x - rock.x;
			ydif = nextPosition.y - rock.y;
			angle = Math.atan2(ydif, xdif);
			dist = Math.sqrt(xdif * xdif + ydif * ydif);
			
			_enemies = new Array<Enemy>();
			left = stageBars.getBar(nextPosition.x);
			if (left == null) left = 0;

			right = stageBars.getBar(rock.x);
			if (right == null) right = 0;

			var i = left;
			while (i <= right) {
				_enemies = _enemies.concat(stageBars.getEnemies(i));

				i++;
			}

			var hitEnemy:Enemy = null, radius:Float = 0;
			addChild(auxiliarRock);
			while (radius < dist && hitEnemy == null) {
				for (enemy in _enemies) {
					auxiliarRock.x = rock.x + Math.cos(angle) * radius;
					auxiliarRock.y = rock.y + Math.sin(angle) * radius;

					if (enemy.pixelHitTest(auxiliarRock)) {
						var isCloser;
						if (hitEnemy == null) {
							hitEnemy = enemy;
						} else {	
							isCloser = enemy.x + enemy.width > hitEnemy.x
											+ hitEnemy.width;
							if (isCloser)
								hitEnemy == enemy;
						}
					}

				}

				radius += rock.width;
			}

			if (hitEnemy != null) {
				rock.damage(hitEnemy, auxiliarRock);
				removeRock(rock);
			} else {
				rock.update();

				if (rock.isStill())
					removeRock(rock);
			}

			removeChild(auxiliarRock);
		}

		updateBloodContainer();
	}

	private function onEnemyKilled(e:EnemyEvent):Void {
		Main.achievements.addKill();
	}

	private function onEnemyHeadshot(e:EnemyEvent):Void {
		Main.achievements.addHeadshot();
	}

	private function onEnemyHeadshotKilled(e:EnemyEvent):Void {
		Main.achievements.addHeadshotKill();
	}

	public function playSound(sound:String):Void {
		game.soundManager.playSfx(sound);
	}

	private function updateBloodContainer():Void {
		bloodBitmapData.lock();

		var position:Point;
		for (particle in bloodParticles) {
			position = particle.getPos();

			if (position.y > FLOOR_Y) {
				bloodParticles.remove(particle);
			} else {
				eraseBlood(Std.int(position.x), Std.int(position.y));
				particle.update();
				position = particle.getPos();
				drawBlood(Std.int(position.x), Std.int(position.y));
			}
		}

		bloodBitmapData.unlock();
	}

	private function drawBlood(x:Int, y:Int):Void {
		bloodBitmapData
			.setPixel32(x, y, BLOOD_COLOR);

		bloodBitmapData
			.setPixel32(x + 1, y, BLOOD_COLOR);

		bloodBitmapData
			.setPixel32(x, y + 1, BLOOD_COLOR);
		
		bloodBitmapData
			.setPixel32(x + 1, y + 1, BLOOD_COLOR);
	}

	private function eraseBlood(x:Int, y:Int):Void {
		bloodBitmapData
			.setPixel32(x, y, 0);

		bloodBitmapData
			.setPixel32(x + 1, y, 0);

		bloodBitmapData
			.setPixel32(x, y + 1, 0);
		
		bloodBitmapData
			.setPixel32(x + 1, y + 1, 0);
	}

	private function destroy():Void {
		removeEventListener(Event.ENTER_FRAME, onEnter);
		enemiesReleaser.removeEventListener(TimerEvent.TIMER, releaseEnemy);

		upgradeTimer.stop();
		upgradeTimer.removeEventListener(TimerEvent.TIMER, releaseUpgrade);

		while (enemiesWaiting.length > 0) {
			destroyEnemy(enemiesWaiting.pop());
		}

		while (enemies.length > 0) {
			destroyEnemy(enemies.pop());
		}

		player.destroy();
	}

}
