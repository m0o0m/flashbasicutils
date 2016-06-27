package com.wg.httpRequest
{
	public class HttpResponseVO
	{
		/**
		 *返回数据存储的变量; 
		 */
		protected var _responseData:Object = {};
		public function HttpResponseVO()
		{
			
		}
		public function get responseData():Object
		{
			return _responseData;
		}
		
		public function formatData(data:Object):void
		{
			_responseData = data;
		}
		public function toString():String{
			var tempstr:String = "";
			return tempstr;
		}
	}
}