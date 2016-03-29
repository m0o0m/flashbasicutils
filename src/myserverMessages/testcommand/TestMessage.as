package myserverMessages.testcommand	
{
	import com.wg.socketserver.messages.interfaces.IMessage;
	import com.wg.serialization.IInputStream;
	import com.wg.serialization.IOutputStream;
	
	public class TestMessage extends TestCommand implements IMessage 
	{	
		
		public static const MINOR_CMD:uint = 1;		
		public static const CMD:uint = 257;	

		public var name:String = "";
		public var age:uint = 0;
		public function TestMessage(initParams:*=null)
		{	
			super(initParams);
			for (var i:String in initParams) {			
				this[i] = initParams[i];
			}
			
			this.minorCmd = 1;	
		}
		
		override public function getCmd() : uint
		{
			return CMD;	
		}
		
		override public function getName() : String
		{
			return "TestMessage";	
		}
		
		override public function serialize(outputStream:IOutputStream) : void
		{
			super.serialize(outputStream);	
			outputStream.writeInt(this.age);
			outputStream.writeUTF(this.name);
		}
		
		override public function unserialize(inputStream:IInputStream) : void
		{
			super.unserialize(inputStream);	
			this.age = inputStream.readUnsignedInt();
			this.name = inputStream.readUTF();
		}
		
		override public function toString() : String
		{
			var elems:Array = [];
			elems.push("age" + ":" + this.age);
			elems.push("name" + ":" + this.name);
			return "TestMessage{" + elems.join(",") + "}";
		}
	}
}
