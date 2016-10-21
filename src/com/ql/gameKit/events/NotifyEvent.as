package com.ql.gameKit.events
{
    import flash.events.*;

    public class NotifyEvent extends Event
    {
        private var _data:Object;

        public function NotifyEvent(type:String, data = null, bubbles:Boolean = false, cancelable:Boolean = false)
        {
            super(type, bubbles, cancelable);
            _data = data;
            return;
        }// end function

        public function get data()
        {
            return _data;
        }// end function

    }
}
