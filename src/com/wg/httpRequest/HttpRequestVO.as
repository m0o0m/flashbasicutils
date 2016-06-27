package  com.wg.httpRequest
{
	import com.wg.logging.Log;
	
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.utils.ByteArray;

	public class HttpRequestVO
	{
		public var url:String;
		public var completeFunc:Function;
		protected var urlVariables:URLVariables;
		private var _needShowLoading:Boolean = true;
		public var dataFormat: String = "";
		public var method:String = "";
		public var urlData:*;
		public function HttpRequestVO(_url:String,_callbackFunc:Function)
		{
			url = _url;
			completeFunc = _callbackFunc;
		}
		
		protected function initurlvariables(arr:Object = null):void
		{
		}
		
		/**
		 *1.如果客户端传入的是字符串,那么以字符串形式打包发送
		 *2.如果客户端传入的是object,那么转换为urlVariables,然后内部按照相应的规则编码数据然后发送;
		 * 2.1 get: 转换为?key=value&key=value
		 * 2.2 post:键值对数据赋值到data变量上;
		 * @param datas
		 * 
		 */
		protected function initurldata(datas:* = null):void
		{
			if(typeof (datas) == "string") {//值传递比较不出类
				this.urlData = datas;
			} else if(datas is Object) {
				this.urlVariables = new URLVariables();
				for(var name:* in datas) {
					//                        console.log(name + ":" + datas[name]);
					this.urlVariables[name] = datas[name];
				}
				this.urlData = this.urlVariables;
			} else if(datas is ByteArray) {
				if(this.method == URLRequestMethod.GET)
				{
					Log.error("get方式不支持字节数组传递");
				}
				this.urlData = datas;
			}
		}
		
		public function get needShowLoading():Boolean
		{
			return _needShowLoading;
		}
		
		/**
		 * Obj包含两部分,func:请求成功返回后回调函数;data:http 参数;
		 * Obj.func
		 * Obj.data = obj
		 * @param Obj
		 * 
		 */
		public function formateData(Obj:Object):void
		{
			completeFunc = Obj.func;
		}
	}
}