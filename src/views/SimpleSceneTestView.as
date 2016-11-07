package views
{
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.MouseEvent;

	public class SimpleSceneTestView extends ViewBase
	{
		private var gamecontent:Sprite;
		private var swfName:String;
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
				content.btn1.addEventListener(MouseEvent.CLICK,firstHandler);
				content.btn2.addEventListener(MouseEvent.CLICK,secondHandler);
				this.addChild(content);
				gamecontent = new Sprite();
				this.addChild(gamecontent);
			}
			super.render();
//			startinit();
			
			
			
			
		}
		private function loadSwf(loadpath:String,loadname:String):void
		{
			Config.resourceLoader.load([Config.resourceLoader.getLoadData(Config.uri.getSimpleMapURI(loadpath), loadname)], function(path:String, bytesLoaded:uint=1, bytesTotal:uint=1):void{}, onLoadComplete);
		}
		private function firstHandler(e:MouseEvent):void
		{
			swfName = "PlatformGame";
			loadSwf("first/"+"PlatformGame","PlatformGame");
			
		}
		
		private function secondHandler(e:MouseEvent):void
		{
			swfName = "Racing";
			loadSwf("second/"+"Racing","Racing");
		}
		
		private function onLoadComplete():void
		{
			this.gamecontent.removeChildren();
			var tempmc:MovieClip = Config.resourceLoader.getContent(swfName);
			this.gamecontent.addChild(tempmc);
			respostion();
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
		
	
		override public  function close():void
		{
			this.removeChildren();
			content = null;
			super.close();
		
		}
		
		
	}
}