package views.formula.hitest
{
	import flash.geom.Point;

	public class Pointtest
	{
//		public static function main():void
		public function Pointtest()
		{
			var pt1:Point = new Point(10, 20);
			var pt2:Point = new Point();
			pt2.x = 30;
			pt2.y = 40;
			var pt3:Point = pt1.clone();
			var pt4:Point = new Point();
			pt4.copyFrom(pt2);
			pt4.setTo(100,100);
			//a.比较两点是否相等 
			trace("equals:",pt1.equals(pt2));
			//b.两点和 
			var pt5:Point = pt4.add(pt1);
			trace("add:",pt5);
			//c.两点差 
			var pt6:Point = pt4.subtract(pt1);
			trace("subtract:",pt6);
			//d.移动一定位置 
			pt4.offset(2,2);
			//e.计算点到原点(0,0)距离 
			var len:Number = pt1.length;
			//f.计算两点距离 
			var distance:Number = Point.distance(pt1, pt2);
			//g.将极坐标转变为普通(笛卡尔)坐标 
			var pt7:Point=Point.polar(50,0.5); 
			//相当于 
			pt7.x = 50*Math.cos(0.5); 
			pt7.y = 50*Math.sin(0.5);
			
			//h.按线段长度缩放坐标 
			pt6.normalize(len); 
			//相当于 
			var oldlen:Number = pt6.length; 
			pt6.x = pt6.x * len / oldlen; 
			pt6.y = pt6.y * len / oldlen;
			
			//i.根据给定的比例来计算两点间的一点 
			var pt8:Point = Point.interpolate(pt1, pt2, 0.7); 
			//相当于 
			pt8.x = pt1.x * 0.7 + pt2.x * 0.3; 
			pt8.y = pt1.y * 0.7 + pt2.y * 0.3; 
		}
	}
}