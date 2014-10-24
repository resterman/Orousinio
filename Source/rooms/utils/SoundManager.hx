package rooms.utils;

import flash.events.Event;
import haxe.ds.StringMap;
import openfl.Assets;
import openfl.media.Sound;
import openfl.media.SoundChannel;
import openfl.media.SoundTransform;

class SoundManager {
	
	public var isPlayingSfx(default, null):Bool = true;
	public var isPlayingBfx(default, null):Bool = true;
	private var sfxs:StringMap<Sound>;
	private var bfxs:StringMap<Sound>;
	private var playingSfxs:Array<SoundChannel>;
	private var playingBfxs:Array<SoundChannel>;

	public function new() {
		sfxs = new StringMap<Sound>();
		bfxs = new StringMap<Sound>();
		playingSfxs = new Array<SoundChannel>();
		playingBfxs = new Array<SoundChannel>();
	}

	public function addSfx(name:String, path:String):Void {
		sfxs.set(name, Assets.getSound(path));
	}

	public function removeSfx(name:String):Bool {
		return sfxs.remove(name);
	}
	
	public function addBfx(name:String, path:String):Void {
    	bfxs.set(name, Assets.getSound(path));
	}

	public function removeBfx(name:String):Bool {
		return bfxs.remove(name);
	}
	
	public function playSfx(name:String):Void {
		var sound:Sound = sfxs.get(name);
		
		if (isPlayingSfx) {
			var soundChannel:SoundChannel = sound.play();
			soundChannel.addEventListener(Event.SOUND_COMPLETE, onSfxEnd);

			playingSfxs.push(soundChannel);
		}
	}

	public function playBfx(name:String):Void {
		var sound:Sound = bfxs.get(name);

		if (isPlayingBfx) {
			var soundChannel:SoundChannel = sound.play();
			soundChannel.addEventListener(Event.SOUND_COMPLETE, onBfxEnd);

			playingBfxs.push(soundChannel);
		}
	}

	private function onSfxEnd(e:Event):Void {
		var target:SoundChannel = e.target;
		target.removeEventListener(Event.SOUND_COMPLETE, onSfxEnd);

		playingSfxs.remove(target);
	}

	private function onBfxEnd(e:Event):Void {
		var target:SoundChannel = e.target;
		target.removeEventListener(Event.SOUND_COMPLETE, onBfxEnd);

		playingBfxs.remove(target);
	}

	public function muteSfx():Void {
		for (sfx in playingSfxs)
			sfx.soundTransform.volume = 0;

		isPlayingSfx = false;
	}

	public function unmuteSfx():Void {
		for (sfx in playingSfxs)
			sfx.soundTransform.volume = 1;

		isPlayingSfx = true;
	}

	public function muteBfx():Void {
		for (bfx in playingBfxs)
			bfx.soundTransform.volume = 0;

		isPlayingBfx = false;
	}

	public function unmuteBfx():Void {
		for (bfx in playingBfxs)
			bfx.soundTransform.volume = 1;

		isPlayingBfx = true;
	}

}
