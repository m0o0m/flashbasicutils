package myserverMessages.testcommand	
{
	import com.wg.serialization.IInputStream;
	import com.wg.serialization.IOutputStream;
	import com.wg.socketserver.messages.Message;
	import com.wg.socketserver.messages.interfaces.IMessage;
	
	public class TestCommand extends Message implements IMessage 
	{	
		/**
		 *指定某一命令集 
		 */
		public static const MAJOR_CMD:uint = 1;			
		
		
		
		public function TestCommand(initParams:*=null)
		{	
			super(initParams);
			for (var i:String in initParams) {			
				this[i] = initParams[i];
			}
			this.majorCmd = 1;	
			
		}
		
		override public function getCmd() : uint
		{
			return 0;	
		}
		
		override public function getName() : String
		{
			return "TestCommand";	
		}
		
		override public function serialize(outputStream:IOutputStream) : void
		{
			super.serialize(outputStream);		
		}
		
		override public function unserialize(inputStream:IInputStream) : void
		{
			super.unserialize(inputStream);	
		}
		
		override public function toString() : String
		{
			var elems:Array = [];
			return "TestCommand{" + elems.join(",") + "}";
		}
	}
}
