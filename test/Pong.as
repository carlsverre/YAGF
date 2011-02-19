package 
{
	import com.carlsverre.yagf.Game;
	import com.coreyoneil.collision.CollisionGroup;
	import com.coreyoneil.collision.CollisionList;
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.events.KeyboardEvent;
	import com.carlsverre.yagf.YAGF;
	import flash.display.Sprite;
	import flash.display.Graphics;
	import com.coreyoneil.collision.CDK;
	import com.carlsverre.yagf.*;
	import com.carlsverre.yagf.YAGF;
	import flash.text.TextField;

	public class Pong extends Game
	{	
		// collisions
		private var mainCollisionList:CollisionList;
		private var brickCollisionList:CollisionList;
		
		private var ball:Ball;
		private var paddle:Paddle;
		private var background:Bitmap;
		
		private var bricks:Array;
		
		private var scoreTF:SimpleTF;
		private var score:int = 0;
		
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
			
			paddle = new Paddle(200);
			ball = new Ball(Math.random() * 150 + 100, Math.random() * 150 + 100);		// atleast 10 pixels per second
			
			ball.x = stage.stageWidth / 2;
			ball.y = stage.stageHeight / 2;
			
			paddle.x = stage.stageWidth / 2 - paddle.width / 2;
			paddle.y = stage.stageHeight - 50;
			
			addChild(paddle);
			addChild(ball);
			
			mainCollisionList = new CollisionList(paddle, ball);
			brickCollisionList = new CollisionList(ball);
			
			createBricks(10, 10);
			
			createScore();
		}
		
		override public function Shutdown():void 
		{
			while (numChildren > 0) {
				removeChildAt(0);
			}
		}
		
		private function createBricks(rows:int, columns:int):void {
			var brickWidth:Number = stage.stageWidth / columns;
			var brickMargin:Number = 5;
			var brickHeight:Number = 30;
			
			bricks = [];
			
			for (var y:int = 0; y < rows; y++) {
				for (var x:int = 0; x < columns; x++) {
					var color:uint = 0xffffff * Math.random();
					if (color > 0xdddddd) color -= 0x222222;
					var brick:Brick = new Brick(brickWidth - brickMargin, brickHeight - brickMargin, color);
					brick.x = x * brickWidth + brickMargin;
					brick.y = y * brickHeight + brickMargin;
					addChild(brick);
					brickCollisionList.addItem(brick);
					
					bricks[x + y * columns] = brick;
				}
			}
		}
		
		private function createScore():void {
			scoreTF = new SimpleTF();
			addChild(scoreTF);
			
			scoreTF.Size.x = 200;
			scoreTF.FontColor = 0x333333;
			scoreTF.Font = "Impact";
			
			updateScore();
			
			var margin:int = 10;
			scoreTF.x = margin;
			scoreTF.y = stage.stageHeight - scoreTF.textHeight - margin;
		}
		
		private function updateScore(newScore:int = 0 ):void {
			scoreTF.Text = "Score: "+newScore;
			scoreTF.Redraw();
		}
		
		override public function Update(delta:Number):void 
		{
			// update game objects
			paddle.Update(delta);
			ball.Update(delta);
			
			// do collisions
			var ballPaddleCollisions:Array = mainCollisionList.checkCollisions();
			if (ballPaddleCollisions.length > 0) {
				// there has been a collision between the paddle and the ball
				var collision:Object = ballPaddleCollisions[0];
				ball.BounceVertical();
			}
			
			var brickCollisions:Array = brickCollisionList.checkCollisions();
			var brick:DisplayObject;
			for each (var c:Object in brickCollisions) {
				if (c.object1 != ball) brick = c.object1;
				else brick = c.object2;
				
				ball.BounceVertical();
				
				removeChild(brick);
				brickCollisionList.removeItem(brick);
				
				score++;
				updateScore(score);
			}
		}
		
	}

}