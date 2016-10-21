package com.ql.gameKit.uiComponent.impl
{
    import com.ql.gameKit.manager.*;
    import flash.display.*;

    public class NumberItemImpl extends Sprite
    {
        private var _assetName:String;
        private var _skinName:String;
        private var _value:String;

        public function NumberItemImpl(assetName:String, skinName:String)
        {
            _assetName = assetName;
            _skinName = skinName;
            return;
        }// end function

        public function get value() : String
        {
            return _value;
        }// end function

        public function set value(data:String) : void
        {
            var _loc_2 = null;
            if (_value != data)
            {
                _value = data;
                removeChildren();
                _loc_2 = AssetManager.shared().getMovieClip(_assetName, _skinName);
                _loc_2.gotoAndStop(_value == "." ? (11) : ((_value + 1)));
                addChild(_loc_2);
            }
            return;
        }// end function

    }
}
