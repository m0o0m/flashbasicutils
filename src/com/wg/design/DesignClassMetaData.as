package com.wg.design 
{	
	import com.wg.error.Err;
	
	import mydesigndatas.logic.ErrorLang;
	import mydesigndatas.logic.Map;
	import mydesigndatas.logic.Npc;


	public class DesignClassMetaData
	{	
		private var _metaData:Object = {};
		
		public function DesignClassMetaData()
		{	
			_metaData[ErrorLang] = {"name": "ErrorLang", "pk": ['errno']};
			_metaData[Npc] = {"name": "Npc", "pk": ['id']};
			_metaData[Map] = {"name": "Map", "pk": ['id']};
		}
		
		public function getMetaData(designClass:Class) : Object
		{		
			var metaData:* = _metaData[designClass];
			if (metaData == null) {			
				Err.occur(Errno.CLIENT_ERROR, {
					desc: "design class [" + designClass + "] meta data not found"
				});
				return null;
			}
			return metaData;
		}
	}
}
