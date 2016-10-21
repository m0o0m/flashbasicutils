package com.ql.gameKit.utils
{
    import flash.globalization.*;

    public class NumberUtil extends Object
    {
        private static var _nf:NumberFormatter;

        public function NumberUtil()
        {
            return;
        }// end function

        public static function formatNumber(num:Number, length:Number) : String
        {
            var _loc_3:* = num.toString();
            while (_loc_3.length < length)
            {
                
                _loc_3 = "0" + _loc_3;
            }
            return _loc_3;
        }// end function

        public static function qianWeiNumber(value:Number, fractionalDigits:int = 0) : String
        {
            if (value == 0 || !value)
            {
                return "0";
            }
            if (!_nf)
            {
                _nf = new NumberFormatter("en-US");
                _nf.trailingZeros = true;
                _nf.fractionalDigits = fractionalDigits;
            }
            return _nf.formatNumber(value);
        }// end function

        public static function qianWeiNumberZF(value:Number) : String
        {
            if (value == 0 || !value)
            {
                return "0";
            }
            if (!_nf)
            {
                _nf = new NumberFormatter("en-US");
                _nf.trailingZeros = false;
            }
            var _loc_2:* = value > 0 ? ("+") : ("");
            _loc_2 = _loc_2 + _nf.formatNumber(value);
            return _loc_2;
        }// end function

        public static function qianWeiNumberSW(value:Number) : String
        {
            if (value == 0 || !value)
            {
                return "0";
            }
            if (!_nf)
            {
                _nf = new NumberFormatter("en-US");
                _nf.trailingZeros = false;
            }
            var _loc_3:* = value >= 100000 ? ("万") : ("");
            var _loc_2:Number = 0;
            if (value >= 100000)
            {
                _loc_2 = value / 10000;
            }
            else
            {
                _loc_2 = value;
            }
            return _nf.formatNumber(_loc_2) + _loc_3;
        }// end function

        public static function qianWeiNumberSWZF(value:Number) : String
        {
            if (value == 0 || !value)
            {
                return "0";
            }
            if (!_nf)
            {
                _nf = new NumberFormatter("en-US");
                _nf.trailingZeros = false;
            }
            var _loc_4:* = value > 0 ? ("+") : ("");
            var _loc_3:* = value >= 100000 ? ("万") : ("");
            var _loc_2:Number = 0;
            if (value >= 100000)
            {
                _loc_2 = value / 10000;
            }
            else
            {
                _loc_2 = value;
            }
            _loc_4 = _loc_4 + _nf.formatNumber(_loc_2) + _loc_3;
            return _loc_4;
        }// end function

        public static function numberWeiShu(value:String, weishu:int) : String
        {
            if (!value)
            {
                return value;
            }
            var _loc_3:* = value.indexOf(".");
            if (_loc_3 >= 0 && value.length - _loc_3 - 1 > weishu)
            {
                value = value.slice(0, _loc_3 + weishu + 1);
            }
            else if (_loc_3 >= 0 && (value.length - 1) == _loc_3)
            {
                value = value.slice(0, _loc_3);
            }
            return value;
        }// end function

    }
}
