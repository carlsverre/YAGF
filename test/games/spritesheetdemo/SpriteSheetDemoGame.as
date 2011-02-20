package  games.spritesheetdemo
{
	import com.carlsverre.yagf.Game;
	import com.carlsverre.yagf.YAGF;
	import flash.display.Bitmap;
	
	public class SpriteSheetDemoGame extends Game
	{
		//{ Resources
		[Embed(source = '../../assets/character.png')]
		private var characterSpriteSheet:Class;	
		
		[Embed(source = '../../assets/grass.png')]
		private static var grassSpriteSheet:Class;
		
		[Embed(source = '../../assets/bushes.png')]
		private static var bushesSpriteSheet:Class;
		
		[Embed(source = '../../assets/flowers.png')]
		private static var flowersSpriteSheet:Class;
		//}
		
		private var background:Background;
		
		override public function Setup():void 
		{
			// setup spritesheets
			YAGF.Instance.SSManager.AddSpriteSheet("character", new characterSpriteSheet(), 16, 16, true);
			YAGF.Instance.SSManager.AddSpriteSheet("grass", new grassSpriteSheet(), 16, 16, true);
			YAGF.Instance.SSManager.AddSpriteSheet("bushes", new bushesSpriteSheet(), 16, 16, true);
			YAGF.Instance.SSManager.AddSpriteSheet("flowers", new flowersSpriteSheet(), 16, 16, true);
			
			background = new Background();
			addChild(background);
			background.Setup();
		}
		
		override public function Update(delta:Number):void 
		{
			background.Animate(delta);
		}
		
	}

}