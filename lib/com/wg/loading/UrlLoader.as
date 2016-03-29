package com.wg.loading
{
	import com.wg.logging.Log;
	import com.wg.schedule.Scheduler;
	
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;

	public class UrlLoader
	{		
		private var _waitingQueue:Array = [];
		private var _loadingDataInfo:UrlLoadingInfo;
		private var _loader:Loader;
		private var _cachedLoaderInfos:Object = {};
		private var _enableCache:Boolean = true;
		private var _inLoadCall:Boolean = false;

		public function UrlLoader(initParams:*=null) : void
		{
			if (initParams != null) {
				for (var i:String in initParams) {
					this[i] = initParams[i];
				}
			}
		}
		
		private function set enableCache(enableCache:Boolean) : void
		{
			_enableCache = enableCache;
		}

		/**
		 * 
		 * @param urls				string or array of string
		 * @param onComplete		Function(ResourceLoadingDataInfo)
		 * @param onProgress		Function(ResourceLoadingDataInfo)
		 * @param onCompleteOnce	Function(ResourceLoadingDataInfo)
		 * 
		 */		
		public function load(urls:*, onComplete:Function, onProgress:Function=null, onCompleteOnce:Function=null) : void
		{
			_inLoadCall = true;
			
			var urlArray:Array;
			if (urls is String) {
				urlArray = [urls];
			}
			else {
				urlArray = urls;
			}

			var datas:Array = [];
			for each (var url:String in urlArray) {
				datas.push(new UrlData(url));				
			}

			_waitingQueue.push(new UrlLoadingInfo(datas, onProgress, onCompleteOnce, onComplete));
			if (!inLoading()) {
				loadWaitingQueue();
			}
			
			_inLoadCall = false;
		}

		private function inLoading() : Boolean
		{
			return _loadingDataInfo != null;
		}
		
		private function loadWaitingQueue() : void
		{
			_loadingDataInfo = _waitingQueue.shift() as UrlLoadingInfo;
			loadDataInfo();
		}
		
		private function loadDataInfo() : void
		{
			if (_loadingDataInfo.waitingDatas.length == 0) {
				onLoadDataInfoComplete();
			}
			else {
				_loadingDataInfo.loadingData = _loadingDataInfo.waitingDatas.shift() as UrlData;
				++_loadingDataInfo.loadingDataIndex;
				loadData();
			}
		}
		
		private function loadData() : void
		{
			if (_enableCache && dataInCache(_loadingDataInfo.loadingData.url)) {
				if (_inLoadCall) {
					Scheduler.callLater(null, loadDataFromCache);
				}
				else {
					loadDataFromCache();
				}
			}
			else {
				_loader = new Loader();
				addEventToLoader(_loader.contentLoaderInfo);
				_loadingDataInfo.loadingData.loaderInfo = _loader.contentLoaderInfo;			
				_loader.load(new URLRequest(_loadingDataInfo.loadingData.url), new LoaderContext(true, new ApplicationDomain(ApplicationDomain.currentDomain)));
			}
		}
		
		private function addEventToLoader(dispatcher:IEventDispatcher) : void 
		{
			dispatcher.addEventListener(Event.COMPLETE, onLoadDataComplete);
			dispatcher.addEventListener(IOErrorEvent.IO_ERROR, onLoadDataIoError);
			dispatcher.addEventListener(ProgressEvent.PROGRESS, onLoadDataProgress);
		}

		private function removeEventFromLoader(dispatcher:IEventDispatcher) : void 
		{
			dispatcher.removeEventListener(Event.COMPLETE, onLoadDataComplete);
			dispatcher.removeEventListener(IOErrorEvent.IO_ERROR, onLoadDataIoError);
			dispatcher.removeEventListener(ProgressEvent.PROGRESS, onLoadDataProgress);
		}

		private function onLoadDataProgress(event:ProgressEvent) : void 
		{
			_loadingDataInfo.loadingDataProgressEvent = event;
			if (_loadingDataInfo.onProgress != null) {
				_loadingDataInfo.onProgress(_loadingDataInfo);				
			}
		}

		private function onLoadDataComplete(event:Event) : void 
		{
			removeEventFromLoader(_loader.contentLoaderInfo);			
			_loadingDataInfo.loadingData.succ = true;
			completeLoadingData();
		}
		
		private function onLoadDataIoError(event:IOErrorEvent) : void 
		{
			removeEventFromLoader(_loader.contentLoaderInfo);
			_loadingDataInfo.loadingData.succ = false;
			completeLoadingData();
		}
		
		private function onLoadDataInfoComplete() : void
		{
			if (_loadingDataInfo.onComplete != null) {
				_loadingDataInfo.onComplete(_loadingDataInfo);
			}
			
			_loadingDataInfo = null;
			if (_waitingQueue.length > 0) {
				loadWaitingQueue();
			}
		}
				
		private function completeLoadingData(loadFromCache:Boolean=false) : void
		{
			if (_loadingDataInfo.loadingData.succ) {
				_loadingDataInfo.successDatas.push(_loadingDataInfo.loadingData);
				if (!loadFromCache) {
					setDataToCache(_loadingDataInfo.loadingData);
				}
			}
			else {
				_loadingDataInfo.errorDatas.push(_loadingDataInfo.loadingData);
			}

			if (_loadingDataInfo.onCompleteOnce != null) {
				_loadingDataInfo.onCompleteOnce(_loadingDataInfo);
			}

			_loadingDataInfo.loadingData = null;
			_loadingDataInfo.loadingDataProgressEvent = null;
			
			loadDataInfo();
		}
		
		private function dataInCache(url:String) : Boolean
		{
			return _cachedLoaderInfos[url] != null;
		}
		
		private function loadDataFromCache() : void
		{
			_loadingDataInfo.loadingData.loaderInfo = _cachedLoaderInfos[_loadingDataInfo.loadingData.url];
			_loadingDataInfo.loadingData.succ = _loadingDataInfo.loadingData.loaderInfo != null;
			completeLoadingData(true);
		}
		
		private function setDataToCache(data:UrlData) : void
		{
			_cachedLoaderInfos[data.url] = data.loaderInfo; 
		}
	}
}
