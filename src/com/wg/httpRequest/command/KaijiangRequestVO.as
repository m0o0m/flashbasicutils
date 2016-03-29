package com.wg.httpRequest.command
{
	import com.wg.httpRequest.HttpRequestVO;
	
	import flash.net.URLVariables;
	
	
	public class KaijiangRequestVO extends HttpRequestVO
	{
		public function KaijiangRequestVO(_url:String,func:Function)
		{
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
		
		/**
		 * 将数据处理,打包成json;
		 * @param Obj
		 * 
		 */
		override public function formateData(Obj:Object):void
		{
			super.formateData(Obj);
			initurlvariables(Obj);
		}
		
		
	}
}