package games.pong
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
		private var speed:Number;
		
		public function Paddle(speed:Number, color:uint = 0x0000ff, width:int = 100) 
		{
			this.speed = speed;
			draw(color, width);
		}
		
		private function draw(color:uint, width:int):void {
			this.graphics.beginFill(color);
			this.graphics.drawRect(0, 0, width, 10);
			this.graphics.endFill();
		}
		
		public function Update(delta:Number):void {
			if (KeyManager.ActionPressed("right", KeyManager.PLAYER1)) {
				x += speed * delta;
			}
			if (KeyManager.ActionPressed("left", KeyManager.PLAYER1)) {
				x -= speed * delta;
			}
			
			if (x < 0)
				x = 0;
			else if (x > stage.stageWidth - width)
				x = stage.stageWidth - width;
		}
	}

}