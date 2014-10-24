package rooms.utils;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.events.Event;
import flash.net.SharedObject;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.utils.Timer;
import openfl.Assets;
import openfl.display.Sprite;

import rooms.events.*;

class MyAchievementManager extends Sprite {

	private inline static var ACHIEVEMENT_SRC:String
		= 'assets/img/achievement.png';

	private inline static var XPOS:Int = 10;
	private inline static var YPOS:Int = 50;

	public inline static var FIRST_KILL:String = 'first_kill';
	public inline static var TEN_KILLS:String = 'ten_kills';
	public inline static var HUNDRED_KILLS:String = 'hundred_kills';
	public inline static var FIRST_HEADSHOT:String = 'first_headshot';
	public inline static var TEN_HEADSHOTS:String = 'ten_headshots';
	public inline static var HUNDRED_HEADSHOTS:String = 'hundred_headshots';
	public inline static var FIRST_HEADSHOT_KILL:String = 'first_headshot_kill';
	public inline static var TEN_HEADSHOT_KILLS:String = 'ten_headshot_kills';
	public inline static var HUNDRED_HEADSHOT_KILLS:String = 'hundred_headshot_kills';
	public inline static var FIRST_LEVEL:String = 'first_level';
	public inline static var TEN_LEVELS:String = 'ten_levels';
	public inline static var LAST_LEVEL:String = 'last_level';

	private var aManager:AchievementManager<Int>;
	
	private var kills:Int;
	private var headshots:Int;
	private var headshotKills:Int;
	private var level:Int;

	private var timer:Timer;
	private var currentDisplay:Sprite;

	public function new() {
		super();

		currentDisplay = new Sprite();
		currentDisplay.alpha = 0;
		addChild(currentDisplay);

		aManager = new AchievementManager<Int>();
		aManager
			.addAchievement(FIRST_KILL, new Achievement<Int>(
					'First kill ',
					function (kills) {
						return kills == 1;
					}
			)).addAchievement(TEN_KILLS, new Achievement<Int>(
					'10 kills',
					function (kills) {
						return kills == 10;
					}
			)).addAchievement(HUNDRED_KILLS, new Achievement<Int>(
					'100 kills',
					function (kills) {
						return kills == 100;
					}
			)).addAchievement(FIRST_HEADSHOT, new Achievement<Int>(
					'First headshot ',
					function (headshots) {
						return headshots == 1;
					}
			)).addAchievement(TEN_HEADSHOTS, new Achievement<Int>(
					'10 headshots ',
					function (headshots) {
						return headshots == 10;
					}
			)).addAchievement(HUNDRED_HEADSHOTS, new Achievement<Int>(
					'100 headshots',
					function (headshots) {
						return headshots == 100;
					}				
			)).addAchievement(FIRST_HEADSHOT_KILL, new Achievement<Int>(
					'First head kill',
					function (headshotKills) {
						return headshotKills == 1;
					}
			)).addAchievement(TEN_HEADSHOT_KILLS, new Achievement<Int>(
					'10 head kills',
					function (headshotKills) {
						return headshotKills == 10;
					}
			)).addAchievement(HUNDRED_HEADSHOT_KILLS, new Achievement<Int>(
					'100 head kills',
					function (headshotKills) {
						return headshotKills == 100;
					}
			)).addAchievement(FIRST_LEVEL, new Achievement<Int>(
					'Beat first level',
					function (level) {
						return level == 2;
					}
			)).addAchievement(TEN_LEVELS, new Achievement<Int>(
					'Beat 10 levels',
					function (level) {
						return level == 11;
					}
			)).addAchievement(LAST_LEVEL, new Achievement<Int>(
					'Beat last level',
					function (level) {
						return level == 26;
					}
			));

		loadData();

		addEventListener(Event.ENTER_FRAME, onEnter);
	}

	private function onEnter(e:Event):Void {
		if (currentDisplay.alpha < 0.04) {
			currentDisplay.alpha = 0;
		} else {
			currentDisplay.alpha *= 0.975;
		}
	}

	private function loadData():Void {
		var so:SharedObject = SharedObject.getLocal('data');

		if (so.data.kills == null) kills = 0;
		else kills = so.data.kills;

		if (so.data.headshots == null) headshots = 0;
		else headshots = so.data.headshots;

		if (so.data.headshotKills == null) headshotKills = 0;
		else headshotKills = so.data.headshotKills;

		if (so.data.level == null) level = 0;
		else level = so.data.level;

	}

	private function saveData():Void {
		var so:SharedObject = SharedObject.getLocal('data');
		
		so.data.kills = kills;
		so.data.headshots = headshots;
		so.data.headshotKills = headshotKills;

		so.flush();
	}

	public function addHeadshot():Void {
		headshots++;

		notify(FIRST_HEADSHOT, headshots);
		notify(TEN_HEADSHOTS, headshots);
		notify(HUNDRED_HEADSHOTS, headshots);

		saveData();
	}

	public function addKill():Void {
		kills++;
		
		notify(FIRST_KILL, kills);
		notify(TEN_KILLS, kills);
		notify(HUNDRED_KILLS, kills);

		saveData();
	}

	public function addHeadshotKill():Void {
		headshotKills++;

		notify(FIRST_HEADSHOT_KILL, headshotKills);
		notify(TEN_HEADSHOT_KILLS, headshotKills);
		notify(HUNDRED_HEADSHOT_KILLS, headshotKills);

		saveData();
	}

	public function checkLevel():Void {
		notify(FIRST_LEVEL, level);
		notify(TEN_LEVELS, level);
		notify(LAST_LEVEL, level);
	}

	private function notify(key:String, value:Int):Void {
		if (aManager.isCompleted(key)) return;

		if (aManager.check(key, value))
			displayAchievement(key);
	}

	private function displayAchievement(key:String):Void {
		var description:String = aManager.getAchievement(key).description;

		removeChild(currentDisplay);
		currentDisplay = new Sprite();
		currentDisplay.alpha = 1;
		currentDisplay.addChild(new Bitmap(
			Assets.getBitmapData(ACHIEVEMENT_SRC)
		));

		var t = new TextField();
		t.defaultTextFormat = new TextFormat('04b03', 12, 0x363027);
		t.wordWrap = true;
		t.text = description;

		currentDisplay.addChild(t);
		t.x = 40;
		t.y = 15;

		currentDisplay.x = XPOS;
		currentDisplay.y = YPOS;
		addChild(currentDisplay);
	}

	public function getAllAchievements():Array<Achievement<Int>> {
		return aManager.getAllAchievements();
	}

}
