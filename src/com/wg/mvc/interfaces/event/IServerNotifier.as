package com.wg.mvc.interfaces.event
{
	public interface IServerNotifier
	{
		function registerMessageHandler(event:String, handler:Function = null) : void
		function cancelMessageHandler(event:String, handler:Function) : void
		function send(event:*,  denyMillisecond:int=-1) : void;
		//通讯的消息广播只能由服务器端消息发送;
//		function handleMessage(message:*) : void;
	}
}