package rooms.entities;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.events.Event;
import flash.events.MouseEvent;
import openfl.Assets;

import rooms.screens.GameStage;

class ProtectionUpgrade extends Upgrade {

	public function new(game:GameStage) {
		super(game);

		addChild(new Bitmap(
					Assets.getBitmapData('assets/img/protectUpgrade.png')
		));
	}

	override private function onClick(e:MouseEvent):Void {
		super.onClick(e);

		game.activateUpgrade(Upgrade.PROTECT);
	}

}
