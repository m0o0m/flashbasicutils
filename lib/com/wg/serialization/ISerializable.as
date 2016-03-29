package com.wg.serialization
{
	
	/**
	 * ...
	 * @author Bob
	 */
	public interface ISerializable 
	{
		function serialize(outputStream:IOutputStream) : void;
		function unserialize(inputStream:IInputStream) : void;
	}
	
}