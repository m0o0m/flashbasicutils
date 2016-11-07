package views.formula.hitest
{
	import flash.geom.Point;
	import flash.geom.Rectangle;

	public class RectangleTest
	{
		public function RectangleTest()
		{
			var rect1:Rectangle = new Rectangle(0, 0, 100, 100);
			var rect2:Rectangle = new Rectangle();
			rect2.x = 10;
			rect2.y = 10;
			rect2.size = new Point(20, 20);
			var rect3:Rectangle = rect1.clone();
			rect3.copyFrom(rect2);
			rect3.setTo(30, 30, 50, 50);
			rect3.setEmpty();
			
			//a.矩形是否为空 
			rect1.isEmpty();
			
			//b.矩形内是否包含某点 
			rect1.contains(1, 2); 
			rect1.containsPoint(new Point(1, 2));
			
			//c.矩形是否相等 
			rect1.equals(rect2);
			
			//d.是否完全覆盖某矩形 
			rect1.containsRect(rect2);
			
			//e.判断矩形是否相交 
			rect1.intersects(rect2);
			
			//f.移动矩形 
			var dx:Number = 0;
			var dy:Number = 0;
			rect2.offset(dx, dy); 
			//相当于 
			rect2.offsetPoint(new Point(dx, dy)); 
			//相当于 
			rect2.x += dx; 
			rect2.y += dy;
			
			//g.扩展矩形的大小 
			rect2.inflate(dx, dy); 
			//相当于 
			rect2.inflatePoint(new Point(dx, dy)); 
			//相当于 
			rect2.x -= dx; 
			rect2.width += 2 * dx; 
			rect2.y -= dy; 
			rect2.width += 2 * dy;
			
			//h.计算两矩形的相交矩形和相合矩形 
			var rect4:Rectangle = rect2.intersection(rect3);
			var rect5:Rectangle = rect2.union(rect3);
		}
	}
}