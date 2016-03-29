package 
{
	import com.wg.design.Design;
	import com.wg.layout.Layout;
	import com.wg.resource.ResourceLoader;
	import com.wg.scene.SceneCamera;
	import com.wg.scene.SceneManager;
	
	import flash.display.Stage;
	import flash.utils.Dictionary;
	
	import starling.core.Starling;
	
	import views.ViewManager;
	import mymap.scene.Mapscene;
	


	public class Config
	{
		public static var resourceLoader:ResourceLoader;
		public static var uri:URI;
		public static var viewManger:ViewManager;
		public static var debug:ClientdebugLogic;
		public static var layout:Layout;
		private static var _instance:Config;
		public static var camera:SceneCamera;
		public static var design:Design;
		public static var sceneManager:SceneManager;
		public static var stage:Stage;
		public static var starling:Starling;
//		public static var seaMapScene:SeaMapScene;
		public static var mapscene:Mapscene;
		public static var mapdata:Object;
		
		public function Config()
		{
			if(_instance)
			{
				throw new Error("单例...");
			}
		}
		
		public static function get instance():Config
		{
			if(!_instance)
			{
				_instance = new Config();
			}
			return _instance;
		}

		
	}
}