package com.ql.gameKit.manager
{
    import flash.events.*;
    import flash.media.*;
    import flash.net.*;

    public class SoundManager extends Object
    {
        private var _transform:SoundTransform;
        private var _bgTransform:SoundTransform;
        private var _soundCacheList:Array;
        private var _musicCacheList:Array;
        private var _soundChannel:SoundChannel;
        private var _musicChannel:SoundChannel;
        private var _effectChannel:SoundChannel;
        private var _playingBGM:String;
        private var _isSoundOn:Boolean;
        private var _isMusicOn:Boolean;
        private static var _instance:SoundManager;

        public function SoundManager()
        {
            _soundChannel = new SoundChannel();
            _musicChannel = new SoundChannel();
            _effectChannel = new SoundChannel();
            if (!_instance)
            {
                _instance = this;
                init();
            }
            return;
        }// end function

        private function init() : void
        {
            _soundChannel = new SoundChannel();
            _musicChannel = new SoundChannel();
            _transform = new SoundTransform();
            _bgTransform = new SoundTransform();
            _soundCacheList = [];
            _musicCacheList = [];
            _isMusicOn = true;
            _isSoundOn = true;
            return;
        }// end function

        private function getSound(soundName:String, assetName:String) : Sound
        {
            var _loc_3:* = getItem(_soundCacheList, soundName);
            if (!_loc_3)
            {
                _loc_3 = AssetManager.shared().getSound(assetName, soundName);
                if (_loc_3)
                {
                    _soundCacheList.push({id:soundName, content:_loc_3});
                }
            }
            return _loc_3;
        }// end function

        private function getMusic(musicName:String, assetName:String) : Sound
        {
            var _loc_3:* = getItem(_musicCacheList, musicName);
            if (!_loc_3)
            {
                _loc_3 = AssetManager.shared().getSound(assetName, musicName);
                if (_loc_3)
                {
                    _musicCacheList.push({id:musicName, content:_loc_3});
                }
            }
            return _loc_3;
        }// end function

        private function getItem(list:Array, id:String) : Sound
        {
            var _loc_3:int = 0;
            _loc_3 = list.length - 1;
            while (_loc_3 >= 0)
            {
                
                if (list[_loc_3].id == id)
                {
                    return list[_loc_3].content as Sound;
                }
                _loc_3--;
            }
            return null;
        }// end function

        public function playMusic(musicName:String, assetName:String) : void
        {
            var _loc_3 = null;
            if (_isMusicOn)
            {
                if (_musicChannel)
                {
                    _musicChannel.stop();
                }
                _loc_3 = getMusic(musicName, assetName);
                if (_loc_3)
                {
                    _playingBGM = musicName;
                    _musicChannel = _loc_3.play(0, 2147483647, _bgTransform);
                }
            }
            return;
        }// end function

        public function playMusicWithURL(name:String, url:String) : void
        {
            name = name;
            url = url;
            var s:* = getItem(_musicCacheList, name);
            if (!s)
            {
                s = new Sound();
                s.addEventListener("ioError", function (event:IOErrorEvent) : void
            {
                event.currentTarget.removeEventListener(event.type, arguments.callee);
                event.currentTarget.removeEventListener("complete", arguments.callee);
                return;
            }// end function
            );
                s.addEventListener("complete", function (event:Event) : void
            {
                _musicCacheList.push({id:name, content:s});
                event.currentTarget.removeEventListener(event.type, arguments.callee);
                event.currentTarget.removeEventListener("ioError", arguments.callee);
                return;
            }// end function
            );
                s.load(new URLRequest(url));
            }
            _playingBGM = name;
            if (_isMusicOn)
            {
                if (_musicChannel)
                {
                    _musicChannel.stop();
                }
                _musicChannel = s.play(0, 2147483647, _bgTransform);
            }
            return;
        }// end function

        public function stopMusic() : void
        {
            if (_musicChannel)
            {
                _musicChannel.stop();
            }
            return;
        }// end function

        public function playSound(soundName:String, assetName:String, isStopChannel:Boolean = false, delay:int = 1500) : int
        {
            var _loc_6:* = getSound(soundName, assetName);
            var _loc_5:* = !getSound(soundName, assetName) ? (1000) : (_loc_6.length);
            if (_isSoundOn)
            {
                if (isStopChannel && _soundChannel)
                {
                    _soundChannel.stop();
                }
                if (_loc_6)
                {
                    _soundChannel = _loc_6.play(0, 0, _transform);
                }
            }
            return _loc_5;
        }// end function

        public function stopSound() : void
        {
            if (_soundChannel)
            {
                _soundChannel.stop();
            }
            return;
        }// end function

        public function playEffect(soundName:String, assetName:String, isStopChannel:Boolean = false, isloop:Boolean = false) : void
        {
            var _loc_5 = null;
            if (_isSoundOn)
            {
                if (isStopChannel && _effectChannel)
                {
                    _effectChannel.stop();
                }
                _loc_5 = getSound(soundName, assetName);
                if (_loc_5)
                {
                    _effectChannel = _loc_5.play(0, isloop ? (2147483647) : (0), _transform);
                }
            }
            return;
        }// end function

        public function setVolume(value:Number) : void
        {
            _bgTransform.volume = value;
            return;
        }// end function

        public function stopAll() : void
        {
            SoundMixer.stopAll();
            return;
        }// end function

        public function clearAll() : void
        {
            stopAll();
            _soundCacheList = [];
            _musicCacheList = [];
            return;
        }// end function

        public function get isSoundOn() : Boolean
        {
            return _isSoundOn;
        }// end function

        public function set isSoundOn(value:Boolean) : void
        {
            _isSoundOn = value;
            if (!value && _soundChannel)
            {
                _soundChannel.stop();
            }
            return;
        }// end function

        public function get isMusicOn() : Boolean
        {
            return _isMusicOn;
        }// end function

        public function set isMusicOn(value:Boolean) : void
        {
            if (_isMusicOn != value)
            {
                _isMusicOn = value;
                if (!value)
                {
                    if (_musicChannel)
                    {
                        if (!value)
                        {
                            _musicChannel.stop();
                        }
                    }
                }
                else if (_playingBGM)
                {
                    playMusic(_playingBGM, null);
                }
            }
            return;
        }// end function

        public static function shared() : SoundManager
        {
            return _instance || new SoundManager;
        }// end function

    }
}
