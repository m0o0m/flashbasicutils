package mydesigndatas.logic
{
	
	import mydesigndatas.base.MapBase;

	public class Map extends MapBase	
	{
		private var _uri:URI;

		public function Map(initParams:*, uri:URI)
		{
			super(initParams);
			_uri = uri;
		}
	}
}
