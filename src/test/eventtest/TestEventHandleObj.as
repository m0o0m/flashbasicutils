package test.eventtest
{
	import flash.display.Sprite;
	import flash.events.Event;
	import test.eventtest;

	public class TestEventHandleObj extends Sprite
	{
		public function TestEventHandleObj()
		{
			eventtest.sampleeventdipat.getEventDispatcher().addEventListener(MyEvent.TESTCONST,helloHandler);
		}
		function helloHandler(e:Event){
			trace("TestEventHandleObj::收到消息 "+e.type);
		}
	}
	
}