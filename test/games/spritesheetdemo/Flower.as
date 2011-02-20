package games.spritesheetdemo
{
	import com.carlsverre.yagf.SpriteSheet;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import com.carlsverre.yagf.YAGF;
	
	public class Flower extends Sprite
	{
		private var canvas:Bitmap;
		private var flowersSS:SpriteSheet;
		private var clearRect:Rectangle;
		private var animationIndex:Number = 0;
		
		public function Flower() 
		{
		}
		
		public function Setup():void {
			flowersSS = YAGF.Instance.SSManager.GetSpriteSheet("flowers");
			canvas = new Bitmap();
			addChild(canvas);
			
			canvas.bitmapData = new BitmapData(flowersSS.TileWidth, flowersSS.TileHeight);
			clearRect = new Rectangle(0, 0, flowersSS.TileWidth, flowersSS.TileHeight);
		}
		
		public function Animate(timeDelta:Number):void
		{
			animationIndex += timeDelta;
			var timedAnimIndex:int = Math.floor(animationIndex) % flowersSS.NumTiles;
			
			canvas.bitmapData.fillRect(clearRect, 0x00000000);
			flowersSS.Blit(timedAnimIndex, canvas.bitmapData, 0, 0);
		}
		
	}

}