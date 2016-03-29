package com.wg.serialization
{
	import flash.utils.Dictionary;
	
	/**
	 * ...
	 * @author Bob
	 */
	public interface IOutputStream 
	{
		function writeByte(value:int):void;
		function writeShort(value:int):void;
		function writeInt(value:int):void;
		function writeUnsignedByte(value:uint):void;
		function writeUnsignedShort(value:uint):void;
		function writeUnsignedInt(value:uint):void;
		function writeDouble(value:Number):void;
		function writeUTF(value:String):void;
		function writeArray(value:Array, writer:Function):void;
		function writeDictionary(value:flash.utils.Dictionary, keyWriter:Function, valueWriter:Function):void;
		function writeObject(value:ISerializable):void;
	}
	
}