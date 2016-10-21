package com.ql.gameKit.uiComponent.impl
{
    import flash.display.*;
    import flash.events.*;

    public class ComboBoxImpl extends Object
    {
        private var _target:MovieClip;
        private var _itemClass:Class;
        private var _isPopup:Boolean;
        private var _itemPool:Array;
        private var _itemContainer:Sprite;
        private var _selectedIndex:int;
        private var _dataSource:Array;

        public function ComboBoxImpl(target:MovieClip, cbItemClass:Class)
        {
            _target = target;
            _itemClass = cbItemClass;
            init();
            return;
        }// end function

        public function get selectedIndex() : int
        {
            return _selectedIndex;
        }// end function

        public function set selectedIndex(value:int) : void
        {
            var _loc_2 = null;
            if (_selectedIndex != value)
            {
                _selectedIndex = value;
                recycleItem();
                _loc_2 = createItem(_dataSource[_selectedIndex].label, false);
                _loc_2.x = -_loc_2.width + 2;
                _loc_2.y = 2;
                _loc_2.mouseEnabled = false;
                _itemContainer.addChild(_loc_2);
            }
            return;
        }// end function

        public function getselectedData() : Object
        {
            return _dataSource[_selectedIndex];
        }// end function

        private function init() : void
        {
            _target.btn.addEventListener("click", onClickBtn);
            _itemPool = [];
            _itemContainer = new Sprite();
            _target.addChild(_itemContainer);
            return;
        }// end function

        protected function onClickStage(event:MouseEvent) : void
        {
            if (event.target != _target.btn)
            {
                hide();
            }
            return;
        }// end function

        private function onClickBtn(event:MouseEvent) : void
        {
            if (!_isPopup)
            {
                show();
            }
            else
            {
                hide();
            }
            return;
        }// end function

        private function show() : void
        {
            var _loc_2 = null;
            var _loc_3:int = 0;
            _isPopup = true;
            recycleItem();
            var _loc_1:* = _dataSource.length;
            _loc_3 = 0;
            while (_loc_3 < _loc_1)
            {
                
                _loc_2 = createItem(_dataSource[_loc_3].label);
                _loc_2.x = -_loc_2.width + 2;
                _loc_2.y = _loc_3 * _loc_2.height + _loc_3 * 1;
                _loc_2.mouseEnabled = true;
                _itemContainer.addChild(_loc_2);
                _loc_3++;
            }
            _target.parent.stage.addEventListener("click", onClickStage);
            return;
        }// end function

        private function hide() : void
        {
            _isPopup = false;
            var _loc_1:* = _selectedIndex;
            _selectedIndex = -1;
            selectedIndex = _loc_1;
            _target.parent.stage.removeEventListener("click", onClickStage);
            return;
        }// end function

        public function get dataSource() : Array
        {
            return _dataSource;
        }// end function

        public function set dataSource(value:Array) : void
        {
            _dataSource = value;
            _selectedIndex = -1;
            selectedIndex = 0;
            return;
        }// end function

        private function recycleItem() : void
        {
            var _loc_1 = null;
            while (_itemContainer.numChildren > 0)
            {
                
                _loc_1 = _itemContainer.removeChildAt(0) as Sprite;
                _loc_1.removeEventListener("click", onClickItem);
                _itemPool.push(_loc_1);
            }
            return;
        }// end function

        private function createItem(label:String, isEnabled:Boolean = true) : Sprite
        {
            var _loc_3 = null;
            if (_itemPool.length > 0)
            {
                _loc_3 = _itemPool.pop();
            }
            else
            {
                _loc_3 = new _itemClass();
            }
            _loc_3["label"] = label;
            if (isEnabled)
            {
                _loc_3.addEventListener("click", onClickItem);
            }
            return _loc_3;
        }// end function

        private function onClickItem(event:MouseEvent) : void
        {
            selectedIndex = _itemContainer.getChildIndex(event.currentTarget as Sprite);
            hide();
            return;
        }// end function

    }
}
