package  
{
	import flash.display.Sprite;
	import flash.geom.Point;
	import com.carlsverre.yagf.KeyManager;
	/**
	 * ...
	 * @author 
	 */
	public class Paddle extends Sprite
	{	
		public function Paddle(color:uint = 0x0000ff, width:int = 100) 
		{
			draw(color, width);
		}
		
		private function draw(color:uint, width:int):void {
			this.graphics.beginFill(color);
			this.graphics.drawRect(0, 0, width, 10);
			this.graphics.endFill();
		}
		
		public function Update():void {
			if (KeyManager.actionPressed("right", KeyManager.PLAYER1)) {
				x += 5;
			}
			if (KeyManager.actionPressed("left", KeyManager.PLAYER1)) {
				x -= 5;
			}
			
			if (x < 0)
				x = 0;
			else if (x > stage.stageWidth - width)
				x = stage.stageWidth - width;
		}
	}

}