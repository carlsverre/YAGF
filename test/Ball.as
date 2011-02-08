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
			
			trace("Ball Velocity: ", velocity);
		
			draw(color, radius);
		}
		
		private function draw(color:uint, radius:int):void {
			this.graphics.beginFill(color);
			this.graphics.drawCircle(radius, radius, radius);
			this.graphics.endFill();
		}
		
		public function Update(delta:Number):void {
			lastPosition.x = x;
			lastPosition.y = y;
			
			x += velocity.x * delta;
			y += velocity.y * delta;
			
			if (x < 0 || x > stage.stageWidth - width) {
				BounceHorizontal();
			}
				
			if (y < 0 || y > stage.stageHeight - height) {
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