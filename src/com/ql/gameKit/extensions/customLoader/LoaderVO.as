package com.ql.gameKit.extensions.customLoader
{

    public class LoaderVO extends Object
    {
        public var id:String;
        public var url:String;
        public var isClearCache:Boolean;
        public var fileType:String;
        public var reloadCount:int;
        public var completeCallback:Function;
        public var errorCallback:Function;
        public var progressCallback:Function;
        public var timeout:int;

        public function LoaderVO(id:String, url:String, fileType:String, isClearCache:Boolean, completeCallback:Function, errorCallback:Function = null, progressCallback:Function = null, reloadCount:int = 0, timeout:int = 60000)
        {
            this.id = id;
            this.url = url;
            this.fileType = fileType;
            this.reloadCount = reloadCount;
            this.isClearCache = isClearCache;
            this.completeCallback = completeCallback;
            this.errorCallback = errorCallback;
            this.progressCallback = progressCallback;
            this.timeout = timeout < 20 ? (20) : (timeout);
            return;
        }// end function

    }
}
