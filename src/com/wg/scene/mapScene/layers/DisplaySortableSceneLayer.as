package  com.wg.scene.mapScene.layers
{
	
	import com.wg.scene.elments.entity.BasicSceneEntity;
	import com.wg.scene.utils.UniqueLinkList;
	
	import flash.display.DisplayObject;
	import com.wg.scene.basics.BasicSceneLayer;

	public class DisplaySortableSceneLayer extends BasicSceneLayer
	{
		public static const SCENELAYER_TOP:int = 1;
		public static const SCENELAYER_MIDDLE:int = 2;
		public static const SCENELAYER_BOTTOM:int = 3;
		
		private static const SCENE_LAYER_RENDER_DELAY:Number = 0.1;
		
		public var sortFunction:Function = defaultDepthRenderElementSortFunction;//default
		public var needRealTimeDepthSort:Boolean = false;
		
		private var mDepthSortDirtyFlag:Boolean = false;
		
		protected var mSceneEntities:UniqueLinkList;
		
		private var mSortWaitTime:Number = 0;
		
		public function DisplaySortableSceneLayer()
		{
			super();
			
			this.mouseChildren = true;
			
			mSceneEntities = new UniqueLinkList();
		}
		
		/**
		 * Indicates this layer is dirty and needs to resort.
		 */
		public function markDirty(force:Boolean = false):void
		{
			if(!needRealTimeDepthSort || force)
			{
				mDepthSortDirtyFlag = true;
			}
		}
		
		override public function onTick(deltaTime:Number):void
		{
			mSortWaitTime += deltaTime;
			
			var needSort:Boolean = false;
			
			if(mSortWaitTime > SCENE_LAYER_RENDER_DELAY)
			{
				mSortWaitTime = 0;
				
				needSort = needRealTimeDepthSort || mDepthSortDirtyFlag;
				
				if(needSort) mDepthSortDirtyFlag = false;
			}
			
			var dispaly:DisplayObject = null;
			if(needSort)
			{
				mSceneEntities.sort(sortFunction);
			}
			
			var entity:BasicSceneEntity = mSceneEntities.moveFirst();
			while(entity)
			{
				if(needSort)
				{
					dispaly	= entity.display;
					
					if(entity.isValidDisplay)
					{
						setChildIndex(dispaly, this.numChildren - 1);
					}
				}
				
				entity.onTick(deltaTime);
				
				entity = mSceneEntities.moveNext();
			}
			
			needSort = false;
		}
		
		override public function onFrame(deltaTime:Number):void
		{
			//--
			
			var entity:BasicSceneEntity = mSceneEntities.moveFirst();
			while(entity)
			{
				entity.onFrame(deltaTime);
				entity = mSceneEntities.moveNext();
			}
		}
		
		public function add(d:BasicSceneEntity):void
		{
			d.scene = scene;
			d.camera = camera;
			
			d.initialize();
			
			mSceneEntities.add(d);
			addChild(d.display);
			markDirty();
		}
		
		public function remove(d:BasicSceneEntity, dispose:Boolean = true):void
		{
			mSceneEntities.remove(d);
			if(d && d.display && d.display.parent)
			{
				removeChild(d.display);
			}
			
			if(dispose)
			{
				d.dispose();
			}
			
			d.scene = null;
			d.camera = null;
		}
		
		public function removeAll(dispose:Boolean = true):void
		{
			var entity:BasicSceneEntity = mSceneEntities.moveFirst();
			while(entity)
			{
				remove(entity);
				
				if(dispose)
				{
					entity.dispose();
				}
				
				entity = mSceneEntities.moveNext();
			}
		}
		
		//这里返回的结果是，场景中层次高在数组的前面， 1表示在上层- 1表示在下层
		public static function defaultDepthRenderElementSortFunction(a:BasicSceneEntity, b:BasicSceneEntity):Number
		{
			if(a.layerIndex > b.layerIndex) return 1;
			else if(a.layerIndex < b.layerIndex) return -1;
			else
			{
				if(a.y > b.y) return 1;
				else if(a.y < b.y) return -1;
				else//相等时
				{
					//左边的排在下面
					if(a.x > b.x) return 1;
					else if(a.x < b.x) return -1;
					{
						if(a.zFighting > b.zFighting) return 1;
						else if(a.zFighting < b.zFighting) return -1;
						else
						{
							a.zFighting++;
							return 1;
						}
					}
				}
			}
		}
	}
}