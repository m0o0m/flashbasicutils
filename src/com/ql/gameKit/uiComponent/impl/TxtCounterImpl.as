package com.ql.gameKit.uiComponent.impl
{
    import flash.display.*;

    public class TxtCounterImpl extends Object
    {
        private var _target:MovieClip;

        public function TxtCounterImpl(target:MovieClip)
        {
            _target = target;
            initTarget();
            return;
        }// end function

        private function initTarget() : void
        {
            _target.mouseEnabled = false;
            _target.mouseChildren = false;
            _target.txt.autoSize = "left";
            setCount("0");
            return;
        }// end function

        public function setCount(value:String) : void
        {
            if (_target.txt.text != value)
            {
                _target.txt.text = value;
                updatePosition();
            }
            return;
        }// end function

        private function updatePosition() : void
        {
            var _loc_1:* = _target.txt.width + _target.labelMc.width;
            _target.txt.x = _target.width - _loc_1 >> 1;
            _target.labelMc.x = _target.txt.x + _target.txt.width;
            return;
        }// end function

    }
}
