package com.wg.httpRequest
{

	public class HttpRequestManager
	{
		private static var _instance:HttpRequestManager;
		private var httpRequests:HttpRequest;
		private var requestDataObj:Object = {};
		private var responseDataObj:Object = {};
		private var httprerquestObj:Object = {};
		
		public function HttpRequestManager()
		{
			if(_instance)
			{
				return //new Error("单例");
			}
		}
		public static function get instance():HttpRequestManager
		{
			if(!_instance)
			{
				_instance = new HttpRequestManager();
			}
			return _instance;
		}
		
		public function getRequestObj(url:String):HttpRequestVO
		{
			return requestDataObj[url];
		}
		public function getResponseObj(url:String):HttpResponseVO
		{
			return responseDataObj[url];
		}
		
		
		public function send(url:String,callbackFunc:Function,requestData:Object = null,dataFormat: String = "",method:String = ""):void
		{
			var requestCls:Class = HttpRequestList.instance.getRequestClass(url);
			
			if(!requestDataObj[url])
			{
				requestDataObj[url] = new requestCls(url,callbackFunc);
			}
			var tempObj:Object = {"func":callbackFunc,data:requestData};
			requestDataObj[url].formateData(tempObj);
			
			var resposeCls:Class = HttpRequestList.instance.getResponseClass(url);
			
			if(!responseDataObj[url])
			{
				responseDataObj[url] = new resposeCls() as HttpResponseVO;
			}
			//多次发送时,这里清除,但是内存中不清除,会在内存中继续操作和接收请求返回的数据;
			httpRequests = null;
			httpRequests = new HttpRequest(requestDataObj[url],responseDataObj[url],dataFormat,method);
		}
	}
}