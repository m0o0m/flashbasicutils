package mymvc
{
	import com.wg.layout.Layout;
	import com.wg.mvc.MVCManager;
	import com.wg.mvc.view.ViewSubBase;
	import com.wg.socketserver.Server;
	
	import flash.display.Stage;
	
	import mymvc.constant.ConstantCls;
	
	public class MyMVCManager
	{
		private static var _layout:Layout;
		private static var _uri:URI;
		private static var _stage:Stage;
		public function MyMVCManager()
		{
			
		}
		
		public static function get stage():Stage
		{
			return _stage;
		}

		public static function init(__stage:Stage):void
		{
			_stage = __stage;
			var server:Server = new Server();
			MVCManager.init(stage,new ConstantCls());
		}
		public static function set layout(value:Layout):void
		{
			_layout = value;
		}
		public static function get layout():Layout
		{
			if(!_layout)
			{
				_layout = new Layout();
				
				_layout.init(stage);
				_layout.name = "_layout";
				stage.addChild(_layout);
			}
			return _layout;
		}
		public static function inStage(view:ViewSubBase):Boolean
		{
			return layout.panelLayer.hasView(view);
		}
		public static function set uri(value:URI):void
		{
			_uri = value;
		}
		public static function get uri():URI
		{
			if(!_uri)
			{
				_uri = new URI();
			}
			return _uri;
		}
		public static function getUri(contentNmae:String):String
		{
			// TODO Auto Generated method stub
			
			return uri.getPanelURI(contentNmae);
		}
	}
	
}