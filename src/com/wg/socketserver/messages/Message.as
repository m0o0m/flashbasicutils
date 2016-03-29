package com.wg.socketserver.messages	
{
	import com.wg.socketserver.messages.interfaces.IMessage;
	import com.wg.serialization.IInputStream;
	import com.wg.serialization.IOutputStream;
		

	public class Message implements IMessage 
	{	
					
				
			

		public var majorCmd:uint = 0;	
		public var minorCmd:uint = 0;	

		public function Message(initParams:*=null)
		{	
			for (var i:String in initParams) {			
				this[i] = initParams[i];
			}
				
				
		}
		
		public function getCmd() : uint
		{
			return 0;	
		}

		public function getName() : String
		{
			return "Message";	
		}

		public function serialize(outputStream:IOutputStream) : void
		{
			//实现IOutputStream接口的类在此写入消息的 两个编码;
			outputStream.writeUnsignedByte(this.majorCmd);	//(writebyte,一字节低八位)
			outputStream.writeUnsignedByte(this.minorCmd);	
		}

		public function unserialize(inputStream:IInputStream) : void
		{
				
			this.majorCmd = inputStream.readUnsignedByte();	
			this.minorCmd = inputStream.readUnsignedByte();	
		}
		
		public function toString() : String
		{
			var elems:Array = [];
			elems.push("majorCmd" + ":" + this.majorCmd);
			elems.push("minorCmd" + ":" + this.minorCmd);
			return "Message{" + elems.join(",") + "}";
		}
	}
}
