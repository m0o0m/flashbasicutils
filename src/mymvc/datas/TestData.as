package mymvc.datas
{
	import com.wg.mvc.command.interfaces.ICommand;
	import com.wg.mvc.data.DataSubBase;
	
	import mymvc.commands.RoleDataCommadResponse;
	import mymvc.constant.ConstantCls;
	
	public class TestData extends DataSubBase
	{
		public var _name:String = "";
		public function TestData()
		{
			
		}
		override public function initMessageHandler():void
		{
			registerMessageHandler(ConstantCls.COMMAD_SERVER_GETROLEINFO,refreshroledata);
		}
		
		private function refreshroledata(message:ICommand):void
		{
			_name = message.getData().name;
		}
	}
}