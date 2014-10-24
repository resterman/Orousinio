package lime;


import lime.utils.Assets;


class AssetData {

	private static var initialized:Bool = false;
	
	public static var library = new #if haxe3 Map <String, #else Hash <#end LibraryType> ();
	public static var path = new #if haxe3 Map <String, #else Hash <#end String> ();
	public static var type = new #if haxe3 Map <String, #else Hash <#end AssetType> ();	
	
	public static function initialize():Void {
		
		if (!initialized) {
			
			path.set ("assets/spritesheets/enemy5.png", "assets/spritesheets/enemy5.png");
			type.set ("assets/spritesheets/enemy5.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/spritesheets/enemy1.png", "assets/spritesheets/enemy1.png");
			type.set ("assets/spritesheets/enemy1.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/spritesheets/enemy7.png", "assets/spritesheets/enemy7.png");
			type.set ("assets/spritesheets/enemy7.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/spritesheets/enemy3.png", "assets/spritesheets/enemy3.png");
			type.set ("assets/spritesheets/enemy3.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/spritesheets/enemy2.png", "assets/spritesheets/enemy2.png");
			type.set ("assets/spritesheets/enemy2.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/spritesheets/enemy6.png", "assets/spritesheets/enemy6.png");
			type.set ("assets/spritesheets/enemy6.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/spritesheets/enemy4.png", "assets/spritesheets/enemy4.png");
			type.set ("assets/spritesheets/enemy4.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/spritesheets/player.png", "assets/spritesheets/player.png");
			type.set ("assets/spritesheets/player.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/levels/normal.json", "assets/levels/normal.json");
			type.set ("assets/levels/normal.json", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("assets/buttons/onButton.png", "assets/buttons/onButton.png");
			type.set ("assets/buttons/onButton.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/buttons/maxHealthButton.png", "assets/buttons/maxHealthButton.png");
			type.set ("assets/buttons/maxHealthButton.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/buttons/shootDamageButton.png", "assets/buttons/shootDamageButton.png");
			type.set ("assets/buttons/shootDamageButton.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/buttons/backButton.png", "assets/buttons/backButton.png");
			type.set ("assets/buttons/backButton.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/buttons/achievementsButton.png", "assets/buttons/achievementsButton.png");
			type.set ("assets/buttons/achievementsButton.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/buttons/criticalMultiplierButton.png", "assets/buttons/criticalMultiplierButton.png");
			type.set ("assets/buttons/criticalMultiplierButton.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/buttons/mainMenuButton.png", "assets/buttons/mainMenuButton.png");
			type.set ("assets/buttons/mainMenuButton.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/buttons/optionsButton.png", "assets/buttons/optionsButton.png");
			type.set ("assets/buttons/optionsButton.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/buttons/shootFrequencyButton.png", "assets/buttons/shootFrequencyButton.png");
			type.set ("assets/buttons/shootFrequencyButton.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/buttons/playButton.png", "assets/buttons/playButton.png");
			type.set ("assets/buttons/playButton.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/buttons/shootSpeedButton.png", "assets/buttons/shootSpeedButton.png");
			type.set ("assets/buttons/shootSpeedButton.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/buttons/offButton.png", "assets/buttons/offButton.png");
			type.set ("assets/buttons/offButton.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/buttons/clearButton.png", "assets/buttons/clearButton.png");
			type.set ("assets/buttons/clearButton.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/buttons/continueButton.png", "assets/buttons/continueButton.png");
			type.set ("assets/buttons/continueButton.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/fonts/04b04.ttf", "assets/fonts/04b04.ttf");
			type.set ("assets/fonts/04b04.ttf", Reflect.field (AssetType, "font".toUpperCase ()));
			path.set ("assets/img/tripleShotUpgrade.png", "assets/img/tripleShotUpgrade.png");
			type.set ("assets/img/tripleShotUpgrade.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/img/upgradeBackground.png", "assets/img/upgradeBackground.png");
			type.set ("assets/img/upgradeBackground.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/img/higQuality.png", "assets/img/higQuality.png");
			type.set ("assets/img/higQuality.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/img/medQuality.png", "assets/img/medQuality.png");
			type.set ("assets/img/medQuality.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/img/menuBackground.png", "assets/img/menuBackground.png");
			type.set ("assets/img/menuBackground.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/img/gameOver.png", "assets/img/gameOver.png");
			type.set ("assets/img/gameOver.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/img/lowQuality.png", "assets/img/lowQuality.png");
			type.set ("assets/img/lowQuality.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/img/achievement.png", "assets/img/achievement.png");
			type.set ("assets/img/achievement.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/img/protectUpgrade.png", "assets/img/protectUpgrade.png");
			type.set ("assets/img/protectUpgrade.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/img/powerUpgrade.png", "assets/img/powerUpgrade.png");
			type.set ("assets/img/powerUpgrade.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/sounds/enemyDeath1.wav", "assets/sounds/enemyDeath1.wav");
			type.set ("assets/sounds/enemyDeath1.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("assets/sounds/enemyDeath2.wav", "assets/sounds/enemyDeath2.wav");
			type.set ("assets/sounds/enemyDeath2.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("assets/sounds/coinPick.wav", "assets/sounds/coinPick.wav");
			type.set ("assets/sounds/coinPick.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("assets/sounds/enemyDeath3.wav", "assets/sounds/enemyDeath3.wav");
			type.set ("assets/sounds/enemyDeath3.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
			
			
			initialized = true;
			
		} //!initialized
		
	} //initialize
	
	
} //AssetData
