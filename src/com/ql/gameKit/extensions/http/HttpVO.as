package com.ql.gameKit.extensions.http
{

    public class HttpVO extends Object
    {
        public var id:String;
        public var url:String;
        public var data:Object;
        public var timeout:int;
        public var method:String;
        public var dataType:String;
        public var reConnectCount:int;
        public var isClearCache:Boolean;
        public var errorCallback:Function;
        public var completeCallback:Function;

        public function HttpVO(id:String, url:String = "", method:String = "get", dataType:String = "text", data:Object = null, completeCallback:Function = null, errorCallback:Function = null, isClearCache:Boolean = true, reConnectCount:int = 0, timeout:int = 15000)
        {
            this.id = id;
            this.url = url;
            this.data = data;
            this.method = method;
            this.timeout = timeout;
            this.dataType = dataType;
            this.isClearCache = isClearCache;
            this.errorCallback = errorCallback;
            this.reConnectCount = reConnectCount;
            this.completeCallback = completeCallback;
            return;
        }// end function

    }
}
