package com.wg.mvc 
{
	import com.wg.logging.Log;
	import com.wg.mvc.command.CommadSubBase;
	import com.wg.mvc.command.interfaces.ICommand;
	import com.wg.mvc.interfaces.data.IData;
	import com.wg.mvc.interfaces.event.IServerNotifier;
	
	public class DataBase extends SuperBase implements IData
	{
		private var _server:IServerNotifier;
		private var _eventHandlers:Object = { };
		
		public function DataBase(server:IServerNotifier,initParams:*=null)
		{
			_server = server;
			if (initParams != null) {
				for (var i:String in initParams) {
					this[i] = initParams[i];
				}
			}
		}

		public function init() : void
		{
		}
		
		public function get server() :IServerNotifier
		{
			if(!_server)
			{
				Log.error("没有注册服务器");
			}
					
			return _server;
		}
		
		
		/**
		 * 
		 * @param message 外部实现,外部执行,所以具体类型由外部设定;
		 * @param denyMillisecond
		 * 
		 */
		public function send(message:*, denyMillisecond:int=-1) : void
		{
			return _server.send(message, denyMillisecond);
		}
		
		public function registerEventHandler(event:String, handler:Function = null) : void
		{
			if (_eventHandlers[event]) {
				var found:Boolean = false;
				for (var i:uint = 0; i < _eventHandlers[event].length; ++i) {
					if (_eventHandlers[event][i] == handler) {
						found = true;
						Log.warn("event[" + event + "] handler[" + handler + "] already add");
						break;
					}
				}
				if (!found) {
					_eventHandlers[event].push(handler);
				}
			}
			else {
				_eventHandlers[event] = [handler];
			}
		}
		
		public function cancelEventHandler(event:String, handler:Function) : void
		{
			if (_eventHandlers[event]) {
				var found:Boolean = false;
				for (var i:uint = 0; i < _eventHandlers[event].length; ++i) {
					if (_eventHandlers[event][i] == handler) {
						found = true;
						_eventHandlers[event].splice(i, 1);
						break;
					}
				}
				if (!found) {
					Log.warn("event[" + event + "] handler[" + handler + "] not found");
				}
			}
			else {
				Log.warn("event[" + event + "] handler[" + handler + "] not found");
			}			
		}
		public function hasEventHandler(event:String):Boolean
		{
			var tempBln:Boolean;
			var handlers:* = _eventHandlers[event];
			if (handlers) {
				tempBln = true;
			}else
			{
				tempBln = false;
				
			}
			return tempBln;
		}
		/**
		 * 回调view层注册的响应函数;
		 * @param event
		 * @param data 为服务器通讯模块指定类型
		 * data层的notifyEvent,提供给view层,注册的data通知数据改变时,view响应这种数据改变;
		 */
		public function notifyEvent(event:String, data:*=null) : void
		{
			
			var tempCommand:ICommand = MVCManager.getCommand(event);
			if(!tempCommand)
			{
				Log.warn(event+" 消息不存在或是在Constant中没有配置常量");
				//throw new Error(event+" 消息不存在或是在Constant中没有配置常量");//如果注销,支持每个data响应的命令可以不用注册绑定一个具体的command;
				tempCommand = new CommadSubBase();
			}
				tempCommand.excute(data);
			
			
			var handlers:* = _eventHandlers[event];
			if (handlers) {
				(handlers as Array).forEach(function(handler:Function, index:int, array:Array):void {
					if(handler != null) handler(tempCommand);
				});
			}else
			{
				Log.warn(event+" 消息在data中没有注册");
				return;
			}
		}


		protected function createObject(className:Class) : *
		{
			return createObjectBase(className, (className + "").replace(/Data\]$/, ""));
		}
	}
}