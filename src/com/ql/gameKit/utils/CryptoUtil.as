package com.ql.gameKit.utils
{
    import flash.utils.*;

    public class CryptoUtil extends Object
    {
        private const CHAR_SET:String = "gbk";
        private var _cryptKey:String;

        public function CryptoUtil(key)
        {
            var _loc_3:int = 0;
            var _loc_2:int = 0;
            _cryptKey = key;
            if (_cryptKey.length != 16)
            {
                throw new Error("crypt必须是16位字符");
            }
            _loc_3 = 0;
            while (_loc_3 < (_cryptKey.length - 1))
            {
                
                _loc_2 = _loc_3 + 1;
                while (_loc_2 < _cryptKey.length)
                {
                    
                    if (_cryptKey.charAt(_loc_3) == _cryptKey.charAt(_loc_2))
                    {
                        throw new Error("crypt存在多个相同的字符" + _cryptKey.charAt(_loc_2));
                    }
                    _loc_2++;
                }
                _loc_3++;
            }
            return;
        }// end function

        public function encode(str:String) : String
        {
            var _loc_7:int = 0;
            var _loc_5:int = 0;
            var _loc_4:int = 0;
            var _loc_6:int = 0;
            var _loc_2:* = new ByteArray();
            _loc_2.writeMultiByte(str, "gbk");
            _loc_2.position = 0;
            var _loc_3:String = "";
            _loc_7 = 0;
            while (_loc_7 < _loc_2.length)
            {
                
                _loc_5 = _loc_2.readByte();
                _loc_4 = _loc_5 >> 4 & 15;
                _loc_6 = _loc_5 & 15;
                _loc_3 = _loc_3 + (_cryptKey.charAt(_loc_4) + _cryptKey.charAt(_loc_6));
                _loc_7++;
            }
            return _loc_3;
        }// end function

        public function decode(str:String) : String
        {
            var _loc_9:int = 0;
            var _loc_7:String = null;
            var _loc_8:String = null;
            var _loc_4:int = 0;
            var _loc_5:int = 0;
            var _loc_6:int = 0;
            if (str.length % 2 != 0)
            {
                throw new Error("错误的编码");
            }
            var _loc_3:* = new ByteArray();
            _loc_9 = 0;
            while (_loc_9 < str.length)
            {
                
                _loc_7 = str.charAt(_loc_9);
                _loc_8 = str.charAt((_loc_9 + 1));
                _loc_4 = getIndex(_loc_7);
                _loc_5 = getIndex(_loc_8);
                _loc_6 = (_loc_4 << 4) + _loc_5;
                _loc_3.writeByte(_loc_6);
                _loc_9 = _loc_9 + 2;
            }
            _loc_3.position = 0;
            var _loc_2:* = _loc_3.readMultiByte(str.length / 2, "gbk");
            return _loc_2;
        }// end function

        private function getIndex(ch:String) : int
        {
            var _loc_2:int = 0;
            _loc_2 = 0;
            while (_loc_2 < _cryptKey.length)
            {
                
                if (ch == _cryptKey.charAt(_loc_2))
                {
                    return _loc_2;
                }
                _loc_2++;
            }
            throw new Error("无效的字符:" + ch);
        }// end function

        public function get cryptKey() : String
        {
            return _cryptKey;
        }// end function

    }
}
