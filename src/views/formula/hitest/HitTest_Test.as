package views.formula.hitest
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.text.TextField;
	
	public class HitTest_Test extends MovieClip
	{
		private var bm1:Bitmap;
		private var bm2:Bitmap;
		private var msg:TextField;
		
		/**
		 *flash.display.BitmapData.hitTest(firstPoint:Point, firstAlphaThreshold:uint, secondObject:Object, secondBitmapDataPoint:Point=null, secondAlphaThreshold:uint=1):Boolean    
注意事项：

1、firstPoint一般为第一个bitmap的左上角点，secondBitmapDataPoint一般为第二个bitmap的左上角点，它两必须以同一个坐标系为参照；

2、firstAlphaThreshold表示第一个bitmap中参与碰撞检测的像素的最小alpha值，也就是说第一个bitmap中的像素点，只能当它的alpha值大于等于firstAlphaThreshold时才会参与碰撞检测；

3、secondAlphaThreshold表示第二个bitmap中参与碰撞检测的像素的最小alpha值，也就是说第二个bitmap中的像素点，只能当它的alpha值大于等于firstAlphaThreshold时才会参与碰撞检测；

4、secondObject除了BitmapData 外，还可以是一个 Rectangle、Point或Bitmap。 
		 * 
		 */
		public function HitTest_Test()
		{
			var sp1:Sprite = new Sprite();
			sp1.graphics.beginFill(0xff0000, 0.5);
			sp1.graphics.drawCircle(50, 50, 50);
			sp1.graphics.endFill();
			var bmd1:BitmapData = new BitmapData(sp1.width, sp1.height, true, 0);
			bmd1.draw(sp1);
			bm1 = new Bitmap(bmd1);
			bm1.x = 150;
			bm1.y = 150;
			this.addChild(bm1);
			
			var sp2:Sprite = new Sprite();
			sp2.graphics.beginFill(0, 0.8);
			sp2.graphics.drawCircle(10, 10, 10);
			var bmd2:BitmapData = new BitmapData(sp2.width, sp2.height, true, 0);
			bmd2.draw(sp2);
			bm2 = new Bitmap(bmd2);
			this.addChild(bm2);
			
			msg = new TextField();
			msg.selectable = false;
			addChild(msg);
			
			this.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}
		
		private function enterFrameHandler(e:Event):void
		{
			bm2.x = mouseX-0.5*bm2.width;
			bm2.y = mouseY-0.5*bm2.height;
			
			msg.x = mouseX+20;
			msg.y = mouseY;
			
			if (bm1.bitmapData.hitTest(new Point(bm1.x, bm1.y), 127, bm2.bitmapData, new Point(bm2.x, bm2.y), 128))
			{
				msg.text ="hit";
			}
			else
			{
				msg.text ="no hit";
			}
		}
	}
}