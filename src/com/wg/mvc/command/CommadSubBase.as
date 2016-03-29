package com.wg.mvc.command
{
	import com.wg.mvc.SuperSubBase;
	import com.wg.mvc.command.interfaces.ICommand;
	import com.wg.mvc.interfaces.event.INotifier;
	
	public class CommadSubBase extends SuperSubBase implements ICommand
	{
		protected var _data:Object;
		public var type:String;//functoin type
		public function CommadSubBase()
		{
			super();
		}
		
		/**
		 *提供重写,在触发时执行; 
		 * 
		 */
		public function excute(data:*=null):void
		{
			_data = data;
		}
		
		public function notifyEvent(event:*, data:*=null) : void
		{
			
		}
		
		public function getData():*
		{
			return _data;
		}
	}
}