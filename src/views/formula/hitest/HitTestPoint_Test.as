package views.formula.hitest
{
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.text.TextField;
	
	/**
	 * 检测显示对象是否与 x 和 y 参数指定的点碰撞
	 * 
	 */
	public class HitTestPoint_Test extends MovieClip
	{
		private var circle:Shape;
		private var msg:TextField;
		
		public function HitTestPoint_Test()
		{
			circle = new Shape();
			circle.graphics.beginFill(0x0000FF, 0.5);
			circle.graphics.drawCircle(0, 0, 40);
			circle.x = 100;
			circle.y = 100;
			this.addChild(circle);
			
			msg = new TextField();
			msg.multiline = true;
			msg.height = 50;
			msg.selectable = false;
			addChild(msg);
			
			this.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}
		
		private function enterFrameHandler(e:Event):void
		{
			if(circle.hitTestPoint(mouseX, mouseY, true))		//以实际图像为准（碰到实际图像才为true)
				msg.text = "hit";
			else
				msg.text = "no hit";
			
			if(circle.hitTestPoint(mouseX, mouseY, false))		//以边框为准（碰到边框就为true)
				msg.text += "\nhit";
			else
				msg.text += "\nno hit";
			
			msg.x = mouseX + 20;
			msg.y = mouseY;
		}
	}
}