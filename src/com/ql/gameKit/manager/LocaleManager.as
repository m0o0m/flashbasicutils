package com.ql.gameKit.manager
{
    import flash.utils.*;

    public class LocaleManager extends Object
    {
        private var _msgObj:Object;
        private static var _instance:LocaleManager;

        public function LocaleManager()
        {
            if (!_instance)
            {
                _instance = this;
            }
            else
            {
                throw getQualifiedClassName(this) + " is a singleton class.";
            }
            return;
        }// end function

        public function append(data:Object) : void
        {
            _msgObj = data || {};
            return;
        }// end function

        public function getMsg(title:String) : String
        {
            return _msgObj[title] || "";
        }// end function

        public static function shared() : LocaleManager
        {
            return _instance || new LocaleManager;
        }// end function

    }
}
