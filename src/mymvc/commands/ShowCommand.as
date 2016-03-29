package mymvc.commands
{
	import com.wg.mvc.MVCManager;
	import com.wg.mvc.command.CommadSubBase;
	
	public class ShowCommand extends CommadSubBase
	{
		public function ShowCommand()
		{
			_data = {"panelname":""};
			super();
		}
		
		override public function excute(data:*=null):void
		{
			super.excute(data);
			MVCManager.getView(this._data["panelname"]).show();
		}
	}
}