package;

import rooms.*;
import rooms.utils.MyAchievementManager;

import flash.events.MouseEvent;
import flash.text.Font;
import openfl.display.Sprite;

@:font('Assets/fonts/04b04.ttf') class MyFont extends Font {}

class Main extends Sprite {

	public static var achievements:MyAchievementManager;

	private inline static var CURSOR_DIM:Int = 3;
	
	private var game:Game;
	private var cursor:Sprite;

	public function new () {
		super();
		
		var so:flash.net.SharedObject = flash.net.SharedObject.getLocal('data');
		so.clear();

		Font.registerFont(MyFont);
		init();
	}

	private function init():Void {
		game = new Game();
		addChild(game);

		cursor = new Sprite();
		cursor.mouseEnabled = cursor.mouseChildren = false;
		cursor.graphics.beginFill(0);
		cursor.graphics.drawRect(0, 0, CURSOR_DIM, CURSOR_DIM);
		cursor.graphics.endFill();
		addChild(cursor);

		flash.ui.Mouse.hide();

		achievements = new MyAchievementManager();
		addChild(achievements);

		stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		stage.addEventListener(MouseEvent.ROLL_OVER, onRollOver);
	}

	private function onMouseMove(e:MouseEvent):Void {
		cursor.x = e.stageX - cursor.width / 2;
		cursor.y = e.stageY - cursor.height / 2;
	}

	private function onRollOver(e:MouseEvent):Void {
		flash.ui.Mouse.hide();
	}
	
}
