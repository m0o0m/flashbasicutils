package com.ql.gameKit.utils
{
    import flash.net.*;

    public class ShareObjectUtil extends Object
    {
        private static var _so:SharedObject;
        private static var _cookieName:String;

        public function ShareObjectUtil()
        {
            return;
        }// end function

        public static function registerCookie(name:String) : void
        {
            _cookieName = name;
            if (!_cookieName)
            {
                throw new Error("cookie名不能为空", 251584);
            }
            _so = SharedObject.getLocal(_cookieName);
            return;
        }// end function

        public static function setValue(name:String, obj:Object) : void
        {
            if (!_so)
            {
                throw new Error("请先注册cookie", 251642);
            }
            _so.data[name] = obj;
            _so.flush();
            return;
        }// end function

        public static function getValue(name:String) : Object
        {
            if (!_so)
            {
                throw new Error("请先注册cookie", 251642);
            }
            return _so.data[name];
        }// end function

        public static function get data() : SharedObject
        {
            return _so;
        }// end function

    }
}
