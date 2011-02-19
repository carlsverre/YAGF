package games.pong
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author 
	 */
	public class Brick extends Sprite
	{
		
		public function Brick(width:Number, height:Number, color:uint) 
		{
			draw(width,height,color);
		}
		
		private function draw(width:Number, height:Number, color:uint):void {
			this.graphics.beginFill(color);
			this.graphics.drawRect(0, 0, width, height);
			this.graphics.endFill();
		}
		
	}

}