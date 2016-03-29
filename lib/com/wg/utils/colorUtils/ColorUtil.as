package com.wg.utils.colorUtils
{
	/**
	 * as3颜色操作工具类集合
	 
	 * version v20121029.0.1  <br/>
	 * date 2012.10.29  <br/>
	 *   <br/>
	 * */
	public class ColorUtil
	{
		public function ColorUtil()
		{
			
		}
		
		/**
		 * 颜色提取
		 * */
		public static function getColor():void
		{
//			red = color24 >> 16;
//			green = color24 >> 8 & 0xFF;
//			blue = color24 & 0xFF;
//			alpha = color32 >> 24;
//			red = color32 >> 16 & 0xFF;
//			green = color32 >> 8 & 0xFF;
//			blue = color232 & 0xFF;
		}
		
		/**
		 * 按位计算得到颜色值
		 * */
		public static function getColorValues():void
		{
//			color24 = red << 16 | green << 8 | blue;
//			color32 = alpha << 24 | red << 16 | green << 8 | blue;
		}
		
		/**
		 * 颜色运算得到透明值
		 * */
		public static function getColorAlpha():void
		{
			var t:uint=0x77ff8877
			var s:uint=0xff000000
			var h:uint=t&s
			var m:uint=h>>>24
			trace(m)
		}
		/** Returns the alpha part of an ARGB color (0 - 255). */
		public static function getAlpha(color:uint):int { return (color >> 24) & 0xff; }
		
		/** Returns the red part of an (A)RGB color (0 - 255). */
		public static function getRed(color:uint):int   { return (color >> 16) & 0xff; }
		
		/** Returns the green part of an (A)RGB color (0 - 255). */
		public static function getGreen(color:uint):int { return (color >>  8) & 0xff; }
		
		/** Returns the blue part of an (A)RGB color (0 - 255). */
		public static function getBlue(color:uint):int  { return  color        & 0xff; }
		
		/** Creates an RGB color, stored in an unsigned integer. Channels are expected
		 *  in the range 0 - 255. */
		public static function rgbToColor(red:int, green:int, blue:int):uint
		{
			return (red << 16) | (green << 8) | blue;
		}
	}
}