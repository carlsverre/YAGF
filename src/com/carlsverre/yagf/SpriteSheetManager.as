package com.carlsverre.yagf 
{
	import flash.display.Bitmap;
	import flash.utils.Dictionary;

	public class SpriteSheetManager 
	{
		private var spriteSheets:Dictionary;
		
		public function SpriteSheetManager() 
		{
			spriteSheets = new Dictionary();
		}
		
		public function AddSpriteSheet(name:String, spriteSheet:Bitmap, tileWidth:int = 16, tileHeight:int = 16, preCompute:Boolean = false):void {
			spriteSheets[name] = new SpriteSheet(spriteSheet, tileWidth, tileHeight, preCompute);
		}
		
		public function RemoveSpriteSheet(name:String):void {
			delete spriteSheets[name];
		}
		
		public function ClearSpriteSheets():void {
			spriteSheets = new Dictionary();
		}
		
		public function GetSpriteSheet(name:String):SpriteSheet {
			return spriteSheets[name];
		}
	}

}