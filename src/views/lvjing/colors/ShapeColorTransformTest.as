package views.lvjing.colors
{
	import flash.display.Sprite;
	import flash.geom.ColorTransform;
	import flash.display.Shape;
	
	/**
	 *http://bbs.9ria.com/blog-347563-21861.html 图像编程 
	 * @author Administrator
	 * 
	 */
	public class ShapeColorTransformTest extends Sprite
	{
		private var _testSprite_src:Sprite; //用于测试的显示对象（变换前）
		private var _testSprite_dst:Sprite;  //用于测试的显示对象（变换后）
		private var _myColorTransform:ColorTransform;  //颜色转换对象
		public function ShapeColorTransformTest(){
			init();
		}
		private function init():void{
			_testSprite_src = getTestSprite();
			addChild(_testSprite_src);
			_testSprite_dst = getTestSprite();   
			_testSprite_dst.x = 200;
			addChild(_testSprite_dst);
			applyTransform();
		}
		//创建用于测试的显示对象
		private function getTestSprite():Sprite{
			var _testSprite:Sprite = new Sprite();
			var _shape1:Shape = new Shape();  //添加一个黑色的矩形底
			_shape1.graphics.beginFill(0x000000);
			_shape1.graphics.drawRect(40, 30, 170, 290);
			_shape1.graphics.endFill();
			_testSprite.addChild(_shape1);
			/*依次添加颜色分别为暗蓝，暗红，暗绿和纯白的4个圆*/
			_testSprite.addChild(new Circle(50, 0x0000CC, 100, 200,1, "add"));
			_testSprite.addChild(new Circle(50, 0xCC0000, 150, 200, 1,"add"));
			_testSprite.addChild(new Circle(50, 0x00CC00, 125, 250, 1,"add"));
			_testSprite.addChild(new Circle(50, 0xFFFFFF, 125, 100, 1, "add"));
				return _testSprite;
				}
		private function applyTransform():void{
			_myColorTransform = _testSprite_dst.transform.colorTransform; //初始化颜色变换对象（从显示对象里获取）
			_myColorTransform.redMultiplier = 1.5;
			_testSprite_dst.transform.colorTransform = _myColorTransform; //应用到显示对象上（变换后必须重新赋值，否则变换效果不起作用，详情可查阅帮助文档）
		}
	}
}