package sfsservertest
{
	import com.smartfoxserver.v2.SmartFox;
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.requests.LoginRequest;
	import com.smartfoxserver.v2.requests.LogoutRequest;
	
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
		
		protected function onloginHandler(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			// This code is executed after the connection
			//sfs.send( new LoginRequest("", "", "testzone") );//匿名登录,指定空间
			sfs.send( new LoginRequest(content.zoneusername_txt.text,content.zoneuserpwd_txt.text,content.zone2_txt.text) );//fozzie用户登录连接时空间
			//sfs.send( new LoginRequest("banned name") );//被后台禁止的用户名;
			
			//rooms指定,default 默认分发;
			
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