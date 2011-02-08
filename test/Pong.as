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
		private var mainCollisionList:CollisionList;
		
		private var ball:Ball;
		private var paddle:Paddle;
		
		public function Pong() 
		{}
		
		override public function Setup():void 
		{
			KeyManager.AddKeyBinding({
				menu: Key.ESCAPE
			});
			KeyManager.AddKeyBinding({
				left: Key.LEFT,
				right: Key.RIGHT
			}, KeyManager.PLAYER1);
			
			paddle = new Paddle();
			ball = new Ball(Math.random() * 3 + 2, Math.random() * 3 + 2);
			
			ball.x = stage.stageWidth / 2;
			ball.y = stage.stageHeight / 2;
			
			paddle.x = stage.stageWidth / 2 - paddle.width / 2;
			paddle.y = stage.stageHeight - 50;
			
			addChild(paddle);
			addChild(ball);
			
			mainCollisionList = new CollisionList(paddle, ball);
		}
		
		override public function Update(delta:Number):void 
		{
			// update game objects
			paddle.Update();
			ball.Update();
			
			// do collisions
			var collisions:Array = mainCollisionList.checkCollisions();
			if (collisions.length > 0) {
				// there has been a collision between the paddle and the ball
				var collision:Object = collisions[0];
				ball.BounceVertical();
			}
		}
		
	}

}