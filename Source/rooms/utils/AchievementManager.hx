package rooms.utils;

import haxe.ds.StringMap;

class AchievementManager<T> {

	private var achievements:StringMap<Achievement<T>>;
		
	public function new() {
		achievements = new StringMap<Achievement<T>>();
	}

	public function addAchievement(key:String, achievement:Achievement<T>):AchievementManager<T> {
		achievements.set(key, achievement);

		return this;
	}

	public function getAchievement(key:String):Achievement<T> {
		return achievements.get(key);
	}

	public function isCompleted(key:String):Bool {
		return achievements.get(key).isCompleted();
	}

	public function check(key:String, value:T):Bool {
		var achievement:Achievement<T> = achievements.get(key);
		if (achievement == null)
			return false;

		var completed:Bool = achievement.check(value);

		return completed;
	}

	public function getAllAchievements():Array<Achievement<T>> {
		var result:Array<Achievement<T>> = new Array<Achievement<T>>();

		for (achievement in achievements)
			result.push(achievement);

		return result;
	}

}
