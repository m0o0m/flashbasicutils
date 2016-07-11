package sfsservertest
{
	import com.smartfoxserver.v2.SmartFox;
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.util.ConfigData;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;

	/**
	 * 
	 * @author Administrator
	 * 
	 */	
	public class Connector extends SFSOperator
	{
		
		public function Connector(_sfs:SmartFox,_content:MovieClip)
		{
			super(_sfs,_content);
			// Turn on the debug feature
			sfs.debug = true;
			
			// Add SFS2X event listeners
			sfs.addEventListener(SFSEvent.CONNECTION, onConnection)
			sfs.addEventListener(SFSEvent.CONNECTION_LOST, onConnectionLost)
			sfs.addEventListener(SFSEvent.CONFIG_LOAD_SUCCESS, onConfigLoadSuccess)
			sfs.addEventListener(SFSEvent.CONFIG_LOAD_FAILURE, onConfigLoadFailure)
			
				
			new Loginer(sfs,content);
			new Roomer(sfs,content);
			new VariablesTest(_sfs,_content);
			// Connect button listener
			content.bt_connect.addEventListener(MouseEvent.CLICK, onBtConnectClick)
			
			dTrace("SmartFox API: " + sfs.version)
			dTrace("Click the CONNECT button to start...")
		}   
		
		private function onBtConnectClick(evt:Event):void
		{
			// Load the default configuration file, config.xml
			
			//sfs.loadConfig()//通过sfs-config.xml来指定 配置;
				//config 配置,连接服务器时,必须指定一个空间登录;
			var configdata:ConfigData = new ConfigData();
			configdata.zone = content.zone_txt.text;
			sfs.connectWithConfig(configdata);
		}
		
		//:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// SFS2X event handlers
		//:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		
		private function onConnection(evt:SFSEvent):void
		{
			if (evt.params.success)
			{
				dTrace("Connection Success!")
			}
			else
			{
				dTrace("Connection Failure: " + evt.params.errorMessage)
			}
		}
		
		private function onConnectionLost(evt:SFSEvent):void
		{
			dTrace("Connection was lost. Reason: " + evt.params.reason)
		}
		
		private function onConfigLoadSuccess(evt:SFSEvent):void
		{
			dTrace("Config load success!")
			dTrace("Server settings: " + sfs.config.host + ":" + sfs.config.port)
		}
		
		private function onConfigLoadFailure(evt:SFSEvent):void
		{
			dTrace("Config load failure!!!")
		}
	}
}