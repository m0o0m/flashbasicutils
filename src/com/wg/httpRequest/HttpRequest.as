package com.wg.httpRequest
{
	
	import com.wg.logging.Log;
	
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.utils.ByteArray;
	

	/**
	 *每次請求重新new,使用後即銷毀; 
	 * @author Allen
	 * 
	 */
	public class HttpRequest
	{

		private var _requestVO:HttpRequestVO;
		public static var openLoading:Function;
		public static var closeLoading:Function;
		public static var method: String = URLRequestMethod.GET;
		public static var defaultDataFormat: String = URLLoaderDataFormat.TEXT;
		public function HttpRequest(_request:HttpRequestVO,_response:HttpResponseVO,dataFormat: String = "",method: String = "")
		{
			_requestVO = _request;
			_responseVO = _response;
			this._requestVO.method = method == "" ? HttpRequest.method : method;
			this._requestVO.dataFormat = dataFormat == "" ? HttpRequest.defaultDataFormat : dataFormat;
			submit();
		}

		private var loader:URLLoader = new URLLoader();
		private var _responseVO:HttpResponseVO;
		public function submit():void
		{
			if(openLoading is Function&&_requestVO.needShowLoading)
			{
//				openLoading();
			}
			//URLRequest.method POST方法
			/*
			 * 
			dataformat 支持三种格式  
			如果 dataFormat 属性的值是 URLLoaderDataFormat.TEXT，则所接收的数据是一个包含已加载文件文本的字符串。
			
			如果 dataFormat 属性的值是 URLLoaderDataFormat.BINARY，则所接收的数据是一个包含原始二进制数据的 ByteArray 对象。
			
			如果 dataFormat 属性的值是 URLLoaderDataFormat.VARIABLES，则所接收的数据是一个包含 URL 编码变量的 URLVariables 对象。
			
			*/
			//loader.dataFormat = URLLoaderDataFormat.BINARY;
			this.loader.dataFormat = this._requestVO.dataFormat;
			configureListeners(loader);
			var header:URLRequestHeader = new URLRequestHeader("X-Requested-With", "XMLHttpRequest");
			//指定传送的值为json格式;
			var header2:URLRequestHeader = new URLRequestHeader("Content-Type", "application/json");
//			var header2:URLRequestHeader = new URLRequestHeader("Cookie", "ds.lottoID=2;ds.lottoTypeID=1;");Content-Type=application/json
//			var URLSt:URLRequest = new URLRequest("http://www.baidu.com");
			var URLSt:URLRequest = new URLRequest(_requestVO.url);
			
//			var URLSt:URLRequest = new URLRequest("http://lotto.222kkw.com/robots.txt");
			//URLSt.method = URLRequestMethod.GET;
			URLSt.method = this._requestVO.method;
			URLSt.requestHeaders.push(header);
			URLSt.requestHeaders.push(header2);
			//设置要传输的信息

			/*
			 * 
			当 method 值为 GET 时，将使用 HTTP 查询字符串语法将 data 值追加到 URLRequest.url 值。
			当 method 值为 POST（或 GET 之外的任何值）时，将在 HTTP 请求体中传输 data 值。
			
			如果该对象为 ByteArray 对象，则 ByteArray 对象的二进制数据用作 POST 数据。对于 GET，不支持 ByteArray 类型的数据。对于 FileReference.upload() 和 FileReference.download()，也不支持 ByteArray 类型的数据。
			如果该对象是 URLVariables 对象，并且该方法是 POST，则使用 x-www-form-urlencoded 格式对变量进行编码，并且生成的字符串会用作 POST 数据。一种例外情况是对 FileReference.upload() 的调用，在该调用中变量将作为 multipart/form-data 发布中的单独字段进行发送。
			如果该对象是 URLVariables 对象，并且该方法是 GET，则 URLVariables 对象将定义要随 URLRequest 对象一起发送的变量。
			否则，该对象会转换为字符串，并且该字符串会用作 POST 或 GET 数据。

			*/
			URLSt.data = _requestVO.urlData;
			
			try {
				loader.load(URLSt);
				trace("httprequest::submit",_requestVO.url);
			} catch (error:Error) {
				trace("Unable to load requested document.");
			}
			
		}
		
		private function configureListeners(dispatcher:IEventDispatcher):void {
			dispatcher.addEventListener(Event.COMPLETE, completeHandler);
			dispatcher.addEventListener(Event.OPEN, openHandler);
			dispatcher.addEventListener(ProgressEvent.PROGRESS, progressHandler);
			dispatcher.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			dispatcher.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
			dispatcher.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
		}
		/**
		 * 服务端返回json格式的字符串,默认utf8编码解析;
		 * 如果二进制形式返回,则要先解码;
		 * */
		private function completeHandler(event:Event):void {
			var loader:URLLoader = URLLoader(event.target);
			trace(_requestVO.url);
			
			trace("httprequest::completeHandler",urldata);
		 	var data:Object //= JSON.parse(urldata);
//		 	var data:Object = JSON.parse(URLLoader(event.target).data);
//			trace("completeHandler==============: " + data["6"]["dish"][0]);
//			var json:JSONDecoder = new JSONDecoder(URLLoader(event.target).data);
			if(this._requestVO.dataFormat == URLLoaderDataFormat.BINARY)
			{
				var urldata:String = encode(URLLoader(event.target).data);
				data = JSON.parse(urldata);
			}else
			{
				//                    data = <any>JSON.parse((<egret.URLLoader>(event.target)).data);
				data = ((event.target)).data;
				Log.trace(1);
			}
			_responseVO.formatData(data);
//			_responseVO.formatData(json.getValue());
			_requestVO.completeFunc(_responseVO);
			if(closeLoading is Function&&_requestVO.needShowLoading)
			{
//				closeLoading();
			}
				
			dispose();
		}
		private function encode(str:*,method:String="utf-8"):String
		{
			var byteArray:ByteArray = new ByteArray();
			byteArray.writeBytes(str);
			byteArray.position = 0;
			return byteArray.readMultiByte(byteArray.length,method); 
		}
		private function openHandler(event:Event):void {
			trace("openHandler: " + event);
		}
		
		private function progressHandler(event:ProgressEvent):void {
			trace("progressHandler loaded:" + event.bytesLoaded + " total: " + event.bytesTotal);
		}
		
		private function securityErrorHandler(event:SecurityErrorEvent):void {
			trace("securityErrorHandler: " + event);
		}
		
		private function httpStatusHandler(event:HTTPStatusEvent):void {
			trace("httpStatusHandler: " + event);
		}
		
		private function ioErrorHandler(event:IOErrorEvent):void {
			trace("ioErrorHandler: " + event);
			trace(event.target.toString());
			trace(event.text);
		}
		
		private function dispose():void
		{
			loader.removeEventListener(Event.COMPLETE, completeHandler);
			loader.removeEventListener(Event.OPEN, openHandler);
			loader.removeEventListener(ProgressEvent.PROGRESS, progressHandler);
			loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			loader.removeEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
			loader.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			_requestVO = null;
			loader = null;
		}
		
	}
}