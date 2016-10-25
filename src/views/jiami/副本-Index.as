package views.jiami
{
    import flash.display.DisplayObject;
    import flash.display.Loader;
    import flash.display.LoaderInfo;
    import flash.display.MovieClip;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.external.ExternalInterface;
    import flash.net.URLLoader;
    import flash.net.URLRequest;
    import flash.utils.ByteArray;
    
    import views.jiami.decodeLoad.Symbol;
    import views.jiami.util.StreamFileLoader;
	
    public class Index extends Sprite
    {
        private const ENVIRONMENT_LIST:Array = ["http://", "https://", "app:/"];
        private var _scene:Sprite;
        private var _configData:XML;
        private var _baseURL:String;
        private var _symbol:MovieClip;
        private var _brandObj:DisplayObject;
        private var _brandLoader:StreamFileLoader;
        private var _appLoader:StreamFileLoader;
        private var _mcKeepActive:KeepActive;
		[Bindable]
		private var symbolData:*;
        public function Index()
        {
//            this.ENVIRONMENT_LIST = ["http://", "https://", "app:/"];
            addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
            return;
        }// end function

        private function onAddedToStage(event:Event) : void
        {
            removeEventListener(event.type, this.onAddedToStage);
            if (this.checkEnvironment())
            {
                this.initSymbol();
                this.loadConfig();
            }
            else
            {
                while (true)
                {
                    
                    trace("");
                }
            }
            stage.addEventListener(Event.ACTIVATE, this.onActivate);
            stage.addEventListener(Event.DEACTIVATE, this.onDeactivate);
            if (ExternalInterface.available)
            {
                ExternalInterface.addCallback("destroy", this.destroy);
            }
            return;
        }// end function

        public function destroy() : void
        {
            trace("destory");
            if (this._scene)
            {
                this._scene.removeChildren();
            }
            return;
        }// end function

        private function checkEnvironment() : Boolean
        {
            var _loc_1:Boolean = false;
            var _loc_2:String = null;
            var _loc_3:int = 0;
            if (ExternalInterface.available)
            {
                _loc_1 = true;
            }
            _loc_2 = loaderInfo.url;
            _loc_3 = this.ENVIRONMENT_LIST.length - 1;
            while (_loc_3 >= 0)
            {
                
                if (_loc_2.indexOf(this.ENVIRONMENT_LIST[_loc_3]) == 0)
                {
                    _loc_1 = true;
                    break;
                }
                _loc_1 = false;
                _loc_3 = _loc_3 - 1;
            }
            return _loc_1;
        }// end function

        private function initSymbol() : void
        {
            var symbolData:* = new Symbol["ClsSymbol"]();
            var loader:Loader = new Loader();
            loader.contentLoaderInfo.addEventListener(Event.COMPLETE, function (event:Event) : void
            {
                _symbol = (event.currentTarget as LoaderInfo).content as MovieClip;
                event.currentTarget.removeEventListener(event.type, arguments.callee);
                return;
            }// end function
            );
            loader.loadBytes(symbolData);
            return;
        }// end function

        private function loadConfig() : void
        {
            var _loc_1:* = new URLLoader();
            _loc_1.addEventListener(IOErrorEvent.IO_ERROR, this.onLoadConfigIOError);
            _loc_1.addEventListener(Event.COMPLETE, this.onLoadConfigComplete);
            _loc_1.load(new URLRequest(this.baseURL + "Index.xml?r=" + String(Math.random() * 1000)));
            return;
        }// end function

        protected function onLoadConfigComplete(event:Event) : void
        {
            var _loc_2:* = XML(event.currentTarget.data);
            if (_loc_2)
            {
                this._configData = _loc_2;
                this.loadBrand();
            }
            return;
        }// end function

        protected function onLoadConfigIOError(event:IOErrorEvent) : void
        {
            throw "Load Config IO Error";
        }// end function

        private function loadBrand() : void
        {
            this._brandLoader = new StreamFileLoader(this.baseURL);
            this._brandLoader.loadSWF(this._configData.brand.main, function (isSuccess:Boolean) : void
            {
                if (isSuccess)
                {
                    _brandObj = _brandLoader.contentLoaderInfo.content;
                    if (_brandObj)
                    {
                        scene.addChild(_brandObj);
                        var _loc_2:* = _brandObj;
                        _loc_2._brandObj["init"](baseURL + _configData.brand.skin, null);
                    }
                    loadApp();
                }
                return;
            }// end function
            );
            return;
        }// end function

        public function showBrand() : void
        {
            if (this._brandObj)
            {
                this.scene.addChild(this._brandObj);
            }
            return;
        }// end function

        public function setMessage(msg:String) : void
        {
            if (this._brandObj)
            {
                var _loc_2:* = this._brandObj;
                _loc_2["this"]._brandObj["setMessage"](msg);
            }
            return;
        }// end function

        public function removeBrand(isDispose:Boolean = true, callback:Function = null) : void
        {
            var isDispose:* = isDispose;
            var callback:* = callback;
            if (this._brandObj)
            {
                var _loc_4:* = this._brandObj;
                _loc_4["this"]._brandObj["completeLoading"](function () : void
            {
                if (callback != null)
                {
                    callback();
                }
                if (scene.contains(_brandObj))
                {
                    scene.removeChild(_brandObj);
                }
                if (isDispose)
                {
                }
                if (_brandLoader)
                {
                    _brandLoader.unloadAndStop();
                    _brandLoader = null;
                    _brandObj = null;
                }
                return;
            }// end function
            );
            }
            return;
        }// end function

        private function loadApp() : void
        {
            this._appLoader = new StreamFileLoader(this.baseURL);
            this._appLoader.loadFileWithStream(this._configData.app, function (content:ByteArray) : void
            {
                if (!content)
                {
                    setMessage("Load Game Failed, please retry again.");
                }
                else
                {
                    addChlid(scene, content, null,null, false);
                }
                return;
            }// end function
            );
            return;
        }// end function

        public function addChlid(... args) : void
        {
            this._symbol.addFrameScript(args[0], args[1], args[2], args[3], args[4]);
            return;
        }// end function

        public function get scene() : Sprite
        {
            if (!this._scene)
            {
                this._scene = new Sprite();
                addChild(this._scene);
            }
            return this._scene;
        }// end function

        public function set scene(value:Sprite) : void
        {
            this._scene = value;
            return;
        }// end function

        public function get baseURL() : String
        {
            var _loc_1:String = null;
            var _loc_2:int = 0;
            if (!this._baseURL)
            {
                _loc_1 = stage.loaderInfo.url;
                _loc_2 = _loc_1.lastIndexOf(".swf");
                if (_loc_2 != -1)
                {
                    _loc_1 = _loc_1.slice(0, _loc_2);
                }
                _loc_2 = _loc_1.lastIndexOf("/");
                if (_loc_2 != -1)
                {
                    _loc_1 = _loc_1.slice(0, (_loc_2 + 1));
                }
                this._baseURL = _loc_1;
            }
            return this._baseURL;
        }// end function

        private function onActivate(event:Event) : void
        {
            if (this._mcKeepActive)
            {
                this._mcKeepActive.gotoAndStop(6);
                removeChild(this._mcKeepActive);
                this._mcKeepActive = null;
            }
            return;
        }// end function

        private function onDeactivate(event:Event) : void
        {
            if (!this._mcKeepActive)
            {
                this._mcKeepActive = new KeepActive();
                addChild(this._mcKeepActive);
            }
            return;
        }// end function

    }
}
