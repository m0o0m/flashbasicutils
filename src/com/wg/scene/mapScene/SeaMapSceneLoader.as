package  com.wg.scene.mapScene
{
	
	import com.wg.logging.Log;
	import com.wg.resource.SWFSecurityUtil;
	import com.wg.scene.utils.GameMathUtil;
	
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import mydesigndatas.logic.Map;
	
	import mymap.sceneInfo.MapSceneInfo;
	
	public class SeaMapSceneLoader
	{
		public var loadStartCallback:Function;
		public var loadProgressCallback:Function;
		public var loadCompleteCallback:Function;
		
		private var _currentMapId:int = -1;
		private var _requestTargetMapId:int = -1;
		
		private var _mapSmallBackgroundImageLoader:Loader;
		private var _mapConfigUrlLoader:URLLoader;
		
		private var _loadedMapSceneTileBitmapDatas:Array;
		private var _loadedMapSceneSmallBitmapData:BitmapData;
		private var _loadedMapSceneConfigXML:XML;

		private var _currentSceneInfo:MapSceneInfo;
		
		public function SeaMapSceneLoader(initMapId:int)
		{
			super();
			
			_requestTargetMapId = initMapId;
			_currentMapId = initMapId;
		}
		
		public function get currentMapId():int
		{
			return _currentMapId;
		}
		
		public function get currentSceneInfo():MapSceneInfo
		{
			return _currentSceneInfo;
		}
		
		public function changedToMap(mapId:int):void
		{
			if(_requestTargetMapId == mapId)
				return;
			
			_requestTargetMapId = mapId;
			
			if(_requestTargetMapId > 0)
			{
				loadSmallBackgroundImag();
				
				loadSeaMapSceneConfig(mapConfigPath);
				
				if(loadStartCallback != null)
					loadStartCallback(mapConfigPath);
			}
		}
		
		private function get mapConfigPath():String
		{
			return Config.uri.getTownMapConfigURI(_requestTargetMapId);
		}
		
		private function loadSmallBackgroundImag():void
		{
			closeLoadSmallBackgroundImag();
			
			_mapSmallBackgroundImageLoader = new Loader();
			
			_mapSmallBackgroundImageLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, mapSmallBackgroundImageLoaderLoadCompleteHandler);
			_mapSmallBackgroundImageLoader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, loadProgressHandler);
			_mapSmallBackgroundImageLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, loadErrorHandler);
			_mapSmallBackgroundImageLoader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, loadErrorHandler);
			
			var url:String = Config.uri.getTownMapSmallURI(this._requestTargetMapId);
			_mapSmallBackgroundImageLoader.load(new URLRequest(url),SWFSecurityUtil.requestSWFLoaderContext(false, true));
		}
		
		private function mapSmallBackgroundImageLoaderLoadCompleteHandler(event:Event):void
		{
			var url:String = _mapSmallBackgroundImageLoader.contentLoaderInfo.url;
			var smallBitmapClsName:String = "bitmap_" + GameMathUtil.getFileName(url);
			var smallBitmapCls:Class = _mapSmallBackgroundImageLoader.contentLoaderInfo.applicationDomain.getDefinition(smallBitmapClsName) as Class;
			
			closeLoadSmallBackgroundImag();
			
			_loadedMapSceneSmallBitmapData = new smallBitmapCls(0, 0);
			
			
			validateLoadComplete();
		}
		
		private function closeLoadSmallBackgroundImag():void
		{
			if(_loadedMapSceneSmallBitmapData)
			{
				_loadedMapSceneSmallBitmapData.dispose();
				_loadedMapSceneSmallBitmapData = null;
			}
			
			if(_mapSmallBackgroundImageLoader)
			{
				_mapSmallBackgroundImageLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE, mapSmallBackgroundImageLoaderLoadCompleteHandler);
				_mapSmallBackgroundImageLoader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, loadProgressHandler);
				_mapSmallBackgroundImageLoader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, loadErrorHandler);
				_mapSmallBackgroundImageLoader.contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, loadErrorHandler);
				
				_mapSmallBackgroundImageLoader = null;
			}
		}
		
		private function loadSeaMapSceneConfig(url:String):void
		{
			closeLoadSeaMapSceneConfig();
			
			_mapConfigUrlLoader = new URLLoader();
			
			_mapConfigUrlLoader.addEventListener(Event.COMPLETE, mapConfigUrlLoaderLoadCompleteHandler);
			_mapConfigUrlLoader.addEventListener(ProgressEvent.PROGRESS, loadProgressHandler);
			_mapConfigUrlLoader.addEventListener(IOErrorEvent.IO_ERROR, loadErrorHandler);
			_mapConfigUrlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, loadErrorHandler);
			
			_mapConfigUrlLoader.load(new URLRequest(url));
		}
		
		private function mapConfigUrlLoaderLoadCompleteHandler(event:Event):void
		{
			closeLoadSeaMapSceneConfig();
			
			_loadedMapSceneConfigXML = new XML(URLLoader(event.currentTarget).data);
			validateLoadComplete();
		}
		
		private function closeLoadSeaMapSceneConfig():void
		{
			if(_loadedMapSceneConfigXML)
			{
				_loadedMapSceneConfigXML = null;
			}
			
			if(_mapConfigUrlLoader)
			{
				_mapConfigUrlLoader.addEventListener(Event.COMPLETE, mapConfigUrlLoaderLoadCompleteHandler);
				_mapConfigUrlLoader.addEventListener(ProgressEvent.PROGRESS, loadProgressHandler);
				_mapConfigUrlLoader.addEventListener(IOErrorEvent.IO_ERROR, loadErrorHandler);
				_mapConfigUrlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, loadErrorHandler);
				
				_mapConfigUrlLoader = null;
			}
		}
		
		private function loadProgressHandler(event:Event):void
		{
			if(loadProgressCallback == null) return;
			
			var bytesLoaded:int = 0; 
			var bytesTotal:int = 0;
			
			if(_mapConfigUrlLoader)
			{
				bytesLoaded += _mapConfigUrlLoader.bytesLoaded;
				bytesTotal += _mapConfigUrlLoader.bytesTotal;
			}
			
			if(_mapSmallBackgroundImageLoader && _mapSmallBackgroundImageLoader.contentLoaderInfo)
			{
				bytesLoaded += _mapSmallBackgroundImageLoader.contentLoaderInfo.bytesLoaded;
				bytesTotal += _mapSmallBackgroundImageLoader.contentLoaderInfo.bytesTotal;
			}
			
			if(bytesTotal == 0)
			{
				bytesLoaded = 0;
				bytesTotal = 100;
			}
			
			loadProgressCallback(mapConfigPath,bytesLoaded, bytesTotal);
		}
		
		private function loadErrorHandler(event:Event):void
		{
			throw new Error("There's Somerthing Error when map resource Loading!" + event["text"]);
		}
		
		private function validateLoadComplete():void
		{
			if(_loadedMapSceneSmallBitmapData && 
				_loadedMapSceneConfigXML)
			{
				_currentMapId = _requestTargetMapId; 
				
				Log.debug("Scene Resource Load Complete!");
				
				_currentSceneInfo = getMapSceneInfo(_currentMapId, _loadedMapSceneSmallBitmapData, _loadedMapSceneConfigXML);
				
				if(loadCompleteCallback != null)
				{
					loadCompleteCallback(_currentSceneInfo);
				}
			}
		}
		
		public function getMapSceneInfo(mapId:int, smallMap:BitmapData, mapConfig:XML):MapSceneInfo
		{
			Log.debug("Scene mapConfig:" + mapConfig.toString());
			trace("Scene mapConfig:" + mapConfig.toString());
			var mapSceneInfo:MapSceneInfo = new MapSceneInfo();
			
			mapSceneInfo.mapId = mapId;
			mapSceneInfo.map = Config.design.load(Map, mapId);
			
			mapSceneInfo.mapName = mapConfig.@name;
			mapSceneInfo.mapType = mapConfig.@type;
			mapSceneInfo.mapSeaColor = uint(mapConfig.@seaColor) || 0x00CCFF;
			mapSceneInfo.mapNumCols = mapConfig.mapWidth;
			mapSceneInfo.mapNumRows = mapConfig.mapHeight;
			mapSceneInfo.mapTotalWidth = mapConfig.mapMaxWidth;
			mapSceneInfo.mapTotalHeight = mapConfig.mapMaxHeight;
			mapSceneInfo.smallBackgroundBitmap = smallMap;
			mapSceneInfo.smallMapScale = smallMap.width / mapSceneInfo.mapTotalWidth;
			mapSceneInfo.isRoleUnderSea = mapConfig.@isRoleUnderSea == -1;//true;//;
			
			var weather:String = mapSceneInfo.map.weather;
			if(weather && weather.length > 0)
			{
				/*var weatherInfo:WeatherInfo = new WeatherInfo();
				mapSceneInfo.weatherInfo = weatherInfo;
				
				var weatherConfigStrArr:Array = weather.split("-");
				
				weatherInfo.type = parseInt(weatherConfigStrArr[0]);
				weatherInfo.proba = GameMathUtil.clamp(parseInt(weatherConfigStrArr[1]), 0, 100);
				weatherInfo.dark = GameMathUtil.clamp(parseInt(weatherConfigStrArr[2]), 0, 100);*/
			}
			
			mapSceneInfo.sceneConfigXMl = mapConfig;
			
			return mapSceneInfo;
		}
	}
}