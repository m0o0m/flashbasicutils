package com.ql.gameKit.events
{
    import flash.events.*;

    public class ModelEvent extends Event
    {
        public var data:Object;
        public static const DATA_CHANGED:String = "dataChanged";

        public function ModelEvent(type:String, data:Object = null, bubbles:Boolean = false, cancelable:Boolean = false)
        {
            super(type, bubbles, cancelable);
            this.data = data;
            return;
        }// end function

    }
}
