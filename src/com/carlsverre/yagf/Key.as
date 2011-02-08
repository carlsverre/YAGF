package com.carlsverre.yagf 
{
	import flash.ui.Keyboard;
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;
	
	public class Key
	{
		private static var keys:Object;
		private static var initialized:Boolean = false;
		
		internal static function Initialize():void {
			if (initialized) throw new Error("The Key class can only be initialized once");
			
			var alphabet:Array = "ABCDEFGHIJKLMNOPQRSTUVWXYZ".split("");
			var nums:Array = ["ZERO", "ONE", "TWO", "THREE", "FOUR", "FIVE", "SIX", "SEVEN", "EIGHT", "NINE"];
			
			keys = new Object();
			for (var i:int = 0; i < alphabet.length; i++) {
				keys[alphabet[i]] = 65 + i;
			}
			for (i = 0; i < nums.length; i++){
				keys[nums[i]] = 48 + i;
			}
			
			initialized = true;
		}
		
		public static function ByName(name:String):int {
			var key:int = (name in Keyboard) ? Keyboard[name] : -1;
			if (key == -1 && (name in keys)) key = keys[name];
			return key;
		}
	}

}