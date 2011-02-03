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
		public static const TICKS_PER_SECOND:int = 30;
		public static const TICK_RATE:Number = 1.0 / Number(TICKS_PER_SECOND);
		public static const TICK_RATE_MS:Number = TICK_RATE * 1000;
		
		// Singleton support
		private static var lockInstance:Boolean = true;
		private static var instance:YAGF;
		
		// Time
		private var lastTime:int = -1;
		private var elapsed:Number = 0.0;
		
		// Managers
		public var KeyManager:KeyManager;
		
		// Game
		private var game:Game;
		private var stage:Stage;
		
		public function YAGF() 
		{
			if (lockInstance) throw new Error("YAGF is a singleton, use YAGF.Instance() rather than new YAGF");
		}
		
		internal static function get Instance():YAGF {
			lockInstance = false;
			if (instance == null) instance = new YAGF();
			lockInstance = true;
			return instance;
		}
		
		public static function Start(mainClass:Sprite, gameObject:Game):void {
			if (!mainClass.stage) throw new Error("The mainClass must be added to the stage before you can startup YAGF");
			if (initialized) throw new Error("YAGF can only be started once.");
			
			stage = mainClass.stage;
			game = gameObject;
			
			Instance.setup();
		}
		
		internal function setup():void {
			this.KeyManager = KeyManager.Instance;	// setup keyboard systems
			
			// setup time stuff for game loop
			lastTime = -1;
			elapsed = 0.0;
			
			stage.addEventListener(Event.ENTER_FRAME, MainLoop);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, KeyManager.KeyPressed);
			stage.addEventListener(KeyboardEvent.KEY_UP, KeyManager.KeyReleased);
			
			// setup the game
			game.SetupInternal();
		}
		
		public function MainLoop(e:Event):void {
			var currentTime:Number = getTimer();
			if (lastTime < 0) {
				lastTime = currentTime;
				return;
			}
			
			var deltaTime:Number = Number(currentTime - lastTime);
			
			// update elapsed time
			elapsed += deltaTime;
			
			var tickCount:int = 0;
			while (elapsed >= TICK_RATE_MS && tickCount < MAX_TICKS_PER_FRAME) {
				game.UpdateInternal(deltaTime);
				
				elapsed -= TICK_RATE_MS;
				tickCount++;
			}
			
			lastTime = currentTime;
		}
	}

}