package com.wg.mvc
{
	
	
	import com.wg.layout.Layout;
	import com.wg.logging.Log;
	import com.wg.mvc.command.interfaces.ICommand;
	import com.wg.mvc.data.DataSubBase;
	import com.wg.mvc.interfaces.event.IServerNotifier;
	import com.wg.mvc.view.ViewSubBase;
	import com.wg.resource.ResourceLoader;
	import com.wg.socketserver.Server;
	
	import flash.display.Stage;

	/**
	 *引用外部模块和内部模块; 改变模块的使用都在这里调整;
	 * @author Administrator
	 * 
	 */
	public class MVCManager
	{
		private static var _stage:Stage;
		
		private static var _view:View;
		private static var _data:Data;
		private static var _resoureloader:ResourceLoader;
		private static var _control:Controller;
		private static var _constant:MVCConstant;
//		private static var _instance:MVCManager;		
		private static var _server:IServerNotifier;
		public function MVCManager()
		{
			/*if(_instance)
			{
				throw new Error("通过 instance 获取实例");
			}*/
			
		}

/*		public static function get instance():MVCManager
		{
			if(!_instance)
			{
				_instance = new MVCManager();
			}
			return _instance;
		}*/

		public static function get server():IServerNotifier
		{
			return _server;
		}

		public static function init(__stage:Stage,con:MVCConstant,server:IServerNotifier = null):void
		{
			_stage = __stage;
			_constant = con;
			_server = server;
		}
		public static function get control():Controller
		{
			if(!_control)
			{
				_control = new Controller(data,view);
			}
			return _control;
		}



		public static function get data():Data
		{
			if(!_data)
			{
				_data = new Data(_server);
			}
			return _data;
		}


		public static function get view():View
		{
			if(!_view)
			{
				_view = new View();
			}
			return _view;
		}


		


		public static function get resoureloader():ResourceLoader
		{
			if(!_resoureloader)
			{
				_resoureloader  = new ResourceLoader();
			}
			return _resoureloader;
		}


		public static function get stage():Stage
		{
			return _stage;
		}

		
		
		public static function getView(str:String):ViewSubBase
		{
			if(!_constant.viewDic[str])
			{
				Log.warn(str+" view没有找到");
			}
			return view.getSubView(_constant.viewDic[str]);
		}
		
		public static function getData(str:String):DataSubBase
		{
			if(!_constant.dataDic[str])
			{
				Log.warn(str+" data没有找到");
			}
			var temp:DataSubBase = data.getSubData(_constant.dataDic[str]);
			return temp;
		}

		
		public static function getCommand(str:String):ICommand
		{
			// TODO Auto Generated method stub
			if(!_constant.commandDic[str])
			{
				Log.warn(str+"命令没有找到");
			}
			return control.getSubCommand(_constant.commandDic[str]) as ICommand;
		}
		
		
	}
}