package views.lvjing.colors
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.ColorTransform;
	
	import views.lvjing.yanhua.AbstractLvjing;
	
	/**
	 *https://en.wikipedia.org/wiki/HSL_and_HSV#Converting_to_RGB  hsl hsv 与rgb的转变;
	 * h:色相	[0-360]度	 	rgb颜色中的两个颜色之间的数值搭配 
	 * s:饱和度	[0-100]百分比   	变化方式:取当前颜色中rgb中的最大值,按照算法改变剩下的值(当s在减小时,剩下的值若有=0的,那么s=0,停止改变;当s在增大时,剩下的 值都变为rgb中最大值时,s=100,停止改变);
	 * b:明亮度   	[0-100]百分比		变化方式:当b在减小时,rgb值按算法减少,在rgb均为0时,b=0,停止变化;当b在增大时,rgb值按算法增大,当其中一个值变为255时,b=100,停止改变;
	 * @author Administrator
	 * 
	 */
	public class ColorTest extends AbstractLvjing
	{
		private var BitmapData0:BitmapData;
		private var myColorTransform:ColorTransform;
		public function ColorTest(con:MovieClip)
		{
			super(con);
			myColorTransform = new ColorTransform();
			init();
		}
		
		private function init():void
		{
			// TODO Auto Generated method stub
			
			//changeColor(Bitmap0);
			var shapcolor:ShapeColorTransformTest = new ShapeColorTransformTest();
			_con.scene_mc.addChild(shapcolor);
		}
		
		private function changeColor():void
		{
			BitmapData0 = new BitmapData(_con.mc1.width,_con.mc1.height);
			BitmapData0.draw(_con.mc1);
			var Bitmap0:Bitmap = new Bitmap(BitmapData0);
			_con.scene_mc.addChild(Bitmap0);
			//myColorTransform.color = 0xFFFF00;
			//效果同下
			/*
			 *颜色计算方式 : newrgbcolor  = oldrgbcolor* Multiplier+ offset
			在经过倍成和偏移计算之后的数值,最后在0--255之间取值;
			*/
			myColorTransform.redMultiplier = myColorTransform.greenMultiplier = myColorTransform.blueMultiplier = 0;
			myColorTransform.redOffset = 255; 
			myColorTransform.greenOffset = 255;
			myColorTransform.blueOffset = 0;
			
			//将显示对象的所有像素点变为同一个颜色值;
			//改变颜色 需要建立新的颜色转换对象,然后赋值给显示对象的对应属性;
			Bitmap0.transform.colorTransform = myColorTransform;
		}
		
		override public function reset():void
		{
			
		}
	}
}