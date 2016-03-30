package test.eventtest
{
	import flash.events.EventDispatcher;  
	
	/**
	 *通过复合实现; 
	 * @author Administrator
	 * 
	 */
	public class SampleEventDispatcher  
	{  
		private var _dispatcher:EventDispatcher;  
		
		public function SampleEventDispatcher()  
		{  
			_dispatcher = new EventDispatcher();  
		}  
		
		//get方法  
		public function getEventDispatcher():EventDispatcher  
		{  
			return _dispatcher;  
		}  
	}  
}