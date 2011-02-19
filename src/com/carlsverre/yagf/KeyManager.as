package com.carlsverre.yagf 
{
	import flash.events.KeyboardEvent;
	import flash.utils.Dictionary;
	
	public class KeyManager
	{
		private static var keysDown:Object;
		private static var keysUpSinceLastUpdate:Array;
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
			keysDown = { };
			keyMap = new Dictionary();
			keysUpSinceLastUpdate = [];
		}
		
		/**
		 * This function will add a keybinding object to a keymap to make it easier for you to bind keys to actions
		 * @param	keybinding		a object which defines a set of properties which map to any valid key (ex: Key["LEFT"])
		 * @param	player			if you want to assign keybindings to a specific player, use any number above 0 (0 is global keybindings)
		 */
		public function AddKeyBinding(keybinding:Object, player:int = KBGLOBAL):void {
			if (keyMap[player] != null) {
				Util.Merge(keyMap[player], keybinding);
			} else {
				keyMap[player] = keybinding;
			}
		}
		
		public function RemoveKeyBinding(player:int = KBGLOBAL):void {
			delete keyMap[player];
		}
		
		public function RemoveAllKeyBindings():void {
			keyMap = new Dictionary();
		}
		
		public static function AddKeyBinding(keybinding:Object, player:int = KBGLOBAL):void {
			Instance.AddKeyBinding(keybinding, player);
		}
		
		public static function RemoveKeyBinding(player:int = KBGLOBAL):void {
			Instance.RemoveKeyBinding(player);
		}
		
		public static function RemoveAllKeyBindings():void {
			Instance.RemoveAllKeyBindings();
		}
		
		public function IsDown(keyCode:uint):Boolean {
			return Boolean(keyCode in keysDown);
		}
		
		public function WasReleased(keyCode:uint):Boolean {
			return Boolean((keysUpSinceLastUpdate.indexOf(keyCode) != -1));
		}
		
		public function IsKeybindingDown(action:String, player:int = KBGLOBAL):Boolean {
			if (!(player in keyMap)) throw new Error("keyMap does not contain keybindings for player #" + player);
			return IsDown(keyMap[player][action]);
		}
		
		public function WasKeybindingReleased(action:String, player:int = KBGLOBAL):Boolean {
			if (!(player in keyMap)) throw new Error("keyMap does not contain keybindings for player #" + player);
			return WasReleased(keyMap[player][action]);
		}
		
		public static function KeyIsPressed(keyCode:uint):Boolean {
			return Instance.IsDown(keyCode);
		}
		
		public static function KeyWasReleased(keyCode:uint):Boolean {
			return Instance.WasReleased(keyCode);
		}
		
		public static function ActionPressed(keybinding:String, player:int = KBGLOBAL):Boolean {
			return Instance.IsKeybindingDown(keybinding, player);
		}
		
		public static function ActionReleased(keybinding:String, player:int = KBGLOBAL):Boolean {
			return Instance.WasKeybindingReleased(keybinding, player);
		}
		
		internal function KeyPressed(e:KeyboardEvent):void {
			keysDown[e.keyCode] = true;
		}
		
		internal function KeyReleased(e:KeyboardEvent):void {
			delete keysDown[e.keyCode];
			keysUpSinceLastUpdate.push(e.keyCode);
		}
		
		internal function Update():void {
			keysUpSinceLastUpdate.splice(0);
		}
	}

}