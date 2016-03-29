package com.wg.serialization
{
	import flash.utils.Dictionary;

	/**
	 * ...
	 * @author Bob
	 */
	public interface IInputStream 
	{
		function readByte():int;
		function readShort():int;
		function readInt():int;
		function readUnsignedByte():uint;
		function readUnsignedShort():uint;
		function readUnsignedInt():uint;
		function readDouble():Number;
		function readUTF():String;
		function readArray(reader:Function, readerParams:Array):Array;		
		function readDictionary(keyReader:Function, keyReaderParams:Array, valueReader:Function, valueReaderParams:Array):flash.utils.Dictionary;
		function readObject(type:Class):ISerializable;
	}	
}