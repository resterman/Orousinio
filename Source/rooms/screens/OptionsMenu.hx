package rooms.screens;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.StageQuality;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.text.Font;
import flash.text.TextField;
import flash.text.TextFormat;
import openfl.display.Sprite;
import openfl.Assets;

class OptionsMenu extends Screen {
	
	private inline static var MENU_BG_SRC:String
		= 'assets/img/menuBackground.png';
	private inline static var ON_BUTTON_SRC:String
		= 'assets/buttons/onButton.png';
	private inline static var OFF_BUTTON_SRC:String
		= 'assets/buttons/offButton.png';
	private inline static var CLEAR_BUTTON_SRC:String
		= 'assets/buttons/clearButton.png';
	private inline static var LOW_QUALITY_BUTTON_SRC:String 
		= 'assets/img/lowQuality.png';
	private inline static var MED_QUALITY_BUTTON_SRC:String 
		= 'assets/img/medQuality.png';
	private inline static var HIG_QUALITY_BUTTON_SRC:String 
		= 'assets/img/higQuality.png';
	private inline static var BACK_BUTTON_SRC:String
		= 'assets/buttons/backButton.png';

	private inline static var MARGIN:Int = 10;

	private var sfxOnButton:Sprite;
	private var sfxOffButton:Sprite;
	private var musicOnButton:Sprite;
	private var musicOffButton:Sprite;
	private var clearButton:Sprite;
	private var lowQualityButton:Sprite;
	private var medQualityButton:Sprite;
	private var higQualityButton:Sprite;
	private var backButton:Sprite;

	public function new(game:Game):Void {
		super(game);

		addEventListener(Event.ADDED_TO_STAGE, init);
	}

	private function init(e:Event):Void {
		removeEventListener(Event.ADDED_TO_STAGE, init);
		
		drawBackground();
		drawSfxButtons();
		//drawMusicButtons();
		drawClearButton();
		drawLabels();
		drawBackButton();
	}

	private function drawBackground():Void {
		addChild(
			new Bitmap(Assets.getBitmapData(MENU_BG_SRC))
		);
	}

	private function drawSfxButtons():Void {
		sfxOnButton = new Sprite();
		sfxOnButton.addChild(new Bitmap(
			Assets.getBitmapData(ON_BUTTON_SRC)
		));
		sfxOnButton.x = MARGIN;
		sfxOnButton.y = stage.stageHeight - sfxOnButton.height - MARGIN;
		sfxOnButton.addEventListener(MouseEvent.CLICK, enableSfx);
		addChild(sfxOnButton);

		sfxOffButton = new Sprite();
		sfxOffButton.addChild(new Bitmap(
			Assets.getBitmapData(OFF_BUTTON_SRC)
		));
		sfxOffButton.x = sfxOnButton.x + sfxOnButton.width + MARGIN;
		sfxOffButton.y = sfxOnButton.y;
		sfxOffButton.addEventListener(MouseEvent.CLICK, disableSfx);
		addChild(sfxOffButton);
	}
	
	private function drawMusicButtons():Void {
		musicOnButton = new Sprite();
		musicOnButton.x = 100;
		musicOnButton.y = 400;
		musicOnButton.addChild(new Bitmap(
			Assets.getBitmapData(ON_BUTTON_SRC)
		));
		musicOnButton.addEventListener(MouseEvent.CLICK, enableBfx);
		addChild(musicOnButton);

		musicOffButton = new Sprite();
		musicOffButton.x = 210;
		musicOffButton.y = 400;
		musicOffButton.addChild(new Bitmap(
			Assets.getBitmapData(OFF_BUTTON_SRC)
		));
		musicOffButton.addEventListener(MouseEvent.CLICK, disableBfx);
		addChild(musicOffButton);
	}
	
	private function drawClearButton():Void {
		clearButton = new Sprite();
		clearButton.addChild(new Bitmap(
					Assets.getBitmapData(CLEAR_BUTTON_SRC)
		));
		clearButton.x = sfxOffButton.x + sfxOffButton.width + 2 * MARGIN;
		clearButton.y = sfxOffButton.y;
		clearButton.addEventListener(MouseEvent.CLICK, deleteData);
		addChild(clearButton);
	}

	private function drawLabels():Void {

		var sfxLabel:TextField = new TextField();
		sfxLabel.defaultTextFormat = new TextFormat('04b03', 23, 0x766854);
		sfxLabel.text = 'Sfx';
		sfxLabel.x = sfxOnButton.x;
		sfxLabel.y = sfxOnButton.y - sfxLabel.textHeight;
		sfxLabel.embedFonts = true;
		sfxLabel.selectable = false;
		addChild(sfxLabel);

		var clearLabel:TextField = new TextField();
		clearLabel.defaultTextFormat = new TextFormat('04b03', 23, 0x766854);
		clearLabel.text = 'Clear data (double click)';
		clearLabel.width = clearLabel.textWidth;
		clearLabel.x = clearButton.x;
		clearLabel.y = clearButton.y - clearLabel.textHeight;
		clearLabel.embedFonts = true;
		clearLabel.selectable = false;
		addChild(clearLabel);
	}

	private function drawBackButton():Void {
		backButton = new Sprite();
		backButton.addChild(
			new Bitmap(Assets.getBitmapData(BACK_BUTTON_SRC))
		);
		backButton.x = stage.stageWidth - backButton.width - 10;
		backButton.y = stage.stageHeight - backButton.height - 10;
		backButton.addEventListener(MouseEvent.CLICK, goBack);
		addChild(backButton);
	}

	private function enableSfx(e:MouseEvent):Void {
		game.soundManager.unmuteSfx();
	}

	private function disableSfx(e:MouseEvent):Void {
		game.soundManager.muteSfx();
	}

	private function enableBfx(e:MouseEvent):Void {
		game.soundManager.unmuteBfx();
	}

	private function disableBfx(e:MouseEvent):Void {
		game.soundManager.muteBfx();
	}

	private function deleteData(e:MouseEvent):Void {
		var so:flash.net.SharedObject = flash.net.SharedObject.getLocal('data');
		so.clear();
		trace("A");
	}

	private function setLowQuality(e:MouseEvent):Void {
		stage.quality = StageQuality.LOW;
	}

	private function setMedQuality(e:MouseEvent):Void {
		stage.quality = StageQuality.MEDIUM;
	}

	private function setHigQuality(e:MouseEvent):Void {
		stage.quality = StageQuality.HIGH;
	}

	private function goBack(e:MouseEvent):Void {
		destroy();
		game.changeScreen(new MainMenu(game));
	}

	private function destroy():Void {
		sfxOnButton.removeEventListener(MouseEvent.CLICK, enableSfx);
		removeChild(sfxOnButton);

		sfxOffButton.removeEventListener(MouseEvent.CLICK, disableSfx);
		removeChild(sfxOffButton);

		clearButton.removeEventListener(MouseEvent.DOUBLE_CLICK, deleteData);
		removeChild(clearButton);

		backButton.removeEventListener(MouseEvent.CLICK, goBack);
		removeChild(backButton);
	}

}
