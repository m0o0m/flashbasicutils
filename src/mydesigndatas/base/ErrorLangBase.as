package  mydesigndatas.base	
{	

	public class ErrorLangBase	
	{	
		public var errno:uint = 0;	
		public var lang:String = "";	

		public function ErrorLangBase(initParams:*=null)
		{
			for (var i:String in initParams) {			
				this[i] = initParams[i];
			}

		}
		
		public function toString() : String
		{
			var elems:Array = [];
			elems.push("errno" + ":" + this.errno);
			elems.push("lang" + ":" + this.lang);
			return "ErrorLangBase{" + elems.join(",") + "}";
		}
	}
}