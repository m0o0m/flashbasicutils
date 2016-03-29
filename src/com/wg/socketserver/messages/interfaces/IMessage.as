package com.wg.socketserver.messages.interfaces 
{
	import com.wg.serialization.ISerializable;

	public interface IMessage extends ISerializable
	{
		function getCmd() : uint;
		function getName() : String;
	}
}
