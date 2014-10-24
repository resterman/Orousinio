package rooms.screens;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.net.SharedObject;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;
import openfl.Assets;
import openfl.display.Sprite;

class UpgradeMenu extends Screen {

	private inline static var BACKGROUND_SRC:String
		= 'assets/img/upgradeBackground.png';

	private inline static var MAX_HEALTH_UPGRADE_BUTTON:String
		= 'assets/buttons/maxHealthButton.png';
	private inline static var SHOOT_FREQUENCY_UPGRADE_BUTTON:String
		= 'assets/buttons/shootFrequencyButton.png';
	private inline static var SHOOT_SPEED_UPGRADE_BUTTON:String
		= 'assets/buttons/shootSpeedButton.png';
	private inline static var SHOOT_DAMAGE_UPGRADE_BUTTON:String
		= 'assets/buttons/shootDamageButton.png';
	private inline static var CRITICAL_MULTIPLIER_UPGRADE_BUTTON:String
		= 'assets/buttons/criticalMultiplierButton.png';
	private inline static var MAIN_MENU_BUTTON:String
		= 'assets/buttons/mainMenuButton.png';
	private inline static var CONTINUE_BUTTON:String
		= 'assets/buttons/continueButton.png';

	private inline static var MAX_HEALTH_ADDITIONAL:Int = 20;
	private inline static var SHOOT_FREQUENCY_ADDITIONAL:Int = 1;
	private inline static var SHOOT_SPEED_ADDITIONAL:Float = 2;
	private inline static var SHOOT_DAMAGE_ADDITIONAL:Int = 1;
	private inline static var CRITICAL_MULTIPLIER_ADDITIONAL:Float = 0.1;

	private inline static var FIRST_ROW:Int = 20;
	private inline static var SECOND_ROW:Int = 120;
	private inline static var THIRD_ROW:Int = 220;
	private inline static var FIRST_COLUMN:Int = 50;
	private inline static var SECOND_COLUMN:Int = 450;
	private inline static var LABELS_MARGIN:Int = 5;
	private inline static var LABELS_WIDTH:Int = 200;
	private inline static var DISABLED_BUTTON_ALPHA:Float = .3;

	private var levelNum:Int;
	private var so:SharedObject;
	
	private var maxHealth:Int;
	private var shootFrequency:Int;
	private var shootSpeed:Float;
	private var shootDamage:Float;
	private var criticalMultiplier:Float;
	private var birrs:Int;

	private var maxHealthButton:Sprite;
	private var maxHealthMainLabel:TextField;
	private var maxHealthPriceLabel:TextField;
	private var maxHealthValueLabel:TextField;

	private var shootFrequencyButton:Sprite;
	private var shootFrequencyMainLabel:TextField;
	private var shootFrequencyPriceLabel:TextField;
	private var shootFrequencyValueLabel:TextField;

	private var shootSpeedButton:Sprite;
	private var shootSpeedMainLabel:TextField;
	private var shootSpeedPriceLabel:TextField;
	private var shootSpeedValueLabel:TextField;

	private var shootDamageButton:Sprite;
	private var shootDamageMainLabel:TextField;
	private var shootDamagePriceLabel:TextField;
	private var shootDamageValueLabel:TextField;

	private var criticalMultiplierButton:Sprite;
	private var criticalMultiplierMainLabel:TextField;
	private var criticalMultiplierPriceLabel:TextField;
	private var criticalMultiplierValueLabel:TextField;

	private var mainMenuButton:Sprite;
	private var continueButton:Sprite;

	private var dayLabel:TextField;
	private var birrsLabel:TextField;
	
	public function new(game:Game, levelNum:Int) {
		super(game);

		this.levelNum = levelNum;

		Main.achievements.checkLevel();

		loadStoredData();

		addEventListener(Event.ADDED_TO_STAGE, init);
	}

	private function init(e:Event):Void {
		removeEventListener(Event.ADDED_TO_STAGE, init);

		drawBackground();
		drawInfo();
		drawUpgradeButtons();
		drawUpgradeLabels();
		drawMainMenuButton();
		drawContinueButton();
	}

	private function loadStoredData():Void {
		this.so = SharedObject.getLocal('data');

		this.maxHealth = so.data.maxHealth;
		this.shootFrequency = so.data.shootFrequency;
		this.shootSpeed = so.data.shootSpeed;
		this.shootDamage = so.data.shootDamage;
		this.criticalMultiplier = so.data.criticalMultiplier;
		this.birrs = so.data.birrs;
	}

