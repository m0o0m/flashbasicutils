package views.tip
{
	import com.assist.utils.TextFieldUtils;
	import com.wg.assets.TextFieldUtils;
	
	/**
	 * ...
	 * @author Jason
	 */
	public class HtmlText extends Object 
	{
		public static const Yellow:uint = 16776960;
		public static const Red:uint = 16711680;
		public static const White:uint = 16777215;
		public static const Green:uint = 65280;
		public static const Blue:uint = 255;
		public static const Orange:uint = 16225309;
		
		public function HtmlText() 
		{
			
		}
		
		public static function yellow(param1:String) : String
		{
			return format(param1, Yellow);
		}
		
		public static function red(param1:String) : String
		{
			return format(param1, Red);
		}
		
		public static function white(param1:String) : String
		{
			return format(param1, White);
		}
		
		public static function green(param1:String) : String
		{
			return format(param1, Green);
		}
		
		public static function blue(param1:String) : String
		{
			return format(param1, Blue);
		}
		
		public static function orange(param1:String) : String
		{
			return format(param1, Orange);
		}
		
		public static function formatSizeColor(p_value:String, p_size:int, p_color:uint):String{
			return format(p_value, p_color, p_size);
		}
		
		public static function format(value:String, color:uint = 0, size:uint = 12, font:String = "Verdana", isbold:Boolean = false, isItalic:Boolean = false, isUnderline:Boolean = false, isHref:String = null, align:String = null) : String
		{
			if(size == 12){
				size = TextFieldUtils.TEXT_FONT_SIZE;
			}
			font = TextFieldUtils.TEXT_FONT_NAME;
			
			if (isbold)
			{
				value = "<b>" + value + "</b>";
			}
			if (isItalic)
			{
				value = "<i>" + value + "</i>";
			}
			if (isUnderline)
			{
				value = "<u>" + value + "</u>";
			}
			var _loc_10:String = "";
			if (font)
			{
				_loc_10 = _loc_10 + (" face=\"" + font + "\"");
			}
			if (size > 0)
			{
				_loc_10 = _loc_10 + (" size=\"" + size + "\"");
			}
			_loc_10 = _loc_10 + (" color=\"#" + color.toString(16) + "\"");
			value = "<font" + _loc_10 + ">" + value + "</font>";
			if (isHref)
			{
				value = "<a href=\"" + isHref + "\" target=\"_blank\">" + value + "</a>";
			}
			if (align)
			{
				value = "<p align=\"" + align + "\">" + value + "</p>";
			}
			return value;
		}
		
	}
	
}
