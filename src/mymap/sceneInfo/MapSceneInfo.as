package mymap.sceneInfo
{
	import com.ClientConstants;
	import com.Constants;
	
	import flash.display.BitmapData;
	
	import mydesigndatas.logic.Map;

	public class MapSceneInfo
	{
		public var mapId:int;
		public var mapName:String;
		private var _mapType:int;
		public var map:Map;

		public function get mapType():int
		{
			return _mapType;
		}

		public function set mapType(value:int):void
		{
			_mapType = value;
		}

		
//		public var map:Map;
		
		public var mapSeaColor:uint = 0xFFFFFF;
		
		public var mapNumCols:int;
		public var mapNumRows:int;
		/**
		 *整个场景的宽,包含未显示在舞台上的
		 * 
		 */
		public var mapTotalWidth:Number = 0;
		/**
		 * 整个场景的高,包含未显示在舞台上的
		 */
		public var mapTotalHeight:Number = 0;
		
		public var smallBackgroundBitmap:BitmapData;
		public var smallMapScale:Number = 1;
		public var isRoleUnderSea:Boolean = false;
		
		public var weatherInfo:WeatherInfo;
		public var sceneConfigXMl:XML;
		
		public function isPataMapSceneType():Boolean
		{
			return mapType == Constants.MAP_TYPE_PATA;
		}
		
		public function isDungeonMapSceneType():Boolean
		{
			return mapType == Constants.MAP_TYPE_FUBEN;
		}
		
		public function isArmyMapSceneType():Boolean
		{
			return mapType == Constants.MAP_TYPE_ARMY;
		}
		
		public function isCampFightMapSceneType():Boolean
		{
			return mapType == Constants.MAP_TYPE_CAMPFIGHT;
		}
		
		public function isNormalMapSceneType():Boolean
		{
			return checkNormalMapSceneType(mapType);
		}
		public static function checkNormalMapSceneType(checkMapType:int):Boolean
		{
			return checkMapType == Constants.MAP_TYPE_COUNTRY ||
				checkMapType == Constants.MAP_TYPE_NEUTRAL ||
				checkMapType == Constants.MAP_TYPE_COMMON || 
				checkMapType == Constants.MAP_TYPE_FIGHT;
		}
		
		public function isHomeMapSceneType():Boolean
		{
			return mapType == Constants.MAP_TYPE_HOME;
		}
		
		public function getIsMyCampWareHouseMap(countryId:int):Boolean
		{
			if(countryId == 1)
			{
				return mapId == 103;
			}
			else if(countryId == 2)
			{
				return mapId == 104;
			}
			return false;
		}
		public function isAbyssIsland():Boolean
		{
			var abyMapId:int = 012345678;//App.instance.gameParameters.AbyssIslandMapID;
			return mapId == abyMapId
		}
	}
}