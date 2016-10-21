package com.ql.gameKit.utils
{
    import com.ql.gameKit.core.*;
    import flash.display.*;
    import flash.events.*;
    import flash.system.*;
    import flash.utils.*;

    public class LoadBinaryUtil extends Object
    {

        public function LoadBinaryUtil()
        {
            return;
        }// end function

        public static function load(byte:ByteArray, callback:Function) : void
        {
            byte = byte;
            callback = callback;
            Context.getInstance().getContext(byte, function (param1:ByteArray) : void
            {
                var content = param1;
                var byteLoader:* = new Loader();
                byteLoader.contentLoaderInfo.addEventListener("complete", function (event:Event) : void
                {
                    if (callback != null)
                    {
                        callback(byteLoader);
                    }
                    return;
                }// end function
                );
                byteLoader.loadBytes(content, new LoaderContext(false, new ApplicationDomain()));
                return;
            }// end function
            , true);
            return;
        }// end function

    }
}
