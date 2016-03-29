package mymap.elements
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import com.wg.scene.elments.SeaMapSceneEntity;

	public class BgElement extends SeaMapSceneEntity
	{
		private var maxwidth:int = 2700;
		private var maxheight:int = 1800;
		public function BgElement()
		{
			super();
			
		}
		override protected function createDisplay():DisplayObject
		{
			//			super.createDisplay();
			var sprite:Sprite = new Sprite();
			sprite.x = 0;
			sprite.y = 0;
			sprite.graphics.beginFill(0xCCCCff,1);
			sprite.graphics.drawRect(0,0,59,59);
			sprite.graphics.endFill();
			
			var text:TextField = new TextField();
		/*	var format:TextFormat = new TextFormat();
			format.size = 10;
			text.setTextFormat(format);*/
			text.wordWrap = true;
			text.text = uid.substr(8,10);
			sprite.addChild(text);
			/*var point:Point = new Point();
				for (var k:int = 0; k < 60; k++) 
				{
					point.y = k*30;
					for (var j:int = 0; j < 90; j++) 
					{
						point.x = j*30;
						sprite.graphics.beginFill(0xCCCCff,1);
						sprite.graphics.drawRect(point.x,point.y,29,29);
						sprite.graphics.endFill();
					}
					
				}*/
				
			
			return sprite;
		}
	}
}