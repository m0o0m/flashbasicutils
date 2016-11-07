package  com.wg.bitmapdataUtils
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BitmapDataChannel;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	/**
	 *随机纹理效果制作 
	 * @author Administrator
	 * http://bbs.9ria.com/thread-281361-1-1.html 柏林噪音文章
	 * http://randomfractals.com/blog/2008/10/16/interactive-bitmapdata-perlin-noise-explorer/	各种强大的随机工具
	 */
	public class RandomWenli extends MovieClip
	{
		public function RandomWenli() 
		{
			var bigBitmapData:BitmapData = new BitmapData(300, 400);
			var smallBitmapData:BitmapData=new BitmapData(300,200);
			var rect:Rectangle=new Rectangle(0,0,300,200);
			var point:Point=new Point(0,0);
			var seed:Number = Math.floor(Math.random() * 100);
			var channels:uint = BitmapDataChannel.GREEN | BitmapDataChannel.RED|BitmapDataChannel.BLUE;
			smallBitmapData.perlinNoise(150, 100,6, seed, true, true,channels);
			//开始将smallBitmapData的数据平铺到bigBitmapData中以便进行无缝滚动
			bigBitmapData.copyPixels(smallBitmapData,rect,point);
			point.y=200;
			bigBitmapData.copyPixels(smallBitmapData,rect,point);
			//结束将smallBitmapData的数据平铺到bigBitmapData中以便进行无缝滚动
			point.y=0;
			var myBitmap:Bitmap= new Bitmap(smallBitmapData);
			addChild(myBitmap);
			myBitmap.width=600;
			myBitmap.height=300;
			addEventListener(Event.ENTER_FRAME, scrollBitmap);
			function scrollBitmap(event:Event):void {
				rect.y+=2;
				if (rect.y>=200) {
					rect.y=0;
				}
				smallBitmapData.copyPixels(bigBitmapData,rect,point);
			}
		}
	}
}