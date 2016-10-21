package com.ql.gameKit.utils
{

    public class ObjectFomatter extends Object
    {

        public function ObjectFomatter()
        {
            return;
        }// end function

        public static function stringCommon(value:Object, gap:String = "") : String
        {
            var _loc_3:int = 0;
            var _loc_6:String = null;
            var _loc_7:int = 0;
            if (value == "")
            {
                return "(空字符串)";
            }
            if (!value)
            {
                return null;
            }
            var _loc_5:String = "";
            var _loc_4:* = value is Array;
            var _loc_8:Array = [];
            for (_loc_6 in value)
            {
                
                if (typeof(value[_loc_6]) == "object")
                {
                    _loc_8.push(_loc_6);
                    continue;
                }
                _loc_5 = _loc_5 + gap;
                if (_loc_4)
                {
                    _loc_5 = _loc_5 + ("[" + _loc_6 + "] = ");
                }
                else
                {
                    _loc_5 = _loc_5 + (_loc_6 + " = ");
                }
                _loc_5 = _loc_5 + (value[_loc_6] + "\n");
            }
            while (_loc_7 < _loc_8.length)
            {
                
                _loc_5 = _loc_5 + gap;
                if (_loc_4)
                {
                    _loc_5 = _loc_5 + ("[" + _loc_8[_loc_7] + "] = ");
                }
                else
                {
                    _loc_5 = _loc_5 + (_loc_8[_loc_7] + " = ");
                }
                if (value[_loc_8[_loc_7]] is Array)
                {
                    _loc_5 = _loc_5 + "(Array) #";
                }
                else
                {
                    _loc_5 = _loc_5 + "(Object) #";
                }
                _loc_5 = _loc_5 + (_loc_3 + "\n");
                _loc_3++;
                _loc_5 = _loc_5 + stringCommon(value[_loc_8[_loc_7]], gap + "    ");
                _loc_7++;
            }
            return _loc_5;
        }// end function

        public static function stringJson(value:Object) : String
        {
            return JSON.stringify(value);
        }// end function

        public static function objectJson(value:String) : Object
        {
            var _loc_2:String = null;
            try
            {
                _loc_2 = JSON.parse(value);
            }
            catch (e:Error)
            {
            }
            return _loc_2;
        }// end function

    }
}
