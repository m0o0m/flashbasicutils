package test.eventtest
{
	import flash.events.Event;  
	import flash.events.EventDispatcher;  
	import flash.events.IEventDispatcher;  
	
	//这样灵活性非常大，可以在这里实现你想要的各种功能  
	/**
	 *通过实现接口 
	 * @author Administrator
	 * 
	 */
	class SampleEventDispatcher2 implements IEventDispatcher  
	{  
		public var _dispatcher:EventDispatcher;  
		
		public function SampleEventDispatcher()  
		{  
			_dispatcher = new EventDispatcher();  
		}  
		
		public function addEventListener(type:String,listener:Function,  
										 useCapture:Boolean = false,priority:int = 0,useWeakReference:Boolean = false):void  
		{  
			_dispatcher.addEventListener(type,listener,useCapture,priority,useWeakReference);  
		}  
		
		public function dispatchEvent(event:Event):Boolean  
		{  
			return _dispatcher.dispatchEvent(event);  
		}  
		
		public function hasEventListener(type:String):Boolean  
		{  
			return _dispatcher.hasEventListener(type);  
		}  
		
		//注意这里的参数个数是与addEventListener数目不同的，仅有3个  
		public function removeEventListener(type:String,listener:Function,useCapture:Boolean = false):void  
		{  
			_dispatcher.removeEventListener(type,listener,useCapture);  
		}  
		
		public function willTrigger(type:String):Boolean  
		{  
			return _dispatcher.willTrigger(type);  
		}  
	}  
}