package  
{
	import flash.display.Sprite;
	import flash.geom.Point;
	/**
	 * ...
	 * @author 
	 */
	public class Ball extends Sprite
	{
		private var velocity:Point;
		private var lastPosition:Point;
		
		public function Ball(velocityX:Number, velocityY:Number, color:uint = 0x0000ff, radius:int = 5) 
		{
			velocity = new Point(velocityX, velocityY);
			lastPosition = new Point(0, 0);
		
			draw(color, radius);
		}
		
		private function draw(color:uint, radius:int):void {
			this.graphics.beginFill(color);
			this.graphics.drawCircle(0, 0, radius);
			this.graphics.endFill();
		}
		
		public function Update():void {
			lastPosition.x = x;
			lastPosition.y = y;
			
			x += velocity.x;
			y += velocity.y;
			
			if (x < 0) {
				x = 0;
				BounceHorizontal();
			} else if (x > stage.stageWidth - width) {
				x = stage.stageWidth - width;
				BounceHorizontal();
			}
				
			if (y < 0) {
				y = 0;
				BounceVertical();
			} else if (y > stage.stageHeight - height) {
				y = stage.stageHeight - width;
				BounceVertical();
			}
		}
		
		public function BounceVertical():void {
			velocity.y = -velocity.y;
			x = lastPosition.x;
			y = lastPosition.y;
		}
		
		public function BounceHorizontal():void {
			velocity.x = -velocity.x;
			x = lastPosition.x;
			y = lastPosition.y;
		}
	}

}