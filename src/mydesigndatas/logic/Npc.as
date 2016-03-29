package mydesigndatas.logic
{
	import mydesigndatas.base.NpcBase;

	public class Npc extends NpcBase	
	{
		private var _uri:URI;

		public function Npc(initParams:*, uri:URI)
		{
			super(initParams);
			_uri = uri;
		}
		
		
		internal var m_mapName:String = "";

		
		private var _subType:int = -1;
		public function get supType():int
		{
			if(_subType == -1)
			{
				var typeStr:String = functions[0];
				
				if(typeStr.length>0)
				{
					_subType = int(typeStr.split("-")[0]);
				}
			}
			
			return _subType;
		}
	}
}
