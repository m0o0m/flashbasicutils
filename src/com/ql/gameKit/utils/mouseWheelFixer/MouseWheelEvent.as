package com.ql.gameKit.utils.mouseWheelFixer
{
    import flash.display.*;
    import flash.events.*;

    public class MouseWheelEvent extends MouseEvent
    {
        private var _deltaX:int;
        private var _deltaY:int;
        public static const MOUSE_WHEEL:String = "mouseWheel2";

        public function MouseWheelEvent(type:String, bubbles:Boolean = true, cancelable:Boolean = false, localX:Number = 0, localY:Number = 0, relatedObject:InteractiveObject = null, ctrlKey:Boolean = false, altKey:Boolean = false, shiftKey:Boolean = false, buttonDown:Boolean = false, deltaX:int = 0, deltaY:int = 0)
        {
            super(type, bubbles, cancelable, localX, localY, relatedObject, ctrlKey, altKey, shiftKey, buttonDown, deltaY);
            _deltaX = deltaX;
            _deltaY = deltaY;
            return;
        }// end function

        public function get deltaX() : int
        {
            return _deltaX;
        }// end function

        public function set deltaX(deltaX:int) : void
        {
            _deltaX = deltaX;
            return;
        }// end function

        public function get deltaY() : int
        {
            return _deltaY;
        }// end function

        public function set deltaY(deltaY:int) : void
        {
            _deltaY = deltaY;
            return;
        }// end function

    }
}
