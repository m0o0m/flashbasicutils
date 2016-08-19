package com.wg.mvc
{
	import com.wg.error.Err;
	import com.wg.logging.Log;
	import com.wg.mvc.command.interfaces.ICommand;
	import com.wg.mvc.interfaces.controls.IController;

    public class ControllerBase extends SuperBase implements IController
    {
        protected var _data:Data;
		protected var _view:View;

		public function ControllerBase(data:Data, view:View):void
		{
			_data = data;
			_view = view;
		}
		

		/**
		 * 首先执行 data中的回调函数,然后是view;最后是control
		 * @param commandname
		 * @param data
		 * 
		 */
		public function excute(commandname:String,data:* = null):void
		{
			var databln:Boolean;
			if(_data.hasEventHandler(commandname))
			{
				_data.notifyEvent(commandname,data);
				databln = true;
			}
			var viewbln:Boolean;
			if(_view.hasEventHandler(commandname))
			{
				_view.notifyEvent(commandname,data);
				viewbln = true;
			}
			
			if(viewbln||databln)
			{
				return;
			}
			//执行无需注册的命令;
			var tempCommand:ICommand = MVCManager.getCommand(commandname);
			if(!tempCommand)
			{
				Log.warn(commandname+" 消息不存在或是在Constant中没有配置常量");
				return;
			}
			tempCommand.excute(data);
			
		}
		
		public function registerMessageHandler(commandname:String, handler:Function = null) : void
		{
			_data.server.registerMessageHandler(commandname, handler);
		}
		
		public function registerDataEventHandler(commandname:String, handler:Function) : void
		{
			_data.registerEventHandler(commandname, handler);
		}
		
		public function registerViewEventHandler(commandname:String, handler:Function = null) : void
		{
			_view.registerEventHandler(commandname, handler);
		}
		
		protected function createObject(className:Class) : void
		{
			throw new Error("消息不可存储,使用后立即销毁");
		}
    }
}
