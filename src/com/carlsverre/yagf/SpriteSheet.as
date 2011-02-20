package com.carlsverre.yagf 
{
	import flash.accessibility.AccessibilityProperties;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.ShaderParameter;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.getQualifiedClassName;

	public class SpriteSheet 
	{
		private var spriteSheetBitmapData:BitmapData;
		private var tileRectangle:Rectangle;
		private var tilePoint:Point;
		private var tmpPoint:Point;
		
		private var tileCols:int;
		private var tileRows:int;
		
		private var tileRectangles:Array;
		
		public function get TileWidth():int {
			return tileRectangle.width;
		}
		
		public function get TileHeight():int {
			return tileRectangle.height;
		}
		
		public function get NumTiles():int {
			return tileCols * tileRows;
		}
		
		public function SpriteSheet(spriteSheetBitmap:Bitmap, tileWidth:int, tileHeight:int, preCompute:Boolean = false) 
		{
			spriteSheetBitmapData = spriteSheetBitmap.bitmapData.clone();
			tileRectangle = new Rectangle(0, 0, tileWidth, tileHeight);
			tilePoint = new Point(0, 0);
			tmpPoint = new Point(0, 0);
			
			tileCols = int(spriteSheetBitmap.width / tileWidth);
			tileRows = int(spriteSheetBitmap.height / tileHeight);
			
			if (preCompute) ComputeSpriteSheet();
		}
		
		public function ComputeSpriteSheet():void {
			tileRectangles = new Array();
			
			for (var y:int = 0; y < tileRows; y++) {
				for (var x:int = 0; x < tileCols; x++) {
					var rx:int = x * tileRectangle.width;
					var ry:int = y * tileRectangle.height;
					tileRectangles.push(new Rectangle(rx, ry, tileRectangle.width, tileRectangle.height));
				}
			}
		}
		
		private function getRect(tileIndex:Number):Rectangle {
			if (tileRectangles != null) return tileRectangles[tileIndex];
			tileRectangle.x = int((tileIndex % tileCols)) * tileRectangle.width;
            tileRectangle.y = int((tileIndex / tileCols)) * tileRectangle.height;
			return tileRectangle;
		}
		
		public function Blit(tileIndex:Number, target:BitmapData, targetX:Number, targetY:Number):void {
			tmpPoint.x = targetX;
			tmpPoint.y = targetY;
			target.copyPixels(spriteSheetBitmapData, getRect(tileIndex), tmpPoint, null, null, true);
		}
		
		public function BlitLevel(levelData:Array, levelWidth:int):BitmapData {
			var levelHeight:int = levelData.length / levelWidth;
			var target:BitmapData = new BitmapData(levelWidth * tileRectangle.width, levelHeight * tileRectangle.height);
			
			for (var y:int = 0; y < levelHeight; y++) {
				for (var x:int = 0; x < levelWidth; x++) {
					Blit(levelData[x + y * levelWidth], target, x * tileRectangle.width, y * tileRectangle.height);
				}
			}
			
			return target.clone();
		}
		
	}

}