	private function saveStoredData():Void {
		so.data.maxHealth = maxHealth;
		so.data.shootFrequency = shootFrequency;
		so.data.shootSpeed = shootSpeed;
		so.data.shootDamage = shootDamage;
		so.data.criticalMultiplier = criticalMultiplier;
		so.data.birrs = birrs;

		so.flush();
	}

	private function drawBackground():Void {
		addChild(new Bitmap(
			Assets.getBitmapData(BACKGROUND_SRC)
		));
	}

	private function drawUpgradeButtons():Void {
		maxHealthButton = new Sprite();
		maxHealthButton.addChild(new Bitmap(
					Assets.getBitmapData(MAX_HEALTH_UPGRADE_BUTTON)
		));
		maxHealthButton.addEventListener(MouseEvent.CLICK, upgradeMaxHealth);
		maxHealthButton.x = FIRST_COLUMN;
		maxHealthButton.y = FIRST_ROW;
		addChild(maxHealthButton);

		shootFrequencyButton = new Sprite();
		shootFrequencyButton.addChild(new Bitmap(
					Assets.getBitmapData(SHOOT_FREQUENCY_UPGRADE_BUTTON)
		));
		shootFrequencyButton.addEventListener(MouseEvent.CLICK, upgradeShootFrequency);
		shootFrequencyButton.x = FIRST_COLUMN;
		shootFrequencyButton.y = SECOND_ROW;
		addChild(shootFrequencyButton);

		shootSpeedButton  = new Sprite();
		shootSpeedButton.addChild(new Bitmap(
					Assets.getBitmapData(SHOOT_SPEED_UPGRADE_BUTTON)
		));
		shootSpeedButton.addEventListener(MouseEvent.CLICK, upgradeShootSpeed);
		shootSpeedButton.x = FIRST_COLUMN;
		shootSpeedButton.y = THIRD_ROW;
		addChild(shootSpeedButton);

		shootDamageButton = new Sprite();
		shootDamageButton.addChild(new Bitmap(
					Assets.getBitmapData(SHOOT_DAMAGE_UPGRADE_BUTTON)
		));
		shootDamageButton.addEventListener(MouseEvent.CLICK, upgradeShootDamage);
		shootDamageButton.x = SECOND_COLUMN;
		shootDamageButton.y = FIRST_ROW;
		addChild(shootDamageButton);

		criticalMultiplierButton = new Sprite();
		criticalMultiplierButton.addChild(new Bitmap(
					Assets.getBitmapData(CRITICAL_MULTIPLIER_UPGRADE_BUTTON)
		));
		criticalMultiplierButton.addEventListener(MouseEvent.CLICK, upgradeCriticalMultiplier);
		criticalMultiplierButton.x = SECOND_COLUMN;
		criticalMultiplierButton.y = SECOND_ROW;
		addChild(criticalMultiplierButton);

		updateButtons();
	}

