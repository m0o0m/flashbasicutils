package views
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;

	public class LoadSwfView extends ViewBase
	{
		public function LoadSwfView()
		{
			panelName = "loadswf";
			super();
		}
		override protected function render():void
		{
			if(!content)
			{
				var maincls:Class = Config.resourceLoader.getClass(panelName);
				content = new maincls();
				this.addChild(content);
				content.start_btn.addEventListener(MouseEvent.CLICK,clickHandler);
			}
			super.render();
		}
		override protected function respostion():void
		{
			this.x = 0;
			this.y = 200;
		}
		private function clickHandler(e:MouseEvent):void
		{
			var className:String = "loadswf2";
			Config.resourceLoader.load([Config.resourceLoader.getLoadData(Config.uri.getPanelURI(className), className)], function(path:String, bytesLoaded:uint=1, bytesTotal:uint=1):void{}, onLoadComplete);
//			onLoadComplete();
		}
		
		private function onLoadComplete():void
		{
			var maincls:Class = Config.resourceLoader.getClass("loadswf2");
			var tempmc:MovieClip = new maincls();
			tempmc.y = 300;
			this.addChild(tempmc);
			
			var maincls2:Class = Config.resourceLoader.getClass("mc1","loadswf2");
			var tempmc2:MovieClip = new maincls2();
			tempmc2.y = 300;
			tempmc2.x = 200;
			this.addChild(tempmc2);
			
			var maincls3:Class = Config.resourceLoader.getClass("LoadSwf3","stimliLoad");
			var tempmc3:MovieClip = new maincls3();
			tempmc3.y = 300;
			tempmc3.x = 400;
			this.addChild(tempmc3);
		}
	}
}