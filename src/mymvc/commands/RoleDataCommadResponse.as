package mymvc.commands
{
	import com.wg.mvc.command.CommadSubBase;
	
	public class RoleDataCommadResponse extends CommadSubBase
	{
		public function RoleDataCommadResponse()
		{
			_data = {"name":""};
			super();
		}
		override public function excute(data:*=null):void
		{
			super.excute(data);
		}
	}
}