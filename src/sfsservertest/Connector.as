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
		private var CURR_STATE:int = 0;
		private var mylogin:Loginer;
		
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
			
				
			mylogin = new Loginer(sfs,content);
			new Roomer(sfs,content);
			new VariablesTest(_sfs,_content);
			new Signuper(_sfs,_content);
			new ErrorCoder(_sfs);
			// Connect button listener
			content.bt_connect.addEventListener(MouseEvent.CLICK, onBtConnectClick)
			
			dTrace("SmartFox API: " + sfs.version)
			dTrace("Click the CONNECT button to start...")
		}   
		
		private function onBtConnectClick(evt:Event):void
		{
			// Load the default configuration file, config.xml
			//方式一,通过配置文件
			//sfs.loadConfig()//通过sfs-config.xml来指定 配置;
				
			//方式二:
			//config 配置,连接服务器时,必须指定一个空间登录;
			//var configdata:ConfigData = new ConfigData();
			//configdata.zone = content.zone_txt.text;
			//sfs.connectWithConfig(configdata);
			//方式三:
			sfs.connect("127.0.0.1",9933);
		}
		private function disconnect():void
		{
			try{
				sfs.killConnection();
				sfs.disconnect();
			}catch(e:Error){
				dTrace(e.message);
			}
		}
		//:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		// SFS2X event handlers
		//:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		
		private function onConnection(evt:SFSEvent):void
		{
			if (evt.params.success)
			{
				dTrace("Connection Success!");
				if (evt.params.success)
				{
					//连接成功后首先guest登录
					if (CURR_STATE == AppStates.CONNECTION_FIRST)
					{
						//CURR_STATE = AppStates.LOGIN_SIGN_UP;
						mylogin.guestLogin();
					}
						
						// We're logging in as registered user, send the credentials
					//已经有账号时的登录,如果已经默认匿名登录,那么首先要退出
					else if (CURR_STATE == AppStates.CONNECTION_LOGIN)
						mylogin.onloginHandler();
						
						// We're logging in for recovering the password, use a guest login
					//修改密码的时候,首先默认guest登录
					else if (CURR_STATE == AppStates.CONNECTION_PASS_RECOVER)
					{
						//CURR_STATE = AppStates.LOGIN_PASS_RECOVER;
						mylogin.guestLogin();
					}
				}
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