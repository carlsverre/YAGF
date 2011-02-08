package com.carlsverre.yagf 
{
	import flash.events.TextEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	public class SimpleTF extends TextField
	{
		
		public var Font:String = "Helvetica";
		public var FontSize:int = 24;
		public var FontBold:Boolean = false;
		public var FontItalic:Boolean = false;
		public var FontColor:uint = 0xffffff;
		public var FontAlign:String = TextFormatAlign.LEFT;
		public var Style:TextFormat = new TextFormat(Font);
		
		public var Text:String = "Label";
		public var Size:Point = new Point(100, 100);
		
		public function SimpleTF() 
		{
			
		}
		
		public function Redraw():void {
            this.width = Size.x;
            this.height = Size.y;
            this.mouseEnabled = false;
            this.multiline = true;
            this.wordWrap = true;
            this.autoSize = TextFieldAutoSize.LEFT;
           
            // The text format.
			Style.font = Font;
            Style.size = FontSize;
            Style.color = FontColor;
            Style.align = FontAlign;
            Style.bold = FontBold;
			Style.italic = FontItalic;
			this.defaultTextFormat = Style;
			
			this.text = Text;
		}
		
	}

}