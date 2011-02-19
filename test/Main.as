package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import com.carlsverre.yagf.YAGF;

	public class Main extends Sprite
	{
		
		public function Main() 
		{
			if (stage != null) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			YAGF.Start(this, new MainMenu());
		}
		
	}

}