package  
{
	import com.carlsverre.yagf.Game;
	import com.carlsverre.yagf.Key;
	import com.carlsverre.yagf.KeyManager;
	import com.carlsverre.yagf.SimpleTF;
	import com.carlsverre.yagf.YAGF;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	
	import games.pong.Pong;
	import games.spritesheetdemo.SpriteSheetDemoGame;
	
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
			KeyManager.AddKeyBinding( {
				"nextItem": Key.DOWN,
				"previousItem":Key.UP,
				"useItem":Key.ENTER
			});
			
			background = new Bitmap(new BitmapData(stage.stageWidth, stage.stageHeight, false, 0xff000000));
			addChild(background);
			
			menu = [];
			selectedItem = 0;
			
			var i:int = 0;
			var height:Number = 50;
			
			var menuTF:SimpleTF;
			for (var key:String in menuItems) {
				menuTF = new SimpleTF();
				menuTF.Text = key;
				menuTF.FontColor = 0xffffffff;
				menuTF.FontSize = 25;
				menuTF.Size = new Point(300, height);
				menuTF.x = 20;
				menuTF.y = i * height;
				i++;
				menu.push(menuTF);
				addChild(menuTF);
				
				menuTF.Redraw();
			}
			
			selectItem(selectedItem);
		}
		
		override public function Shutdown():void 
		{
			KeyManager.RemoveAllKeyBindings();
		}
		
		private function selectItem(index:int):void {
			for (var i:int = 0; i < menu.length; i++) {
				menu[i].FontBold = (i == index);
				menu[i].Redraw();
			}
		}
		
		override public function Update(delta:Number):void 
		{
			if (KeyManager.ActionReleased("nextItem")) {
				selectedItem = (selectedItem + 1) % (menu.length);
			} else if (KeyManager.ActionReleased("previousItem")) {
				selectedItem = (--selectedItem < 0) ? menu.length - 1 : selectedItem;
			} else if (KeyManager.ActionReleased("useItem")) {
				YAGF.Instance.SwitchGame(menuItems[menu[selectedItem].Text]);
			}
			
			selectItem(selectedItem);
		}
		
	}

}