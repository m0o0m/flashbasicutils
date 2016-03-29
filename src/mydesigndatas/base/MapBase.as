package mydesigndatas.base
{	

	public class MapBase	
	{	
		public var id:uint = 0;	
		public var name:String = "";	
		public var bgSound:String = "";	
		public var fightBgSound:String = "";	
		public var weather:String = "";	
		public var fightMaplds:String = "";	
		public var needLevel:uint = 0;	
		public var campId:uint = 0;	

		public function MapBase(initParams:*=null)
		{
			for (var i:String in initParams) {			
				this[i] = initParams[i];
			}

		}
		
		public function toString() : String
		{
			var elems:Array = [];
			elems.push("id" + ":" + this.id);
			elems.push("name" + ":" + this.name);
			elems.push("bgSound" + ":" + this.bgSound);
			elems.push("fightBgSound" + ":" + this.fightBgSound);
			elems.push("weather" + ":" + this.weather);
			elems.push("fightMaplds" + ":" + this.fightMaplds);
			elems.push("needLevel" + ":" + this.needLevel);
			elems.push("campId" + ":" + this.campId);
			return "MapBase{" + elems.join(",") + "}";
		}
	}
}