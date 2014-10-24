package rooms.screens;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.net.SharedObject;
import flash.text.Font;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;
import openfl.Assets;
import openfl.display.Sprite;

class MainMenu extends Screen {

	private inline static var MENU_BG_SRC:String
		= 'assets/img/menuBackground.png';
	private inline static var PLAY_BUTTON_SRC:String
		= 'assets/buttons/playButton.png';
	private inline static var OPTIONS_BUTTON_SRC:String
		= 'assets/buttons/optionsButton.png';
	private inline static var ACHIEVEMENTS_BUTTON_SRC:String
		= 'assets/buttons/achievementsButton.png';

	private inline static var MARGIN:Int = 10;

	private var gameTitleLabel:TextField;
	private var playButton:Sprite;
	private var optionsButton:Sprite;
	private var achievementsButton:Sprite;

	public function new(game:Game) {
		super(game);

		addEventListener(Event.ADDED_TO_STAGE, init);
	}

	private function init(e:Event):Void {
		removeEventListener(Event.ADDED_TO_STAGE, init);
		
		drawBackground();
		drawLabels();
		drawMenuButtons();
	}

	private function drawBackground():Void {
		addChild(
			new Bitmap(Assets.getBitmapData(MENU_BG_SRC))
		);
	}

	private function drawLabels():Void {
		gameTitleLabel = new TextField();
		gameTitleLabel.defaultTextFormat = new TextFormat('04b03', 45, 0x766854);
		gameTitleLabel.x = MARGIN;
		gameTitleLabel.y = 330;
		gameTitleLabel.autoSize = TextFieldAutoSize.LEFT;
		gameTitleLabel.width = gameTitleLabel.textWidth;
		gameTitleLabel.embedFonts = true;
		gameTitleLabel.selectable = false;
		gameTitleLabel.text = "OROUSINO";
		gameTitleLabel.width = gameTitleLabel.textWidth;

		addChild(gameTitleLabel);
	}

	private function drawMenuButtons():Void {
		drawAchievementsButton();
		drawOptionsButton();
		drawPlayButton();
	}

	private function drawPlayButton():Void {
		var bmpData:BitmapData
			= Assets.getBitmapData(PLAY_BUTTON_SRC);
		var bmp:Bitmap = new Bitmap(bmpData);

		playButton = new Sprite();
		playButton.addChild(bmp);
		playButton.x = optionsButton.x - MARGIN - playButton.width;
		playButton.y = 330;
		addChild(playButton);

		playButton.addEventListener(MouseEvent.CLICK, showGameStage);
	}

	private function drawOptionsButton():Void {
		var bmpData:BitmapData
			= Assets.getBitmapData(OPTIONS_BUTTON_SRC);
		var bmp:Bitmap = new Bitmap(bmpData);

		optionsButton = new Sprite();
		optionsButton.addChild(bmp);
		optionsButton.x = achievementsButton.x - MARGIN - optionsButton.width;
		optionsButton.y = 330;
		addChild(optionsButton);

		optionsButton.addEventListener(MouseEvent.CLICK, showOptionsMenu);
	}

	private function drawAchievementsButton():Void {
		achievementsButton = new Sprite();
		achievementsButton.addChild(new Bitmap(
			Assets.getBitmapData(ACHIEVEMENTS_BUTTON_SRC)
		));
		achievementsButton.x = stage.stageWidth - achievementsButton.width - MARGIN;
		achievementsButton.y = 330;
		
		addChild(achievementsButton);

		achievementsButton.addEventListener(MouseEvent.CLICK, showAchievements);
	}

	private function destroy():Void {
		playButton.removeEventListener(MouseEvent.CLICK, showGameStage);
		playButton = null;

		optionsButton.removeEventListener(MouseEvent.CLICK, showOptionsMenu);
		optionsButton = null;

		achievementsButton.removeEventListener(MouseEvent.CLICK, showAchievements);
		achievementsButton = null;
	}

	private function showOptionsMenu(e:MouseEvent):Void {
		destroy();

		game.changeScreen(new OptionsMenu(game));
	}

	private function showGameStage(e:MouseEvent):Void {
		destroy();

		var so:SharedObject = SharedObject.getLocal('data');
		//so.clear();

		if (so.data.level == null)
			game.changeScreen(new GameStage(game, 0));
		else
			game.changeScreen(new UpgradeMenu(game, so.data.level));
	}

	private function showAchievements(e:MouseEvent):Void {
		destroy();

		game.changeScreen(new AchievementsScreen(game));
	}

}
