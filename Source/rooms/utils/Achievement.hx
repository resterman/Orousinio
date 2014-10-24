package rooms.utils;

class Achievement<T> {

	public var description:String;
	private var condition:Dynamic;
	private var completed:Bool = false;

	public function new(description:String, condition:Dynamic) {
		this.description = description;
		this.condition = condition;
	}

	public function isCompleted():Bool {
		return completed;
	}

	public function check(value:T):Bool {
		return (completed = condition(value));
	}

}
