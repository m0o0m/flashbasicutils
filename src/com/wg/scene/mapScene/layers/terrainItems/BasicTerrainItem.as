package  com.wg.scene.mapScene.layers.terrainItems
{
	
	import com.wg.scene.SceneCamera;
	import com.wg.scene.mapScene.layers.TerrainSceneLayer;
	import com.wg.scene.utils.GameMathUtil;
	import com.wg.schedule.IAnimatedObject;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	import mymap.sceneInfo.MapSceneInfo;
	

	public class BasicTerrainItem extends Sprite implements IAnimatedObject
//	public class BasicTerrainItem extends starling.display.DisplayObject implements IAnimatedObject
	{
		private static const OUT_OF_CAMERA_RELEASE_WAITE_TIME:Number = 10;//s
		
		public var seaMapInfo:MapSceneInfo;
		public var camera:SceneCamera;
		public var path:String;
		public var itemX:int = 0;
		public var itemY:int = 0;
		public var itemWidth:int = 0;
		public var itemHeight:int = 0;
		public var underSea:Boolean = false;
		
		protected var mOwner:TerrainSceneLayer;
		
//		protected var terrainItemDisplayObject:starling.display.DisplayObject
		protected var terrainItemDisplayObject:flash.display.DisplayObject;
		
		protected var mTerrainItemOutCameraTime:Number = 0.0;
		protected var mTerrainItemIsInCamera:Boolean = false;

		protected var mTerrainItemIsLoadInited:Boolean = false;
		protected var mTerrainItemIsLoading:Boolean = false;
		protected var mTerrainItemDisplayObjectCreated:Boolean = false;
		
		public function BasicTerrainItem(owner:TerrainSceneLayer)
		{
			super();
			
			this.mOwner = owner;
			this.visible = false;
		}
		
		public function onFrame(deltaTime:Number):void
		{
			mTerrainItemIsInCamera = GameMathUtil.isRectangleOverlap(camera.scrollX, camera.scrollY, 
				camera.width, camera.height, itemX, itemY, itemWidth, itemHeight)

			if(mTerrainItemIsInCamera)
			{
				mTerrainItemOutCameraTime = 0;
				
				if(!mTerrainItemDisplayObjectCreated)
				{
					onTerrainItemCreate();
					
					this.x = itemX >> 0;
					this.y = itemY >> 0;
					
					mTerrainItemDisplayObjectCreated = true;
				}
				else
				{
					if(!mTerrainItemIsLoadInited)
					{
						if(mOwner.isValidLoad())
						{
							onTerrainItemLoad();
							
							mTerrainItemIsLoadInited = true;
							mTerrainItemIsLoading = true;
						}
					}
				}
				
//				this.x = (itemX - camera.scrollX) >> 0;
//				this.y = (itemY - camera.scrollY) >> 0;
				
				this.visible = true;
			}
			else
			{
				mTerrainItemOutCameraTime += deltaTime;
				if(mTerrainItemOutCameraTime > OUT_OF_CAMERA_RELEASE_WAITE_TIME)
				{
					mTerrainItemOutCameraTime = 0;
					
					releaseTerrainItem();
					
					mTerrainItemDisplayObjectCreated = false;
					mTerrainItemIsLoading = false;
				}
				
				this.visible = false;
			}
		}
		
		protected function onTerrainItemCreate():void
		{
			this.addChild(terrainItemDisplayObject);
		}

		public function releaseTerrainItem():void
		{
			if(mTerrainItemDisplayObjectCreated)
			{
				mTerrainItemDisplayObjectCreated = false;
				
				this.removeChild(terrainItemDisplayObject);
				terrainItemDisplayObject = null;
				
				if(mTerrainItemIsLoading)
				{
					mTerrainItemIsLoading = false;
					mOwner.decreaseLoadCount();
				}
				
				mTerrainItemIsLoadInited = false;
				mTerrainItemOutCameraTime = 0;
				
				this.visible = false;
			}
		}
		
		protected function onTerrainItemLoad():void
		{
			mOwner.increaseLoadCount();
		}
		
		protected function onTerrainItemLoadComplete():void
		{
			mOwner.decreaseLoadCount();
			mTerrainItemIsLoading = false;
		}
		
		protected function onTerrainItemLoadError():void
		{
			mOwner.decreaseLoadCount();
			mTerrainItemIsLoading = false;
		}
		
//		override public function get hasVisibleArea():Boolean
//		{
//			return mTerrainItemIsInCamera && terrainItemDisplayObject && 
//				super.hasVisibleArea;
//		}
//		
//		override public function render(support:RenderSupport, parentAlpha:Number):void
//		{
//			support.pushMatrix();
//			support.transformMatrix(terrainItemDisplayObject);
//			
//			terrainItemDisplayObject.render(support, alpha);
//			
//			support.popMatrix();
//		}
		
		public function dispose():void
//		override public function dispose():void
		{
			releaseTerrainItem();
			
//			super.dispose();
		}
	}
}