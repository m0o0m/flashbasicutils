package modules
{
	import com.views.map.DungeonMap;
	import com.views.map.GuardAthenaMap;
	import com.views.map.LegionMap;
	import com.views.map.MapKey;
	import com.views.map.TownMap;
	import com.views.map.WorldBossMap;
	import com.views.map.info.MapInfo;
	import com.views.map.interfaces.IDungeonMap;
	import com.views.map.interfaces.IGuardAthenaMap;
	import com.views.map.interfaces.ILegionMap;
	import com.views.map.interfaces.IMapInstance;
	import com.views.map.interfaces.ITownMap;
	import com.views.map.interfaces.IWorldBossMap;
	
	import flash.display.Sprite;
	import flash.display.Stage;
	
	[SWF(backgroundColor='0x999999',frameRate='30',width="1000", height="650")]
	public class Map extends Sprite implements IMapInstance
	{
		private var _info:MapInfo;
		private var _TownMap:TownMap;
		private var _DungeonMap:DungeonMap;
		
		private var _stage:Stage;
		
		public function get town() : ITownMap
		{
			return new TownMap();
		}
		
		public function get dungeon() : IDungeonMap
		{
			return new DungeonMap();
		}
		
		public function get worldBoss():IWorldBossMap
		{
			return new WorldBossMap();
		}
		
		public function get guardAthena():IGuardAthenaMap
		{
			return new GuardAthenaMap();
		}
		
		public function get legiomMap():ILegionMap{
			return new LegionMap();
		}
		
		public function set mapStage(value:Stage):void{
			_stage = value;
		}
		
		public function init():void{
			MapKey.initKey(_stage);
		}
	}
}