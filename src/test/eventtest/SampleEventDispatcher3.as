package test.eventtest
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	public class SampleEventDispatcher3 extends EventDispatcher
	{
		/**
		 *通过继承实现 
		 * @param target
		 * 
		 */
		public function SampleEventDispatcher3(target:IEventDispatcher=null)
		{
			super(target);
		}
	}
}