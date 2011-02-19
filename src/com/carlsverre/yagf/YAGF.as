package com.carlsverre.yagf 
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.utils.getTimer;
	
	public class YAGF 
	{
		// These variables are taken from PushButtonEngine
		private static const TICKS_PER_SECOND:int = 31;
		private static const TICK_RATE:Number = 1.0 / Number(TICKS_PER_SECOND);
		private static const TICK_RATE_MS:Number = TICK_RATE * 1000;
		private static const MAX_TICKS_PER_FRAME:int = 5;
		
		// Singleton support
		private static var lockInstance:Boolean = true;
		private static var instance:YAGF;
		private static var started:Boolean = false;
		
		// Time
		private var lastTime:int = -1;
		private var elapsed:Number = 0.0;
		private var pauseLoop:Boolean = false;
		
		// Managers
		public var KManager:KeyManager;
		public var SSManager:SpriteSheetManager;
		
		// Game
		private var game:Game;
		private var stage:Stage;
		
		public function YAGF() 
		{
			if (lockInstance) throw new Error("YAGF is a singleton, use YAGF.Instance() rather than new YAGF");
		}
		
		public static function get Instance():YAGF {
			lockInstance = false;
			if (instance == null) instance = new YAGF();
			lockInstance = true;
			return instance;
		}
		
		public static function Start(mainClass:Sprite, gameObject:Game):void {
			if (!mainClass.stage) throw new Error("The mainClass must be added to the stage before you can startup YAGF");
			if (started) throw new Error("YAGF can only be started once.");
			started = true;
			
			Instance.setup(mainClass, gameObject);
		}
		
		internal function setup(mainClass:Sprite, gameObject:Game):void {
			KManager = KeyManager.Instance;	// setup keyboard systems
			SSManager = new SpriteSheetManager();
			
			// setup time stuff for game loop
			lastTime = -1;
			elapsed = 0.0;		
			
			stage = mainClass.stage;
			game = gameObject;
			
			stage.addEventListener(Event.ENTER_FRAME, MainLoop);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, KeyManager.Instance.KeyPressed);
			stage.addEventListener(KeyboardEvent.KEY_UP, KeyManager.Instance.KeyReleased);
			
			// setup the game
			stage.addChild(game);
			game.SetupInternal();
		}
		
		public function SwitchGame(newGame:Game):void {
			pauseLoop = true;
			
			game.ShutdownInternal();
			
			// Maintain the layer position of the last game
			stage.addChild(newGame);
			stage.swapChildren(game, newGame);
			stage.removeChild(game);
			
			game = newGame;
			newGame.SetupInternal();
			
			pauseLoop = false;
		}
		
		internal function MainLoop(e:Event):void {
			if (pauseLoop) return;
			
			var currentTime:Number = getTimer();
			if (lastTime < 0) {
				lastTime = currentTime;
				return;
			}
			
			var deltaTime:Number = Number(currentTime - lastTime);
			var deltaTimeInSeconds:Number = deltaTime / 1000;
			
			// update elapsed time
			elapsed += deltaTime;
			
			var tickCount:int = 0;
			while (elapsed >= TICK_RATE_MS && tickCount < MAX_TICKS_PER_FRAME) {
				game.UpdateInternal(deltaTimeInSeconds);
				KManager.Update();	// this needs to run after each game update
				
				elapsed -= TICK_RATE_MS;
				tickCount++;
			}
			
			lastTime = currentTime;
		}
	}

}