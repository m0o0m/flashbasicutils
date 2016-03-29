package views
{
	import com.wg.mvc.MVCManager;
	import com.wg.socketserver.Server;
	
	import mymvc.MyMVCManager;
	import mymvc.commands.ShowCommand;
	import mymvc.constant.ConstantCls;
	import mymvc.views.TestView;

	public class MvcTestView extends ViewBase
	{
		public function MvcTestView()
		{
			panelName = "mvc";
			super();
		}
		
		override protected function render():void
		{
			if(!content)
			{
				var maincls:Class = Config.resourceLoader.getClass(panelName);
				content = new maincls();
				this.addChild(content);
				
				MyMVCManager.init(_stage);
//				MyMVCManager.instance.resoureloader = Config.resourceLoader;
				
			}
			super.render();
			MVCManager.control.excute("openPanel",{"panelname":ConstantCls.VIEW_TESTVIEW});
//			MVCManager.view.notifyEvent("openPanel",{"panelname":"mvctestview"});
		}
		
		override protected function dispose():void
		{
			var testview:TestView = MVCManager.getView(ConstantCls.VIEW_TESTVIEW) as TestView;
			testview.close();
//			_stage.removeChild(MyMVCManager.layout);
//			MyMVCManager.layout = null;
		}
	}
}