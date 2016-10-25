package views.jiami.util
{
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.utils.*;

    public class StreamFileLoader extends Loader
    {
        private var _completeCall:Function;
        private var _progressCall:Function;
        private var _streamLoder:URLStream;
        private var _baseURL:String;
        private var _isLoadSWF:Boolean;

        public function StreamFileLoader(baseURL:String = "")
        {
            this._baseURL = baseURL;
            return;
        }// end function

		/**
		 *开始加载文件 
		 * @param file 文件路径
		 * @param completeCall 
		 * @param progressCall
		 * 
		 */
        public function loadFile(file:String, completeCall:Function, progressCall:Function = null) : void
        {
            this._completeCall = completeCall;
            this._progressCall = progressCall;
            contentLoaderInfo.addEventListener(Event.COMPLETE, this.onComplete);
            contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.onError);
            contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onError);
            load(new URLRequest(this._baseURL + file));
            return;
        }// end function

        public function loadFileWithStream(file:String, completeCall:Function, progressCall:Function = null) : void
        {
            this._completeCall = completeCall;
            this._progressCall = progressCall;
            this._streamLoder = new URLStream();
            this._streamLoder.addEventListener(Event.COMPLETE, this.onLoadStreamComplete);
            this._streamLoder.addEventListener(IOErrorEvent.IO_ERROR, this.onError);
            this._streamLoder.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onError);
            if (this._progressCall != null)
            {
                this._streamLoder.addEventListener(ProgressEvent.PROGRESS, this.onLoadStreamProgress);
            }
            this._streamLoder.load(new URLRequest(this._baseURL + file));
            return;
        }// end function

        public function loadSWF(file:String, completeCall:Function, progressCall:Function = null) : void
        {
            this._isLoadSWF = true;
            this.loadFileWithStream(file, completeCall, progressCall);
            return;
        }// end function

        private function onLoadStreamProgress(event:ProgressEvent) : void
        {
            this._progressCall(int(event.bytesLoaded / event.bytesTotal * 100) + "%");
            return;
        }// end function

        private function onLoadStreamComplete(event:Event) : void
        {
            var _loc_2:* = new ByteArray();
            this._streamLoder.readBytes(_loc_2, 0, this._streamLoder.bytesAvailable);
            if (!this._isLoadSWF)
            {
                if (this._completeCall != null)
                {
                    this._completeCall(_loc_2);
                }
            }
            else
            {
                contentLoaderInfo.addEventListener(Event.COMPLETE, this.onComplete);
                contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.onError);
                contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onError);
                loadBytes(_loc_2);
            }
            this._streamLoder.removeEventListener(ProgressEvent.PROGRESS, this.onLoadStreamProgress);
            this._streamLoder.removeEventListener(Event.COMPLETE, this.onLoadStreamComplete);
            this._streamLoder.removeEventListener(IOErrorEvent.IO_ERROR, this.onError);
            this._streamLoder.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onError);
            this._streamLoder = null;
            this._progressCall = null;
            return;
        }// end function

        private function onComplete(event:Event) : void
        {
            contentLoaderInfo.removeEventListener(Event.COMPLETE, this.onComplete);
            contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, this.onError);
            contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onError);
            if (this._completeCall != null)
            {
                this._completeCall(true);
            }
            return;
        }// end function

        private function onError(event) : void
        {
            if (this._completeCall != null)
            {
                this._completeCall(!this._isLoadSWF ? (null) : (false));
            }
            return;
        }// end function

    }
}
