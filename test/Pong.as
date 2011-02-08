package 
{
	import com.carlsverre.yagf.Game;
	import com.coreyoneil.collision.CollisionGroup;
	import com.coreyoneil.collision.CollisionList;
	import flash.events.KeyboardEvent;
	import com.carlsverre.yagf.YAGF;
	import flash.display.Sprite;
	import flash.display.Graphics;
	import com.coreyoneil.collision.CDK;
	import com.carlsverre.yagf.*;

	public class Pong extends Game
	{
		// collisions
		private var BallPaddleG:CollisionList;
		
		private var Ball:Sprite;
		private var BallVelocityX:Number;
		private var BallVelocityY:Number;
		
		private var Paddle:Sprite;
		
		public function Pong() 
		{}
		
		override public function Setup():void 
		{
			KeyManager.Instance.AddKeyBinding({
				menu: Key.ESCAPE
			});
			KeyManager.Instance.AddKeyBinding({
				left: Key.LEFT,
				right: Key.RIGHT
			}, PLAYER1);
			
			Paddle = drawPaddle(createObject());
			Ball = drawBall(createObject());
			
			Paddle.x = stage.stageWidth / 2 - Paddle.width/2;
			Paddle.y = stage.stageHeight - 30;
			
			Ball.x = stage.stageWidth / 2 - Ball.width/2;
			Ball.y = stage.stageHeight / 2 - Ball.height / 2;
			
			BallVelocityX = Math.random() * 3 + 2;
			BallVelocityY = Math.random() * 3 + 2;
		}
		
		private function drawPaddle(s:Sprite):Sprite {
			s.graphics.beginFill(0x00ff00);
			s.graphics.drawRect(0, 0, 100, 10);
			s.graphics.endFill();
			return s;
		}
		
		private function drawBall(s:Sprite):Sprite {
			s.graphics.beginFill(0x0000ff);
			s.graphics.drawCircle(0, 0, 5);
			s.graphics.endFill();
			return s;
		}
		
		private function createObject():Sprite {
			var obj:Sprite = new Sprite();
			
			stage.addChild(obj);
			return obj;
		}
		
		override public function Update(delta:Number):void 
		{
			if (keybindingPressed("right", PLAYER1)) Paddle.x += 5;
			else if (keybindingPressed("left", PLAYER1)) Paddle.x -= 5;
			
			//Paddle.x = mouseX - Paddle.width/2;
			
			if (Paddle.x > stage.stageWidth - Paddle.width) {
				Paddle.x = stage.stageWidth - Paddle.width;
			} else if (Paddle.x < 0) {
				Paddle.x = 0;
			}
			
			var newPosX:Number = Ball.x + BallVelocityX;
			var newPosY:Number = Ball.y + BallVelocityY;
			
			// check for ball collision with paddle
			if (newPosX > Paddle.x && newPosX < Paddle.x + Paddle.width
			 && newPosY > Paddle.y && newPosY < Paddle.y + Paddle.height) {
				BallVelocityY = -BallVelocityY;
			}
			
			if (newPosX > stage.stageWidth || newPosX < 0) BallVelocityX = -BallVelocityX;
			if (newPosY > stage.stageHeight || newPosY < 0) BallVelocityY = -BallVelocityY;
			
			Ball.x += BallVelocityX;
			Ball.y += BallVelocityY;
		}
		
	}

}