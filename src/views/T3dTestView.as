package views
{
	import flash.T3dTestite;
	import flash.events.MouseEvent;
	import flash.utils.setInterval;
	import flash.utils.setTimeout;
	
	import views.t3d.Dungeon3D;

	public class T3dTestView extends ViewBase
	{
		private var dungeon3d:Dungeon3D;
		public function T3dTestView()
		{
			panelName = "3dTest";
			super();
		}
		override protected function render():void
		{
			if(!content)
			{
				var maincls:Class = Config.resourceLoader.getClass(panelName,panelName);
				content = new maincls();
				this.addChild(content);
				
			};
			
			super.render();
			setTimeout(init,1000);
		}
		private function init():void
		{
			dungeon3d = new Dungeon3D();
			dungeon3d.Ceiling = Config.resourceLoader.getClass("Ceiling",panelName);
			dungeon3d.Floor = Config.resourceLoader.getClass("Floor",panelName);
			dungeon3d.Coin = Config.resourceLoader.getClass("Coin",panelName);
			dungeon3d.Map = Config.resourceLoader.getClass("Map",panelName);
			dungeon3d.Square = Config.resourceLoader.getClass("Square",panelName);
			dungeon3d.Wall = Config.resourceLoader.getClass("Wall",panelName);
			
			content.y = content.y+0;
			content.addChild(dungeon3d);
			dungeon3d.init();
		}
	}
}