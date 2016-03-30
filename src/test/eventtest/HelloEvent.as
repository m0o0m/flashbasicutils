package test.eventtest
{
	import flash.events.Event;
	
	public class HelloEvent extends Event
	{
		public static const HELLO_TEST:String = "sdfsdfsdfsf";
		public function HelloEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}