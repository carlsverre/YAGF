package com.carlsverre.yagf 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	import com.coreyoneil.collision.CDK;

	public class Game extends Sprite
	{
		protected const KBGLOBAL:int = 0;
		protected const PLAYER1:int = 1;
		protected const PLAYER2:int = 2;
		protected const PLAYER3:int = 3;
		protected const PLAYER4:int = 4;
		
		public function Game() 
		{
		}
		
		// Internal API
		internal function SetupInternal():void {
			Setup();
		}
		
		internal function UpdateInternal(delta:Number):void {
			Update(delta);
		}
		
		// Utility API methods
		
		protected function keyIsPressed(keyCode:uint):Boolean {
			return KeyManager.Instance.IsDown(keyCode);
		}
		
		protected function keybindingPressed(keybinding:String, player:int = KBGLOBAL):Boolean {
			return KeyManager.Instance.IsKeybindingDown(keybinding, player);
		}
		
		// Overridable API
		public function Setup():void {}
		
		public function OnMouseDown(e:MouseEvent):void {}
		
		public function OnMouseUp(e:MouseEvent):void {}
		
		public function OnKeyDown(e:KeyboardEvent):void {}
		
		public function OnKeyUp(e:KeyboardEvent):void {}
		
		public function Update(delta:Number):void {}
		
	}

}