package com.ql.gameKit.utils
{

    public class DateUtil extends Object
    {

        public function DateUtil()
        {
            return;
        }// end function

        public static function date(value:Date = null) : String
        {
            var _loc_3 = null;
            if (value)
            {
                _loc_3 = value;
            }
            else
            {
                _loc_3 = new Date();
            }
            var _loc_2:String = "";
            _loc_2 = _loc_2 + (_loc_3.fullYear.toString() + "/");
            _loc_2 = _loc_2 + (_loc_3.month >= 9 ? (((_loc_3.month + 1)).toString()) : ("0" + (_loc_3.month + 1) + "/"));
            _loc_2 = _loc_2 + (_loc_3.date > 9 ? (_loc_3.date.toString()) : ("0" + _loc_3.date));
            return _loc_2;
        }// end function

        public static function fullTime(value:Date = null) : String
        {
            var _loc_3 = null;
            if (value)
            {
                _loc_3 = value;
            }
            else
            {
                _loc_3 = new Date();
            }
            var _loc_2:String = "";
            _loc_2 = _loc_2 + (_loc_3.hours > 9 ? (_loc_3.hours.toString()) : ("0" + _loc_3.hours + ":"));
            _loc_2 = _loc_2 + (_loc_3.minutes > 9 ? (_loc_3.minutes.toString()) : ("0" + _loc_3.minutes + ":"));
            _loc_2 = _loc_2 + (_loc_3.seconds > 9 ? (_loc_3.seconds.toString()) : ("0" + _loc_3.seconds));
            return _loc_2;
        }// end function

        public static function getByFormat(format:String, value:Date = null) : String
        {
            var _loc_4 = null;
            if (value)
            {
                _loc_4 = value;
            }
            else
            {
                _loc_4 = new Date();
            }
            var _loc_3:* = format;
            _loc_3 = _loc_3.replace("yy", _loc_4.fullYear.toString());
            _loc_3 = _loc_3.replace("mm", _loc_4.month >= 9 ? (((_loc_4.month + 1)).toString()) : ("0" + (_loc_4.month + 1)));
            _loc_3 = _loc_3.replace("dd", _loc_4.date > 9 ? (_loc_4.date.toString()) : ("0" + _loc_4.date));
            _loc_3 = _loc_3.replace("HH", _loc_4.hours > 9 ? (_loc_4.hours.toString()) : ("0" + _loc_4.hours));
            _loc_3 = _loc_3.replace("MM", _loc_4.minutes > 9 ? (_loc_4.minutes.toString()) : ("0" + _loc_4.minutes));
            _loc_3 = _loc_3.replace("SS", _loc_4.seconds > 9 ? (_loc_4.seconds.toString()) : ("0" + _loc_4.seconds));
            return _loc_3;
        }// end function

        public static function getDateByStr(str:String) : Date
        {
            var _loc_2 = null;
            var _loc_5 = null;
            var _loc_4 = null;
            var _loc_3 = null;
            if (str)
            {
                _loc_2 = str.split(" ");
                _loc_5 = _loc_2[0].split("-");
                _loc_4 = _loc_2[1].split(":");
                _loc_3 = new Date(_loc_5[0], _loc_5[1], _loc_5[2], _loc_4[0], _loc_4[1], _loc_4[2]);
                return _loc_3;
            }
            return null;
        }// end function

    }
}
