package com.ql.gameKit.uiComponent.impl
{
    import flash.text.*;

    public class TextFieldImpl extends Object
    {

        public function TextFieldImpl()
        {
            return;
        }// end function

        public static function optimize(target:TextField, isBold:Boolean = false) : void
        {
            var _loc_3 = null;
            if (target)
            {
                target.antiAliasType = "advanced";
                if (isBold)
                {
                    _loc_3 = new TextFormat();
                    _loc_3.bold = true;
                    target.defaultTextFormat = _loc_3;
                }
            }
            return;
        }// end function

    }
}
