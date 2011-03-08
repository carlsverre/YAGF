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
		
		public function Game() 
		{
		}
		
		// Internal API
		internal function SetupInternal():void {
			Setup();
		}
		
		internal function ShutdownInternal():void {
			Shutdown();
		}
		
		internal function UpdateInternal(delta:Number):void {
			Update(delta);
		}
		
		internal function DrawInternal():void {
			Draw();
		}
		
		// Overridable API
		public function Setup():void { }
		
		public function Shutdown():void { }
		
		public function OnMouseDown(e:MouseEvent):void {}
		
		public function OnMouseUp(e:MouseEvent):void {}
		
		public function OnKeyDown(e:KeyboardEvent):void {}
		
		public function OnKeyUp(e:KeyboardEvent):void {}
		
		public function Update(delta:Number):void { }
		
		public function Draw():void { }
		
	}

}