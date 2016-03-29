package  com.wg.httpRequest
{
	import flash.net.URLVariables;

	public class HttpRequestVO
	{
		public var url:String;
		public var completeFunc:Function;
		public var urlVariables:URLVariables;
		private var _needShowLoading:Boolean = true;
		public function HttpRequestVO(_url:String,_callbackFunc:Function)
		{
			url = _url;
			completeFunc = _callbackFunc;
		}
		
		protected function initurlvariables(arr:Object = null):void
		{
		}
		
		public function get needShowLoading():Boolean
		{
			return _needShowLoading;
		}
		
		/**
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