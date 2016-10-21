package com.ql.gameKit.uiComponent.impl
{
    import com.greensock.*;
    import com.greensock.easing.*;
    import flash.display.*;
    import flash.text.*;

    public class MarqueeImpl extends Object
    {
        private var _target:MovieClip;
        private var _tl:TweenLite;
        private var _playCount:int;
        private var _content:String;
        private var _isPlaying:Boolean;

        public function MarqueeImpl(target:MovieClip)
        {
            _target = target;
            initTarget();
            return;
        }// end function

        private function initTarget() : void
        {
            _target.mouseEnabled = false;
            _target.contentTxt.text = "";
            TextFieldImpl.optimize(_target.contentTxt);
            _target.contentTxt.mask = _target.maskMc;
            _target.maskMc.mosueEnabled = false;
            _target.maskMc.mouseChildren = false;
            (_target.contentTxt as TextField).autoSize = "left";
            return;
        }// end function

        public function resize(width:Number, height:Number) : void
        {
            if (_target && _target.maskMc)
            {
                if (width > 0)
                {
                    _target.maskMc.width = width;
                }
                if (height > 0)
                {
                    _target.maskMc.height = height;
                }
            }
            return;
        }// end function

        public function update(repeat:int, content:String) : void
        {
            _playCount = repeat;
            _content = content;
            return;
        }// end function

        public function play() : void
        {
            var _loc_1:Number = NaN;
            if (_playCount > 0)
            {
                _isPlaying = true;
                _target.contentTxt.htmlText = _content;
                _target.contentTxt.x = _target.maskMc.width;
                _loc_1 = (_target.contentTxt.textWidth + _target.width) / 50;
                _tl = TweenLite.to(_target.contentTxt, _loc_1, {x:-_target.contentTxt.textWidth - 20, onComplete:onCompleteHander, ease:Linear.easeNone});
            }
            else
            {
                setDisplay(false);
            }
            return;
        }// end function

        public function stop() : void
        {
            _playCount = 0;
            pause();
            return;
        }// end function

        public function pause() : void
        {
            _isPlaying = false;
            onCompleteHander();
            setDisplay(false);
            return;
        }// end function

        private function onCompleteHander() : void
        {
            _tl = null;
            (_playCount - 1);
            play();
            return;
        }// end function

        public function setDisplay(isDisplay:Boolean) : void
        {
            _target.visible = isDisplay;
            return;
        }// end function

        public function get playCount() : int
        {
            return _playCount;
        }// end function

        public function get isPlaying() : Boolean
        {
            return _isPlaying;
        }// end function

    }
}
