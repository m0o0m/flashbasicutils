package com.wg.scene.loading
{
	
	import com.wg.logging.Log;
	import com.wg.resource.SWFSecurityUtil;
	
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLRequest;

	public class BasicSWFModelLoadItem extends EventDispatcher implements ISceneResourceLoaderItem
	{
		private var _isLoading:Boolean = false;
		private var _modelURL:String;
		private var _modelLoader:Loader;
		
		public function BasicSWFModelLoadItem()
		{
			super();
		}
		
		public function get modelURL():String { return _modelURL };
		
		public function load(modelURL:String):void
		{
			if(!_isLoading)
			{
				_modelURL = modelURL;
				
				_isLoading = true;
				
				if(!_modelLoader)
				{
					_modelLoader = new Loader();

					_modelLoader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, modelLoaderLoaderErrorHandler);
					_modelLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, modelLoaderLoaderErrorHandler);
					_modelLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, modelLoaderLoadCompleteHandler);
					
					_modelLoader.load(new URLRequest(_modelURL),SWFSecurityUtil.requestSWFLoaderContext(false, true));
				}
			}
		}
		
		private function modelLoaderLoadCompleteHandler(event:Event = null):void
		{
			if(!ShareObjectCacheManager.getInstance().hasRegistShareObject(_modelURL))
			{
				var content:* = convertLoadedContentToCacheContent(_modelLoader.contentLoaderInfo);
				
				//regist the cache loaded item.
				ShareObjectCacheManager.getInstance().registShareObject(_modelURL, content);
			}

			if(this.hasEventListener(Event.COMPLETE))
			{
				this.dispatchEvent(new Event(Event.COMPLETE));
			}
			
			closeLoader();
		}
		
		protected function convertLoadedContentToCacheContent(l:LoaderInfo):*
		{
			return null;
		}
		
		private function modelLoaderLoaderErrorHandler(event:Event):void
		{
			Log.error("BasicSWFModelLoadItem", event["text"]);
			
			if(this.hasEventListener(IOErrorEvent.IO_ERROR))
			{
				this.dispatchEvent(new IOErrorEvent(IOErrorEvent.IO_ERROR, false, false, event["text"]));
			}
			
			closeLoader();
		}
		
		private function closeLoader():void
		{
			if(_isLoading)
			{
				_isLoading = false;
				
				if(_modelLoader)
				{
					_modelLoader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, modelLoaderLoaderErrorHandler);
					_modelLoader.contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, modelLoaderLoaderErrorHandler);
					_modelLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE, modelLoaderLoadCompleteHandler);
					
					_modelLoader.unload();
					_modelLoader = null;
				}

				SceneResourceLoaderManager.getInstance().clearLoadingItem(_modelURL);
			}
		}
	}
}