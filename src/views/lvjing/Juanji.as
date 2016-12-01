package views.lvjing
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.filters.ConvolutionFilter;
	import flash.geom.Point;
	import views.lvjing.yanhua.AbstractLvjing;

	/**
	 *卷积定理
	 * https://www.zhihu.com/question/22298352
	 * 输入时,瞬间输入; 输入间隔,规定单位时间;
	 *  y[0] = i, y[1] = j, x[2]=k
	 * 在规定的单位时间中,y的同位置衰减值;
	 * 	y[0] = a, y[1] = b, y[2]=c
	 * 
	 * x[n] * y[n]：计算出 y同位置,不同单位时间的输出值;
	 * t1=ai;
	 * t2=bi+aj;
	 * t3=ci+bj+ak;
	 * t4=cj+bk;
	 * t5=ck;
	 * 
	 * @author Administrator
	 * 
	 */
	public class Juanji extends AbstractLvjing
	{
		public var cf:ConvolutionFilter = new ConvolutionFilter(3, 3, [1, 1, 1, 1, 32, 1, 1, 1, 1], 40,0);
		public function Juanji(con:MovieClip)
		{
			super(con);
			init();
		}
		private var BitmapData0:BitmapData;
		private function init():void
		{
//			if(!BitmapData0)
			{
				BitmapData0 = new BitmapData(_con.mc1.width,_con.mc1.height);
				BitmapData0.draw(_con.mc1);
				var Bitmap0:Bitmap = new Bitmap(BitmapData0);
				_con.scene_mc.addChild(Bitmap0);
			}
			if(!_con.scene_mc.hasEventListener(Event.ENTER_FRAME))_con.scene_mc.addEventListener(Event.ENTER_FRAME,enter_frame);
		}
		
		protected function enter_frame(event:Event):void
		{
			// TODO Auto-generated method stub
			BitmapData0.applyFilter(BitmapData0.clone(),BitmapData0.rect,new Point(0, 0),cf);
		}
		
		override public function reset():void
		{
			_con.scene_mc.removeEventListener(Event.ENTER_FRAME,enter_frame);
		}
	}
}