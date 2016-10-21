package com.ql.gameKit.uiComponent.impl
{
    import flash.display.*;
    import flash.events.*;

    public class CheckboxImpl extends Object
    {
        private var _btnSpr:Sprite;
        private var _target:MovieClip;
        private var _clickedHandler:Function;
        private var _isEnabled:Boolean;
        private var _isSelected:Boolean;

        public function CheckboxImpl(target:MovieClip, clickedHandler:Function)
        {
            _target = target;
            _clickedHandler = clickedHandler;
            initTarget();
            return;
        }// end function

        private function initTarget() : void
        {
            _target.mouseEnabled = false;
            _btnSpr = new Sprite();
            _btnSpr.buttonMode = true;
            _btnSpr.graphics.beginFill(0, 0);
            _btnSpr.graphics.drawRect(0, 0, _target.width, _target.height);
            _btnSpr.graphics.endFill();
            _target.addChild(_btnSpr);
            _btnSpr.addEventListener("click", onClick);
            setSelected(true);
            setEnabled(true);
            return;
        }// end function

        public function setEnabled(value:Boolean) : void
        {
            _isEnabled = value;
            _btnSpr.visible = value;
            return;
        }// end function

        public function setSelected(value:Boolean) : void
        {
            _isSelected = value;
            _target.checkboxMc.gotoAndStop(2 - value);
            return;
        }// end function

        public function getSelected() : Boolean
        {
            return _isSelected;
        }// end function

        public function setVisible(value:Boolean) : void
        {
            _target.visible = value;
            if (!value)
            {
                _btnSpr.visible = false;
            }
            else if (_isEnabled)
            {
                _btnSpr.visible = true;
            }
            return;
        }// end function

        private function onClick(event:MouseEvent) : void
        {
            if (!_isEnabled)
            {
                return;
            }
            setSelected(!_isSelected);
            if (_clickedHandler != null)
            {
                this._clickedHandler(this);
            }
            return;
        }// end function

    }
}
