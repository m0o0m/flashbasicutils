package com.ql.gameKit.uiComponent.impl
{
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;

    public class MCBtnImpl extends Object
    {
        public const NORMAL:String = "normal";
        public const HOVER:String = "hover";
        public const DOWN:String = "down";
        public const DISABLED:String = "disabled";
        public var target:MovieClip;
        private var _isSelected:Boolean;
        private var _clickCall:Function;

        public function MCBtnImpl(target:MovieClip, clickCall:Function)
        {
            this.target = target;
            _clickCall = clickCall;
            draw();
            return;
        }// end function

        protected function draw() : void
        {
            if (target)
            {
                reset();
                target.addEventListener("rollOver", onOver);
                target.addEventListener("rollOut", onOut);
                target.addEventListener("mouseDown", onDown);
                target.addEventListener("mouseUp", onUp);
            }
            return;
        }// end function

        protected function onOver(event:MouseEvent) : void
        {
            if (!_isSelected)
            {
                try
                {
                    target.gotoAndStop("hover");
                }
                catch (e:Error)
                {
                }
            }
            return;
        }// end function

        protected function onOut(event:MouseEvent) : void
        {
            if (!_isSelected)
            {
                try
                {
                    target.gotoAndStop("normal");
                }
                catch (e:Error)
                {
                }
            }
            return;
        }// end function

        protected function onDown(event:MouseEvent) : void
        {
            try
            {
                target.gotoAndStop("down");
            }
            catch (e:Error)
            {
            }
            return;
        }// end function

        protected function onUp(event:MouseEvent) : void
        {
            if (_clickCall != null)
            {
                this._clickCall(this);
            }
            return;
        }// end function

        public function setEnabled(isEnabled:Boolean) : void
        {
            isEnabled = isEnabled;
            target.mouseEnabled = isEnabled;
            target.mouseChildren = isEnabled;
            target.buttonMode = isEnabled;
            return;
        }// end function

        public function setSelected(isSelected:Boolean) : void
        {
            _isSelected = isSelected;
            setEnabled(!isSelected);
            if (!isSelected)
            {
                onOut(null);
            }
            else
            {
                onDown(null);
            }
            return;
        }// end function

        public function reset() : void
        {
            target.visible = true;
            try
            {
                target.gotoAndStop("normal");
            }
            catch (e:Error)
            {
            }
            return;
        }// end function

    }
}
