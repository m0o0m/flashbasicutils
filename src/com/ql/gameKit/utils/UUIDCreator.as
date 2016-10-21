package com.ql.gameKit.utils
{
    import flash.system.*;

    public class UUIDCreator extends Object
    {
        private static var counter:Number = 0;

        public function UUIDCreator()
        {
            return;
        }// end function

        public static function create() : String
        {
            var _loc_1:* = new Date();
            var _loc_3:* = _loc_1.getTime();
            var _loc_2:* = Math.random() * 17976931348623161000000000000;
            var _loc_6:* = Capabilities.serverString;
            (counter + 1);
            var _loc_4:* = calculate(_loc_3 + _loc_6 + _loc_2 + counter).toUpperCase();
            var _loc_5:* = calculate(_loc_3 + _loc_6 + _loc_2 + counter).toUpperCase().substring(0, 8) + "-" + _loc_4.substring(8, 12) + "-" + _loc_4.substring(12, 16) + "-" + _loc_4.substring(16, 20) + "-" + _loc_4.substring(20, 32);
            return calculate(_loc_3 + _loc_6 + _loc_2 + counter).toUpperCase().substring(0, 8) + "-" + _loc_4.substring(8, 12) + "-" + _loc_4.substring(12, 16) + "-" + _loc_4.substring(16, 20) + "-" + _loc_4.substring(20, 32);
        }// end function

        private static function calculate(src:String) : String
        {
            return hex_sha1(src);
        }// end function

        private static function hex_sha1(src:String) : String
        {
            return binb2hex(core_sha1(str2binb(src), src.length * 8));
        }// end function

        private static function core_sha1(x:Array, len:Number) : Array
        {
            var _loc_9:Number = NaN;
            var _loc_16:Number = NaN;
            var _loc_14:Number = NaN;
            var _loc_8:Number = NaN;
            var _loc_13:Number = NaN;
            var _loc_17:* = len >> 5;
            var _loc_18:* = x[_loc_17] | 128 << 24 - len % 32;
            x[_loc_17] = _loc_18;
            x[(len + 64 >> 9 << 4) + 15] = len;
            var _loc_10:* = new Array(80);
            var _loc_7:Number = 1732584193;
            var _loc_5:Number = -271733879;
            var _loc_6:Number = -1732584194;
            var _loc_3:Number = 271733878;
            var _loc_4:Number = -1009589776;
            _loc_9 = 0;
            while (_loc_9 < x.length)
            {
                
                _loc_16 = _loc_7;
                var _loc_15:* = _loc_5;
                _loc_14 = _loc_6;
                var _loc_12:* = _loc_3;
                var _loc_11:* = _loc_4;
                _loc_8 = 0;
                while (_loc_8 < 80)
                {
                    
                    if (_loc_8 < 16)
                    {
                        _loc_10[_loc_8] = x[_loc_9 + _loc_8];
                    }
                    else
                    {
                        _loc_10[_loc_8] = rol(_loc_10[_loc_8 - 3] ^ _loc_10[_loc_8 - 8] ^ _loc_10[_loc_8 - 14] ^ _loc_10[_loc_8 - 16], 1);
                    }
                    _loc_13 = safe_add(safe_add(rol(_loc_7, 5), sha1_ft(_loc_8, _loc_5, _loc_6, _loc_3)), safe_add(safe_add(_loc_4, _loc_10[_loc_8]), sha1_kt(_loc_8)));
                    _loc_4 = _loc_3;
                    _loc_3 = _loc_6;
                    _loc_6 = rol(_loc_5, 30);
                    _loc_5 = _loc_7;
                    _loc_7 = _loc_13;
                    _loc_8++;
                }
                _loc_7 = safe_add(_loc_7, _loc_16);
                _loc_5 = safe_add(_loc_5, _loc_15);
                _loc_6 = safe_add(_loc_6, _loc_14);
                _loc_3 = safe_add(_loc_3, _loc_12);
                _loc_4 = safe_add(_loc_4, _loc_11);
                _loc_9 = _loc_9 + 16;
            }
            return new Array(_loc_7, _loc_5, _loc_6, _loc_3, _loc_4);
        }// end function

        private static function sha1_ft(t:Number, b:Number, c:Number, d:Number) : Number
        {
            if (t < 20)
            {
                return b & c | ~b & d;
            }
            if (t < 40)
            {
                return b ^ c ^ d;
            }
            if (t < 60)
            {
                return b & c | b & d | c & d;
            }
            return b ^ c ^ d;
        }// end function

        private static function sha1_kt(t:Number) : Number
        {
            return t < 20 ? (1518500249) : (t < 40 ? (1859775393) : (t < 60 ? (-1894007588) : (-899497514)));
        }// end function

        private static function safe_add(x:Number, y:Number) : Number
        {
            var _loc_3:* = (x & 65535) + (y & 65535);
            var _loc_4:* = (x >> 16) + (y >> 16) + (_loc_3 >> 16);
            return (x >> 16) + (y >> 16) + (_loc_3 >> 16) << 16 | _loc_3 & 65535;
        }// end function

        private static function rol(num:Number, cnt:Number) : Number
        {
            return num << cnt | num >>> 32 - cnt;
        }// end function

        private static function str2binb(str:String) : Array
        {
            var _loc_4:Number = NaN;
            var _loc_3:Array = [];
            var _loc_2:Number = 255;
            _loc_4 = 0;
            while (_loc_4 < str.length * 8)
            {
                
                var _loc_5:* = _loc_4 >> 5;
                var _loc_6:* = _loc_3[_loc_5] | (str.charCodeAt(_loc_4 / 8) & _loc_2) << 24 - _loc_4 % 32;
                _loc_3[_loc_5] = _loc_6;
                _loc_4 = _loc_4 + 8;
            }
            return _loc_3;
        }// end function

        private static function binb2hex(binarray:Array) : String
        {
            var _loc_4:Number = NaN;
            var _loc_2:* = new String("");
            var _loc_3:* = new String("0123456789abcdef");
            _loc_4 = 0;
            while (_loc_4 < binarray.length * 4)
            {
                
                _loc_2 = _loc_2 + (_loc_3.charAt(binarray[_loc_4 >> 2] >> (3 - _loc_4 % 4) * 8 + 4 & 15) + _loc_3.charAt(binarray[_loc_4 >> 2] >> (3 - _loc_4 % 4) * 8 & 15));
                _loc_4++;
            }
            return _loc_2;
        }// end function

    }
}
