package rooms;

import flash.events.Event;
import openfl.display.Sprite;
import openfl.Assets;

import rooms.screens.*;
import rooms.utils.SoundManager;

class Game extends Sprite {

	public inline static var ENEMY_DEATH1_SOUND:String = 'enemy_death1';
	public inline static var ENEMY_DEATH2_SOUND:String = 'enemy_death2';
	public inline static var ENEMY_DEATH3_SOUND:String = 'enemy_death3';
	public inline static var COIN_PICK_SOUND:String = 'coin_pick';
	
	private var screen:Screen;
	public var soundManager:SoundManager;
	
	public function new() {
		super();

		soundManager = new SoundManager();
		soundManager.addSfx(ENEMY_DEATH1_SOUND, 'assets/sounds/enemyDeath1.wav');
		soundManager.addSfx(ENEMY_DEATH2_SOUND, 'assets/sounds/enemyDeath2.wav');
		soundManager.addSfx(ENEMY_DEATH3_SOUND, 'assets/sounds/enemyDeath3.wav');
		soundManager.addSfx(COIN_PICK_SOUND, 'assets/sounds/coinPick.wav');

		addEventListener(Event.ADDED_TO_STAGE, init);
	}

	private function init(e:Event):Void {
		removeEventListener(Event.ADDED_TO_STAGE, init);

		screen = new MainMenu(this);	
		addChild(screen);
	}

	public function changeScreen(screen:Screen):Void {
		removeChild(this.screen);

		this.screen = screen;
		addChild(screen);
	}

}
