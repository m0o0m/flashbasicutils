package views.formula.hitest
{
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.text.TextField;
	
	/**
	 * 最粗糙的碰撞：只要两个可视对象（DisplayObject)的边框重叠，就认为它两相撞
	 * 
	 */
	public class HitTestObject_test extends MovieClip
	{
		private var circle1:Shape;
		private var circle2:Shape;
		private var msg:TextField;
		
		public function HitTestObject_test()
		{
			circle1 = new Shape();
			circle1.graphics.beginFill(0xFF0000);
			circle1.graphics.drawCircle(0, 0, 40);
			circle1.x = 100;
			circle1.y = 100;
			addChild(circle1);
			
			circle2 = new Shape();
			circle2.graphics.beginFill(0x00FF00);
			circle2.graphics.drawCircle(0, 0, 40);
			circle2.x = 50;
			addChild(circle2);
			
			msg = new TextField();
			msg.selectable = false;
			addChild(msg);
			
			this.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}
		
		private function enterFrameHandler(e:Event):void
		{
			circle2.x = mouseX;
			circle2.y = mouseY;
			
			if(circle1.hitTestObject(circle2))
				msg.text = "hit";
			else
				msg.text = "no hit";
			
			msg.x = mouseX + 20;
			msg.y = mouseY;
		}
	}
}