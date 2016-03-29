package myserverMessages.testcommand
{
	import com.wg.serialization.IInputStream;
	import com.wg.serialization.IOutputStream;
	import com.wg.socketserver.messages.interfaces.IMessage;

	public class TestMessageResponse  extends TestCommand implements IMessage
	{
		
		public static const MINOR_CMD:uint = 2;		
		public static const CMD:uint = 258;
		public var type:String;
		
		public function TestMessageResponse(initParams:*=null):void
		{
			super(initParams);
			for (var i:String in initParams) {			
				this[i] = initParams[i];
			}
			
			this.minorCmd = 2;	
		}
		


		override public function getCmd() : uint
		{
			return CMD;	
		}
		
		override public function getName() : String
		{
			return "TestMessageResponse";	
		}
		
		override public function serialize(outputStream:IOutputStream) : void
		{
			super.serialize(outputStream);		
			outputStream.writeUTF(this.type);	
		}
		
		override public function unserialize(inputStream:IInputStream) : void
		{
			super.unserialize(inputStream);	
			this.type = inputStream.readUTF();	
		}
		
		override public function toString() : String
		{
			var elems:Array = [];
			elems.push("type" + ":" + this.type);
			return "TestMessageResponse{" + elems.join(",") + "}";
		}
	}
}