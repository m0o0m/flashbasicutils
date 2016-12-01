package  views.lvjing.yanhua3.geom
{
	public class ColorUtil
	{
		/**
		 * 通过通道随机获取随机性更良好的色彩值
		 * @return uint 一个随机的色彩值
		 **/
	    public static function getRandomColor():uint
		{
			var _rgbObject:RGBColor = new RGBColor();
			_rgbObject.r = Math.random() * 255;
			_rgbObject.g = Math.random() * 255;
			_rgbObject.b = Math.random() * 255;
			return getColorFromRGBObject(_rgbObject);
		}
		
		/**
		 * 根据颜色值返回一个包含r,g,b三个属性的对象
		 * @param color uint 传入的颜色值
		 * @return RGBColor 包含RGB三个属性的对象
		 *
		 **/
		public static function getRGBObjectFromColor(color:uint):RGBColor
		{
			var _rgbObject:RGBColor = new RGBColor();
			_rgbObject.a = (color >> 24) & 0xFF;
			//17~24位代表红色
			_rgbObject.r = (color >> 16) & 0xFF;
			//9~16位代表红色
			_rgbObject.g = (color >> 8) & 0xFF;
			//1~8位代表蓝色
			_rgbObject.b = color & 0xFF;
			return _rgbObject;
		}
		
		/**
		 * 根据传入的RGB对象获得一个颜色值
		 * @param object 传入的RGB对象
		 * @return uint 颜色值
		 *
		 **/
		public static function getColorFromRGBObject(object:Object):uint
		{
			return (object.a << 24) | (object.r << 16) | (object.g << 8) | (object.b);
		}
		
		/**
		 * 根据传入的RGB对象获得一个颜色值
		 * @param object 传入的RGB对象
		 * @return uint 颜色值
		 *
		 **/
		public static function getColorFromRGBA(r:uint, g:uint, b:uint, a:uint = 0):uint
		{
			return (a << 24) | (r << 16) | (g << 8) | (b);
		}
	}
}