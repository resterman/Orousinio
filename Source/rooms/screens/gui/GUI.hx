package rooms.screens.gui;

import flash.events.Event;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;
import openfl.display.Sprite;

import rooms.screens.GameStage;

class GUI extends Sprite {

	private static var HEALTH_BAR_HEIGHT:Int = 5;
	private static var HEALTH_BAR_MARGIN:Int = 10;
	private static var HEALTH_BAR_COLOR:UInt = 0xFF663333;
	private static var LEVEL_LABEL_COLOR:Int = 0x363027;

	private var game:GameStage;
	private var healthBar:Sprite;
	private var birrsField:TextField;

	private var maxHealth:Float;
	private var levelNum:Int;

	public function new(game:GameStage, levelNum:Int, maxHealth:Float) {
		super();

		this.game = game;
		this.maxHealth = maxHealth;
		this.levelNum = levelNum;

		addEventListener(Event.ADDED_TO_STAGE, init);
	}

	private function init(e:Event):Void {
		removeEventListener(Event.ADDED_TO_STAGE, init);

		addHealthBar();
		addLevelLabel();
		addBirrsLabel();
	}

	private function addHealthBar():Void {
		healthBar = new Sprite();
		healthBar.graphics.beginFill(HEALTH_BAR_COLOR);
		healthBar.graphics.drawRect(0, 0, stage.stageWidth - 2 * HEALTH_BAR_MARGIN,
				HEALTH_BAR_HEIGHT);
		healthBar.x = HEALTH_BAR_MARGIN;
		healthBar.y = HEALTH_BAR_MARGIN;

		addChild(healthBar);
	}

	public function updateHealth(health:Float):Void {
		if (stage == null) return;

		var maxWidth:Float = stage.stageWidth - 2 * HEALTH_BAR_MARGIN;
		health = (health > 0) ? health : 0;

		healthBar.width = health / maxHealth * maxWidth;
	}

	private function addLevelLabel():Void {
		var label:TextField = new TextField();
		label.defaultTextFormat = new TextFormat('04b03', 18, LEVEL_LABEL_COLOR, null,
				null, null, null, null, TextFormatAlign.CENTER);
		label.width = stage.stageWidth;
		label.x = 0;
		label.y = healthBar.x + healthBar.height + HEALTH_BAR_MARGIN;
		label.text = 'Day ' + (levelNum + 1);

		addChild(label);
	}
	
	private function addBirrsLabel():Void {
		birrsField = new TextField();
		birrsField.selectable = false;
		birrsField.defaultTextFormat = new TextFormat('04b03', 18,
				LEVEL_LABEL_COLOR, null, null, null, null, null,
				TextFormatAlign.RIGHT);
		birrsField.x = HEALTH_BAR_MARGIN;
		birrsField.y = healthBar.x + healthBar.height + HEALTH_BAR_MARGIN;
		birrsField.width = stage.stageWidth - 2 * HEALTH_BAR_MARGIN;
		
		addChild(birrsField);
	}

	public function updateBirrs(birrs:Int):Void {
		birrsField.text = 'Br' + birrs;
	}
}
