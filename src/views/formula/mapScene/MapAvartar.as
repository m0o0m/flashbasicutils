package views.formula.mapScene
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.Point;
	
	public class MapAvartar extends Sprite
	{
		private var _inMapPositionX:Number ;
		private var _content:MovieClip;
		private var _inMapPositionY:Number;
		public function MapAvartar(con:MovieClip)
		{
			_content = con;
			_inMapPositionX = con.x;
			_inMapPositionY = con.y;
			
			con.x = 0;
			con.y = 0;
				
			this.addChild(con);
			super();
		}
		
		public function get inMapPositionY():Number
		{
			return _inMapPositionY;
		}

		public function get inMapPositionX():Number
		{
			return _inMapPositionX;
		}

		public function moveTo(mapx:Number,mapy:Number):void
		{
			this.x = mapx+_inMapPositionX;
			this.y = mapy+_inMapPositionY;
		}
	}
}