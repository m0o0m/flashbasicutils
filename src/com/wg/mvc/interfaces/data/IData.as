package com.wg.mvc.interfaces.data 
{
	import com.wg.mvc.interfaces.event.INotifier;
	import com.wg.socketserver.messages.interfaces.IMessage;

	public interface IData extends INotifier
	{		
		// not a good practice here
		function send(message:*, denyMillisecond:int=-1) : void;
	}
}