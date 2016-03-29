package com.wg.mvc 
{
	import com.wg.mvc.data.DataSubBase;
	import com.wg.mvc.interfaces.event.IServerNotifier;

	public class Data extends DataBase
	{
		public function Data(server:IServerNotifier,initParams:*=null)
		{
			super(server,initParams);
		}
		
//		public function get toolBarData():ToolbarData
//		{
//			return  createObject(ToolbarData) as ToolbarData;
//		}
		
		public function getSubData(cls:Class):DataSubBase
		{
			return  createObject(cls);
		}
	}
}