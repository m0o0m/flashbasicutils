package com.ql.gameKit.utils.filter
{
    import flash.filters.*;

    dynamic public class ColorMatrixFilterProxy extends Object
    {
        private var _type:int;
        private var _n:int;
        public static const SATURATION:int = 0;
        public static const CONTRAST:int = 1;
        public static const BRIGHTNESS:int = 2;
        public static const INVERSION:int = 3;
        public static const HUE:int = 4;
        public static const THRESHOLD:int = 5;

        public function ColorMatrixFilterProxy(type:int, n:int)
        {
            this.type = type;
            this.n = n;
            return;
        }// end function

        public function get n() : int
        {
            return _n;
        }// end function

        public function set n(v:int) : void
        {
            _n = v;
            return;
        }// end function

        public function get type() : int
        {
            return _type;
        }// end function

        public function set type(v:int) : void
        {
            _type = v;
            return;
        }// end function

        public static function createSaturationFilter(n:Number) : ColorMatrixFilter
        {
            return new ColorMatrixFilter([0.3086 * (1 - n) + n, 0.6094 * (1 - n), 0.082 * (1 - n), 0, 0, 0.3086 * (1 - n), 0.6094 * (1 - n) + n, 0.082 * (1 - n), 0, 0, 0.3086 * (1 - n), 0.6094 * (1 - n), 0.082 * (1 - n) + n, 0, 0, 0, 0, 0, 1, 0]);
        }// end function

        public static function createContrastFilter(n:Number) : ColorMatrixFilter
        {
            return new ColorMatrixFilter([n, 0, 0, 0, 128 * (1 - n), 0, n, 0, 0, 128 * (1 - n), 0, 0, n, 0, 128 * (1 - n), 0, 0, 0, 1, 0]);
        }// end function

        public static function createBrightnessFilter(n:Number) : ColorMatrixFilter
        {
            return new ColorMatrixFilter([1, 0, 0, 0, n, 0, 1, 0, 0, n, 0, 0, 1, 0, n, 0, 0, 0, 1, 0]);
        }// end function

        public static function createInversionFilter() : ColorMatrixFilter
        {
            return new ColorMatrixFilter([-1, 0, 0, 0, 255, 0, -1, 0, 0, 255, 0, 0, -1, 0, 255, 0, 0, 0, 1, 0]);
        }// end function

        public static function createHueFilter(n:Number) : ColorMatrixFilter
        {
            var _loc_4:Number = NaN;
            _loc_4 = 0.213;
            var _loc_3:Number = NaN;
            _loc_3 = 0.715;
            var _loc_2:Number = NaN;
            _loc_2 = 0.072;
            var _loc_6:* = Math.cos(n * 3.14159 / 180);
            var _loc_5:* = Math.sin(n * 3.14159 / 180);
            return new ColorMatrixFilter([0.213 + _loc_6 * (1 - 0.213) + _loc_5 * -0.213, 0.715 + _loc_6 * -0.715 + _loc_5 * -0.715, 0.072 + _loc_6 * -0.072 + _loc_5 * (1 - 0.072), 0, 0, 0.213 + _loc_6 * -0.213 + _loc_5 * 0.143, 0.715 + _loc_6 * (1 - 0.715) + _loc_5 * 0.14, 0.072 + _loc_6 * -0.072 + _loc_5 * -0.283, 0, 0, 0.213 + _loc_6 * -0.213 + _loc_5 * -0.787, 0.715 + _loc_6 * -0.715 + _loc_5 * 0.715, 0.072 + _loc_6 * (1 - 0.072) + _loc_5 * 0.072, 0, 0, 0, 0, 0, 1, 0]);
        }// end function

        public static function createThresholdFilter(n:Number) : ColorMatrixFilter
        {
            return new ColorMatrixFilter([79.0016, 156.006, 20.992, 0, -256 * n, 79.0016, 156.006, 20.992, 0, -256 * n, 79.0016, 156.006, 20.992, 0, -256 * n, 0, 0, 0, 1, 0]);
        }// end function

    }
}
