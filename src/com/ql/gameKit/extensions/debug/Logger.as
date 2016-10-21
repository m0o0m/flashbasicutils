package com.ql.gameKit.extensions.debug
{
    import com.ql.gameKit.utils.*;
    import flash.utils.*;

    public class Logger extends Object
    {
        private static var _isDebug:Boolean;
        private static var _isLog:Boolean;
        private static var _log:Array = [];
        private static const MAX_SIZE:int = 1000;

        public function Logger()
        {
            return;
        }// end function

        public static function log(msg:String, target:Object, type:String = "INFO") : void
        {
            var _loc_4:String = null;
            if (msg != null)
            {
                _loc_4 = "[" + DateUtil.getByFormat("yy/mm/dd HH:MM:SS", new Date()) + "][" + type + "|" + (!target ? ("") : (getQualifiedClassName(target).split("::")[1])) + "]->" + msg;
                if (_isLog)
                {
                    _log.push(_loc_4);
                    if (_log.length > 1000)
                    {
                        clearLog();
                    }
                }
                if (_isDebug)
                {
                    trace(_loc_4);
                }
            }
            return;
        }// end function

        public static function warn(msg:String, target:Object) : void
        {
            log(msg, target, "WARN");
            return;
        }// end function

        public static function error(msg:String, target:Object) : void
        {
            log(msg, target, "ERROR");
            return;
        }// end function

        public static function clearLog() : void
        {
            _log = [];
            return;
        }// end function

        public static function getLog() : String
        {
            return _log.join("\r");
        }// end function

        public static function get isDebug() : Boolean
        {
            return _isDebug;
        }// end function

        public static function set isDebug(value:Boolean) : void
        {
            _isDebug = value;
            return;
        }// end function

        public static function get isLog() : Boolean
        {
            return _isLog;
        }// end function

        public static function set isLog(value:Boolean) : void
        {
            _isLog = value;
            return;
        }// end function

/*		public static function trace(_loc_4:String):void
		{
			// TODO Auto Generated method stub
			//trace(_loc_4);
		}
		*/
	}
}
