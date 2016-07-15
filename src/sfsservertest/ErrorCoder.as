package sfsservertest
{
	import com.smartfoxserver.v2.SmartFox;
	import com.smartfoxserver.v2.util.SFSErrorCodes;

	public class ErrorCoder
	{
		private var sfs:SmartFox;
		public function ErrorCoder(_sfs:SmartFox)
		{
			sfs = _sfs;
			initErrorCodes();
		}
		/**
		 *只能修改sfs对象的错误; 
		 * 
		 */
		private function initErrorCodes():void
		{
			//http://docs2x.smartfoxserver.com/AdvancedTopics/client-error-messages
			//User {0} is already logged in Zone {1}
			SFSErrorCodes.setErrorMessage(6, "用户{0}已经登录到{1}空间");
			//Wrong password for user {0}
			SFSErrorCodes.setErrorMessage(3, "用户{0}登录密码错误");
			//User name {0} is not recognized
		}
	}
}