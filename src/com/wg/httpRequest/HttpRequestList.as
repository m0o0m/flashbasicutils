package com.wg.httpRequest
{
	import com.wg.error.Err;
	import com.wg.httpRequest.command.KaijiangRequestVO;
	import com.wg.httpRequest.command.KaijiangResponseVO;
	

	public class HttpRequestList
	{
		public static var domain:String;
		private var _urlToRequest:Object = new Object();
		private var _urlToResponse:Object = new Object();
		private static var _instance:HttpRequestList;
		public function HttpRequestList():void
		{
			if(_instance)
			{
				return //new Error("单例");
			}
			init();
		}
		public static function get instance():HttpRequestList
		{
			if(!_instance)
			{
				_instance = new HttpRequestList();
			}
			return _instance;
		}
		public function init():void
		{
			initRequest();
			initResponse();
		}
		
		private function initRequest():void
		{
			_urlToRequest[kaijiangrequest] = KaijiangRequestVO;

		}
		private function initResponse():void
		{
			_urlToResponse[kaijiangrequest] =KaijiangResponseVO;

		}
		public static function get kaijiangrequest():String
		{
			var url:String = "http://"+HttpRequestList.domain+"/jsontest";
//			var url:String =  "http://192.168.8.80:88/api/pankou/GetKaiPan";
//			traceUrl(url);
			return url;
		}
		

		
		public function getRequestClass(cmd:String) : Class
		{
			var classObj:* = _urlToRequest[cmd];
			if (classObj == null) {
				Err.occur(Errno.CLIENT_ERROR, {
					desc: "message cmd [" + cmd + "] not found class"
				});
				return null;
			}
			return classObj;			
		}
		public function getResponseClass(cmd:String) :Class
		{
			var classObj:* = _urlToResponse[cmd];
			if (classObj == null) {
				Err.occur(Errno.CLIENT_ERROR, {
					desc: "message cmd [" + cmd + "] not found class"
				});
				return null;
			}
			return classObj;			
		}
		private static function traceUrl(url:String):void
		{
			trace("HttpRequestList::",url);
		}
	}
}