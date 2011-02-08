package com.carlsverre.yagf 
{
	import flash.events.KeyboardEvent;
	import flash.utils.Dictionary;
	
	public class KeyManager
	{
		private static var keysDown:Object;
		private static var lockInstance:Boolean = true;
		private static var instance:KeyManager;
		
		private var keyMap:Dictionary;
		
		public static const KBGLOBAL:int = 0;
		public static const PLAYER1:int = 1;
		public static const PLAYER2:int = 2;
		public static const PLAYER3:int = 3;
		public static const PLAYER4:int = 4;
		
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
			keyMap = new Dictionary();
		}
		
		/**
		 * This function will add a keybinding object to a keymap to make it easier for you to bind keys to actions
		 * @param	keybinding		a object which defines a set of properties which map to any valid key (ex: Key["LEFT"])
		 * @param	player			if you want to assign keybindings to a specific player, use any number above 0 (0 is global keybindings)
		 */
		public function AddKeyBinding(keybinding:Object, player:int = 0):void {
			if (keyMap[player] != null) {
				Util.Merge(keyMap[player], keybinding);
			} else {
				keyMap[player] = keybinding;
			}
		}
		
		public static function AddKeyBinding(keybinding:Object, player:int = 0):void {
			Instance.AddKeyBinding(keybinding, player);
		}
		
		public function IsDown(keyCode:uint):Boolean {
			return Boolean(keyCode in keysDown);
		}
		
		public function IsKeybindingDown(action:String, player:int = KBGLOBAL):Boolean {
			if (!(player in keyMap)) throw new Error("keyMap does not contain keybindings for player #" + player);
			return IsDown(keyMap[player][action]);
		}
		
		public static function keyIsPressed(keyCode:uint):Boolean {
			return Instance.IsDown(keyCode);
		}
		
		public static function actionPressed(keybinding:String, player:int = KBGLOBAL):Boolean {
			return Instance.IsKeybindingDown(keybinding, player);
		}
		
		internal function KeyPressed(e:KeyboardEvent):void {
			keysDown[e.keyCode] = true;
		}
		
		internal function KeyReleased(e:KeyboardEvent):void {
			delete keysDown[e.keyCode];
		}
	}

}