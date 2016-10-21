package com.ql.gameKit.manager
{
    import flash.utils.*;

    public class TimeOutManager extends Object
    {
        private var _timeoutDic:Dictionary;
        private static var _instance:TimeOutManager;

        public function TimeOutManager()
        {
            if (!_instance)
            {
                _instance = this;
                _timeoutDic = new Dictionary();
            }
            return;
        }// end function

        public function add(tag:String, id:int) : void
        {
            _timeoutDic[tag] = id;
            return;
        }// end function

        public function getItem(tag:String) : int
        {
            return _timeoutDic[tag];
        }// end function

        public function getItemsContainTag(tag:String) : Array
        {
            var _loc_3:Array = [];
            for (var _loc_2 in _timeoutDic)
            {
                
                if (_loc_2.indexOf(tag) != -1)
                {
                    _loc_3.push(_loc_2);
                }
            }
            return _loc_3;
        }// end function

        public function clearItemContainTag(tag:String) : void
        {
            for (var _loc_2 in _timeoutDic)
            {
                
                if (_loc_2.indexOf(tag) != -1)
                {
                    clear(_loc_2);
                }
            }
            return;
        }// end function

        public function clear(tag:String) : void
        {
            if (_timeoutDic[tag])
            {
                clearTimeout(_timeoutDic[tag]);
                delete _timeoutDic[tag];
            }
            return;
        }// end function

        public function clearAll() : void
        {
            for each (var _loc_1 in _timeoutDic)
            {
                
                clearTimeout(_loc_1);
            }
            _timeoutDic = new Dictionary();
            return;
        }// end function

        public static function shared() : TimeOutManager
        {
            return _instance || new TimeOutManager;
        }// end function

    }
}
