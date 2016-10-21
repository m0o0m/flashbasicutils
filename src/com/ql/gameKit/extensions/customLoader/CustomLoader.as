package com.ql.gameKit.extensions.customLoader
{
    import flash.display.Loader;
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.events.ProgressEvent;
    import flash.events.SecurityErrorEvent;
    import flash.events.TimerEvent;
    import flash.net.URLLoader;
    import flash.net.URLRequest;
    import flash.net.URLStream;
    import flash.system.ApplicationDomain;
    import flash.system.LoaderContext;
    import flash.utils.Timer;

    public class CustomLoader extends Object implements ICustomLoader
    {
        private var _loader:Object;
        private var _eventOwner:Object;
        private var _data:LoaderVO;
        private var _isStart:Boolean;
        private var _reloadCount:int;
        private var _checkTimeoutTimer:Timer;

        public function CustomLoader(data:LoaderVO)
        {
            _data = data;
            return;
        }// end function

        public function get data() : LoaderVO
        {
            return _data;
        }// end function

        public function set data(value:LoaderVO) : void
        {
            _data = value;
            return;
        }// end function

        public function start() : void
        {
            var _loc_1:String = null;
            if (!_data)
            {
                throw "loader data is null";
            }
            if (!_isStart)
            {
                _isStart = true;
	                if (!_loader)
	                {
	                    var _loc_2:* = _data.fileType;
	                    if (_loc_2 == "text")
	                    {
	                        
	                        _loader = new URLLoader();
	                        _eventOwner = _loader;
						
	                }else if(_loc_2 == "bytes"){
						_loader = new Loader();
						_eventOwner = (_loader as Loader).contentLoaderInfo;
						
					}else if(_loc_2 == "stream"){
						_loader = new URLStream();
						_eventOwner = _loader;
					};
						
	                _eventOwner.addEventListener("complete", onComplete);
	                _eventOwner.addEventListener("ioError", onError);
	                _eventOwner.addEventListener("progress", onProgress);
	                _eventOwner.addEventListener("securityError", onSECError);
	                _loc_1 = _data.url;
	                if (_data.isClearCache)
	                {
	                    _loc_1 = _loc_1 + ((_loc_1.lastIndexOf("?") == -1 ? ("?r=") : ("&r=")) + Math.random() * 10000);
	                }
	                trace("load >>" + _loc_1);
	                if (_data.fileType == "bytes")
	                {
	                    _loader.load(new URLRequest(_loc_1), new LoaderContext(false, new ApplicationDomain()));
	                }
	                else
	                {
	                    _loader.load(new URLRequest(_loc_1));
	                }
	                createCheckTimeoutTimer();
	            }
			}
        }// end function

        public function close(isDispose:Boolean = false) : void
        {
            _isStart = false;
            killCheckTimeoutTimer();
            if (_eventOwner)
            {
                _eventOwner.removeEventListener("complete", onComplete);
                _eventOwner.removeEventListener("ioError", onError);
                _eventOwner.removeEventListener("progress", onProgress);
                _eventOwner.removeEventListener("securityError", onSECError);
                if (isDispose)
                {
                    _eventOwner = null;
                }
            }
            if (isDispose && _loader)
            {
                _loader = null;
            }
            return;
        }// end function

        public function destroy() : void
        {
            close();
            if (_data.fileType == "bytes")
            {
                (_loader as Loader).unloadAndStop();
            }
            _loader = null;
            return;
        }// end function

        private function onComplete(event:Event) : void
        {
            if (_data && _data.completeCallback != null)
            {
                _data.completeCallback(_data.id, _loader);
            }
            close();
            return;
        }// end function

        private function onSECError(event:SecurityErrorEvent) : void
        {
            return;
        }// end function

        private function onError(event:IOErrorEvent) : void
        {
            close(true);
            (_reloadCount + 1);
            if (_data.reloadCount >= (_reloadCount + 1))
            {
                start();
            }
            else if (_data && _data.errorCallback != null)
            {
                _data.errorCallback(_data.id);
            }
            return;
        }// end function

        private function onProgress(event:ProgressEvent) : void
        {
            var _loc_2:* = event.bytesLoaded / event.bytesTotal * 100;
            if (_data && _data.progressCallback != null)
            {
                _data.progressCallback(_data.id, _loc_2);
            }
            return;
        }// end function

        private function createCheckTimeoutTimer() : void
        {
            if (!_checkTimeoutTimer)
            {
                _checkTimeoutTimer = new Timer(_data.timeout, 1);
            }
            if (!_checkTimeoutTimer.hasEventListener("timerComplete"))
            {
                _checkTimeoutTimer.addEventListener("timerComplete", onCheckTimeoutComplete);
            }
            _checkTimeoutTimer.reset();
            _checkTimeoutTimer.start();
            return;
        }// end function

        private function killCheckTimeoutTimer() : void
        {
            if (_checkTimeoutTimer)
            {
                _checkTimeoutTimer.stop();
                _checkTimeoutTimer.removeEventListener("timerComplete", onCheckTimeoutComplete);
                _checkTimeoutTimer = null;
            }
            return;
        }// end function

        protected function onCheckTimeoutComplete(event:TimerEvent) : void
        {
            onError(null);
            return;
        }// end function

    }
}
