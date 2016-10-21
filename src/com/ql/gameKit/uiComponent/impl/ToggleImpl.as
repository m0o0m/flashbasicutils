package com.ql.gameKit.uiComponent.impl
{
    import flash.display.*;
    import flash.events.*;

    public class ToggleImpl extends Object
    {
        protected var _targetMc:MovieClip;
        private var _isEnable:Boolean;
        private var _clickCallback:Function;
        private var _mouseEnabled:Boolean;

        public function ToggleImpl(target:MovieClip, clickCallback:Function = null)
        {
            _targetMc = target;
            _clickCallback = clickCallback;
            create();
            return;
        }// end function

        private function create() : void
        {
            isEnable = false;
            _mouseEnabled = true;
            _targetMc.addEventListener("click", onClick);
            return;
        }// end function

        protected function onClick(event:MouseEvent) : void
        {
            isEnable = !isEnable;
            if (_clickCallback != null)
            {
                this._clickCallback();
            }
            return;
        }// end function

        public function get isEnable() : Boolean
        {
            return _isEnable;
        }// end function

        public function set isEnable(value:Boolean) : void
        {
            _isEnable = value;
            _targetMc.gotoAndStop(!_isEnable ? ("off") : ("on"));
            return;
        }// end function

        public function get mouseEnabled() : Boolean
        {
            return _mouseEnabled;
        }// end function

        public function set mouseEnabled(value:Boolean) : void
        {
            if (_mouseEnabled != value)
            {
                _mouseEnabled = value;
                _targetMc.mouseEnabled = value;
                _targetMc.mouseChildren = value;
                _targetMc.alpha = !value ? (0.7) : (1);
                if (!value)
                {
                    _targetMc.removeEventListener("click", onClick);
                }
                else
                {
                    _targetMc.addEventListener("click", onClick);
                }
            }
            return;
        }// end function

    }
}
