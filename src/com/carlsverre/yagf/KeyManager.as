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
		
		public function IsDown(keyCode:uint):Boolean {
			return Boolean(keyCode in keysDown);
		}
		
		public function IsKeybindingDown(action:String, player:int = 0):Boolean {
			if (!(player in keyMap)) throw new Error("keyMap does not contain keybindings for player #" + player);
			return IsDown(keyMap[player][action]);
		}
		
		internal function KeyPressed(e:KeyboardEvent):void {
			keysDown[e.keyCode] = true;
		}
		
		internal function KeyReleased(e:KeyboardEvent):void {
			delete keysDown[e.keyCode];
		}
	}

}