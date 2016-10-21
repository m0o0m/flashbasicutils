package com.ql.gameKit.manager
{
    import com.ql.gameKit.extensions.customLoader.*;
    import flash.utils.*;

    public class LoaderManager extends Object
    {
        private var _loaderDic:Dictionary;
        private static var _instance:LoaderManager;

        public function LoaderManager()
        {
            if (!_instance)
            {
                _instance = this;
                _loaderDic = new Dictionary(true);
            }
            return;
        }// end function

        public function addLoader(loaderVO:LoaderVO) : void
        {
            var _loc_2 = null;
            if (loaderVO)
            {
                if (!_loaderDic[loaderVO.id])
                {
                    _loc_2 = new CustomLoader(loaderVO);
                    _loaderDic[loaderVO.id] = _loc_2;
                    _loc_2.start();
                }
            }
            return;
        }// end function

        public function removeLoader(id:String) : void
        {
            if (id && _loaderDic[id])
            {
                _loaderDic[id].destroy();
                delete _loaderDic[id];
            }
            return;
        }// end function

        public function clearAll() : void
        {
            for each (var _loc_1 in _loaderDic)
            {
                
                _loc_1.destroy();
            }
            _loaderDic = new Dictionary(true);
            return;
        }// end function

        public static function shared() : LoaderManager
        {
            return _instance || new LoaderManager;
        }// end function

    }
}
