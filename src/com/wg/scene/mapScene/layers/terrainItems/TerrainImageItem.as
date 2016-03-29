package com.wg.scene.mapScene.layers.terrainItems
{

	
	import com.wg.scene.avtars.parts.BitmapLoader2AvatarPart;
	import com.wg.scene.mapScene.layers.TerrainSceneLayer;
	import com.wg.scene.mapScene.layers.terrainItems.BasicTerrainItem;
	import com.wg.scene.utils.GameMathUtil;
	import com.wg.utils.stringUtils.StringUtil;
	import com.wg.scene.seaWar_internal;
	import flash.display.BitmapData;
	import flash.geom.Rectangle;

	public class TerrainImageItem extends BasicTerrainItem
	{
		//如果超过这个时间还是没有加载完资源则添加小图缩放代替
		private static const PRELOAD_IMAGE_SET_WAIT_TIME:Number = 1;
		
//		private var mBitmapLoaderAvatarPart:SBitmapLoader2AvatarPart;
		private var mBitmapLoaderAvatarPart:BitmapLoader2AvatarPart;
		
//		private var mPalceHoldBitmapTexture:Texture;
		private var mPalceHoldBitmapData:BitmapData;

		private var mIsLoaded:Boolean = false;
		private var mHasPreLoadSet:Boolean = false;
		private var mSetPreLoadTime:Number = 0.0;
		
		public function TerrainImageItem(owner:TerrainSceneLayer)
		{
			super(owner);
			
//			this.graphics.lineStyle(1, 0xFF0000);
//			this.graphics.drawCircle(0, 0, 5);
		}
		
		override protected function onTerrainItemCreate():void
		{
//			terrainItemDisplayObject = mBitmapLoaderAvatarPart = new SBitmapLoader2AvatarPart();
			terrainItemDisplayObject = mBitmapLoaderAvatarPart = new BitmapLoader2AvatarPart();
			
			super.onTerrainItemCreate();
			
//			this.graphics.clear();
//			this.graphics.beginFill(Math.random() * uint.MAX_VALUE, 0.4);
//			this.graphics.drawRect(0, 0, itemWidth, itemHeight);
//			this.graphics.endFill();
		}
		
		override protected function onTerrainItemLoad():void
		{
			super.onTerrainItemLoad();
			
			mIsLoaded = false;
			mHasPreLoadSet = false;
			mSetPreLoadTime = 0.0;
			
			var curPath:String = StringUtil.replace(path, {".png":".swf"});
			mBitmapLoaderAvatarPart.loadModel(curPath, null, onTerrainItemLoadComplete, onTerrainItemLoadError);
		}
		
		override protected function onTerrainItemLoadComplete():void
		{
			super.onTerrainItemLoadComplete();
			
			mIsLoaded = true;
			
			if(mPalceHoldBitmapData)
			{
				mPalceHoldBitmapData.dispose();
				mPalceHoldBitmapData = null;
			}
			
//			if(mPalceHoldBitmapTexture)
//			{
//				mPalceHoldBitmapTexture.dispose();
//				mPalceHoldBitmapTexture = null;
//			}

			mBitmapLoaderAvatarPart.smoothing = false;
			mBitmapLoaderAvatarPart.scaleX = mBitmapLoaderAvatarPart.scaleY = 1;
//			this.cacheAsBitmap = true;
		}
		
		override public function releaseTerrainItem():void
		{
			if(mPalceHoldBitmapData)
			{
				mPalceHoldBitmapData.dispose();
				mPalceHoldBitmapData = null;
			}
			
//			if(mPalceHoldBitmapTexture)
//			{
//				mPalceHoldBitmapTexture.dispose();
//				mPalceHoldBitmapTexture = null;
//			}
			
			if(mBitmapLoaderAvatarPart)
			{
				mBitmapLoaderAvatarPart.dispose();
				mBitmapLoaderAvatarPart = null;
			}
			
			mHasPreLoadSet = false;
			mIsLoaded = false;
			mSetPreLoadTime = 0.0;
			
//			this.cacheAsBitmap = false;
			
			super.releaseTerrainItem();
		}
		
		override public function onFrame(deltaTime:Number):void
		{
			super.onFrame(deltaTime);
			
			if(mTerrainItemIsInCamera && mBitmapLoaderAvatarPart)
			{
				mBitmapLoaderAvatarPart.onFrame(deltaTime);
				
				if(!underSea && !mIsLoaded && !mHasPreLoadSet)
				{
					mSetPreLoadTime += deltaTime;
					
					if(mSetPreLoadTime > PRELOAD_IMAGE_SET_WAIT_TIME)
					{
						mSetPreLoadTime = 0.0;
						
						mHasPreLoadSet = true;
						
						if(seaMapInfo.smallBackgroundBitmap != null)
						{
							var smallMapBitmapData:BitmapData = seaMapInfo.smallBackgroundBitmap;
							var smallMapBitmapScale:Number = seaMapInfo.smallMapScale;
							
							var smallRectX:int = Math.round(itemX * smallMapBitmapScale);
							var smallRectY:int = Math.round(itemY * smallMapBitmapScale);
							var smallRectW:int = Math.ceil(itemWidth * smallMapBitmapScale);
							var smallRectH:int = Math.ceil(itemHeight * smallMapBitmapScale);
							
							mPalceHoldBitmapData = new BitmapData(smallRectW, smallRectH, true, 0);
							mPalceHoldBitmapData.copyPixels(smallMapBitmapData, 
								new Rectangle(smallRectX, smallRectY, smallRectW, smallRectH), 
								GameMathUtil.EMPTY_POINT);
							
//							mPalceHoldBitmapTexture = Texture.fromBitmapData(mPalceHoldBitmapData);
//							mBitmapLoaderAvatarPart.texture = mPalceHoldBitmapTexture
							
							//--
							
							//preloading
							mBitmapLoaderAvatarPart.smoothing = true;
							mBitmapLoaderAvatarPart.scaleX = mBitmapLoaderAvatarPart.scaleY = 1 / smallMapBitmapScale;
							mBitmapLoaderAvatarPart.seaWar_internal::internalBitmap = mPalceHoldBitmapData;
//							this.cacheAsBitmap = true;
						}
					}
				}
			}
		}
	}
}