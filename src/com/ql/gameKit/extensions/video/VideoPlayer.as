package com.ql.gameKit.extensions.video
{
    import __AS3__.vec.*;
    import com.ql.gameKit.extensions.debug.*;
    import com.ql.gameKit.manager.*;
    import com.ql.gameKit.utils.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.media.*;
    import flash.net.*;
    import flash.utils.*;

    public class VideoPlayer extends Sprite
    {
        private var _videoWidth:Number;
        private var _videoHeight:Number;
        private var _videoUrl:String;
        private var _videoTarget:String;
        private var _reConnectCounter:int;
        private var _netConnection:NetConnection;
        private var _netStream:NetStream;
        private var _isManualStop:Boolean;
        private var _isShowPrompt:Boolean;
        private var _isPlaying:Boolean;
        private var _spPrompt:VideoPrompt;
        private var _container:Sprite;
        private var _video:Video;
        private var _voVideo:VideoVO;
        private var _sources:Vector.<VideoVO>;
        private var _getVideoDelayCallback:Function;
        private var _pingTimer:Timer;
        private var _playerName:String;
        private var _checkPlayingCallback:Function;
        private var _videoStreamTime:Number;
        private var _checkPingTimoutTimer:Timer;
        private var _pingInterval:int;
        private var _connectionTimer:Timer;
        private var _playTimeoutID:int;
        private var _checkPlayingTimeout:int;
        private var _networkDelay:int;
        private const ZOOM_EASING:Number = 0.1;
        private var _zoomTimer:Timer;
        private var _zoomVal:Number;
        private var _zoomPoint:Point;
        private var _zoomType:String;

        public function VideoPlayer()
        {
            return;
        }// end function

        public function get isPlaying() : Boolean
        {
            return _isPlaying;
        }// end function

        public function init(width:Number, height:Number, sources:Vector.<VideoVO>, showPrompt:Boolean = true, getVideoDelay:Function = null, pingInterval:int = 3000, playerName:String = null, checkPlayingCallback:Function = null, checkPlayingTimeout:int = 10000) : void
        {
            if (!sources)
            {
                return;
            }
            _videoStreamTime = 0;
            _videoWidth = width;
            _videoHeight = height;
            _isShowPrompt = showPrompt;
            _getVideoDelayCallback = getVideoDelay;
            _checkPlayingCallback = checkPlayingCallback;
            _playerName = playerName;
            _checkPlayingTimeout = checkPlayingTimeout;
            _pingInterval = pingInterval;
            if (_getVideoDelayCallback)
            {
                _pingTimer = new Timer(pingInterval);
                _pingTimer.addEventListener("timer", onPingTimer);
                _checkPingTimoutTimer = new Timer(pingInterval);
                _checkPingTimoutTimer.addEventListener("timer", onCheckPingTimer);
            }
            if (_isShowPrompt)
            {
                _spPrompt = new VideoPrompt(_videoWidth, _videoHeight);
                addChild(_spPrompt);
            }
            _container = new Sprite();
            _container.graphics.beginFill(0, 0);
            _container.graphics.drawRect(0, 0, _videoWidth, _videoHeight);
            _container.graphics.endFill();
            addChild(_container);
			//遮罩创建,
            var _loc_10:* = new Sprite();
			_loc_10.graphics.beginFill(16776960, 1);
            _loc_10.graphics.drawRect(0, 0, _videoWidth, _videoHeight);
            _loc_10.graphics.endFill();
            addChild(_loc_10);
            _container.mask = _loc_10;
            _sources = sources.concat();
            return;
        }// end function

        public function play(line:int, clarityTag:String) : void
        {
            var _loc_4 = null;
            var _loc_3:int = 0;
            if (_isShowPrompt)
            {
                _spPrompt.connecting();
            }
            stopVideo(1);
            if (line >= 0 && line < _sources.length && _sources[line])
            {
                _loc_4 = _sources[line];
                if (_loc_4 && _loc_4.isValid())
                {
                    _loc_3 = _loc_4.url.lastIndexOf("/");
                    _videoUrl = _loc_4.url.slice(0, _loc_3);
                    _videoTarget = _loc_4.url.slice((_loc_3 + 1));
                    if (clarityTag)
                    {
                        _videoTarget = _videoTarget + clarityTag;
                    }
                    _voVideo = _loc_4;
                    setTimeout(createConnection, 50);
                }
                else
                {
                    TimeOutManager.shared().add("PlayingError", setTimeout(playingErrorCallback, 1000));
                }
            }
            else
            {
                TimeOutManager.shared().add("PlayingError", setTimeout(playingErrorCallback, 1000));
            }
            return;
        }// end function

        private function createConnection() : void
        {
            _netConnection = new NetConnection();
            _netConnection.client = this;
            _netConnection.addEventListener("ioError", onError, false, 0, true);
            _netConnection.addEventListener("securityError", onError, false, 0, true);
            _netConnection.addEventListener("asyncError", onError, false, 0, true);
            _netConnection.addEventListener("netStatus", onNetStatus);
            _netConnection.connect(StringFormatter.trim(_videoUrl), _playerName);
            startConnectionTimer();
            return;
        }// end function

        private function startConnectionTimer() : void
        {
            if (!_connectionTimer)
            {
                _connectionTimer = new Timer(1000);
            }
            if (!_connectionTimer.hasEventListener("timer"))
            {
                _connectionTimer.addEventListener("timer", onConnectionTimer);
            }
            _connectionTimer.reset();
            _connectionTimer.start();
            return;
        }// end function

        private function stopConnectionTimer(isDestroy:Boolean) : void
        {
            if (_connectionTimer)
            {
                _connectionTimer.reset();
                _connectionTimer.removeEventListener("timer", onConnectionTimer);
            }
            if (isDestroy)
            {
                _connectionTimer = null;
            }
            return;
        }// end function

        protected function onConnectionTimer(event:TimerEvent) : void
        {
            trace("...", (event.currentTarget as Timer).currentCount);
            if ((event.currentTarget as Timer).currentCount > _checkPlayingTimeout / (event.currentTarget as Timer).delay)
            {
                stopConnectionTimer(false);
                onError(null);
            }
            return;
        }// end function

        private function onError(event) : void
        {
            if (_isShowPrompt)
            {
                _spPrompt.noSignal();
            }
            playingErrorCallback();
            var _loc_2:* = !event ? ("timeout") : (event.type);
            Logger.error(_loc_2, this);
            return;
        }// end function

        private function onNetStatus(event:NetStatusEvent) : void
        {
            event = event;
            Logger.log(event.info.code, this);
            if (event.info.code == "NetConnection.Connect.Success")
            {
                if (_netConnection.connected)
                {
                    stopConnectionTimer(false);
                    if (_netStream)
                    {
                        _netStream.close();
                        _netStream.removeEventListener("netStatus", onNetStatus);
                    }
                    _netStream = new NetStream(_netConnection);
                    _netStream.addEventListener("netStatus", onNetStatus);
                    _netStream.bufferTime = _voVideo.buffer;
                    _netStream.client = this;
                    if (!_video)
                    {
                        _video = new Video(_videoWidth, _videoHeight);
                        _video.smoothing = true;
                        _container.addChild(_video);
                    }
                    _video.attachNetStream(_netStream);
                    _netStream.play(_videoTarget);
                    _video.visible = true;
                    _isManualStop = false;
                    _reConnectCounter = 0;
                    _playTimeoutID = setTimeout(function () : void
            {
                if (!_isPlaying)
                {
                    playingErrorCallback();
                }
                return;
            }// end function
            , _checkPlayingTimeout);
                }
            }
            else if (event.info.code == "NetConnection.Connect.Closed")
            {
                clearVideo();
                _isPlaying = false;
                stopConnectionTimer(false);
                if (!_isManualStop && _isShowPrompt)
                {
                    _spPrompt.noSignal();
                }
                playingErrorCallback();
            }
            else if (event.info.code == "NetConnection.Connect.Failed")
            {
                _isPlaying = false;
                stopConnectionTimer(false);
                if (_isShowPrompt)
                {
                    _spPrompt.noSignal();
                }
                playingErrorCallback();
                clearVideo();
            }
            else if (event.info.code == "NetStream.Play.Start")
            {
                _isPlaying = true;
                clearTimeout(_playTimeoutID);
                _playTimeoutID = setTimeout(playingErrorCallback, _checkPlayingTimeout);
            }
            else if (event.info.code == "NetStream.Play.StreamNotFound")
            {
                playingErrorCallback();
            }
            return;
        }// end function

        public function stopVideo(type:int = 0) : void
        {
            if (_isShowPrompt)
            {
                _spPrompt.stop();
            }
            _isManualStop = type == 0;
            clearVideo();
            return;
        }// end function

        private function clearVideo() : void
        {
            if (_netConnection)
            {
                _netConnection.removeEventListener("ioError", onError);
                _netConnection.removeEventListener("securityError", onError);
                _netConnection.removeEventListener("asyncError", onError);
                _netConnection.removeEventListener("netStatus", onNetStatus);
                _netConnection.close();
                _netConnection = null;
            }
            if (_netStream)
            {
                _netStream.close();
                _netStream.removeEventListener("netStatus", onNetStatus);
                _netStream = null;
            }
            if (_video)
            {
                _container.removeChildren();
                _video.clear();
                _video = null;
            }
            if (_pingTimer)
            {
                _pingTimer.stop();
            }
            if (_checkPingTimoutTimer)
            {
                _checkPingTimoutTimer.stop();
            }
            if (!_isManualStop && _checkPlayingCallback != null)
            {
                this._checkPlayingCallback(false, _isManualStop);
            }
            return;
        }// end function

        public function onMetaData(info:Object) : void
        {
            playingCallback();
            return;
        }// end function

        public function onMetadata(info:Object) : void
        {
            playingCallback();
            return;
        }// end function

        private function playingErrorCallback() : void
        {
            if (!_isManualStop && _getVideoDelayCallback != null)
            {
                this._getVideoDelayCallback(-1);
            }
            return;
        }// end function

        private function playingCallback() : void
        {
            var _loc_1:Number = NaN;
            clearTimeout(_playTimeoutID);
            if (_checkPlayingCallback != null)
            {
                _loc_1 = _voVideo.buffer * 2 * 1000;
                setTimeout(_checkPlayingCallback, _loc_1 < 10 ? (10) : (_loc_1), true);
                _networkDelay = getTimer();
                updateSignal();
                if (_pingTimer)
                {
                    _pingTimer.reset();
                    _pingTimer.start();
                }
                if (_checkPingTimoutTimer)
                {
                    _checkPingTimoutTimer.reset();
                    _checkPingTimoutTimer.start();
                }
            }
            return;
        }// end function

        private function onPingTimer(event:TimerEvent) : void
        {
            if (_netConnection)
            {
                _netConnection.call("ping2", new Responder(updateSignal));
            }
            return;
        }// end function

        private function onCheckPingTimer(event:TimerEvent) : void
        {
            updateSignal(0);
            return;
        }// end function

        private function updateSignal(result:Number = 0) : void
        {
            var _loc_2:int = 0;
            if (_getVideoDelayCallback != null)
            {
                _loc_2 = getTimer() - _networkDelay - _pingInterval;
                if (_loc_2 < 0)
                {
                    _loc_2 = 0;
                }
                this._getVideoDelayCallback(_loc_2);
            }
            if (result != 0)
            {
                _networkDelay = getTimer();
            }
            return;
        }// end function

        public function destroy() : void
        {
            if (_pingTimer)
            {
                _pingTimer.stop();
                _pingTimer.removeEventListener("timer", onPingTimer);
                _pingTimer = null;
            }
            if (_checkPingTimoutTimer)
            {
                _checkPingTimoutTimer.stop();
                _checkPingTimoutTimer.removeEventListener("timer", onPingTimer);
                _checkPingTimoutTimer = null;
            }
            stopVideo();
            stopConnectionTimer(true);
            return;
        }// end function

        public function get videoStreamTime() : Number
        {
            return _videoStreamTime;
        }// end function

        public function onFI(info:Object) : void
        {
            var _loc_4:* = info.sd.split("-");
            var _loc_7:* = info.sd.split("-")[2] + "-" + (_loc_4[1] - 1) + "-" + _loc_4[0];
            var _loc_3:* = info.st.lastIndexOf(".");
            var _loc_6:* = _loc_3 > -1 ? (info.st.slice(0, _loc_3)) : (info.st);
            var _loc_5:* = _loc_7 + " " + _loc_6;
            var _loc_2:* = DateUtil.getDateByStr(_loc_5).time;
            _videoStreamTime = _loc_2;
            return;
        }// end function

        public function onBWCheck(... args) : Number
        {
            return 0;
        }// end function

        public function onBWDone(... args) : void
        {
            if (args.length > 0)
            {
                args = args[0];
            }
            return;
        }// end function

        public function close() : void
        {
            return;
        }// end function

        public function zoom(zoomVal:Number, zoomPoint:Point, zoomTime:Number, zoomType:String) : void
        {
            if (_zoomTimer != null)
            {
                if (_zoomTimer.running)
                {
                    _zoomTimer.stop();
                    _zoomTimer.removeEventListener("timer", onMotion);
                }
                _zoomTimer = null;
            }
            _zoomVal = zoomVal;
            _zoomPoint = zoomPoint;
            _zoomType = zoomType;
            _zoomTimer = new Timer(zoomTime);
            _zoomTimer.addEventListener("timer", onMotion, false, 0, true);
            _zoomTimer.start();
            return;
        }// end function

        private function onMotion(event:TimerEvent) : void
        {
            if (_zoomType == "in" && _container.scaleX < _zoomVal)
            {
                _container.scaleX = _container.scaleX + (_zoomVal - _container.scaleX) * 0.1;
                _container.scaleY = _container.scaleY + (_zoomVal - _container.scaleY) * 0.1;
                _container.x = _container.x + (_zoomPoint.x - _container.x) * 0.1;
                _container.y = _container.y + (_zoomPoint.y - _container.y) * 0.1;
            }
            else if (_zoomType == "out" && _container.scaleX > _zoomVal)
            {
                _container.scaleX = _container.scaleX + (_zoomVal - _container.scaleX) * 0.1;
                _container.scaleY = _container.scaleY + (_zoomVal - _container.scaleY) * 0.1;
                _container.x = _container.x + (_zoomPoint.x - _container.x) * 0.1;
                _container.y = _container.y + (_zoomPoint.y - _container.y) * 0.1;
            }
            else
            {
                _zoomTimer.stop();
                _zoomTimer.removeEventListener("timer", onMotion);
                var _loc_2:* = _zoomVal;
                _container.scaleY = _zoomVal;
                _container.scaleX = _loc_2;
            }
            return;
        }// end function

        public function resize() : void
        {
            if (_zoomTimer != null)
            {
                if (_zoomTimer.running)
                {
                    _zoomTimer.stop();
                    _zoomTimer.removeEventListener("timer", onMotion);
                }
                _zoomTimer = null;
            }
            _container.scaleX = 1;
            _container.scaleY = 1;
            _container.x = 0;
            _container.y = 0;
            return;
        }// end function

    }
}