	private function drawUpgradeLabels():Void {
		var mainFormat:TextFormat = new TextFormat('04b03', 20, 0x363027);
		var priceFormat:TextFormat = new TextFormat('04b03', 18, 0x363027);
		var valueFormat:TextFormat = new TextFormat('04b03', 18, 0x363027);

		maxHealthMainLabel = new TextField();
		maxHealthMainLabel.defaultTextFormat = mainFormat;
		maxHealthMainLabel.x = maxHealthButton.x + maxHealthButton.width 
			+ LABELS_MARGIN;
		maxHealthMainLabel.y = maxHealthButton.y + LABELS_MARGIN;
		maxHealthMainLabel.width = LABELS_WIDTH;
		maxHealthMainLabel.text = 'Max health';
		addChild(maxHealthMainLabel);

		maxHealthPriceLabel = new TextField();
		maxHealthPriceLabel.defaultTextFormat = priceFormat;
		maxHealthPriceLabel.x = maxHealthMainLabel.x;
		maxHealthPriceLabel.y = maxHealthMainLabel.y 
			+ maxHealthMainLabel.textHeight	+ LABELS_MARGIN;
		maxHealthPriceLabel.width = LABELS_WIDTH;
		addChild(maxHealthPriceLabel);

		maxHealthValueLabel = new TextField();
		maxHealthValueLabel.defaultTextFormat = valueFormat;
		maxHealthValueLabel.x = maxHealthPriceLabel.x;
		maxHealthValueLabel.y = maxHealthPriceLabel.y
			+ maxHealthPriceLabel.textHeight + LABELS_MARGIN;
		maxHealthValueLabel.width = LABELS_WIDTH;
		addChild(maxHealthValueLabel);

		shootFrequencyMainLabel = new TextField();
		shootFrequencyMainLabel.defaultTextFormat = mainFormat;
		shootFrequencyMainLabel.x = shootFrequencyButton.x
			+ shootFrequencyButton.width + LABELS_MARGIN;
		shootFrequencyMainLabel.y = shootFrequencyButton.y + LABELS_MARGIN;
		shootFrequencyMainLabel.width = LABELS_WIDTH;
		shootFrequencyMainLabel.text = 'Shots per second';
		addChild(shootFrequencyMainLabel);

		shootFrequencyPriceLabel = new TextField();
		shootFrequencyPriceLabel.defaultTextFormat = priceFormat;
		shootFrequencyPriceLabel.x = shootFrequencyMainLabel.x;
		shootFrequencyPriceLabel.y = shootFrequencyMainLabel.y
			+ shootFrequencyMainLabel.textHeight + LABELS_MARGIN;
		shootFrequencyPriceLabel.width = LABELS_WIDTH;
		addChild(shootFrequencyPriceLabel);

		shootFrequencyValueLabel = new TextField();
		shootFrequencyValueLabel.defaultTextFormat = priceFormat;
		shootFrequencyValueLabel.x = shootFrequencyPriceLabel.x;
		shootFrequencyValueLabel.y = shootFrequencyPriceLabel.y
			+ shootFrequencyPriceLabel.textHeight + LABELS_MARGIN;
		shootFrequencyValueLabel.width = LABELS_WIDTH;
		addChild(shootFrequencyValueLabel);

		shootSpeedMainLabel = new TextField();
		shootSpeedMainLabel.defaultTextFormat = mainFormat;
		shootSpeedMainLabel.x = shootSpeedButton.x
			+ shootSpeedButton.width + LABELS_MARGIN;
		shootSpeedMainLabel.y = shootSpeedButton.y + LABELS_MARGIN;
		shootSpeedMainLabel.width = LABELS_WIDTH;
		shootSpeedMainLabel.text = 'Shot speed';
		addChild(shootSpeedMainLabel);

		shootSpeedPriceLabel = new TextField();
		shootSpeedPriceLabel.defaultTextFormat = priceFormat;
		shootSpeedPriceLabel.x = shootSpeedMainLabel.x;
		shootSpeedPriceLabel.y = shootSpeedMainLabel.y 
			+ shootSpeedMainLabel.textHeight + LABELS_MARGIN;
		shootSpeedPriceLabel.width = LABELS_WIDTH;
		addChild(shootSpeedPriceLabel);

		shootSpeedValueLabel = new TextField();
		shootSpeedValueLabel.defaultTextFormat = valueFormat;
		shootSpeedValueLabel.x = shootSpeedPriceLabel.x;
		shootSpeedValueLabel.y = shootSpeedPriceLabel.y
			+ shootSpeedPriceLabel.textHeight + LABELS_MARGIN;
		shootSpeedValueLabel.width = LABELS_WIDTH;
		addChild(shootSpeedValueLabel);

		shootDamageMainLabel = new TextField();
		shootDamageMainLabel.defaultTextFormat = mainFormat;
		shootDamageMainLabel.x = shootDamageButton.x
			+ shootDamageButton.width + LABELS_MARGIN;
		shootDamageMainLabel.y = shootDamageButton.y + LABELS_MARGIN;
		shootDamageMainLabel.width = LABELS_WIDTH;
		shootDamageMainLabel.text = 'Shot damage';
		addChild(shootDamageMainLabel);

		shootDamagePriceLabel = new TextField();
		shootDamagePriceLabel.defaultTextFormat = priceFormat;
		shootDamagePriceLabel.x = shootDamageMainLabel.x;
		shootDamagePriceLabel.y = shootDamageMainLabel.y
			+ shootDamagePriceLabel.textHeight + LABELS_MARGIN;
		shootDamagePriceLabel.width = LABELS_WIDTH;
		addChild(shootDamagePriceLabel);

		shootDamageValueLabel = new TextField();
		shootDamageValueLabel.defaultTextFormat = valueFormat;
		shootDamageValueLabel.x = shootDamagePriceLabel.x;
		shootDamageValueLabel.y = shootDamagePriceLabel.y
			+ shootDamagePriceLabel.textHeight + LABELS_MARGIN;
		shootDamageValueLabel.width = LABELS_WIDTH;
		addChild(shootDamageValueLabel);

		criticalMultiplierMainLabel = new TextField();
		criticalMultiplierMainLabel.defaultTextFormat = mainFormat; 
		criticalMultiplierMainLabel.x = criticalMultiplierButton.x 
			+ criticalMultiplierButton.width + LABELS_MARGIN;
		criticalMultiplierMainLabel.y = criticalMultiplierButton.y
			+ LABELS_MARGIN;
		criticalMultiplierMainLabel.width = LABELS_WIDTH;
		criticalMultiplierMainLabel.text = 'Critical multiplier';
		addChild(criticalMultiplierMainLabel);

		criticalMultiplierPriceLabel = new TextField();
		criticalMultiplierPriceLabel.defaultTextFormat = priceFormat;
		criticalMultiplierPriceLabel.x = criticalMultiplierMainLabel.x;
		criticalMultiplierPriceLabel.y = criticalMultiplierMainLabel.y
			+ criticalMultiplierMainLabel.textHeight + LABELS_MARGIN;
		criticalMultiplierPriceLabel.width = LABELS_WIDTH;
		addChild(criticalMultiplierPriceLabel);

		criticalMultiplierValueLabel = new TextField();
		criticalMultiplierValueLabel.defaultTextFormat = valueFormat;
		criticalMultiplierValueLabel.x = criticalMultiplierPriceLabel.x;
		criticalMultiplierValueLabel.y = criticalMultiplierPriceLabel.y
			+ criticalMultiplierPriceLabel.textHeight + LABELS_MARGIN;
		criticalMultiplierValueLabel.width = LABELS_WIDTH;
		addChild(criticalMultiplierValueLabel);

		updateValueLabels();
		updatePriceLabels();
	}

