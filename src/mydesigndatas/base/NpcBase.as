package mydesigndatas.base
{	

	public class NpcBase	
	{	
		public var id:uint = 0;	
		public var name:String = "";	
		public var type:uint = 0;	
		public var campId:uint = 0;	
		public var desc:String = "";	
		public var modelUri:String = "";	
		public var iconUri:String = "";	
		public var functions:Array = [];	
		public var talks:Array = [];	
		public var mapID:uint = 0;	
		public var smallMapIcon:uint = 0;	

		public function NpcBase(initParams:*=null)
		{
			for (var i:String in initParams) {			
				this[i] = initParams[i];
			}

			var functions_:Array = [];
			for (var index_functions:uint = 0; index_functions < this.functions.length; ++index_functions) {
				functions_.push(this.functions[index_functions]);
			}
			this.functions = functions_;
			
			var talks_:Array = [];
			for (var index_talks:uint = 0; index_talks < this.talks.length; ++index_talks) {
				talks_.push(this.talks[index_talks]);
			}
			this.talks = talks_;
			
		}
		
		public function toString() : String
		{
			var elems:Array = [];
			elems.push("id" + ":" + this.id);
			elems.push("name" + ":" + this.name);
			elems.push("type" + ":" + this.type);
			elems.push("campId" + ":" + this.campId);
			elems.push("desc" + ":" + this.desc);
			elems.push("modelUri" + ":" + this.modelUri);
			elems.push("iconUri" + ":" + this.iconUri);
			elems.push("functions" + ":" + this.functions);
			elems.push("talks" + ":" + this.talks);
			elems.push("mapID" + ":" + this.mapID);
			elems.push("smallMapIcon" + ":" + this.smallMapIcon);
			return "NpcBase{" + elems.join(",") + "}";
		}
	}
}