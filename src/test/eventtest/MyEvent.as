package test.eventtest
{
	import flash.events.Event;
	
	public class MyEvent extends Event
	{
		public static const TESTCONST:String  = "nihao";
		public function MyEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false,isTest:Boolean = false)
		{
			super(type, bubbles, cancelable);
		}
	}
}