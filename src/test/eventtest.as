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
	 * 自定义事件发送者的三种方法
	 * http://blog.csdn.net/aisajiajiao/article/details/6960475
	 * @author Administrator
	 * 
	 */
	/**
	 * 一.显示对象的鼠标点击事件
	 * 1.逐层传递
	 * 2.父类,自身,子类
	 * 3.可以设置子类不接收;只有注册了事件才可以响应;可以设置冒泡阶段或捕获阶段响应
	 * 4.只有在同一显示链条上的对象才可以有以上特性
	 * @author Administrator
	 * 
	 */	
	/**
	 *二. EventDispatcher类和Event类
	 * EventDispatcher类,拥有
	 * addEventListener
	 * dispatchEvent
	 * hasEventListener等
	 * 注册的
	 * Event类,拥有
	 * clone(),bubbles,cancelable,currentTarget,eventPhase,target,type等属性方法
	 * event,数据的载体,
	 * @author Administrator
	 * 
	 */	
	/**
	 * 三.扩展EventDispatcher类和Event类
	 * EventDispatcher类职责:
	 * 1.存储注册的回调函数,
	 * 2.注册回调函数
	 * 3.发送event事件
	 * 4.响应注册的event事件
	 * 以上所有的操作,只有当前扩展类的实例可以做,其它扩展类互不干涉;
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