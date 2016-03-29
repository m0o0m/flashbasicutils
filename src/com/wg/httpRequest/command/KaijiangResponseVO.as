package com.wg.httpRequest.command
{
	
	import com.wg.httpRequest.HttpResponseVO;
	
	import flash.utils.ByteArray;
	
	
	public class KaijiangResponseVO extends HttpResponseVO
	{
		//在切换彩种时,判断是否需要更新一些数据,不需要更新的,直接从保存数据里读取;
		private var _needObj:Object = {};
		private var _caiTimeObj:Object = {};//保存所有彩种的状态;
		public function KaijiangResponseVO()
		{
			super();
		}
		
		
		public function get responseData():Object
		{
			return _responseData;
		}

		public function get name():String
		{
			return _responseData.name;
		}
		override public function formatData(data:Object):void
		{
			super.formatData(data);
		}
		
		
	}
}