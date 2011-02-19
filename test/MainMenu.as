package  
{
	import com.carlsverre.yagf.Game;
	import com.carlsverre.yagf.SimpleTF;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	public class MainMenu extends Game
	{
		private var menuItems:Object = {
			"Pong":new Pong(),
			"Sprite Sheet Demo":new SpriteSheetDemoGame()
		};
		private var menu:Array;
		private var selectedItem:int;
		private var background:Bitmap;
		
		override public function Setup():void 
		{
			background = new Bitmap(new BitmapData(stage.stageWidth, stage.stageHeight, false, 0x00000000));
			
			menu = [];
			selectedItem = 0;
			
			var i:int = 0;
			var height:Number = 30;
			
			var menuTF:SimpleTF;
			for each(var key:String in menuItems) {
				menuTF = new SimpleTF();
				menuTF.Text = key;
				menuTF.FontColor = 0xffffff;
				menuTF.x = 20;
				menuTF.y = i * height;
				menu.push(menuTF);
				addChild(menuTF);
			}
		}
		
		override public function Update(delta:Number):void 
		{
			
		}
		
	}

}