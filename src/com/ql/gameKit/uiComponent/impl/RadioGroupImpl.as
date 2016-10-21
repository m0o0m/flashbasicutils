package com.ql.gameKit.uiComponent.impl
{
    import __AS3__.vec.*;

    public class RadioGroupImpl extends Object
    {
        private var _group:Vector.<RadioImpl>;

        public function RadioGroupImpl()
        {
            init();
            return;
        }// end function

        private function init() : void
        {
            _group = new Vector.<RadioImpl>;
            return;
        }// end function

        public function addItem(item:RadioImpl) : void
        {
            if (item && _group.lastIndexOf(item) == -1)
            {
                item.setSelectedCallback(update);
                _group.push(item);
            }
            return;
        }// end function

        private function update(selectedItem:RadioImpl) : void
        {
            var _loc_2:int = 0;
            _loc_2 = _group.length - 1;
            while (_loc_2 >= 0)
            {
                
                if (_group[_loc_2] != selectedItem)
                {
                    _group[_loc_2].setSelected(false);
                }
                _loc_2--;
            }
            return;
        }// end function

        public function setSelected(index:int) : void
        {
            var _loc_2:* = _group[index];
            _loc_2.setSelected(true);
            return;
        }// end function

    }
}
