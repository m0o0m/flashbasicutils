package com.wg.scene.mapScene.layers.terrainItems
{
	import com.wg.scene.mapScene.layers.TerrainSceneLayer;

	public class TerrainEffectItem extends BasicTerrainItem
	{
		private var mSWFChildLoaderAvatarPart:ModelLoaderAvatarPart;
		
		public function TerrainEffectItem(owner:TerrainSceneLayer)
		{
			super(owner);
		}
		
		override protected function onTerrainItemCreate():void
		{
			terrainItemDisplayObject = mSWFChildLoaderAvatarPart = new ModelLoaderAvatarPart();
			mSWFChildLoaderAvatarPart.isReportError = true;
			
			super.onTerrainItemCreate();
			
//			this.graphics.lineStyle(1, 0xFF0000);
//			this.graphics.drawCircle(0, 0, 5);
//			this.graphics.drawRect(0, 0, itemWidth, itemHeight);
			
		}
		
		override protected function onTerrainItemLoad():void
		{
			super.onTerrainItemLoad();
			
//			mSWFChildLoaderAvatarPart.x = (itemWidth >> 1);
//			mSWFChildLoaderAvatarPart.y = (itemHeight >> 1);
			
//			if(underSea) terrainItemDisplayObject.alpha = ClientConstants.FAR_VIEW_ALPHA;
			
			var curPath:String = StringUtil.replace(path, {".png":".swf"});
			mSWFChildLoaderAvatarPart.loadModel(path, null, onTerrainItemLoadComplete, onTerrainItemLoadError);
		}
		
		override protected function onTerrainItemLoadComplete():void
		{
			super.onTerrainItemLoadComplete();
			
			mSWFChildLoaderAvatarPart.gotoAndPlay(1, -1, "Idel");
		}
		
		override public function releaseTerrainItem():void
		{
			if(mSWFChildLoaderAvatarPart)
			{
				mSWFChildLoaderAvatarPart.dispose();
				mSWFChildLoaderAvatarPart = null;
			}	
			
			super.releaseTerrainItem();
		}
		
		override public function onFrame(deltaTime:Number):void
		{
			super.onFrame(deltaTime);
			
			if(mTerrainItemIsInCamera && mSWFChildLoaderAvatarPart)
			{
				mSWFChildLoaderAvatarPart.onFrame(deltaTime);
			}
		}
	}
}