	private function drawMainMenuButton():Void {
		mainMenuButton = new Sprite();
		mainMenuButton.addChild(new Bitmap(
					Assets.getBitmapData(MAIN_MENU_BUTTON)
		));
		mainMenuButton.addEventListener(MouseEvent.CLICK, gotoMainMenu);
		mainMenuButton.x = LABELS_MARGIN;
		mainMenuButton.y = stage.stageHeight - mainMenuButton.height - LABELS_MARGIN;

		addChild(mainMenuButton);
	}

	private function drawContinueButton():Void {
		continueButton = new Sprite();
		continueButton.addChild(new Bitmap(
					Assets.getBitmapData(CONTINUE_BUTTON)
		));
		continueButton.addEventListener(MouseEvent.CLICK, gotoGameStage);
		continueButton.x = stage.stageWidth - continueButton.width - LABELS_MARGIN;
		continueButton.y = stage.stageHeight - continueButton.height - LABELS_MARGIN;

		addChild(continueButton);
	}

	private function drawInfo():Void {
		dayLabel = new TextField();
		dayLabel.defaultTextFormat = new TextFormat('04b03', 18, 0x766854, null,
				null, null, null, null, TextFormatAlign.CENTER);
		dayLabel.text = 'Day ' + (levelNum + 1);
		dayLabel.x = 0;
		dayLabel.y = GameStage.FLOOR_Y + LABELS_MARGIN;
		dayLabel.width = stage.stageWidth;
		addChild(dayLabel);

		birrsLabel = new TextField();
		birrsLabel.defaultTextFormat = new TextFormat('04b03', 18, 0x766854, null,
				null, null, null, null, TextFormatAlign.CENTER);
		birrsLabel.text = 'Br' + this.birrs;
		birrsLabel.x = 0;
		birrsLabel.y = dayLabel.y + dayLabel.textHeight + LABELS_MARGIN;
		birrsLabel.width = stage.stageWidth;
		addChild(birrsLabel);
	}

	private function updateButtons():Void {
		maxHealthButton.alpha 
			= (birrs < maxHealthPrice()) ? DISABLED_BUTTON_ALPHA : 1;
		shootFrequencyButton.alpha 
			= (birrs < shootFrequencyPrice()) ? DISABLED_BUTTON_ALPHA : 1;
		shootSpeedButton.alpha 
			= (birrs < shootSpeedPrice()) ? DISABLED_BUTTON_ALPHA : 1;
		shootDamageButton.alpha
			= (birrs < shootDamagePrice()) ? DISABLED_BUTTON_ALPHA : 1;
		criticalMultiplierButton.alpha
			= (birrs < criticalMultiplierPrice()) ? DISABLED_BUTTON_ALPHA : 1;
	}

