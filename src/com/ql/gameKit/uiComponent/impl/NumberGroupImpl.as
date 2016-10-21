package com.ql.gameKit.uiComponent.impl
{
    import __AS3__.vec.*;
    import flash.display.*;

    public class NumberGroupImpl extends Sprite
    {
        private var _assetName:String;
        private var _skinName:String;
        private var _numberPool:Vector.<NumberItemImpl>;
        private var _gap:int;
        private var _value:String;

        public function NumberGroupImpl(assetName:String, skinName:String, gap:int)
        {
            _gap = gap;
            _assetName = assetName;
            _skinName = skinName;
            _numberPool = new Vector.<NumberItemImpl>;
            return;
        }// end function

        public function get value() : String
        {
            return _value;
        }// end function

        public function set value(value:String) : void
        {
            var _loc_2:int = 0;
            var _loc_4 = null;
            var _loc_3:Number = NaN;
            var _loc_5:int = 0;
            if (_value != value)
            {
                _value = value;
                recycleItem();
                _loc_2 = value.length;
                _loc_5 = 0;
                while (_loc_5 < _loc_2)
                {
                    
                    if (_loc_4)
                    {
                        _loc_3 = _loc_4.x + _loc_4.width + _gap;
                    }
                    _loc_4 = createItem(value.charAt(_loc_5));
                    _loc_4.x = _loc_3;
                    addChild(_loc_4);
                    _loc_5++;
                }
            }
            return;
        }// end function

        private function recycleItem() : void
        {
            while (numChildren > 0)
            {
                
                _numberPool.push(removeChildAt(0) as NumberItemImpl);
            }
            return;
        }// end function

        private function createItem(num:String) : NumberItemImpl
        {
            var _loc_2 = null;
            if (_numberPool.length > 0)
            {
                _loc_2 = _numberPool.pop();
            }
            else
            {
                _loc_2 = new NumberItemImpl(_assetName, _skinName);
            }
            if (_loc_2.value != num)
            {
                _loc_2.value = num;
            }
            return _loc_2;
        }// end function

    }
}
