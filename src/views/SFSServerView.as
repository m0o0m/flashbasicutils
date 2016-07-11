package views
{
	import com.smartfoxserver.v2.SmartFox;
	
	import flash.events.MouseEvent;
	
	import sfsservertest.Connector;

	public class SFSServerView extends ViewBase
	{
		private var connector:Connector;
		public function SFSServerView()
		{
			panelName = "sfsserver";
			super();
		}
		/**
		 *连接步骤:
		 * 1.connector
		 * 2.loginer
		 * 3.roomer
		 * 房间是游戏基本单位; 
		 * 
		 */		
		override protected function render():void
		{
			if(!content)
			{
				var maincls:Class = Config.resourceLoader.getClass(panelName);
				content = new maincls();
				connector = new Connector(new SmartFox(),content.user1);
				new Connector(new SmartFox(),content.user2);
				this.addChild(content);
			}
			super.render();
			
			
		}
	}
}