	private function updateValueLabels():Void {
		maxHealthValueLabel.text = maxHealth + ' hp';
		shootFrequencyValueLabel.text = shootFrequency + ' shots/s';
		shootSpeedValueLabel.text = shootSpeed + ' m/s';
		shootDamageValueLabel.text = shootDamage + ' dmg';
		criticalMultiplierValueLabel.text = 'Dmg x' + criticalMultiplier;
	}

	private function updatePriceLabels():Void {
		maxHealthPriceLabel.text = 'Br' + maxHealthPrice() + ' +' 
			+ MAX_HEALTH_ADDITIONAL;
		shootFrequencyPriceLabel.text = 'Br' + shootFrequencyPrice() + ' +'
			+ SHOOT_FREQUENCY_ADDITIONAL;
		shootSpeedPriceLabel.text = 'Br' + shootSpeedPrice() + ' +'
			+ SHOOT_SPEED_ADDITIONAL;
		shootDamagePriceLabel.text = 'Br' + shootDamagePrice() + ' +'
			+ SHOOT_DAMAGE_ADDITIONAL;
		criticalMultiplierPriceLabel.text = 'Br' + criticalMultiplierPrice() 
			+ ' +' + CRITICAL_MULTIPLIER_ADDITIONAL;

		birrsLabel.text = 'Br' + birrs;	
	}

	private function maxHealthPrice():Int {
		return Std.int(this.maxHealth / 4);
	}

	private function shootFrequencyPrice():Int {
		return this.shootFrequency * 150;
	}

	private function shootSpeedPrice():Int {
		var x = this.shootSpeed;
		return Std.int(x * 10);
	}

	private function shootDamagePrice():Int {
		var x = this.shootDamage;
		return Std.int(x * x * 25);
	}

	private function criticalMultiplierPrice():Int {
		var x = this.criticalMultiplier;
		return Std.int(5 * x * x + 10 * x);
	}

	private function upgradeMaxHealth(e:MouseEvent):Void {
		if (maxHealthPrice() <= birrs) {
			birrs -= maxHealthPrice();
			maxHealth += MAX_HEALTH_ADDITIONAL;

			updateButtons();
			updateValueLabels();
			updatePriceLabels();
		}
	}

	private function upgradeShootFrequency(e:MouseEvent):Void {	
		if (shootFrequencyPrice() <= birrs) {
			birrs -= shootFrequencyPrice();
			shootFrequency += SHOOT_FREQUENCY_ADDITIONAL;

			updateButtons();
			updateValueLabels();
			updatePriceLabels();
		}
	}

	private function upgradeShootSpeed(e:MouseEvent):Void {	
		if (shootSpeedPrice() <= birrs) {
			birrs -= shootSpeedPrice();
			shootSpeed += SHOOT_SPEED_ADDITIONAL;

			updateButtons();
			updateValueLabels();
			updatePriceLabels();
		}
	}

	private function upgradeShootDamage(e:MouseEvent):Void {	
		if (shootDamagePrice() <= birrs) {
			birrs -= shootDamagePrice();
			shootDamage += SHOOT_DAMAGE_ADDITIONAL;

			updateButtons();
			updateValueLabels();
			updatePriceLabels();
		}
	}

	private function upgradeCriticalMultiplier(e:MouseEvent):Void {	
		if (criticalMultiplierPrice() <= birrs) {
			birrs -= criticalMultiplierPrice();
			criticalMultiplier += CRITICAL_MULTIPLIER_ADDITIONAL;

			updateButtons();
			updateValueLabels();
			updatePriceLabels();
		}
	}

	private function gotoMainMenu(e:MouseEvent):Void {
		destroy();

		saveStoredData();

		game.changeScreen(new MainMenu(game));
	}

	private function gotoGameStage(e:MouseEvent):Void {
		destroy();

		saveStoredData();

		game.changeScreen(new GameStage(game, levelNum));
	}

	private function destroy():Void {
		maxHealthButton.removeEventListener(MouseEvent.CLICK, upgradeMaxHealth);
		shootFrequencyButton.removeEventListener(MouseEvent.CLICK, upgradeShootFrequency);
		shootSpeedButton.removeEventListener(MouseEvent.CLICK, upgradeShootSpeed);
		shootDamageButton.removeEventListener(MouseEvent.CLICK, upgradeShootDamage);
		criticalMultiplierButton.removeEventListener(MouseEvent.CLICK, upgradeCriticalMultiplier);
		
		mainMenuButton.removeEventListener(MouseEvent.CLICK, gotoMainMenu);
		continueButton.removeEventListener(MouseEvent.CLICK, gotoGameStage);
	}

}
