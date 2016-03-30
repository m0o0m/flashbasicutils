package test
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.Timer;
	import test.eventtest.MyEvent;
	import test.eventtest.SampleEventDispatcher;
	import test.eventtest.TestEventHandleObj;
	
	/**
	 *EventDispatcher: 事件管理类;拥有此类的功能,可以注册任何对象的各种事件响应;
	 * 1.可以成立一个全局事件管理类
	 * 2.可以使某类拥有此类功能,在引用的地方自己异地发送消息,(某事件的触发只能是自己本身发送dispatch某事件)
	 * 3.鼠标,键盘事件,层层传递,至本dispatch对象;
	 * 
	 * Event:事件类型;EventDispatcher类规定键值对为: Event:Function [];
	 * 
	 * @author Administrator
	 * 
	 */
	public class eventtest extends Sprite
	{
		public static var sampleeventdipat:SampleEventDispatcher; 
		public function eventtest()
		{
			sampleeventdipat = new SampleEventDispatcher();
			
			var testo:TestEventHandleObj = new TestEventHandleObj();
			this.addChild(testo);
			var time:Timer = new Timer(10);
			time.addEventListener(MyEvent.TESTCONST,function(e:Event):void{
				trace("time::收到消息");
			});
			
			
			sampleeventdipat.getEventDispatcher().addEventListener(MyEvent.TESTCONST,helloHandler);
			
			sampleeventdipat.getEventDispatcher().dispatchEvent(new MyEvent(MyEvent.TESTCONST,false,false,true));
		}
		
		private function helloHandler(e:Event):void{
			trace("eventtest::收到消息");
		}
	}
}