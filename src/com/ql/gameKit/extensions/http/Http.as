package com.ql.gameKit.extensions.http
{
    import flash.events.*;
    import flash.net.*;
    import flash.utils.*;

    public class Http extends Object
    {
        public var data:HttpVO;
        private var _loader:URLLoader;
        private var _reConnectCount:int;
        private var _timeoutTimer:Timer;

        public function Http()
        {
            init();
            return;
        }// end function

        private function init() : void
        {
            _loader = new URLLoader();
            _loader.addEventListener("complete", onComplete);
            _loader.addEventListener("ioError", onIOError);
            _loader.addEventListener("securityError", onSecurityError);
            _timeoutTimer = new Timer(1000);
            _timeoutTimer.addEventListener("timer", onTimeoutCounter);
            return;
        }// end function

        private function onTimeoutCounter(event:TimerEvent) : void
        {
            if (_timeoutTimer.currentCount > data.timeout)
            {
                checkError();
            }
            return;
        }// end function

        public function send(data:HttpVO) : void
        {
            if (!data)
            {
                throw "send data is not null.";
            }
            this.data = data;
            _loader.dataFormat = data.dataType;
            var _loc_2:* = new URLVariables();
            if (data.data)
            {
                for (_loc_4 in data.data)
                {
                    
                    _loc_2[_loc_4] = data.data[_loc_4];
                }
                _loc_2["r"] = Math.random() * 1000;
            }
            var _loc_3:* = new URLRequest(data.url);
            _loc_3.method = data.method;
            _loc_3.data = _loc_2;
            try
            {
                _loader.load(_loc_3);
            }
            catch (error)
            {
                return;
            }
            _timeoutTimer.start();
            return;
        }// end function

        private function onComplete(event:Event) : void
        {
            _reConnectCount = 0;
            _timeoutTimer.reset();
            if (data != null && data.completeCallback != null)
            {
                data.completeCallback(data.id, event.currentTarget.data);
            }
            destroy();
            return;
        }// end function

        private function onIOError(event:IOErrorEvent) : void
        {
            checkError();
            return;
        }// end function

        private function onSecurityError(event:SecurityErrorEvent) : void
        {
            checkError();
            return;
        }// end function

        private function checkError() : void
        {
            _timeoutTimer.reset();
            (_reConnectCount + 1);
            if ((_reConnectCount + 1) < data.reConnectCount)
            {
                send(data);
            }
            else
            {
                if (data && data.errorCallback != null)
                {
                    data.errorCallback(data.id);
                }
                destroy();
            }
            return;
        }// end function

        private function destroy() : void
        {
            if (_loader)
            {
                _loader.removeEventListener("complete", onComplete);
                _loader.removeEventListener("ioError", onIOError);
                _loader.removeEventListener("securityError", onSecurityError);
                _loader = null;
            }
            if (_timeoutTimer)
            {
                _timeoutTimer.removeEventListener("timer", onTimeoutCounter);
                _timeoutTimer = null;
            }
            data = null;
            return;
        }// end function

    }
}
