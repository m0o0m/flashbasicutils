package com.wg.serialization
{
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;

	public class CppStream implements IOutputStream, IInputStream 
	{
		private var _byteArray:ByteArray;
		
		public function CppStream(byteArray:ByteArray)
		{
			this._byteArray = byteArray;
		}
		
		public function readByte():int
		{
			return this._byteArray.readByte();
		}
		
		public function readShort():int
		{
			return this._byteArray.readShort();
		}
		
		public function readInt():int
		{
			return this._byteArray.readInt();
		}
				
		public function readUnsignedByte():uint
		{
			return this._byteArray.readUnsignedByte();			
		}

		public function readUnsignedShort():uint
		{
			return this._byteArray.readUnsignedShort();			
		}

		public function readUnsignedInt():uint
		{
			return this._byteArray.readUnsignedInt();
		}
		
		public function readDouble():Number
		{
			return this._byteArray.readDouble();
		}
		
		public function readUTF():String
		{
			var len:uint = this._byteArray.readUnsignedInt();
			return this._byteArray.readUTFBytes(len);
		}
		
		public function readArray(reader:Function, readerParams:Array):Array
		{
			var length:uint = this._byteArray.readUnsignedInt();
			var array:Array = new Array();
			for (var i:uint = 0; i < length; ++i) {
				array.push(reader.apply(null, readerParams));
			}
			return array;
		}
		
		public function readDictionary(keyReader:Function, keyReaderParams:Array, valueReader:Function, valueReaderParams:Array):flash.utils.Dictionary
		{
			var length:uint = this._byteArray.readUnsignedInt();
			var dict:Dictionary = new Dictionary;
			for (var i:uint = 0; i < length; ++i) {
				var key:* = keyReader.apply(null, keyReaderParams);
				var value:* = valueReader.apply(null, valueReaderParams);
				dict[key] = value;
			}
			return dict;			
		}
		
		public function readObject(type:Class):ISerializable
		{
			var object:ISerializable = new type;
			object.unserialize(this);
			return object;
		}


		public function writeByte(value:int):void
		{
			this._byteArray.writeByte(value);
		}
		
		public function writeShort(value:int):void
		{
			this._byteArray.writeShort(value);
		}
		
		public function writeInt(value:int):void
		{
			this._byteArray.writeInt(value);
		}
		
		public function writeUnsignedByte(value:uint):void
		{
			this._byteArray.writeByte(value);
		}
		
		public function writeUnsignedShort(value:uint):void
		{
			this._byteArray.writeShort(value);
		}

		public function writeUnsignedInt(value:uint):void
		{
			this._byteArray.writeUnsignedInt(value);
		}

		public function writeDouble(value:Number):void
		{
			this._byteArray.writeDouble(value);
		}
		
		public function writeUTF(value:String):void
		{
			var bytes:ByteArray = new ByteArray;
			bytes.writeUTFBytes(value);
			this._byteArray.writeUnsignedInt(bytes.length);
			this._byteArray.writeBytes(bytes);
		}
		
		public function writeArray(value:Array, writer:Function):void
		{
			this.writeUnsignedInt(value.length);			
			for (var i:uint = 0; i < value.length; ++i) {
				writer.apply(null, [value[i]]);
			}
		}
		
		public function writeDictionary(value:flash.utils.Dictionary, keyWriter:Function, valueWriter:Function):void
		{
			var length:uint = 0;
			for (var i:* in value) {
				++length;
			}
			this.writeUnsignedInt(length);	
			for (var key:* in value) {
				keyWriter.apply(null, [key]);
				valueWriter.apply(null, [value[key]]);
			}			
		}
		
		public function writeObject(value:ISerializable):void
		{
			value.serialize(this);
		}
	}	
}