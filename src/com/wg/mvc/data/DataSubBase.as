package com.wg.mvc.data 
{
	import com.wg.mvc.Data;
	import com.wg.mvc.SuperBase;
	import com.wg.mvc.SuperSubBase;
	
	public class DataSubBase extends SuperSubBase
	{
		private var _data:Data;
	
		public function DataSubBase() 
		{
			return;
		}
		
		override public function __init(superBase:SuperBase, module:String) : void
		{
			super.__init(superBase, module);
			_data = superBase as Data;
			if (_data == null) {
				throwInheritError();
			}
			initMessageHandler();
		}
		
		protected function get data() : Data
		{
			return _data;
		}
		
		protected function registerMessageHandler(event:String, handler:Function = null) : void
		{
			_data.server.registerMessageHandler(event, handler);
		}
		
		protected function cancelMessageHandler(event:String, handler:Function) : void
		{
			_data.server.cancelMessageHandler(event, handler);		
		}
		
		protected function notifyEvent(event:String, data:*=null) : void
		{
			_data.notifyEvent(event, data);
		}
		
		public function initMessageHandler():void
		{
			
		}
	}
}
