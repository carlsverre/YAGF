package com.carlsverre.yagf 
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.TimerEvent;
	import flash.utils.getTimer;
	import flash.utils.Timer;
	
	public class YAGF 
	{
		public static const FRAME_RATE:int = 40;
		
		// Singleton support
		private static var lockInstance:Boolean = true;
		private static var instance:YAGF;
		private static var started:Boolean = false;
		
		// Time
		private var freezeLoop:Boolean = false;
		private var gameTimer:Timer;
		private var period:Number = 1000 / FRAME_RATE;
		private var beforeTime:int = 0;
		private var afterTime:int = 0;
		private var deltaTime:int = 0;
		private var deltaTimeInSeconds:Number = 0;
		private var timeDiff:int = 0;
		private var sleepTime:int = 0;
		private var overSleepTime:int = 0;
		private var excess:int = 0;
		
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
			gameTimer = new Timer(period, 1);
			afterTime = getTimer();
			
			stage = mainClass.stage;
			game = gameObject;
			
			gameTimer.addEventListener(TimerEvent.TIMER, MainLoop);
			gameTimer.start();
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, KeyManager.Instance.KeyPressed);
			stage.addEventListener(KeyboardEvent.KEY_UP, KeyManager.Instance.KeyReleased);
			
			// setup the game
			stage.addChild(game);
			game.SetupInternal();
		}
		
		public function SwitchGame(newGame:Game):void {
			freezeLoop = true;
			
			game.ShutdownInternal();
			
			// Maintain the layer position of the last game
			stage.addChild(newGame);
			stage.swapChildren(game, newGame);
			stage.removeChild(game);
			
			game = newGame;
			newGame.SetupInternal();
			
			freezeLoop = false;
		}
		
		internal function MainLoop(e:TimerEvent):void {
			if (freezeLoop) return;
			
			beforeTime = getTimer();
			deltaTime = beforeTime - afterTime;
			deltaTimeInSeconds = deltaTime / 1000;
			overSleepTime = deltaTime - sleepTime;
			
			game.UpdateInternal(deltaTimeInSeconds);
			game.Draw(deltaTimeInSeconds);
			
			afterTime = getTimer();
			timeDiff = afterTime - beforeTime;
			sleepTime = (period - timeDiff) - overSleepTime;
			if (sleepTime <= 0) {
				excess -= sleepTime;
				sleepTime = 2;
			}
			gameTimer.reset();
			gameTimer.delay = sleepTime;
			gameTimer.start();
			
			while (excess > period) {
				excess -= period;
			}
			
			KManager.Update();
			
			e.updateAfterEvent();
		}
	}

}