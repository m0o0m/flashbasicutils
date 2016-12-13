package views.lvjing.colors
{
	import flash.display.BlendMode;
	import flash.display.Sprite;

	public class Circle extends Sprite{
		//为节省本书篇幅，我把x，y，alpha, blendMode这些基本属性都封装到Circle类里面了，项目开发中不推荐这么做
		public function Circle(radius:Number = 50, color:uint = 0x000000, x:Number = 0, y:Number = 0, alpha:Number = 1, blendMode:String = BlendMode.NORMAL){
			super();
			this.x = x; this.y = y; 
			//http://www.cnblogs.com/jacku/articles/2287712.html 混合模式的介绍
			//BlendMode 类中的一个值，用于指定要使用的混合模式。 内部绘制位图的方法有两种。 如果启用了混合模式或外部剪辑遮罩，则将通过向矢量渲染器添加有位图填充的正方形来绘制位图。
			//与下面的显示对象进行颜色混合,与上面的无关;
			this.blendMode = blendMode;
			graphics.beginFill(color, alpha);
			graphics.drawCircle(0, 0, radius);
			graphics.endFill(); 
		}
	}
}