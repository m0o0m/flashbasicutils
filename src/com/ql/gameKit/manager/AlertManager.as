package com.ql.gameKit.manager
{
    import flash.display.*;
    import flash.utils.*;

    public class AlertManager extends Object
    {
        private var _sceneSize:Object;
        private var _targetCls:Class;
        private var _target:Sprite;
        private var _layer:Sprite;
        private var _modalSp:Sprite;
        private var _showList:Array;
        private static var _instance:AlertManager;

        public function AlertManager()
        {
            if (!_instance)
            {
                _instance = this;
                _showList = [];
            }
            else
            {
                throw getQualifiedClassName(this) + "is a singletion class.";
            }
            return;
        }// end function

        public function init(layer:Sprite, alertClass:Class, sceneSize:Object) : void
        {
            _layer = layer;
            _sceneSize = sceneSize;
            _targetCls = alertClass;
            return;
        }// end function

        public function show(content:String, closeHandle:Function, otherHandle:Function = null, isModal:Boolean = true) : void
        {
            if (!_target)
            {
                _target = new _targetCls() as Sprite;
            }
            if (!_layer.contains(_target))
            {
                if (isModal)
                {
                    _modalSp = new Sprite();
                    _modalSp.graphics.beginFill(0, 0.5);
                    _modalSp.graphics.drawRect(0, 0, _sceneSize.width, _sceneSize.height);
                    _modalSp.graphics.endFill();
                    _layer.addChildAt(_modalSp, 0);
                }
                _target["show"](content, closeHandle, otherHandle);
                _target.x = _sceneSize.width - _target.width >> 1;
                _target.y = _sceneSize.height - _target.height >> 1;
                _layer.addChild(_target);
            }
            else
            {
                _showList.push({content:content, closeHandle:closeHandle, otherHandle:otherHandle, isModal:isModal});
            }
            return;
        }// end function

        public function hide() : void
        {
            remove();
            return;
        }// end function

        public function hideAll() : void
        {
            _showList = [];
            remove();
            return;
        }// end function

        private function remove() : void
        {
            if (_modalSp)
            {
                _layer.removeChild(_modalSp);
                _modalSp = null;
            }
            _layer.removeChild(_target);
            if (_showList.length > 0)
            {
                show(_showList[0].content, _showList[0].closeHandle, _showList[0].otherHandle, _showList[0].isModal);
                _showList.shift();
            }
            return;
        }// end function

        public static function shared() : AlertManager
        {
            return _instance || new AlertManager;
        }// end function

    }
}
