package sfsservertest
{
	import com.smartfoxserver.v2.SmartFox;
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.requests.LoginRequest;
	import com.smartfoxserver.v2.requests.LogoutRequest;
	import com.smartfoxserver.v2.util.SFSErrorCodes;
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	import fl.controls.Button;

	public class Loginer extends SFSOperator
	{
		private var login_btn:Button;
		public function Loginer(_sfs:SmartFox,_content:MovieClip)
		{
			super(_sfs,_content);
			
			sfs.addEventListener(SFSEvent.LOGIN, onLogin);
			sfs.addEventListener(SFSEvent.LOGIN_ERROR, onLoginError);
			login_btn = _content.login_btn;
			login_btn.addEventListener(MouseEvent.CLICK,onloginHandler);
			_content.loginout_btn.addEventListener(MouseEvent.CLICK,onloginoutHandler);
			sfs.addEventListener(SFSEvent.LOGOUT, onLogout);	
		}
		/**
		 * 会有以下情况
		 *-- Login failed: User name Fozzie is not recognized 
		 * @param event
		 * 
		 */		
		public function onloginHandler(event:MouseEvent = null):void
		{
			// TODO Auto-generated method stub
			
			if(sfs.currentZone){
				dTrace("你已经登录到: " + sfs.currentZone+" 空间");
				return;
			}
			
			// This code is executed after the connection
			//sfs.send( new LoginRequest("", "", "testzone") );//匿名登录,指定空间
			sfs.send( new LoginRequest(content.zoneusername_txt.text,content.zoneuserpwd_txt.text,content.zone2_txt.text) );//fozzie用户登录连接时空间
			//sfs.send( new LoginRequest("banned name") );//被后台禁止的用户名;
			
			//rooms指定,default 默认分发;
			
		}
		/**
		 *发送会有重复的匿名的登录的情况; 
		 * 
		 */		
		public function guestLogin():void
		{
			sfs.send( new LoginRequest());
		}
		protected function onloginoutHandler(event:MouseEvent):void
		{
			sfs.send(new LogoutRequest());
		}
		
		public function onLogin(evt:SFSEvent):void
		{
			dTrace("Login success: " + evt.params.user.name);
		}
		
		public function onLoginError(evt:SFSEvent):void
		{
			dTrace("Login failed: " + evt.params.errorMessage);
		}
		
		private function onLogout(evt:SFSEvent):void
		{
			dTrace("Logout executed!");
		}

		
	}
}