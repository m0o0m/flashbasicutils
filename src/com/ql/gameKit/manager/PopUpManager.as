package com.ql.gameKit.manager
{
    import flash.display.*;
    import flash.filters.*;
    import flash.utils.*;

    public class PopUpManager extends Object
    {
        private var _popList:Dictionary;
        private var _popupDic:Dictionary;
        private var _popUpLayer:Sprite;
        private var _mainLayer:Sprite;
        private var _sceenSize:Object;
        private var _blurFilter:BlurFilter;
        private static var _instance:PopUpManager;

        public function PopUpManager()
        {
            if (!_instance)
            {
                _instance = this;
                _popList = new Dictionary(true);
                _popupDic = new Dictionary();
            }
            else
            {
                throw getQualifiedClassName(this) + "is a singletion class.";
            }
            return;
        }// end function

        public function init(popUplayer:Sprite, mainLayer:Sprite, sceenSize:Object) : void
        {
            _popUpLayer = popUplayer;
            _mainLayer = mainLayer;
            _sceenSize = sceenSize;
            _blurFilter = new BlurFilter(4, 4, 3);
            return;
        }// end function

        public function popUpCenter(obj:DisplayObject, isModal:Boolean = true, tag:String = null, isBlur:Boolean = false, bgAlpha:Number = 0) : void
        {
            popUp(obj, isModal, tag, isBlur, bgAlpha);
            obj.x = _sceenSize.width - obj.width >> 1;
            obj.y = _sceenSize.height - obj.height >> 1;
            return;
        }// end function

        public function popUp(obj:DisplayObject, isModal:Boolean = true, tag:String = null, isBlur:Boolean = false, bgAlpha:Number = 0) : void
        {
            var _loc_6 = null;
            if (!obj)
            {
                return;
            }
            if (isModal)
            {
                _loc_6 = new Sprite();
                _loc_6.graphics.beginFill(0, bgAlpha);
                _loc_6.graphics.drawRect(0, 0, _sceenSize.width, _sceenSize.height);
                _loc_6.graphics.endFill();
                _popUpLayer.addChild(_loc_6);
                _loc_6.addChild(obj);
                _popList[obj] = _loc_6;
                if (isBlur)
                {
                    _mainLayer.filters = [_blurFilter];
                }
            }
            else
            {
                _popUpLayer.addChild(obj);
            }
            if (tag)
            {
                removePopUpByTag(tag);
                _popupDic[tag] = obj;
            }
            return;
        }// end function

        public function removePopUp(obj:DisplayObject) : void
        {
            if (!obj)
            {
                return;
            }
            if (_popList[obj])
            {
                _mainLayer.filters = [];
                if (_popUpLayer.contains(obj))
                {
                    _popUpLayer.removeChild(_popList[obj]);
                }
                delete _popList[obj];
            }
            else if (_popUpLayer.contains(obj))
            {
                _popUpLayer.removeChild(obj);
            }
            return;
        }// end function

        public function removePopUpByTag(tag:String) : void
        {
            if (_popupDic[tag])
            {
                removePopUp(_popupDic[tag]);
                delete _popupDic[tag];
            }
            return;
        }// end function

        public function checkPopUpByTag(tag:String) : Boolean
        {
            return _popupDic[tag] != null;
        }// end function

        public function removeAllPopUp() : void
        {
            for (var _loc_1 in _popupDic)
            {
                removePopUpByTag(_loc_1);
            }
            for (var _loc_2 in _popList)
            {
                removePopUp(_loc_2);
            }
            return;
        }// end function

        public static function shared() : PopUpManager
        {
            return _instance || new PopUpManager;
        }// end function

    }
}
