package mymvc.commands
{
	import com.wg.mvc.MVCManager;
	import com.wg.mvc.command.CommadSubBase;
	
	public class RefreshRoleDataCommand extends CommadSubBase
	{
		public function RefreshRoleDataCommand()
		{
			this._data = {"role":{"name":""}};
			super();
		}
		
		override public function excute(data:*=null):void
		{
			super.excute(data);
		}
	}
}