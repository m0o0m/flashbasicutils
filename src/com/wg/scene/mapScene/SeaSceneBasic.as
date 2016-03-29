package  com.wg.scene.mapScene
{

	import com.wg.logging.Log;
	import com.wg.scene.SceneCamera;
	import com.wg.scene.elments.entity.BasicSceneEntity;
	import com.wg.scene.elments.entity.SceneEntity;
	import com.wg.scene.mapScene.layers.DisplaySortableSceneLayer;
	import com.wg.scene.mapScene.layers.TerrainSceneLayer;
	
	import flash.utils.Dictionary;
	
	import mymap.scene.layers.BGScenenLayer;
	import mymap.sceneInfo.MapSceneInfo;
	
	import starling.core.Starling;

	public class SeaSceneBasic extends SceneBasic
	{
		
		//layers...
//		public var seaTileWaterWaveRenderLayer:SeaTileWaterWaveRenderLayer = null;
//		public var terrainSceneLayer:TerrainSceneLayer = null;
		public var bgScenenLayer:BGScenenLayer = null;
		public var topSceneLayer:DisplaySortableSceneLayer = null;
		public var middleSceneLayer:DisplaySortableSceneLayer = null;
		public var bottomSceneLayer:DisplaySortableSceneLayer = null;
		public var effectSceneLayer:DisplaySortableSceneLayer = null;
		public var uiEffectSceneLayer:DisplaySortableSceneLayer = null;
		
		//all scenes objects
		private var mSceneElements:Dictionary = new Dictionary(); //SceneEntity
		private var mSceneUIdElementsCounter:int = 0;

		private static const BG_SOUND_WAIT_LOAD_TIME:Number = 1;
		
		private var mBgSoundCurTime:Number = 0;
		private var mBgSoundUrl:String;
		private var mBgSoundDirty:Boolean = false;
		
		private var mBackgroundColor:uint = 0;
		private var mBackGroundColorDirty:Boolean = false;
		private var mIsCurrentCutdownEffectPlaying:Boolean = false;
		
		public function SeaSceneBasic()
		{
			super();
		}
		
		override protected function onInitialize():void
		{
			super.onInitialize();	
			
			
			//测试用;
			bgScenenLayer = new BGScenenLayer();
			bgScenenLayer.mouseEnabled = false;
			bgScenenLayer.mouseChildren = false;
			bgScenenLayer.scene = this;
			bgScenenLayer.camera = this.camera;
//			bgScenenLayer.visible = false;
			addChild(bgScenenLayer);

			terrainSceneLayer = new TerrainSceneLayer();
			terrainSceneLayer.mouseEnabled = false;
			terrainSceneLayer.mouseChildren = false;
			terrainSceneLayer.mapSceneInfo = this.mapSceneInfo;
			terrainSceneLayer.scene = this;
			terrainSceneLayer.camera = this.camera;
//			terrainSceneLayer.visible = false;
//			terrainSceneLayer.touchable = false;
			this.addChild(terrainSceneLayer);
//			Starling.current.stage.addChild(terrainSceneLayer);
			
			//--
			
			bottomSceneLayer = new DisplaySortableSceneLayer();
			bottomSceneLayer.scene = this;
			bottomSceneLayer.camera = this.camera;
			addChild(bottomSceneLayer);
			
			middleSceneLayer = new DisplaySortableSceneLayer();
			middleSceneLayer.camera = this.camera;
			middleSceneLayer.scene = this;
			middleSceneLayer.needRealTimeDepthSort = true;
			addChild(middleSceneLayer);
			
			topSceneLayer = new DisplaySortableSceneLayer();
			topSceneLayer.camera = this.camera;
			topSceneLayer.scene = this;
			addChild(topSceneLayer);
			
			effectSceneLayer = new DisplaySortableSceneLayer();
			effectSceneLayer.mouseEnabled = false;
			effectSceneLayer.mouseChildren = false;
			effectSceneLayer.scene = this;
			effectSceneLayer.camera = this.camera;
			this.addChild(effectSceneLayer);
			
			uiEffectSceneLayer = new DisplaySortableSceneLayer();
			uiEffectSceneLayer.mouseEnabled = false;
			uiEffectSceneLayer.mouseChildren = false;
			uiEffectSceneLayer.scene = this;
			uiEffectSceneLayer.camera = this.camera;
			this.addChild(uiEffectSceneLayer);
		}
		public var mapSceneInfo:MapSceneInfo;
		private var terrainSceneLayer:TerrainSceneLayer;
		override protected function onInitializeScene(sceneDatas:Array):void
		{
			mapSceneInfo = sceneDatas[0];
			
			mSceneScrollWidth = mapSceneInfo.mapTotalWidth;
			mSceneScrollHeight = mapSceneInfo.mapTotalHeight;
			mSceneUIdElementsCounter = 0;
			terrainSceneLayer.initializeMap(mapSceneInfo);
		}
		
		public function playBackgroundSound(url:String):void
		{
			Log.debug("playBackgroundSound "+url);
			mBgSoundCurTime = 0;
			mBgSoundUrl = url;
			mBgSoundDirty = true;
		}
		
		private function stopBackgroundSound():void
		{
			mBgSoundDirty = false;
			if(mBgSoundUrl)
			{
//				SoundManage.stopBgSound();
				mBgSoundUrl = null;
			}
		}
		
		public function setBackgroundColor(color:uint):void
		{
			mBackgroundColor = color;
			mBackGroundColorDirty = true;
		}
		
		override protected function onActivedScene():void
		{
			super.onActivedScene();
			
			
		}
		
		override protected function onDeActivedScene():void
		{
			super.onDeActivedScene();
			
			
			terrainSceneLayer.releaseTerrainItems();
		}
		
		override protected function onClearScene():void
		{
			mIsCurrentCutdownEffectPlaying = false;
			effectSceneLayer.removeAll();
			uiEffectSceneLayer.removeAll();
			
			super.onClearScene();
			
			stopBackgroundSound();
			
			removeAllSceneElements();
			terrainSceneLayer.clear();
			
			if(hasEventListener(MapSceneEvent.SCENE_CLEARED))
			{
				var sceneEvent:MapSceneEvent = new MapSceneEvent(MapSceneEvent.SCENE_CLEARED);
				dispatchEvent(sceneEvent);
			}
		}
		
		public function notifyInitializeSceneComplete():void
		{
			if(hasEventListener(MapSceneEvent.SCENE_INITIALIZED))
			{
				var sceneEvent:MapSceneEvent = new MapSceneEvent(MapSceneEvent.SCENE_INITIALIZED);
				dispatchEvent(sceneEvent);
			}
		}
		
		override public function onTick(deltaTime:Number):void
		{
			super.onTick(deltaTime);
			
			if(mBgSoundDirty)
			{
				mBgSoundCurTime += deltaTime;
				if(mBgSoundCurTime > BG_SOUND_WAIT_LOAD_TIME)
				{
					mBgSoundCurTime = 0;
//					SoundManage.playBgSound(mBgSoundUrl); 
					
					mBgSoundDirty = false;
				}
			}
			
			effectSceneLayer.onTick(deltaTime);
			uiEffectSceneLayer.onTick(deltaTime);
			topSceneLayer.onTick(deltaTime);
			middleSceneLayer.onTick(deltaTime);
			bottomSceneLayer.onTick(deltaTime);
			bgScenenLayer.onTick(deltaTime);
		}
		
		override public function onFrame(deltaTime:Number):void
		{
			super.onFrame(deltaTime);
			bgScenenLayer.onFrame(deltaTime);
			
			topSceneLayer.onFrame(deltaTime);
			middleSceneLayer.onFrame(deltaTime);
			bottomSceneLayer.onFrame(deltaTime);
			
			effectSceneLayer.onFrame(deltaTime);
			uiEffectSceneLayer.onFrame(deltaTime);
			terrainSceneLayer.onFrame(deltaTime);
//			topSceneLayer.visible = false;
//			middleSceneLayer.visible = false;
//			topSceneLayer.visible = false;
			
			if(mBackGroundColorDirty)
			{
				drawBackgroundColor();
				mBackGroundColorDirty = false;
			}
		}
		
		private function drawBackgroundColor():void
		{
//			this.graphics.clear();
//			this.graphics.beginFill(mapSceneInfo.mapSeaColor);
//			this.graphics.drawRect(0, 0, camera.width, camera.height);
//			this.graphics.endFill();
			
//			Starling.current.stage.color = 0x00ff00;
		}
		
		override protected function onStageResize():void
		{
			super.onStageResize();
			
			if(mActived)
			{
				mBackGroundColorDirty = true;
			}
		}
		
		//----------------------------------------------------------------------
		protected function getUnUsedmSceneEntityUID():int
		{
			return mSceneUIdElementsCounter++;
		}
		
		protected function resetUnUsedmSceneEntityUID():void
		{
			mSceneUIdElementsCounter = 0;
		}
		
		public function addSceneEntity(sceneEntity:SceneEntity):SceneEntity
		{
			if(mSceneElements[sceneEntity.uid]) 
			{
				Log.error("Scene::addSceneElement exsit error." + " uid: " + sceneEntity.uid);
				return null;
			}
			
			mSceneElements[sceneEntity.uid] = sceneEntity;
			
			switch(sceneEntity.sceneLayerType)
			{
				case DisplaySortableSceneLayer.SCENELAYER_BOTTOM:
					bottomSceneLayer.add(sceneEntity);
					break;
				
				case DisplaySortableSceneLayer.SCENELAYER_MIDDLE:
					middleSceneLayer.add(sceneEntity);
					break;
				
				case DisplaySortableSceneLayer.SCENELAYER_TOP:
					topSceneLayer.add(sceneEntity);
					break;
				
				default:
					throw new Error("addSceneEntity no scene layer!");
					break;
			}
			
			return sceneEntity;
		}
		
		public function getSceneElement(uid:String):SceneEntity
		{
			return mSceneElements[uid] as SceneEntity;
		}
		
		public function getSceneElementByFunction(filterFunction:Function):SceneEntity
		{
			for each(var element:SceneEntity in mSceneElements)
			{
				if(filterFunction(element))
				{
					return element;
				}
			}
			
			return null;
		}
		
		public function getSceneElementsByFunction(filterFunction:Function):Array
		{
			var results:Array = [];
			
			for each(var element:SceneEntity in mSceneElements)
			{
				if(filterFunction(element))
				{
					results.push(element);
				}
			}
			
			return results;
		}
		
		public function removeAllSceneElements(filterPassFunction:Function = null):void
		{
			for each(var element:SceneEntity in mSceneElements)
			{
				if(filterPassFunction == null || filterPassFunction(element))
				{
					deleteSceneElement(element.uid);
				}
			}
		}
		
		public function deleteSceneElement(uid:String):SceneEntity
		{
			var element:SceneEntity = mSceneElements[uid] as SceneEntity;
			
			if(!element) 
			{
				Log.error("Scene::deleteSceneElement not exsit error. uid: " + uid);
				return null;
			}
			
			delete mSceneElements[uid];
			
			switch(element.sceneLayerType)
			{
				case DisplaySortableSceneLayer.SCENELAYER_BOTTOM:
					bottomSceneLayer.remove(element);
					break;
				
				case DisplaySortableSceneLayer.SCENELAYER_MIDDLE:
					middleSceneLayer.remove(element);
					break;
				
				case DisplaySortableSceneLayer.SCENELAYER_TOP:
					topSceneLayer.remove(element);
					break;
				
				default:
					throw new Error("addSceneElement no scene layer!");
					break;
			}
			
			return element;
		}
		
		public function getAllSceneElementCount():uint
		{
			var count:uint = 0;
			for each(var element:SceneEntity in mSceneElements)
			{
				count++;
			}
			
			return count;
		}
		
		
		public function payCutdownEffect(time:int, x:Number = 0, y:Number =0):void
		{
			if(time > 0)
			{
				if(mIsCurrentCutdownEffectPlaying)
				{
				}
				else
				{
					mIsCurrentCutdownEffectPlaying = true;
				}
				
			}
		}
		
		public function removeCutdownEffect():void
		{
			if(mIsCurrentCutdownEffectPlaying)
			{
				mIsCurrentCutdownEffectPlaying = false;
			}
		}
		
		//effect
		public function addSceneEffect(element:BasicSceneEntity):void
		{
			effectSceneLayer.add(element);
		}
		
		public function removeSceneEffect(element:BasicSceneEntity, dispose:Boolean = true):void
		{
			effectSceneLayer.remove(element, dispose);
		}
		
		public function addSceneUIEffect(element:BasicSceneEntity):void
		{
			uiEffectSceneLayer.add(element);
		}
		
		public function removeSceneUIEffect(element:BasicSceneEntity, dispose:Boolean = true):void
		{
			uiEffectSceneLayer.remove(element, dispose);
		}
	}
}