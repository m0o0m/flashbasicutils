package com.wg.assets
{
	import flash.media.Video;
	import flash.text.TextField;
	import flash.text.TextFormat;

	public class TextFieldUtils
	{
		public static var TEXT_FONT_NAME:String = "";
		public static var TEXT_FONT_SIZE:int = 12;
		
		public static var NUMBER_FONT_NAME:String = "";
		public static var NUMBER_FONT_SIZE:int = 12;
		public static const QUEST_TITLE_SIZE:int = 12;
		
		public static function setText(textField:TextField, text:String, number:Boolean = false, font:String = "", size:int = 0):void
		{
			if(textField == null) return;
			
			var textFormat:TextFormat;
			
			var textFont:String;
			var textSize:int;
			
			if(textField.defaultTextFormat != null)
			{
				textFormat = createTextFormat(textField.defaultTextFormat);
			}else{
				textFormat = new TextFormat();
			}
			
			if(!number){
				textFont = TEXT_FONT_NAME;
				textSize = TEXT_FONT_SIZE;
			}else{
				textFont = NUMBER_FONT_NAME;
				textSize = NUMBER_FONT_SIZE;
			}
			
			if(font != "") textFont = font;
			if(size != 0) textSize = size;
			
			textFormat.font = textFont;
			textFormat.size = textSize;
			
			textField.defaultTextFormat = textFormat;
			
			textField.text = text;
		}
		
		public static function setTextColor(textField:TextField,color:int):void
		{
			var textFormat:TextFormat = new TextFormat();
			textFormat.color = color;
			textField.setTextFormat(textFormat);
		}
		public static function setHtmlTextWidthBold(textField:TextField, htmlText:String, number:Boolean = false, font:String = "", size:int = 0):void
		{
			htmlText = "<b>"+htmlText+"</b>";
			setHtmlText(textField,htmlText,number,font,size);
		}
		
		public static function setHtmlText(textField:TextField, htmlText:String, number:Boolean = false, font:String = "", size:int = 0):void
		{
			if(textField == null) return;
			
			var textFont:String;
			var textSize:int;
			
			if(!number){
				textFont = TEXT_FONT_NAME;
				textSize = TEXT_FONT_SIZE;
			}else{
				textFont = NUMBER_FONT_NAME;
				textSize = NUMBER_FONT_SIZE;
			}
			
			if(font != "") textFont = font;
			if(size != 0) textSize = size;
//			textField.htmlText = "<font face = '" + textFont + "' size = '" + textSize + "'>" + htmlText + "</font>";
			
//			var regExp:RegExp = /\w+(\d+)\w+/gi;
//			
//			htmlText = htmlText.replace(regExp, "<b>$1</b>");
			
			textField.htmlText = "<font face = \"" + textFont + "\" size = \"" + textSize + "\">" + htmlText + "</font>";
		}
		
		private static function createTextFormat(textFormat:TextFormat):TextFormat
		{
			var newFormat:TextFormat = new TextFormat();
			
			for(var key:String in textFormat)
			{
				newFormat[key] = textFormat[key];
			}
			
			return newFormat;
		}
	}
}