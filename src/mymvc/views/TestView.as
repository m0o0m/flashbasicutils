package mymvc.views
{
	import com.wg.logging.Log;
	import com.wg.mvc.MVCManager;
	import com.wg.mvc.command.CommadSubBase;
	import com.wg.mvc.command.interfaces.ICommand;
	import com.wg.mvc.view.ViewSubBase;
	
	import mymvc.MyMVCManager;
	import mymvc.commands.RoleDataCommadResponse;
	import mymvc.constant.ConstantCls;
	import mymvc.datas.TestData;
	
	public class TestView extends ViewSubBase
	{
		private var contentNmae:String = "mvctestview";
		private var m_panel:TestCompent;
		public function TestView()
		{
			super();
		}
		
		private function freshRoleDataHandler(eventname:CommadSubBase):void
		{
			Log.trace(eventname,eventname.getData().role.name);
		}
		override public function show():void
		{
			registerViewEventHandler(ConstantCls.COMMAND_VIEW_REFRESHROLEDATA,freshRoleDataHandler);
			loadPanel(contentNmae,MyMVCManager.getUri(contentNmae));
		}
		protected override function render():void
		{
			var compCls:Class = MVCManager.resoureloader.getClass(contentNmae) as Class;
			if(!compCls) return;
			m_panel = new TestCompent(new compCls());
			if(MyMVCManager.layout.parent)
			{
				MyMVCManager.layout.panelLayer.addView(this, this.m_panel);
			}else
			{
				Log.warn("没有添加到舞台");
			}
			var tempdata:TestData = MVCManager.getData(ConstantCls.DATA_TEST) as TestData;
			
			Log.trace(MyMVCManager.inStage(this as ViewSubBase),inStage);
			this.notifyEvent(ConstantCls.COMMAND_VIEW_REFRESHROLEDATA,{"role":{"name":"named第一次更新"}});
			registerDataEventHandler(ConstantCls.COMMAD_SERVER_GETROLEINFO,setdata);
			
			var message:RoleDataCommadResponse = new RoleDataCommadResponse();
			MVCManager.data.notifyEvent(ConstantCls.COMMAD_SERVER_GETROLEINFO,{"name":"hello"});
			MVCManager.control.excute(ConstantCls.COMMAD_SERVER_GETROLEINFO,{"name":"hello2"});
			MVCManager.control.excute(ConstantCls.COMMAND_VIEW_REFRESHROLEDATA,{"role":{"name":"已更新第二次更新"}});
//			view.addToPositionList(sign, reposion);
		}
		
		override public function close():void
		{
			cancelDataEventHandler(ConstantCls.COMMAD_SERVER_GETROLEINFO,setdata);
			cancelViewEventHandler(ConstantCls.COMMAND_VIEW_REFRESHROLEDATA,freshRoleDataHandler);
			MyMVCManager.layout.panelLayer.closeView(this);
			Log.trace(MyMVCManager.inStage(this as ViewSubBase),inStage);
		}
			
		private function setdata(command:ICommand):void
		{
			var temp:RoleDataCommadResponse = command as RoleDataCommadResponse;
			var tempdata:TestData = MVCManager.getData(ConstantCls.DATA_TEST) as TestData;
			trace(tempdata._name,temp.getData().name);
		}
				
	}
	
	
}