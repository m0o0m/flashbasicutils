package views.lvjing.yanhua
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.ConvolutionFilter;
	import flash.geom.Point;

	/**
	 *将使用movieclip处理的烟花效果转换为bitmap位图烟花; 
	 * @author Administrator
	 * 
	 */
	public class Yanhua extends AbstractLvjing
	{
		private var dotArr:Array = new Array();
		private var BitmapData0:BitmapData = new BitmapData(550, 400, false, 0x0);
		private var cf:ConvolutionFilter;
		public function Yanhua(con:MovieClip)
		{
			super(con);
			
			var Bitmap0:Bitmap = new Bitmap(BitmapData0);
			_con.addChild(Bitmap0);
			
			_con.addEventListener(MouseEvent.MOUSE_DOWN,mouse_down);
			
			cf = new ConvolutionFilter(3, 3, [1, 1, 1, 1, 32, 1, 1, 1, 1], 40,0);
			_con.addEventListener(Event.ENTER_FRAME,enter_frame);
			
		}
		private function mouse_down(evt:MouseEvent):void {
			var color:Number = 0xff000000+int(Math.random()*0xffffff);
			for (var i:Number = 0; i<500; i++) {
				var v:Number = Math.random()*10;
				var a:Number =Math.random()*Math.PI*2;
				var xx:Number = v*Math.cos(a)+_con.mouseX;
				var yy:Number = v*Math.sin(a)+_con.mouseY;
				var mouseP:Point=new Point(_con.mouseX,_con.mouseY);
				if (Math.random()>0.6) {
					var cc:Number = 0xffffffff;
				} else {
					cc= color;
				}
				dotArr.push([xx, yy, v*Math.cos(a), v*Math.sin(a), cc,mouseP]);
			}
		}
		private function enter_frame(evt:Event):void {
			for (var i:Number = 0; i<dotArr.length; i++) {
				BitmapData0.setPixel32(dotArr[i][0],dotArr[i][1],dotArr[i][4]);
				dotArr[i][0] += dotArr[i][2]*Math.random();
				dotArr[i][1] += dotArr[i][3]*Math.random();
				var dotP:Point=new Point(dotArr[i][0],dotArr[i][1]);
				var b1:Boolean=Point.distance(dotP,dotArr[i][5])>80;
				var b2:Boolean=Math.abs(dotArr[i][2])+Math.abs(dotArr[i][3])<0.5;
				if ((b1 || b2) && Math.random()>0.9) {
					dotArr.splice(i,1);
				}
			}
			BitmapData0.applyFilter(BitmapData0.clone(),BitmapData0.rect,new Point(0, 0),cf);
		}
		override public function reset():void
		{
			_con.removeEventListener(MouseEvent.MOUSE_DOWN,mouse_down);
			_con.removeEventListener(Event.ENTER_FRAME,enter_frame);
			_con = null;
		}
	}
}