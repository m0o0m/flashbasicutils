package com.ql.gameKit.utils
{
    import flash.utils.*;

    public class StringFormatter extends Object
    {

        public function StringFormatter() : void
        {
            return;
        }// end function

        public static function stringsAreEqual(s1:String, s2:String, caseSensitive:Boolean = false) : Boolean
        {
            if (caseSensitive)
            {
                return s1 == s2;
            }
            return s1.toUpperCase() == s2.toUpperCase();
        }// end function

        public static function trim(input:String) : String
        {
            return StringFormatter.ltrim(StringFormatter.rtrim(input));
        }// end function

        public static function ltrim(input:String) : String
        {
            var _loc_2:Number = NaN;
            var _loc_3:* = input.length;
            _loc_2 = 0;
            while (_loc_2 < _loc_3)
            {
                
                if (input.charCodeAt(_loc_2) > 32)
                {
                    return input.substring(_loc_2);
                }
                _loc_2++;
            }
            return "";
        }// end function

        public static function rtrim(input:String) : String
        {
            var _loc_2:Number = NaN;
            var _loc_3:* = input.length;
            _loc_2 = _loc_3;
            while (_loc_2 > 0)
            {
                
                if (input.charCodeAt((_loc_2 - 1)) > 32)
                {
                    return input.substring(0, _loc_2);
                }
                _loc_2--;
            }
            return "";
        }// end function

        public static function beginsWith(input:String, prefix:String) : Boolean
        {
            return prefix == input.substring(0, prefix.length);
        }// end function

        public static function endsWith(input:String, suffix:String) : Boolean
        {
            return suffix == input.substring(input.length - suffix.length);
        }// end function

        public static function remove(input:String, remove:String) : String
        {
            return StringFormatter.replace(input, remove, "");
        }// end function

        public static function replace(input:String, replace:String, replaceWith:String) : String
        {
            var _loc_8:Number = NaN;
            var _loc_6:Number = NaN;
            var _loc_5:* = new String();
            var _loc_9:Boolean = false;
            var _loc_7:* = input.length;
            var _loc_4:* = replace.length;
            _loc_8 = 0;
            while (_loc_8 < _loc_7)
            {
                
                if (input.charAt(_loc_8) == replace.charAt(0))
                {
                    _loc_9 = true;
                    _loc_6 = 0;
                    while (_loc_6 < _loc_4)
                    {
                        
                        if (input.charAt(_loc_8 + _loc_6) != replace.charAt(_loc_6))
                        {
                            _loc_9 = false;
                            break;
                        }
                        _loc_6++;
                    }
                    if (_loc_9)
                    {
                        _loc_5 = _loc_5 + replaceWith;
                        _loc_8 = _loc_8 + (_loc_4 - 1);
                        ;
                    }
                }
                _loc_5 = _loc_5 + input.charAt(_loc_8);
                _loc_8++;
            }
            return _loc_5;
        }// end function

        public static function numberToStr(value:Number, decimalCount:int = 2, isFixed:Boolean = false) : String
        {
            var _loc_7:String = null;
            var _loc_4:String = null;
            var _loc_8:int = 0;
            var _loc_6:* = value.toString();
            var _loc_5:* = value.toString().indexOf(".");
            if (value.toString().indexOf(".") != -1)
            {
                _loc_6 = value.toFixed(decimalCount);
                if (decimalCount > 0)
                {
                    _loc_7 = _loc_6.slice(0, (_loc_5 + 1));
                    _loc_4 = _loc_6.slice((_loc_5 + 1));
                    _loc_6 = _loc_7 + _loc_4.slice(0, decimalCount > _loc_4.length ? (_loc_4.length) : (decimalCount));
                    if (!isFixed)
                    {
                        _loc_8 = _loc_6.length - 1;
                        while (_loc_8 >= 0)
                        {
                            
                            if (_loc_6.charAt(_loc_8) == "0")
                            {
                                _loc_6 = _loc_6.substring(0, _loc_8);
                            }
                            else
                            {
                                break;
                            }
                            _loc_8--;
                        }
                    }
                }
            }
            return _loc_6;
        }// end function

        public static function getStrLength(str:String) : int
        {
            var _loc_3 = null;
            var _loc_2:int = 0;
            if (str)
            {
                _loc_3 = new ByteArray();
                _loc_3.writeMultiByte(str, "gb2312");
                _loc_3.position = 0;
                _loc_2 = _loc_3.bytesAvailable;
            }
            return _loc_2;
        }// end function

        public static function sliceStr(str:String, maxLength:uint, keepLength:uint, symbol:String) : String
        {
            var _loc_6:int = 0;
            var _loc_7:int = 0;
            var _loc_5:String = null;
            if (str && symbol)
            {
                _loc_6 = getStrLength(str);
                if (_loc_6 > maxLength)
                {
                    _loc_7 = str.length;
                    _loc_5 = "";
                    while (getStrLength(_loc_5) < keepLength)
                    {
                        
                        _loc_5 = str.charAt((_loc_7 - 1)) + _loc_5;
                        _loc_7--;
                    }
                    if (getStrLength(_loc_5) > keepLength)
                    {
                        _loc_5 = _loc_5.substring(1);
                    }
                    _loc_5 = symbol + _loc_5;
                    return _loc_5;
                }
                return str;
            }
            return null;
        }// end function

    }
}
