package games.spritesheetdemo
{
	import adobe.utils.CustomActions;
	import com.carlsverre.yagf.SpriteSheet;
	import com.carlsverre.yagf.YAGF;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.sampler.NewObjectSample;
	
	public class Background extends Sprite
	{
		private var flowers:Array;
		private var bg:Bitmap;
		
		public function Background() 
		{
			
		}
		
		public function Setup():void {
			flowers = [];
			bg = new Bitmap();
			addChild(bg);
			drawLevel();
		}
		
		private function drawLevel():void {
			var grassSS:SpriteSheet = YAGF.Instance.SSManager.GetSpriteSheet("grass");
			var bushesSS:SpriteSheet = YAGF.Instance.SSManager.GetSpriteSheet("bushes");
			
			var levelWidth:int = stage.stageWidth / grassSS.TileWidth;
			var levelHeight:int = stage.stageHeight / grassSS.TileHeight;
			
			var target:BitmapData = new BitmapData(levelWidth * grassSS.TileWidth, levelHeight * grassSS.TileHeight);
			
			var rTmp:int;
			for (var y:int = 0; y < levelHeight; y++) {
				for (var x:int = 0; x < levelWidth; x++) {
					var targetX:int = x * grassSS.TileWidth;
					var targetY:int = y * grassSS.TileHeight;
					
					rTmp = Math.floor(Math.random() * grassSS.NumTiles);
					grassSS.Blit(rTmp, target, targetX, targetY);
					
					if (y == 0 || y == levelHeight - 1 || x == 0 || x == levelWidth - 1) {
						rTmp = Math.floor(Math.random() * bushesSS.NumTiles);
						bushesSS.Blit(rTmp, target, targetX, targetY);
					} else if (Math.random() > 0.9) {
						var f:Flower = new Flower();
						f.x = targetX;
						f.y = targetY;
						addChild(f);
						f.Setup();
						flowers.push(f);
					}
				}
			}
			
			bg.bitmapData = target;
		}
		
		public function Animate(timeDelta:Number):void {
			for each(var f:Flower in flowers) {
				f.Animate(timeDelta);
			}
		}
		
	}

}