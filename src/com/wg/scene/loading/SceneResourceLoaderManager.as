package com.wg.scene.loading
{
	import flash.display.BitmapData;

	public class SceneResourceLoaderManager
	{
		private static var _instance:SceneResourceLoaderManager
		
		public static function getInstance():SceneResourceLoaderManager
		{
			return _instance ||= new SceneResourceLoaderManager();
		}
		
		public function SceneResourceLoaderManager()
		{
			super();
		}
		
		private var _avatarPlaceHoldModelBitmapData:BitmapData;
		private var _avatarBoatPlaceHoldModelBitmapData:BitmapData;
		
		private var _currentLoadingItemMaps:Array = [];//key => ModelLoadItem
		
		public function getAvatarPlaceModelBitmapData():BitmapData
		{
			if(_avatarPlaceHoldModelBitmapData == null)
			{
				var cls:Class = Config.resourceLoader.getClass("RoleDefaultModel", "common");
				_avatarPlaceHoldModelBitmapData = new cls();
			}
			
			return _avatarPlaceHoldModelBitmapData;
		}
		
		public function getBoatAvatarPlaceModelBitmapData():BitmapData
		{
			if(_avatarBoatPlaceHoldModelBitmapData == null)
			{
				var cls:Class = Config.resourceLoader.getClass("RoeBoatDefaultModel", "common");
				_avatarBoatPlaceHoldModelBitmapData = new cls();
			}
			
			return _avatarBoatPlaceHoldModelBitmapData;
		}
		
		private var _avatarBubbleBitmapData:BitmapData;
		
		public function getAvatarBubbleBitmapData():BitmapData
		{
			if(_avatarBubbleBitmapData == null)
			{
				var cls:Class = getCommonResource("BubbleCls");
				_avatarBubbleBitmapData = new cls();
			}
			
			return _avatarBubbleBitmapData;
			
//			var bitmap:Bitmap = new Bitmap(_modelBubbleBitmapData);
//			bitmap.x = -(_modelBubbleBitmapData.width >> 1);
//			bitmap.y = -(_modelBubbleBitmapData.height >> 1);
//			
//			return bitmap;
		}
		
		
		private var _avatarBubbleChatBitmapData:BitmapData;
		
		public function getAvatarBubbleChatBitmapData():BitmapData
		{
			if(_avatarBubbleBitmapData == null)
			{
				var cls:Class = getCommonResource("BubbleChat");
				_avatarBubbleBitmapData = new cls();
			}
			
			return _avatarBubbleBitmapData;
			
			//			var bitmap:Bitmap = new Bitmap(_modelBubbleBitmapData);
			//			bitmap.x = -(_modelBubbleBitmapData.width >> 1);
			//			bitmap.y = -(_modelBubbleBitmapData.height >> 1);
			//			
			//			return bitmap;
		}
		
		public function getBattleCommonResource(className:String):Class
		{
			return Config.resourceLoader.getClass(className, "BattleCommonResource");
		}
		
		public function getCommonResource(className:String):Class
		{
			var cls:Class = Config.resourceLoader.getClass(className, "common");
			return cls;
		}
		
		public function clearLoadingItem(url:String):void
		{
			delete _currentLoadingItemMaps[url];
		}
		
		public function loadItem(itemURL:String, loadItemClass:Class):ISceneResourceLoaderItem
		{
//			trace("SceneResourceLoaderManager", itemURL);
			if(ShareObjectCacheManager.getInstance().hasRegistShareObject(itemURL))
			{
				var callLaterModelLoadItem:CallLaterLoadItem = new CallLaterLoadItem();
				callLaterModelLoadItem.load(itemURL);
				return callLaterModelLoadItem;
			}
			else
			{
				var loadItem:ISceneResourceLoaderItem = _currentLoadingItemMaps[itemURL] as ISceneResourceLoaderItem;
				if(!loadItem)
				{
					loadItem = new loadItemClass();
					_currentLoadingItemMaps[itemURL] = loadItem;
					loadItem.load(itemURL);
				}
				
				return loadItem;
			}
		}
	}
}