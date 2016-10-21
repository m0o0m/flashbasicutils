package com.ql.gameKit.core
{
    import flash.events.*;

    public class Notifier extends EventDispatcher
    {
        private static var _instance:Notifier;

        public function Notifier()
        {
            if (!_instance)
            {
                _instance = this;
            }
            return;
        }// end function

        public static function get instance() : Notifier
        {
            return _instance || new Notifier;
        }// end function

        public static function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false) : void
        {
            instance.addEventListener(type, listener, useCapture, priority, useWeakReference);
            return;
        }// end function

        public static function dispatchEvent(event:Event) : Boolean
        {
            return instance.dispatchEvent(event);
        }// end function

        public static function removeEventListener(type:String, listener:Function, useCapture:Boolean = false) : void
        {
            instance.removeEventListener(type, listener, useCapture);
            return;
        }// end function

        public static function hasEventListener(type:String) : Boolean
        {
            return instance.hasEventListener(type);
        }// end function

    }
}
