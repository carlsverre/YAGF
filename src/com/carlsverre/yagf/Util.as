package com.carlsverre.yagf 
{
	/**
	 * ...
	 * @author 
	 */
	public class Util 
	{
		
		public static function Merge(obj1:Object, obj2:Object):Object {
			for (var s:String in obj2) {
				obj1[s] = obj2[s];
			}
			return obj1;
		}
		
	}

}