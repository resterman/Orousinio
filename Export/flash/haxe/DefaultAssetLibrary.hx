package;


import haxe.Timer;
import haxe.Unserializer;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.MovieClip;
import openfl.events.Event;
import openfl.text.Font;
import openfl.media.Sound;
import openfl.net.URLRequest;
import openfl.utils.ByteArray;
import openfl.Assets;

#if (flash || js)
import openfl.display.Loader;
import openfl.events.Event;
import openfl.net.URLLoader;
#end

#if sys
import sys.FileSystem;
#end

#if ios
import openfl.utils.SystemPath;
#end


@:access(openfl.media.Sound)
class DefaultAssetLibrary extends AssetLibrary {
	
	
	public var className (default, null) = new Map <String, Dynamic> ();
	public var path (default, null) = new Map <String, String> ();
	public var type (default, null) = new Map <String, AssetType> ();
	
	private var lastModified:Float;
	private var timer:Timer;
	
	
	public function new () {
		
		super ();
		
		#if flash
		
		className.set ("assets/spritesheets/enemy5.png", __ASSET__assets_spritesheets_enemy5_png);
		type.set ("assets/spritesheets/enemy5.png", AssetType.IMAGE);
		className.set ("assets/spritesheets/enemy1.png", __ASSET__assets_spritesheets_enemy1_png);
		type.set ("assets/spritesheets/enemy1.png", AssetType.IMAGE);
		className.set ("assets/spritesheets/enemy7.png", __ASSET__assets_spritesheets_enemy7_png);
		type.set ("assets/spritesheets/enemy7.png", AssetType.IMAGE);
		className.set ("assets/spritesheets/enemy3.png", __ASSET__assets_spritesheets_enemy3_png);
		type.set ("assets/spritesheets/enemy3.png", AssetType.IMAGE);
		className.set ("assets/spritesheets/enemy2.png", __ASSET__assets_spritesheets_enemy2_png);
		type.set ("assets/spritesheets/enemy2.png", AssetType.IMAGE);
		className.set ("assets/spritesheets/enemy6.png", __ASSET__assets_spritesheets_enemy6_png);
		type.set ("assets/spritesheets/enemy6.png", AssetType.IMAGE);
		className.set ("assets/spritesheets/enemy4.png", __ASSET__assets_spritesheets_enemy4_png);
		type.set ("assets/spritesheets/enemy4.png", AssetType.IMAGE);
		className.set ("assets/spritesheets/player.png", __ASSET__assets_spritesheets_player_png);
		type.set ("assets/spritesheets/player.png", AssetType.IMAGE);
		className.set ("assets/levels/normal.json", __ASSET__assets_levels_normal_json);
		type.set ("assets/levels/normal.json", AssetType.TEXT);
		className.set ("assets/buttons/onButton.png", __ASSET__assets_buttons_onbutton_png);
		type.set ("assets/buttons/onButton.png", AssetType.IMAGE);
		className.set ("assets/buttons/maxHealthButton.png", __ASSET__assets_buttons_maxhealthbutton_png);
		type.set ("assets/buttons/maxHealthButton.png", AssetType.IMAGE);
		className.set ("assets/buttons/shootDamageButton.png", __ASSET__assets_buttons_shootdamagebutton_png);
		type.set ("assets/buttons/shootDamageButton.png", AssetType.IMAGE);
		className.set ("assets/buttons/backButton.png", __ASSET__assets_buttons_backbutton_png);
		type.set ("assets/buttons/backButton.png", AssetType.IMAGE);
		className.set ("assets/buttons/achievementsButton.png", __ASSET__assets_buttons_achievementsbutton_png);
		type.set ("assets/buttons/achievementsButton.png", AssetType.IMAGE);
		className.set ("assets/buttons/criticalMultiplierButton.png", __ASSET__assets_buttons_criticalmultiplierbutton_png);
		type.set ("assets/buttons/criticalMultiplierButton.png", AssetType.IMAGE);
		className.set ("assets/buttons/mainMenuButton.png", __ASSET__assets_buttons_mainmenubutton_png);
		type.set ("assets/buttons/mainMenuButton.png", AssetType.IMAGE);
		className.set ("assets/buttons/optionsButton.png", __ASSET__assets_buttons_optionsbutton_png);
		type.set ("assets/buttons/optionsButton.png", AssetType.IMAGE);
		className.set ("assets/buttons/shootFrequencyButton.png", __ASSET__assets_buttons_shootfrequencybutton_png);
		type.set ("assets/buttons/shootFrequencyButton.png", AssetType.IMAGE);
		className.set ("assets/buttons/playButton.png", __ASSET__assets_buttons_playbutton_png);
		type.set ("assets/buttons/playButton.png", AssetType.IMAGE);
		className.set ("assets/buttons/shootSpeedButton.png", __ASSET__assets_buttons_shootspeedbutton_png);
		type.set ("assets/buttons/shootSpeedButton.png", AssetType.IMAGE);
		className.set ("assets/buttons/offButton.png", __ASSET__assets_buttons_offbutton_png);
		type.set ("assets/buttons/offButton.png", AssetType.IMAGE);
		className.set ("assets/buttons/clearButton.png", __ASSET__assets_buttons_clearbutton_png);
		type.set ("assets/buttons/clearButton.png", AssetType.IMAGE);
		className.set ("assets/buttons/continueButton.png", __ASSET__assets_buttons_continuebutton_png);
		type.set ("assets/buttons/continueButton.png", AssetType.IMAGE);
		className.set ("assets/fonts/04b04.ttf", __ASSET__assets_fonts_04b04_ttf);
		type.set ("assets/fonts/04b04.ttf", AssetType.FONT);
		className.set ("assets/img/upgradeBackground.png", __ASSET__assets_img_upgradebackground_png);
		type.set ("assets/img/upgradeBackground.png", AssetType.IMAGE);
		className.set ("assets/img/higQuality.png", __ASSET__assets_img_higquality_png);
		type.set ("assets/img/higQuality.png", AssetType.IMAGE);
		className.set ("assets/img/medQuality.png", __ASSET__assets_img_medquality_png);
		type.set ("assets/img/medQuality.png", AssetType.IMAGE);
		className.set ("assets/img/menuBackground.png", __ASSET__assets_img_menubackground_png);
		type.set ("assets/img/menuBackground.png", AssetType.IMAGE);
		className.set ("assets/img/gameOver.png", __ASSET__assets_img_gameover_png);
		type.set ("assets/img/gameOver.png", AssetType.IMAGE);
		className.set ("assets/img/lowQuality.png", __ASSET__assets_img_lowquality_png);
		type.set ("assets/img/lowQuality.png", AssetType.IMAGE);
		className.set ("assets/sounds/enemyDeath1.wav", __ASSET__assets_sounds_enemydeath1_wav);
		type.set ("assets/sounds/enemyDeath1.wav", AssetType.SOUND);
		className.set ("assets/sounds/enemyDeath2.wav", __ASSET__assets_sounds_enemydeath2_wav);
		type.set ("assets/sounds/enemyDeath2.wav", AssetType.SOUND);
		className.set ("assets/sounds/coinPick.wav", __ASSET__assets_sounds_coinpick_wav);
		type.set ("assets/sounds/coinPick.wav", AssetType.SOUND);
		className.set ("assets/sounds/enemyDeath3.wav", __ASSET__assets_sounds_enemydeath3_wav);
		type.set ("assets/sounds/enemyDeath3.wav", AssetType.SOUND);
		
		
		#elseif html5
		
		var id;
		id = "assets/spritesheets/enemy5.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/spritesheets/enemy1.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/spritesheets/enemy7.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/spritesheets/enemy3.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/spritesheets/enemy2.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/spritesheets/enemy6.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/spritesheets/enemy4.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/spritesheets/player.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/levels/normal.json";
		path.set (id, id);
		type.set (id, AssetType.TEXT);
		id = "assets/buttons/onButton.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/buttons/maxHealthButton.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/buttons/shootDamageButton.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/buttons/backButton.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/buttons/achievementsButton.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/buttons/criticalMultiplierButton.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/buttons/mainMenuButton.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/buttons/optionsButton.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/buttons/shootFrequencyButton.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/buttons/playButton.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/buttons/shootSpeedButton.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/buttons/offButton.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/buttons/clearButton.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/buttons/continueButton.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/fonts/04b04.ttf";
		className.set (id, __ASSET__assets_fonts_04b04_ttf);
		type.set (id, AssetType.FONT);
		id = "assets/img/upgradeBackground.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/img/higQuality.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/img/medQuality.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/img/menuBackground.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/img/gameOver.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/img/lowQuality.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/sounds/enemyDeath1.wav";
		path.set (id, id);
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/enemyDeath2.wav";
		path.set (id, id);
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/coinPick.wav";
		path.set (id, id);
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/enemyDeath3.wav";
		path.set (id, id);
		type.set (id, AssetType.SOUND);
		
		
		#else
		
		#if (windows || mac || linux)
		
		var useManifest = false;
		
		className.set ("assets/spritesheets/enemy5.png", __ASSET__assets_spritesheets_enemy5_png);
		type.set ("assets/spritesheets/enemy5.png", AssetType.IMAGE);
		
		className.set ("assets/spritesheets/enemy1.png", __ASSET__assets_spritesheets_enemy1_png);
		type.set ("assets/spritesheets/enemy1.png", AssetType.IMAGE);
		
		className.set ("assets/spritesheets/enemy7.png", __ASSET__assets_spritesheets_enemy7_png);
		type.set ("assets/spritesheets/enemy7.png", AssetType.IMAGE);
		
		className.set ("assets/spritesheets/enemy3.png", __ASSET__assets_spritesheets_enemy3_png);
		type.set ("assets/spritesheets/enemy3.png", AssetType.IMAGE);
		
		className.set ("assets/spritesheets/enemy2.png", __ASSET__assets_spritesheets_enemy2_png);
		type.set ("assets/spritesheets/enemy2.png", AssetType.IMAGE);
		
		className.set ("assets/spritesheets/enemy6.png", __ASSET__assets_spritesheets_enemy6_png);
		type.set ("assets/spritesheets/enemy6.png", AssetType.IMAGE);
		
		className.set ("assets/spritesheets/enemy4.png", __ASSET__assets_spritesheets_enemy4_png);
		type.set ("assets/spritesheets/enemy4.png", AssetType.IMAGE);
		
		className.set ("assets/spritesheets/player.png", __ASSET__assets_spritesheets_player_png);
		type.set ("assets/spritesheets/player.png", AssetType.IMAGE);
		
		className.set ("assets/levels/normal.json", __ASSET__assets_levels_normal_json);
		type.set ("assets/levels/normal.json", AssetType.TEXT);
		
		className.set ("assets/buttons/onButton.png", __ASSET__assets_buttons_onbutton_png);
		type.set ("assets/buttons/onButton.png", AssetType.IMAGE);
		
		className.set ("assets/buttons/maxHealthButton.png", __ASSET__assets_buttons_maxhealthbutton_png);
		type.set ("assets/buttons/maxHealthButton.png", AssetType.IMAGE);
		
		className.set ("assets/buttons/shootDamageButton.png", __ASSET__assets_buttons_shootdamagebutton_png);
		type.set ("assets/buttons/shootDamageButton.png", AssetType.IMAGE);
		
		className.set ("assets/buttons/backButton.png", __ASSET__assets_buttons_backbutton_png);
		type.set ("assets/buttons/backButton.png", AssetType.IMAGE);
		
		className.set ("assets/buttons/achievementsButton.png", __ASSET__assets_buttons_achievementsbutton_png);
		type.set ("assets/buttons/achievementsButton.png", AssetType.IMAGE);
		
		className.set ("assets/buttons/criticalMultiplierButton.png", __ASSET__assets_buttons_criticalmultiplierbutton_png);
		type.set ("assets/buttons/criticalMultiplierButton.png", AssetType.IMAGE);
		
		className.set ("assets/buttons/mainMenuButton.png", __ASSET__assets_buttons_mainmenubutton_png);
		type.set ("assets/buttons/mainMenuButton.png", AssetType.IMAGE);
		
		className.set ("assets/buttons/optionsButton.png", __ASSET__assets_buttons_optionsbutton_png);
		type.set ("assets/buttons/optionsButton.png", AssetType.IMAGE);
		
		className.set ("assets/buttons/shootFrequencyButton.png", __ASSET__assets_buttons_shootfrequencybutton_png);
		type.set ("assets/buttons/shootFrequencyButton.png", AssetType.IMAGE);
		
		className.set ("assets/buttons/playButton.png", __ASSET__assets_buttons_playbutton_png);
		type.set ("assets/buttons/playButton.png", AssetType.IMAGE);
		
		className.set ("assets/buttons/shootSpeedButton.png", __ASSET__assets_buttons_shootspeedbutton_png);
		type.set ("assets/buttons/shootSpeedButton.png", AssetType.IMAGE);
		
		className.set ("assets/buttons/offButton.png", __ASSET__assets_buttons_offbutton_png);
		type.set ("assets/buttons/offButton.png", AssetType.IMAGE);
		
		className.set ("assets/buttons/clearButton.png", __ASSET__assets_buttons_clearbutton_png);
		type.set ("assets/buttons/clearButton.png", AssetType.IMAGE);
		
		className.set ("assets/buttons/continueButton.png", __ASSET__assets_buttons_continuebutton_png);
		type.set ("assets/buttons/continueButton.png", AssetType.IMAGE);
		
		className.set ("assets/fonts/04b04.ttf", __ASSET__assets_fonts_04b04_ttf);
		type.set ("assets/fonts/04b04.ttf", AssetType.FONT);
		
		className.set ("assets/img/upgradeBackground.png", __ASSET__assets_img_upgradebackground_png);
		type.set ("assets/img/upgradeBackground.png", AssetType.IMAGE);
		
		className.set ("assets/img/higQuality.png", __ASSET__assets_img_higquality_png);
		type.set ("assets/img/higQuality.png", AssetType.IMAGE);
		
		className.set ("assets/img/medQuality.png", __ASSET__assets_img_medquality_png);
		type.set ("assets/img/medQuality.png", AssetType.IMAGE);
		
		className.set ("assets/img/menuBackground.png", __ASSET__assets_img_menubackground_png);
		type.set ("assets/img/menuBackground.png", AssetType.IMAGE);
		
		className.set ("assets/img/gameOver.png", __ASSET__assets_img_gameover_png);
		type.set ("assets/img/gameOver.png", AssetType.IMAGE);
		
		className.set ("assets/img/lowQuality.png", __ASSET__assets_img_lowquality_png);
		type.set ("assets/img/lowQuality.png", AssetType.IMAGE);
		
		className.set ("assets/sounds/enemyDeath1.wav", __ASSET__assets_sounds_enemydeath1_wav);
		type.set ("assets/sounds/enemyDeath1.wav", AssetType.SOUND);
		
		className.set ("assets/sounds/enemyDeath2.wav", __ASSET__assets_sounds_enemydeath2_wav);
		type.set ("assets/sounds/enemyDeath2.wav", AssetType.SOUND);
		
		className.set ("assets/sounds/coinPick.wav", __ASSET__assets_sounds_coinpick_wav);
		type.set ("assets/sounds/coinPick.wav", AssetType.SOUND);
		
		className.set ("assets/sounds/enemyDeath3.wav", __ASSET__assets_sounds_enemydeath3_wav);
		type.set ("assets/sounds/enemyDeath3.wav", AssetType.SOUND);
		
		
		if (useManifest) {
			
			loadManifest ();
			
			if (Sys.args ().indexOf ("-livereload") > -1) {
				
				var path = FileSystem.fullPath ("manifest");
				lastModified = FileSystem.stat (path).mtime.getTime ();
				
				timer = new Timer (2000);
				timer.run = function () {
					
					var modified = FileSystem.stat (path).mtime.getTime ();
					
					if (modified > lastModified) {
						
						lastModified = modified;
						loadManifest ();
						
						if (eventCallback != null) {
							
							eventCallback (this, "change");
							
						}
						
					}
					
				}
				
			}
			
		}
		
		#else
		
		loadManifest ();
		
		#end
		#end
		
	}
	
	
	public override function exists (id:String, type:AssetType):Bool {
		
		var assetType = this.type.get (id);
		
		#if pixi
		
		if (assetType == IMAGE) {
			
			return true;
			
		} else {
			
			return false;
			
		}
		
		#end
		
		if (assetType != null) {
			
			if (assetType == type || ((type == SOUND || type == MUSIC) && (assetType == MUSIC || assetType == SOUND))) {
				
				return true;
				
			}
			
			#if flash
			
			if ((assetType == BINARY || assetType == TEXT) && type == BINARY) {
				
				return true;
				
			} else if (path.exists (id)) {
				
				return true;
				
			}
			
			#else
			
			if (type == BINARY || type == null) {
				
				return true;
				
			}
			
			#end
			
		}
		
		return false;
		
	}
	
	
	public override function getBitmapData (id:String):BitmapData {
		
		#if pixi
		
		return BitmapData.fromImage (path.get (id));
		
		#elseif (flash)
		
		return cast (Type.createInstance (className.get (id), []), BitmapData);
		
		#elseif openfl_html5
		
		return BitmapData.fromImage (ApplicationMain.images.get (path.get (id)));
		
		#elseif js
		
		return cast (ApplicationMain.loaders.get (path.get (id)).contentLoaderInfo.content, Bitmap).bitmapData;
		
		#else
		
		if (className.exists(id)) return cast (Type.createInstance (className.get (id), []), BitmapData);
		else return BitmapData.load (path.get (id));
		
		#end
		
	}
	
	
	public override function getBytes (id:String):ByteArray {
		
		#if (flash)
		
		return cast (Type.createInstance (className.get (id), []), ByteArray);

		#elseif (js || openfl_html5 || pixi)
		
		var bytes:ByteArray = null;
		var data = ApplicationMain.urlLoaders.get (path.get (id)).data;
		
		if (Std.is (data, String)) {
			
			bytes = new ByteArray ();
			bytes.writeUTFBytes (data);
			
		} else if (Std.is (data, ByteArray)) {
			
			bytes = cast data;
			
		} else {
			
			bytes = null;
			
		}

		if (bytes != null) {
			
			bytes.position = 0;
			return bytes;
			
		} else {
			
			return null;
		}
		
		#else
		
		if (className.exists(id)) return cast (Type.createInstance (className.get (id), []), ByteArray);
		else return ByteArray.readFile (path.get (id));
		
		#end
		
	}
	
	
	public override function getFont (id:String):Font {
		
		#if pixi
		
		return null;
		
		#elseif (flash || js)
		
		return cast (Type.createInstance (className.get (id), []), Font);
		
		#else
		
		if (className.exists(id)) {
			var fontClass = className.get(id);
			Font.registerFont(fontClass);
			return cast (Type.createInstance (fontClass, []), Font);
		} else return new Font (path.get (id));
		
		#end
		
	}
	
	
	public override function getMusic (id:String):Sound {
		
		#if pixi
		
		return null;
		
		#elseif (flash)
		
		return cast (Type.createInstance (className.get (id), []), Sound);
		
		#elseif openfl_html5
		
		var sound = new Sound ();
		sound.__buffer = true;
		sound.load (new URLRequest (path.get (id)));
		return sound; 
		
		#elseif js
		
		return new Sound (new URLRequest (path.get (id)));
		
		#else
		
		if (className.exists(id)) return cast (Type.createInstance (className.get (id), []), Sound);
		else return new Sound (new URLRequest (path.get (id)), null, true);
		
		#end
		
	}
	
	
	public override function getPath (id:String):String {
		
		#if ios
		
		return SystemPath.applicationDirectory + "/assets/" + path.get (id);
		
		#else
		
		return path.get (id);
		
		#end
		
	}
	
	
	public override function getSound (id:String):Sound {
		
		#if pixi
		
		return null;
		
		#elseif (flash)
		
		return cast (Type.createInstance (className.get (id), []), Sound);
		
		#elseif js
		
		return new Sound (new URLRequest (path.get (id)));
		
		#else
		
		if (className.exists(id)) return cast (Type.createInstance (className.get (id), []), Sound);
		else return new Sound (new URLRequest (path.get (id)), null, type.get (id) == MUSIC);
		
		#end
		
	}
	
	
	public override function getText (id:String):String {
		
		#if js
		
		var bytes:ByteArray = null;
		var data = ApplicationMain.urlLoaders.get (path.get (id)).data;
		
		if (Std.is (data, String)) {
			
			return cast data;
			
		} else if (Std.is (data, ByteArray)) {
			
			bytes = cast data;
			
		} else {
			
			bytes = null;
			
		}
		
		if (bytes != null) {
			
			bytes.position = 0;
			return bytes.readUTFBytes (bytes.length);
			
		} else {
			
			return null;
		}
		
		#else
		
		var bytes = getBytes (id);
		
		if (bytes == null) {
			
			return null;
			
		} else {
			
			return bytes.readUTFBytes (bytes.length);
			
		}
		
		#end
		
	}
	
	
	public override function isLocal (id:String, type:AssetType):Bool {
		
		#if flash
		
		if (type != AssetType.MUSIC && type != AssetType.SOUND) {
			
			return className.exists (id);
			
		}
		
		#end
		
		return true;
		
	}
	
	
	public override function list (type:AssetType):Array<String> {
		
		var items = [];
		
		for (id in this.type.keys ()) {
			
			if (type == null || exists (id, type)) {
				
				items.push (id);
				
			}
			
		}
		
		return items;
		
	}
	
	
	public override function loadBitmapData (id:String, handler:BitmapData -> Void):Void {
		
		#if pixi
		
		handler (getBitmapData (id));
		
		#elseif (flash || js)
		
		if (path.exists (id)) {
			
			var loader = new Loader ();
			loader.contentLoaderInfo.addEventListener (Event.COMPLETE, function (event:Event) {
				
				handler (cast (event.currentTarget.content, Bitmap).bitmapData);
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {
			
			handler (getBitmapData (id));
			
		}
		
		#else
		
		handler (getBitmapData (id));
		
		#end
		
	}
	
	
	public override function loadBytes (id:String, handler:ByteArray -> Void):Void {
		
		#if pixi
		
		handler (getBytes (id));
		
		#elseif (flash || js)
		
		if (path.exists (id)) {
			
			var loader = new URLLoader ();
			loader.addEventListener (Event.COMPLETE, function (event:Event) {
				
				var bytes = new ByteArray ();
				bytes.writeUTFBytes (event.currentTarget.data);
				bytes.position = 0;
				
				handler (bytes);
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {
			
			handler (getBytes (id));
			
		}
		
		#else
		
		handler (getBytes (id));
		
		#end
		
	}
	
	
	public override function loadFont (id:String, handler:Font -> Void):Void {
		
		#if (flash || js)
		
		/*if (path.exists (id)) {
			
			var loader = new Loader ();
			loader.contentLoaderInfo.addEventListener (Event.COMPLETE, function (event) {
				
				handler (cast (event.currentTarget.content, Bitmap).bitmapData);
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {*/
			
			handler (getFont (id));
			
		//}
		
		#else
		
		handler (getFont (id));
		
		#end
		
	}
	
	
	#if (!flash && !html5)
	private function loadManifest ():Void {
		
		try {
			
			#if blackberry
			var bytes = ByteArray.readFile ("app/native/manifest");
			#elseif tizen
			var bytes = ByteArray.readFile ("../res/manifest");
			#elseif emscripten
			var bytes = ByteArray.readFile ("assets/manifest");
			#else
			var bytes = ByteArray.readFile ("manifest");
			#end
			
			if (bytes != null) {
				
				bytes.position = 0;
				
				if (bytes.length > 0) {
					
					var data = bytes.readUTFBytes (bytes.length);
					
					if (data != null && data.length > 0) {
						
						var manifest:Array<Dynamic> = Unserializer.run (data);
						
						for (asset in manifest) {
							
							if (!className.exists (asset.id)) {
								
								path.set (asset.id, asset.path);
								type.set (asset.id, Type.createEnum (AssetType, asset.type));
								
							}
							
						}
						
					}
					
				}
				
			} else {
				
				trace ("Warning: Could not load asset manifest (bytes was null)");
				
			}
		
		} catch (e:Dynamic) {
			
			trace ('Warning: Could not load asset manifest (${e})');
			
		}
		
	}
	#end
	
	
	public override function loadMusic (id:String, handler:Sound -> Void):Void {
		
		#if (flash || js)
		
		/*if (path.exists (id)) {
			
			var loader = new Loader ();
			loader.contentLoaderInfo.addEventListener (Event.COMPLETE, function (event) {
				
				handler (cast (event.currentTarget.content, Bitmap).bitmapData);
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {*/
			
			handler (getMusic (id));
			
		//}
		
		#else
		
		handler (getMusic (id));
		
		#end
		
	}
	
	
	public override function loadSound (id:String, handler:Sound -> Void):Void {
		
		#if (flash || js)
		
		/*if (path.exists (id)) {
			
			var loader = new Loader ();
			loader.contentLoaderInfo.addEventListener (Event.COMPLETE, function (event) {
				
				handler (cast (event.currentTarget.content, Bitmap).bitmapData);
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {*/
			
			handler (getSound (id));
			
		//}
		
		#else
		
		handler (getSound (id));
		
		#end
		
	}
	
	
	public override function loadText (id:String, handler:String -> Void):Void {
		
		#if js
		
		if (path.exists (id)) {
			
			var loader = new URLLoader ();
			loader.addEventListener (Event.COMPLETE, function (event:Event) {
				
				handler (event.currentTarget.data);
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {
			
			handler (getText (id));
			
		}
		
		#else
		
		var callback = function (bytes:ByteArray):Void {
			
			if (bytes == null) {
				
				handler (null);
				
			} else {
				
				handler (bytes.readUTFBytes (bytes.length));
				
			}
			
		}
		
		loadBytes (id, callback);
		
		#end
		
	}
	
	
}


#if pixi
#elseif flash

@:keep class __ASSET__assets_spritesheets_enemy5_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_spritesheets_enemy1_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_spritesheets_enemy7_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_spritesheets_enemy3_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_spritesheets_enemy2_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_spritesheets_enemy6_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_spritesheets_enemy4_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_spritesheets_player_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_levels_normal_json extends openfl.utils.ByteArray { }
@:keep class __ASSET__assets_buttons_onbutton_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_buttons_maxhealthbutton_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_buttons_shootdamagebutton_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_buttons_backbutton_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_buttons_achievementsbutton_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_buttons_criticalmultiplierbutton_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_buttons_mainmenubutton_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_buttons_optionsbutton_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_buttons_shootfrequencybutton_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_buttons_playbutton_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_buttons_shootspeedbutton_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_buttons_offbutton_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_buttons_clearbutton_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_buttons_continuebutton_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_fonts_04b04_ttf extends openfl.text.Font { }
@:keep class __ASSET__assets_img_upgradebackground_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_img_higquality_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_img_medquality_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_img_menubackground_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_img_gameover_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_img_lowquality_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_sounds_enemydeath1_wav extends openfl.media.Sound { }
@:keep class __ASSET__assets_sounds_enemydeath2_wav extends openfl.media.Sound { }
@:keep class __ASSET__assets_sounds_coinpick_wav extends openfl.media.Sound { }
@:keep class __ASSET__assets_sounds_enemydeath3_wav extends openfl.media.Sound { }


#elseif html5
























@:keep class __ASSET__assets_fonts_04b04_ttf extends flash.text.Font { #if (!openfl_html5_dom) public function new () { super (); fontName = "assets/fonts/04b04.ttf"; } #end }












#elseif (windows || mac || linux)


@:bitmap("Assets/spritesheets/enemy5.png") class __ASSET__assets_spritesheets_enemy5_png extends flash.display.BitmapData {}
@:bitmap("Assets/spritesheets/enemy1.png") class __ASSET__assets_spritesheets_enemy1_png extends flash.display.BitmapData {}
@:bitmap("Assets/spritesheets/enemy7.png") class __ASSET__assets_spritesheets_enemy7_png extends flash.display.BitmapData {}
@:bitmap("Assets/spritesheets/enemy3.png") class __ASSET__assets_spritesheets_enemy3_png extends flash.display.BitmapData {}
@:bitmap("Assets/spritesheets/enemy2.png") class __ASSET__assets_spritesheets_enemy2_png extends flash.display.BitmapData {}
@:bitmap("Assets/spritesheets/enemy6.png") class __ASSET__assets_spritesheets_enemy6_png extends flash.display.BitmapData {}
@:bitmap("Assets/spritesheets/enemy4.png") class __ASSET__assets_spritesheets_enemy4_png extends flash.display.BitmapData {}
@:bitmap("Assets/spritesheets/player.png") class __ASSET__assets_spritesheets_player_png extends flash.display.BitmapData {}
@:file("Assets/levels/normal.json") class __ASSET__assets_levels_normal_json extends flash.utils.ByteArray {}
@:bitmap("Assets/buttons/onButton.png") class __ASSET__assets_buttons_onbutton_png extends flash.display.BitmapData {}
@:bitmap("Assets/buttons/maxHealthButton.png") class __ASSET__assets_buttons_maxhealthbutton_png extends flash.display.BitmapData {}
@:bitmap("Assets/buttons/shootDamageButton.png") class __ASSET__assets_buttons_shootdamagebutton_png extends flash.display.BitmapData {}
@:bitmap("Assets/buttons/backButton.png") class __ASSET__assets_buttons_backbutton_png extends flash.display.BitmapData {}
@:bitmap("Assets/buttons/achievementsButton.png") class __ASSET__assets_buttons_achievementsbutton_png extends flash.display.BitmapData {}
@:bitmap("Assets/buttons/criticalMultiplierButton.png") class __ASSET__assets_buttons_criticalmultiplierbutton_png extends flash.display.BitmapData {}
@:bitmap("Assets/buttons/mainMenuButton.png") class __ASSET__assets_buttons_mainmenubutton_png extends flash.display.BitmapData {}
@:bitmap("Assets/buttons/optionsButton.png") class __ASSET__assets_buttons_optionsbutton_png extends flash.display.BitmapData {}
@:bitmap("Assets/buttons/shootFrequencyButton.png") class __ASSET__assets_buttons_shootfrequencybutton_png extends flash.display.BitmapData {}
@:bitmap("Assets/buttons/playButton.png") class __ASSET__assets_buttons_playbutton_png extends flash.display.BitmapData {}
@:bitmap("Assets/buttons/shootSpeedButton.png") class __ASSET__assets_buttons_shootspeedbutton_png extends flash.display.BitmapData {}
@:bitmap("Assets/buttons/offButton.png") class __ASSET__assets_buttons_offbutton_png extends flash.display.BitmapData {}
@:bitmap("Assets/buttons/clearButton.png") class __ASSET__assets_buttons_clearbutton_png extends flash.display.BitmapData {}
@:bitmap("Assets/buttons/continueButton.png") class __ASSET__assets_buttons_continuebutton_png extends flash.display.BitmapData {}
@:font("Assets/fonts/04b04.ttf") class __ASSET__assets_fonts_04b04_ttf extends flash.text.Font {}
@:bitmap("Assets/img/upgradeBackground.png") class __ASSET__assets_img_upgradebackground_png extends flash.display.BitmapData {}
@:bitmap("Assets/img/higQuality.png") class __ASSET__assets_img_higquality_png extends flash.display.BitmapData {}
@:bitmap("Assets/img/medQuality.png") class __ASSET__assets_img_medquality_png extends flash.display.BitmapData {}
@:bitmap("Assets/img/menuBackground.png") class __ASSET__assets_img_menubackground_png extends flash.display.BitmapData {}
@:bitmap("Assets/img/gameOver.png") class __ASSET__assets_img_gameover_png extends flash.display.BitmapData {}
@:bitmap("Assets/img/lowQuality.png") class __ASSET__assets_img_lowquality_png extends flash.display.BitmapData {}
@:sound("Assets/sounds/enemyDeath1.wav") class __ASSET__assets_sounds_enemydeath1_wav extends flash.media.Sound {}
@:sound("Assets/sounds/enemyDeath2.wav") class __ASSET__assets_sounds_enemydeath2_wav extends flash.media.Sound {}
@:sound("Assets/sounds/coinPick.wav") class __ASSET__assets_sounds_coinpick_wav extends flash.media.Sound {}
@:sound("Assets/sounds/enemyDeath3.wav") class __ASSET__assets_sounds_enemydeath3_wav extends flash.media.Sound {}


#end
