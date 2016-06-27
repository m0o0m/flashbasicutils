package com.wg.httpRequest.command
{
	import com.wg.httpRequest.HttpRequestVO;
	
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLVariables;
	
	
	public class KaijiangRequestVO extends HttpRequestVO
	{
		public function KaijiangRequestVO(_url:String,func:Function)
		{
			//dataFormat = URLLoaderDataFormat.BINARY;//在使用处定义
			super(_url,func);
		}
		override public function get needShowLoading():Boolean
		{
			return false;
		}
		override protected function initurlvariables(arr:Object = null):void
		{
			urlVariables = new URLVariables();
			urlVariables.name = arr.name;
		}
		override protected function initurldata(datas:* = null):void
		{
			super.initurldata(datas);
		}
		/**
		 * 将数据处理,打包成json;
		 * @param Obj
		 * 
		 */
		override public function formateData(Obj:Object):void
		{
			super.formateData(Obj);
			this.initurldata(Obj["data"]);
		}
		
		
	}
}