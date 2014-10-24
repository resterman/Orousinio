package rooms.events;

import flash.events.Event;

class EnemyEvent extends Event {

	public inline static var KILLED:String = 'killed';
	public inline static var HEADSHOT:String = 'headshot';
	public inline static var HEADSHOT_KILLED:String = 'headshotKilled';
	
	public function new(type:String, bubbles:Bool = false, cancelable:Bool = false) {
		super(type, bubbles, cancelable);
	}

}
