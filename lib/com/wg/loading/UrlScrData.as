package com.wg.loading
{
	/**
	 * @用途 
	 */
	public class UrlScrData
	{
		public var key:String;
		
		public var data:Object;
		
		public var recallFun:Function;
		
		public var progressFun:Function;
		
		public function UrlScrData(key:String,progressFun:Function,recall:Function)
		{
			this.key  = key;
			this.recallFun = recall;
			this.progressFun = progressFun;
		}
	}
}