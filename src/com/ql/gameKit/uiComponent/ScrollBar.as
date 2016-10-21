package com.ql.gameKit.uiComponent
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;

    public class ScrollBar extends Object
    {
        public const name:String = "滚动条窗口";
        private var _speed:Number = 3;
        private var _upBtn:Sprite;
        private var _downBtn:Sprite;
        private var _tween:Number;
        private var _elastic:Boolean;
        private var _lineAbleClick:Boolean;
        private var _mouseWheel:Boolean;
        private var _direction:String;
        private var _scale9Grid:Rectangle;
        private var _target:DisplayObject;
        private var _maskTarget:DisplayObject;
        private var _scrollBar:Sprite;
        private var _scrollLine:Sprite;
        private var _timer:Timer = null;
        private var _scrollBarOriginalPoint:Point;
        private var _parentMC:DisplayObjectContainer;
        private var _rectangle:Rectangle;
        private var _distanceX:Number;
        private var _distanceY:Number;
        private var _targetPoint:Number = NaN;
        private var _coor:String;
        private var _length:String;
        private var _mouse:String;
        private var _oldLength:Point;
        private var _abled:Boolean = true;
        private var _targetOriginPos:Point;
        private var _isHover:Boolean;
        public static const H:String = "H";
        public static const L:String = "L";

        public function ScrollBar($target:DisplayObjectContainer, $maskTarget, $scrollBar:Sprite, $scrollLine:Sprite, $tween:Number = 5, $elastic:Boolean = false, $lineAbleClick:Boolean = false, $mouseWheel:Boolean = false, $direction:String = "L")
        {
            if (!($maskTarget is DisplayObject || $maskTarget is Rectangle))
            {
                throw new Error("没有传入遮罩对象");
            }
            _target = $target;
            _maskTarget = $maskTarget is Rectangle ? (drawMaskTarget($maskTarget)) : ($maskTarget);
            _scrollBar = $scrollBar;
            _scrollLine = $scrollLine;
            _tween = $tween < 0 || $tween > 20 ? (1) : ($tween);
            _elastic = $elastic;
            _lineAbleClick = $lineAbleClick;
            _mouseWheel = $mouseWheel;
            _direction = $direction;
            _parentMC = _scrollBar.parent;
            _coor = $direction == "H" ? ("x") : ("y");
            _length = _coor == "x" ? ("width") : ("height");
            _mouse = _coor == "x" ? ("mouseX") : ("mouseY");
            _oldLength = new Point(_scrollBar.width, _scrollBar.height);
            _targetOriginPos = new Point(_target.x, _target.y);
            _scale9Grid = new Rectangle(_scrollBar.width / 3, _scrollBar.height / 3, _scrollBar.width / 3, _scrollBar.height / 3);
            makeScrollPane();
            return;
        }// end function

        public function reset() : void
        {
            _scrollBar.x = _scrollBarOriginalPoint.x;
            _scrollBar.y = _scrollBarOriginalPoint.y;
            _target.x = _targetOriginPos.x;
            _target.y = _targetOriginPos.y;
            refresh();
            return;
        }// end function

        public function pause() : void
        {
            makeMouseWheel("stop");
            return;
        }// end function

        public function refresh() : void
        {
            checkAbled();
            return;
        }// end function

        private function makeScrollPane() : void
        {
            initAllThing();
            _scrollBarOriginalPoint = new Point(_scrollBar.x, _scrollBar.y);
            makeMask();
            checkAbled();
            return;
        }// end function

        private function checkAbled() : void
        {
            if (_maskTarget[_length] >= _target[_length])
            {
                _scrollBar.visible = false;
                _scrollLine.visible = false;
                if (_downBtn)
                {
                    _downBtn.visible = false;
                }
                if (_upBtn)
                {
                    _upBtn.visible = false;
                }
                _abled = false;
                if (_upBtn && _downBtn)
                {
                    _upBtn.removeEventListener("mouseDown", upDownBtnMouseDownHandler);
                    _downBtn.removeEventListener("mouseDown", upDownBtnMouseDownHandler);
                }
                if (_mouseWheel)
                {
                    makeMouseWheel("stop");
                }
            }
            else
            {
                _scrollBar.visible = true;
                _scrollLine.visible = true;
                if (_downBtn)
                {
                    _downBtn.visible = true;
                }
                if (_upBtn)
                {
                    _upBtn.visible = true;
                }
                _abled = true;
                makeScrollBar();
                if (_upBtn && _downBtn)
                {
                    _upBtn.addEventListener("mouseDown", upDownBtnMouseDownHandler, false, 0, true);
                    _downBtn.addEventListener("mouseDown", upDownBtnMouseDownHandler, false, 0, true);
                }
                if (_lineAbleClick)
                {
                    makeScrollLine();
                }
                if (_mouseWheel)
                {
                    makeMouseWheel();
                }
                timeListener();
            }
            return;
        }// end function

        private function timeListener() : void
        {
            if (_timer != null)
            {
                return;
            }
            _timer = new Timer(33.3333, 0);
            _timer.addEventListener("timer", timeHandler, false, 0, true);
            _timer.start();
            return;
        }// end function

        private function initAllThing() : void
        {
            setRegistration(_maskTarget as DisplayObjectContainer);
            setRegistration(_target as DisplayObjectContainer);
            setRegistration(_scrollLine);
            setRegistration(_scrollBar);
            return;
        }// end function

        private function makeMask() : void
        {
            _target.x = Math.floor(_target.x);
            _target.y = Math.floor(_target.y);
            _maskTarget.x = _target.x;
            _maskTarget.y = _target.y;
            if (_maskTarget.parent == null)
            {
                _parentMC.addChild(_maskTarget);
            }
            _target.mask = _maskTarget;
            return;
        }// end function

        private function makeScrollLine() : void
        {
            _scrollLine.buttonMode = false;
            if (!_scrollLine.hasEventListener("mouseDown"))
            {
                _scrollLine.addEventListener("mouseDown", scrollLineMouseDownHandler, false, 0, true);
            }
            return;
        }// end function

        private function makeMouseWheel(state:String = "start") : void
        {
            if (_target.stage != null)
            {
                if (state == "start" && !_target.hasEventListener("mouseWheel"))
                {
                    _target.stage.addEventListener("mouseWheel", mouseWheelHandler);
                }
                else if (state == "stop")
                {
                    _target.stage.removeEventListener("mouseWheel", mouseWheelHandler);
                }
            }
            return;
        }// end function

        private function makeScrollBar() : void
        {
            _scrollBar.buttonMode = true;
            _scrollBar.mouseChildren = false;
            scrollBarLength();
            if (_coor == "y")
            {
                _rectangle = new Rectangle(_scrollBarOriginalPoint.x, _scrollBarOriginalPoint.y, 0, _scrollLine.getRect(_parentMC)[_length] - _scrollBar.getRect(_parentMC)[_length]);
            }
            else
            {
                _rectangle = new Rectangle(_scrollBarOriginalPoint.x, _scrollBarOriginalPoint.y, _scrollLine.getRect(_parentMC)[_length] - _scrollBar.getRect(_parentMC)[_length], 0);
            }
            if (!_scrollBar.hasEventListener("mouseDown"))
            {
                _scrollBar.addEventListener("mouseDown", scrollBarMouseDownHandler, false, 0, true);
                _scrollBar.addEventListener("mouseUp", scrollBarMouseUpHandler, false, 0, true);
                _scrollBar.parent.stage.addEventListener("mouseUp", scrollBarMouseUpHandler, false, 0, true);
                _scrollBar.root.stage.addEventListener("mouseLeave", scrollBarMouseUpHandler, false, 0, true);
                _target.addEventListener("rollOut", onRollout);
                _target.addEventListener("rollOver", onOver);
            }
            return;
        }// end function

        protected function onRollout(event:Event) : void
        {
            _isHover = false;
            return;
        }// end function

        protected function onOver(event:Event) : void
        {
            _isHover = true;
            return;
        }// end function

        private function scrollBarLength() : void
        {
            if (_elastic)
            {
                try
                {
                    _scrollBar.scale9Grid = _scale9Grid;
                }
                catch (e)
                {
                    _scrollBar.scale9Grid = null;
                }
            }
            else
            {
                _scrollBar.scale9Grid = null;
            }
            _scrollBar.width = _oldLength.x;
            _scrollBar.height = _oldLength.y;
            _scrollBar[_length] = _elastic ? (_scrollLine[_length] * _maskTarget[_length] / _target[_length]) : (_oldLength[_coor]);
            return;
        }// end function

        private function scrollBarMouseDownHandler(event:MouseEvent) : void
        {
            _distanceX = _scrollBar.x - _parentMC.mouseX;
            _distanceY = _scrollBar.y - _parentMC.mouseY;
            if (!_scrollBar.hasEventListener("enterFrame"))
            {
                _scrollBar.addEventListener("enterFrame", scrolBarEnterFrameHandler, false, 0, true);
            }
            return;
        }// end function

        private function scrollBarMouseUpHandler(e) : void
        {
            _scrollBar.removeEventListener("enterFrame", scrolBarEnterFrameHandler);
            return;
        }// end function

        private function scrolBarEnterFrameHandler(event:Event) : void
        {
            makeDragBar();
            return;
        }// end function

        private function timeHandler(event:TimerEvent) : void
        {
            scrollMachine();
            return;
        }// end function

        private function scrollLineMouseDownHandler(event:MouseEvent) : void
        {
            if (_parentMC[_mouse] > _scrollBar[_coor])
            {
                var _loc_2:* = _coor;
                var _loc_3:* = _scrollBar[_loc_2] + 3 * _speed;
                _scrollBar[_loc_2] = _loc_3;
            }
            else
            {
                _loc_3 = _coor;
                _loc_2 = _scrollBar[_loc_3] - 3 * _speed;
                _scrollBar[_loc_3] = _loc_2;
            }
            judgeBoundary();
            return;
        }// end function

        private function upDownBtnMouseDownHandler(event:MouseEvent) : void
        {
            if (event.currentTarget == _downBtn)
            {
                var _loc_2:* = _coor;
                var _loc_3:* = _scrollBar[_loc_2] + 3 * _speed;
                _scrollBar[_loc_2] = _loc_3;
            }
            else
            {
                _loc_3 = _coor;
                _loc_2 = _scrollBar[_loc_3] - 3 * _speed;
                _scrollBar[_loc_3] = _loc_2;
            }
            judgeBoundary();
            return;
        }// end function

        private function mouseWheelHandler(event:MouseEvent) : void
        {
            if (event.delta < 0)
            {
                var _loc_2:* = _coor;
                var _loc_3:* = _scrollBar[_loc_2] + _speed;
                _scrollBar[_loc_2] = _loc_3;
            }
            else
            {
                _loc_3 = _coor;
                _loc_2 = _scrollBar[_loc_3] - _speed;
                _scrollBar[_loc_3] = _loc_2;
            }
            judgeBoundary();
            return;
        }// end function

        private function makeDragBar() : void
        {
            _scrollBar.x = _parentMC.mouseX + _distanceX;
            _scrollBar.y = _parentMC.mouseY + _distanceY;
            judgeBoundary();
            return;
        }// end function

        private function judgeBoundary() : void
        {
            if (_scrollBar.x < _rectangle.x)
            {
                _scrollBar.x = _rectangle.x;
            }
            if (_scrollBar.x > _rectangle.right)
            {
                _scrollBar.x = _rectangle.right;
            }
            if (_scrollBar.y < _rectangle.y)
            {
                _scrollBar.y = _rectangle.y;
            }
            if (_scrollBar.y > _rectangle.bottom)
            {
                _scrollBar.y = _rectangle.bottom;
            }
            return;
        }// end function

        private function scrollMachine() : void
        {
            _targetPoint = _maskTarget[_coor] - (_scrollBar[_coor] - _scrollBarOriginalPoint[_coor]) * (_target[_length] - _maskTarget[_length]) / (_scrollLine[_length] - _scrollBar[_length]);
            if (Math.abs(_target[_coor] - _targetPoint) < 0.3)
            {
                if (_target[_coor] != _targetPoint)
                {
                    _target[_coor] = _targetPoint;
                }
                return;
            }
            if (_tween != 0)
            {
                var _loc_1:* = _coor;
                var _loc_2:* = _target[_loc_1] + (_targetPoint - _target[_coor]) / _tween;
                _target[_loc_1] = _loc_2;
            }
            else
            {
                _target[_coor] = _targetPoint;
            }
            return;
        }// end function

        private function drawMaskTarget($rect:Rectangle) : Sprite
        {
            var _loc_2:* = new Sprite();
            _loc_2.graphics.beginFill(16777215);
            _loc_2.graphics.drawRect($rect.x, $rect.y, $rect.width, $rect.height);
            _loc_2.graphics.endFill();
            return _loc_2;
        }// end function

        private function setRegistration($target:DisplayObjectContainer) : void
        {
            var _loc_7:int = 0;
            var _loc_4 = null;
            var _loc_5:* = $target.getRect($target);
            var _loc_2:* = $target.getRect($target).x;
            var _loc_3:* = _loc_5.y;
            var _loc_6:* = $target.numChildren;
            if ($target.numChildren == 0)
            {
                return;
            }
            _loc_7 = 0;
            while (_loc_7 < _loc_6)
            {
                
                _loc_4 = $target.getChildAt(_loc_7);
                _loc_4.x = _loc_4.x - _loc_2;
                _loc_4.y = _loc_4.y - _loc_3;
                _loc_7 = _loc_7 + 1;
            }
            if ($target.parent != null)
            {
                $target.x = $target.x + _loc_2;
                $target.y = $target.y + _loc_3;
            }
            return;
        }// end function

        public function set tween($value:Number) : void
        {
            _tween = $value < 1 || $value > 20 ? (1) : ($value);
            return;
        }// end function

        public function set elastic($value:Boolean) : void
        {
            _elastic = $value;
            if (_abled)
            {
                makeScrollBar();
            }
            return;
        }// end function

        public function set lineAbleClick($value:Boolean) : void
        {
            _lineAbleClick = $value;
            if (_lineAbleClick)
            {
                _scrollLine.addEventListener("mouseDown", scrollLineMouseDownHandler, false, 0, true);
            }
            else
            {
                _scrollLine.removeEventListener("mouseDown", scrollLineMouseDownHandler);
            }
            return;
        }// end function

        public function set stepNumber($value:Number) : void
        {
            _speed = $value;
            return;
        }// end function

        public function set mouseWheel($value:Boolean) : void
        {
            _mouseWheel = $value;
            if (_mouseWheel && _abled)
            {
                _parentMC.stage.addEventListener("mouseWheel", mouseWheelHandler, false, 0, true);
            }
            else if (_abled)
            {
                _parentMC.stage.removeEventListener("mouseWheel", mouseWheelHandler);
            }
            return;
        }// end function

        public function set direction($value:String) : void
        {
            _direction = $value;
            _coor = _direction == "H" ? ("x") : ("y");
            _length = _coor == "x" ? ("width") : ("height");
            _mouse = _coor == "x" ? ("mouseX") : ("mouseY");
            if (_abled)
            {
                makeScrollBar();
            }
            return;
        }// end function

        public function set scale9Grid($value:Rectangle) : void
        {
            _scale9Grid = $value;
            try
            {
                _scrollBar.scale9Grid = _scale9Grid;
            }
            catch (e)
            {
                _scrollBar.scale9Grid = null;
            }
            return;
        }// end function

        public function set speed($value:Number) : void
        {
            _speed = $value < 5 ? (15) : ($value);
            return;
        }// end function

        public function set UP($target:Sprite) : void
        {
            _upBtn = $target;
            if (!_abled)
            {
                _upBtn.visible = false;
                _upBtn.removeEventListener("mouseDown", upDownBtnMouseDownHandler);
                return;
            }
            _upBtn.addEventListener("mouseDown", upDownBtnMouseDownHandler, false, 0, true);
            return;
        }// end function

        public function set DOWN($target:Sprite) : void
        {
            _downBtn = $target;
            if (!_abled)
            {
                _downBtn.visible = false;
                _downBtn.removeEventListener("mouseDown", upDownBtnMouseDownHandler);
                return;
            }
            _downBtn.addEventListener("mouseDown", upDownBtnMouseDownHandler, false, 0, true);
            return;
        }// end function

    }
}
