package views
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	import views.alert.AlertManager;

	public class AlertView extends ViewBase
	{
		public function AlertView()
		{
			panelName = "alertComp";
			super();
		}
		override protected function render():void
		{
			if(!content)
			{
				var maincls:Class = Config.resourceLoader.getClass(panelName);
				content = new maincls();
				content.alertbutton.addEventListener(MouseEvent.CLICK,showAlert);
				this.addChild(content);
				
			}
			super.render();
			
		}
		private function showAlert(e:MouseEvent):void
		{
			var alertcls:Class = Config.resourceLoader.getClass("CommonAlert",panelName);
			var alertmc:MovieClip = new alertcls();
			AlertManager.instance.setAlert(alertmc,this);
			AlertManager.instance.showYesNoMsg("基本弹出框测试");
		}
		override public function close():void
		{
			AlertManager.instance.close();
			AlertManager.instance.clear();
			super.close();
		}
	}
}