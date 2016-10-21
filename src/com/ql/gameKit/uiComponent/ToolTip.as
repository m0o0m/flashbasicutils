package com.ql.gameKit.uiComponent
{
    import flash.display.*;
    import flash.text.*;

    public class ToolTip extends Sprite
    {
        private var _tips:String;
        private var _txt:TextField;
        private var _txtFormat:TextFormat;
        private var _bgColor:uint;
        private var _bgAlpha:Number;
        private var _bgBorderColor:uint;
        private var _bgBorderAlpha:Number;

        public function ToolTip()
        {
            mouseChildren = false;
            mouseEnabled = false;
            return;
        }// end function

        public function init(message:String, txtFormat:TextFormat, bgColor:uint = 0, bgAlpha:Number = 0.5, bgBorderColor:uint = 14737632, bgBorderAlpha:Number = 0.5) : void
        {
            if (!_txt)
            {
                _txt = new TextField();
                _txt.defaultTextFormat = txtFormat;
                _txt.autoSize = "left";
                addChild(_txt);
            }
            _txtFormat = txtFormat;
            _bgColor = bgColor;
            _bgAlpha = bgAlpha;
            _bgBorderColor = bgBorderColor;
            _bgBorderAlpha = bgBorderAlpha;
            tips = message;
            return;
        }// end function

        public function get tips() : String
        {
            return _tips;
        }// end function

        public function set tips(value:String) : void
        {
            var _loc_3:Number = NaN;
            var _loc_2:Number = NaN;
            if (_tips != value)
            {
                _tips = value;
                _txt.text = value;
                _loc_3 = _txt.textHeight + 10;
                _loc_2 = _txt.textWidth + 14;
                _txt.x = _loc_2 * 0.5 - _txt.width * 0.5;
                _txt.y = _loc_3 * 0.5 - _txt.height * 0.5;
                graphics.clear();
                graphics.lineStyle(1, _bgBorderColor, _bgBorderAlpha);
                graphics.beginFill(_bgColor, _bgAlpha);
                graphics.drawRoundRect(0, 0, _loc_2, _loc_3, 4, 4);
                graphics.endFill();
            }
            return;
        }// end function

        public static function create(message:String, fontSize:int = 12, fontColor:uint = 16777215, bgColor:uint = 0, bgAlpha:Number = 0.5, bgBorderColor:uint = 14737632, bgBorderAlpha:Number = 0.5) : ToolTip
        {
            var _loc_8:* = new TextFormat("_sans", fontSize, fontColor);
            new TextFormat("_sans", fontSize, fontColor).align = "left";
            var _loc_9:* = new ToolTip();
			_loc_9.init(message, _loc_8, bgColor, bgAlpha, bgBorderColor, bgBorderAlpha);
            return _loc_9;
        }// end function

    }
}
