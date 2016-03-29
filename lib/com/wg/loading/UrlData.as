package com.wg.loading
{
	import flash.display.LoaderInfo;

	public class UrlData
	{
		private var _url:String;
		private var _loaderInfo:LoaderInfo;
		private var _succ:Boolean = false;

		public function UrlData(url:String)
		{
			_url = url;
		}

		public function get url() : String
		{
			return _url;
		}
		
		public function set loaderInfo(loaderInfo:LoaderInfo) : void
		{
			_loaderInfo = loaderInfo;
		}
		
		public function get loaderInfo() : LoaderInfo
		{
			return _loaderInfo;
		}
		
		public function set succ(succ:Boolean) : void
		{
			_succ = succ;
		}
		
		public function get succ() : Boolean
		{
			return _succ;
		}
	}
}