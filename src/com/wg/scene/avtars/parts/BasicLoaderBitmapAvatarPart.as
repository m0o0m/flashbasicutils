package com.wg.scene.avtars.parts
{
	
	import com.wg.scene.loading.ISceneResourceLoaderItem;
	import com.wg.scene.loading.SceneResourceLoaderManager;
	import com.wg.scene.loading.ShareObjectCacheManager;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;

	public class BasicLoaderBitmapAvatarPart extends BitmapAvatarPart
	{
		private var myModelUrl:String;
		private var myModelUrlDirty:Boolean = false;
		
		private var mModelLoaded:Boolean = false;
		private var mLoadCompleteCallback:Function;
		private var mLoadErrorCallback:Function;
		
		private var mSceneResourceLoaderItem:ISceneResourceLoaderItem;
		
		public function BasicLoaderBitmapAvatarPart()
		{
			super();
		}
		
		public function get modelUrl():String { return myModelUrl; }
		public function get modelLoaded():Boolean { return mModelLoaded };
		
		public function loadModel(url:String, onLoadStart:Function = null, 
								  onLoadComplete:Function = null, onLoadError:Function = null):void
		{
			if(myModelUrl == url) return;
			
			if(myModelUrl != url)
			{
				closeLoadModel();
				
				if(onLoadStart != null)
				{
					onLoadStart();
				}
				
				myModelUrl = url;
				
				if(myModelUrl && myModelUrl.length > 0)
				{
					mLoadCompleteCallback = onLoadComplete;
					mLoadErrorCallback = onLoadError;
					
					myModelUrlDirty = true;
				}
			}
		}
		
		protected function closeLoadModel():void
		{
			if(myModelUrl)
			{
				if(mModelLoaded)
				{
					ShareObjectCacheManager.getInstance().releaseShareObject(myModelUrl);	
					mModelLoaded = false;
				}
				
				super.bitmapData = null;

				myModelUrl = null;
			}
			
			myModelUrlDirty = false;
			
			//--
			
			if(mSceneResourceLoaderItem != null)
			{
				mSceneResourceLoaderItem.removeEventListener(Event.COMPLETE, modelLoadCompleteHandler);
				mSceneResourceLoaderItem.removeEventListener(IOErrorEvent.IO_ERROR, modelLoadErrorHandler);
				mSceneResourceLoaderItem = null;
			}
		}
		
		override public function dispose():void
		{
			closeLoadModel();
			
			mLoadCompleteCallback = null;
			
			super.dispose();
		}
		
		override public function onFrame(deltaTime:Number):void
		{
			if(myModelUrlDirty)
			{
				onUpdateModelUrl();
				myModelUrlDirty = false;
			}
			
			super.onFrame(deltaTime);
		}
		
		protected function onUpdateModelUrl():void
		{
			mSceneResourceLoaderItem = SceneResourceLoaderManager.getInstance().loadItem(modelUrl, getLoaderCls());
			
			mSceneResourceLoaderItem.addEventListener(Event.COMPLETE, modelLoadCompleteHandler);
			mSceneResourceLoaderItem.addEventListener(IOErrorEvent.IO_ERROR, modelLoadErrorHandler);
		}
		
		protected function getLoaderCls():Class
		{
			return null;
		}
		
		protected function onCompleteLoadModel(content:*):void
		{
		}
		
		protected final function modelLoadCompleteHandler(event:Event = null):void
		{
			mModelLoaded = true;
			
			if(mSceneResourceLoaderItem)
			{
				mSceneResourceLoaderItem.removeEventListener(Event.COMPLETE, modelLoadCompleteHandler);
				mSceneResourceLoaderItem.removeEventListener(IOErrorEvent.IO_ERROR, modelLoadErrorHandler);
				mSceneResourceLoaderItem = null;
			}
			
			var content:* = ShareObjectCacheManager.getInstance().fetchShareObject(modelUrl); 
			onCompleteLoadModel(content);
			
			if(mLoadCompleteCallback != null)
			{
				var cb:Function = mLoadCompleteCallback;
				mLoadCompleteCallback = null;
				cb();
			}
		}
		
		protected final function modelLoadErrorHandler(event:Event = null):void
		{
			if(mLoadErrorCallback != null)
			{
				var cb:Function = mLoadErrorCallback;
				mLoadErrorCallback = null;
				cb();
			}
		}
	}
}