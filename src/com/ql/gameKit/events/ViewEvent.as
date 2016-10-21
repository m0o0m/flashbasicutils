package com.ql.gameKit.events
{
    import flash.events.*;

    public class ViewEvent extends Event
    {
        private var _data:Object;

        public function ViewEvent(type:String, data:Object = null, bubbles:Boolean = false, cancelable:Boolean = false)
        {
            super(type, bubbles, cancelable);
            _data = data;
            return;
        }// end function

        public function get data() : Object
        {
            return _data;
        }// end function

        override public function clone() : Event
        {
            return new ViewEvent(type, data, bubbles, cancelable);
        }// end function

    }
}
