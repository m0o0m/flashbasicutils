package com.ql.gameKit.manager
{
    import flash.display.*;
    import flash.media.*;
    import flash.utils.*;

    public class AssetManager extends Object
    {
        private var _assets:Dictionary;
        private static var _instance:AssetManager;

        public function AssetManager()
        {
            _instance = this;
            return;
        }// end function

        public function storeAsset(name:String, asset:Loader) : void
        {
            if (!_assets)
            {
                _assets = new Dictionary(false);
            }
            if (name && asset)
            {
                _assets[name] = asset;
            }
            return;
        }// end function

        public function getAsset(name:String) : Loader
        {
            var _loc_2 = null;
            if (_assets)
            {
                _loc_2 = _assets[name];
            }
            return _loc_2;
        }// end function

        public function removeAssset(name:String) : void
        {
            var _loc_2 = null;
            if (name != null && _assets)
            {
                _loc_2 = getAsset(name);
                if (_loc_2)
                {
                    _loc_2.unloadAndStop();
                }
                _assets[name] = null;
                delete _assets[name];
            }
            return;
        }// end function

        public function getClass(assetName:String, className:String) : Class
        {
            var _loc_4 = null;
            var _loc_3 = null;
            if (assetName && className && _assets)
            {
                _loc_3 = getAsset(assetName);
                if (_loc_3)
                {
                    try
                    {
                        _loc_4 = _loc_3.contentLoaderInfo.applicationDomain.getDefinition(className) as Class;
                    }
                    catch (e:Error)
                    {
                    }
                }
            }
            return _loc_4;
        }// end function

        public function getMovieClip(assetName:String, mcName:String) : MovieClip
        {
            var _loc_3 = null;
            var _loc_4 = null;
            if (assetName && mcName)
            {
                _loc_4 = getClass(assetName, mcName);
                if (_loc_4)
                {
                    _loc_3 = new _loc_4 as MovieClip;
                }
            }
            return _loc_3;
        }// end function

        public function getBitmap(assetName:String, targetName:String) : Bitmap
        {
            var _loc_4 = null;
            var _loc_3:* = getBitmapData(assetName, targetName);
            if (_loc_3)
            {
                _loc_4 = new Bitmap(_loc_3);
            }
            return _loc_4;
        }// end function

        public function getBitmapData(assetName:String, targetName:String, width:int = -1, height:int = -1) : BitmapData
        {
            var _loc_5 = null;
            var _loc_6 = null;
            if (assetName && targetName)
            {
                _loc_6 = getClass(assetName, targetName);
                if (_loc_6)
                {
                    if (width == -1 || height == -1)
                    {
                        _loc_5 = new _loc_6 as BitmapData;
                    }
                    else
                    {
                        _loc_5 = new _loc_6(6, 6) as BitmapData;
                    }
                }
            }
            return _loc_5;
        }// end function

        public function getSound(assetName:String, targetName:String) : Sound
        {
            var _loc_4 = null;
            var _loc_3 = null;
            if (assetName && targetName)
            {
                _loc_3 = getClass(assetName, targetName);
                if (_loc_3)
                {
                    _loc_4 = new _loc_3 as Sound;
                }
            }
            return _loc_4;
        }// end function

        public function getButton(assetName:String, targetName:String) : SimpleButton
        {
            var _loc_4 = null;
            var _loc_3 = null;
            if (assetName && targetName)
            {
                _loc_3 = getClass(assetName, targetName);
                if (_loc_3)
                {
                    _loc_4 = new _loc_3 as SimpleButton;
                }
            }
            return _loc_4;
        }// end function

        public function getSprite(assetName:String, targetName:String) : Sprite
        {
            var _loc_4 = null;
            var _loc_3 = null;
            if (assetName && targetName)
            {
                _loc_3 = getClass(assetName, targetName);
                if (_loc_3)
                {
                    _loc_4 = new _loc_3 as Sprite;
                }
            }
            return _loc_4;
        }// end function

        public function destroyAsset() : void
        {
            if (_assets)
            {
                for each (var _loc_1 in _assets)
                {
                    
                    _loc_1.unloadAndStop();
                }
                _assets = null;
            }
            return;
        }// end function

        public static function shared() : AssetManager
        {
            return _instance || new AssetManager;
        }// end function

    }
}
