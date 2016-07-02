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
		private function helloHandler(e:Event):void{
			trace("TestEventHandleObj::收到消息 "+e.type);
		}
	}
	
}