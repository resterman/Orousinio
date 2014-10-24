package rooms.screens;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.events.Event;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;
import openfl.Assets;
import rooms.utils.*;

class AchievementsScreen extends Screen {
	
	private inline static var BACKGROUND_SRC:String
		= 'assets/img/menuBackground.png';
	private inline static var MARGIN:Int = 10;

	private var aManager:MyAchievementManager;

	public function new(game:Game) {
		super(game);

		aManager = Main.achievements;

		addEventListener(Event.ADDED_TO_STAGE, init);
	}

	private function init(e:Event):Void {
		removeEventListener(Event.ADDED_TO_STAGE, init);

		drawBackground();
		drawAchievements();
	}
	
	private function drawBackground():Void {
		addChild(
			new Bitmap(Assets.getBitmapData(BACKGROUND_SRC))
		);
	}

	private function drawAchievements():Void {
		var textField = new TextField();
		textField.defaultTextFormat = new TextFormat('04b03', 15, 0x363027);
		textField.selectable = false;
		textField.wordWrap = true;
		textField.embedFonts = true;
		textField.x = MARGIN;
		textField.y = MARGIN;
		textField.width = stage.stageWidth - 2 * MARGIN;

		addChild(textField);

		for (i in aManager.getAllAchievements()) {
			if (!i.isCompleted()) continue;
			
			textField.appendText(i.description + ', ');
		}

		textField.text = textField.text.substring(0, textField.text.length - 2);

		addChild(aManager);
	}

}
