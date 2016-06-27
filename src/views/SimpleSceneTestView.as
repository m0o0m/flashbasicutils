package views
{
	
	import flash.display.Stage;

	public class SimpleSceneTestView extends ViewBase
	{
		public function SimpleSceneTestView()
		{
			panelName = "simplemap";
			super();
		}
		override protected function render():void
		{
			if(!content)
			{
				var maincls:Class = Config.resourceLoader.getClass(panelName);
				content = new maincls();
				this.addChild(content);
			}
			super.render();
//			startinit();
		}
	/*	private var townMap:TownMapView;
		public static var player:PlayerData;
		private function startinit():void
		{	
			// TODO Auto Generated method stub 
			player = new PlayerData();
			
			townMap = new TownMapView();
			
			//获取map.swf
			var mapInstance:IMapInstance = Config.resourceLoader.getContent(Config.uri.getModuleURI("Map")) as IMapInstance;
			//
			townMap.init(mapInstance.town, Config.stage);
			townMap.gotoTownAtId(2);
		}*/
		
	
		
		
		
	}
}