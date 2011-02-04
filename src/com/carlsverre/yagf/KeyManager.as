package com.carlsverre.yagf 
{
	import flash.events.KeyboardEvent;
	
	public class KeyManager
	{
		private static var keysDown:Object;
		private static var lockInstance:Boolean = true;
		private static var instance:KeyManager;
		
		public function KeyManager() 
		{
			if (lockInstance) throw new Error("KeyManager is a singleton, use KeyManager.Instance() rather than new KeyManager");
			
			setup();
		}
		
		public static function get Instance():KeyManager {
			lockInstance = false;
			if (instance == null) instance = new KeyManager();
			lockInstance = true;
			return instance;
		}
		
		private function setup():void {
			keysDown = new Object();
			
			// initialize key tracking class
			KeyEnum.Initialize();
		}
		
		public function isDown(keyCode:uint):Boolean {
			return Boolean(keyCode in keysDown);
		}
		
		internal function KeyPressed(e:KeyboardEvent):void {
			keysDown[e.keyCode] = true;
		}
		
		internal function KeyReleased(e:KeyboardEvent):void {
			delete keysDown[e.keyCode];
		}
	}

}