package com.ql.gameKit.extensions.video
{

    public class VideoVO extends Object
    {
        public var url:String;
        public var buffer:Number;
        private const PROTOCOL:Array = ["rtmp", "rtmfp"];

        public function VideoVO(url:String, buffer:Number = 0)
        {
            this.url = url;
            this.buffer = buffer;
            return;
        }// end function

        public function isValid() : Boolean
        {
            var _loc_1:int = 0;
            if (url)
            {
                _loc_1 = PROTOCOL.length - 1;
                while (_loc_1 >= 0)
                {
                    
                    if (url.indexOf(PROTOCOL[_loc_1]) != -1)
                    {
                        return true;
                    }
                    _loc_1--;
                }
            }
            return false;
        }// end function

    }
}
