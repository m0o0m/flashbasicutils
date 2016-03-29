package mymvc.constant
{
	import com.wg.mvc.MVCConstant;
	import myserverMessages.testcommand.TestMessageResponse;
	
	import flash.utils.Dictionary;
	
	import mymvc.commands.RefreshRoleDataCommand;
	import mymvc.commands.RoleDataCommadResponse;
	import mymvc.commands.ShowCommand;
	import mymvc.datas.TestData;
	import mymvc.views.TestView;

	/**
	 * 传递值为class,实现统一生产不同类;
	 * 利用字符串做引用,在变更类后无需多处修改, 
	 * @author Administrator
	 * 
	 */
	public class ConstantCls extends MVCConstant
	{
		
		private static var _instance:ConstantCls;
		public static const COMMAND_OPENPANEL:String = "openPanel";
		public static const COMMAD_SERVER_GETROLEINFO:String = "COMMAD_SERVER_GETROLEINFO";
		public static const DATA_TEST:String = "DATA_TEST";
		public static const COMMAND_VIEW_REFRESHROLEDATA:String = "freshroledata";
		public static const VIEW_TESTVIEW:String = "VIEW_TESTVIEW";
		public function ConstantCls()
		{
			if(_instance)
			{
				throw new Error("单例...");
			}
			initCommand();
			initView();
			initData();
//			initServerCommand();
		}
		
	/*	private function initServerCommand():void
		{
			// TODO Auto Generated method stub
			serverCommandDic[""] ;
		}*/
		public static function get instance():ConstantCls
		{
			if(!_instance)
			{
				_instance = new ConstantCls();
			}
			return _instance;
		}
		private function initCommand():void
		{
			commandDic[COMMAND_OPENPANEL] = ShowCommand;
			commandDic[COMMAD_SERVER_GETROLEINFO] = RoleDataCommadResponse;
			commandDic[COMMAND_VIEW_REFRESHROLEDATA] = RefreshRoleDataCommand;
			commandDic["testsocket"] = TestMessageResponse;
			
		}
		
		private function initView():void
		{
			viewDic[VIEW_TESTVIEW] =  TestView;
		}
		private function initData():void
		{
			dataDic[DATA_TEST] = TestData;
		}
		
		public  function getCommandNameByClass(cls:Class):String
		{
			for(var name:String in commandDic)
			{
				if(commandDic[name] == cls)
				{
					return name;
				}
			}
			return "";
		}
	}
}