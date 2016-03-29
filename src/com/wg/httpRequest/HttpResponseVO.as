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
		
		public function formatData(data:Object):void
		{
			_responseData = data;
		}
	}
}