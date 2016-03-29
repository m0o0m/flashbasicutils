package com.wg.mvc.interfaces.event
{
	public interface INotifier
	{
		/**
		 * 
		 * @param event
		 * @param handler 回调函数为空的,无需注册,直接发送;
		 * 
		 */
		function registerEventHandler(event:String, handler:Function = null) : void;
		function cancelEventHandler(event:String, handler:Function) : void;
		function hasEventHandler(event:String):Boolean;
		/**
		 * 
		 * @param event
		 * @param data 数据类型可以是任何类型;
		 * 
		 */
		function notifyEvent(event:String, data:*=null) : void;
	}
}