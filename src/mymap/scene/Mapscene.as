package mymap.scene
{
	import com.wg.scene.elments.SeaMapSceneEntity;
	import com.wg.scene.mapScene.MapSceneEvent;
	import com.wg.scene.mapScene.SeaSceneBasic;
	import com.wg.scene.mapScene.grid.SeaMapGridUtil;
	import com.wg.scene.mapScene.layers.DisplaySortableSceneLayer;
	
	import flash.geom.Point;
	import flash.utils.getTimer;
	
	import mymap.elements.BgElement;
	import mymap.elements.MyselfElement;
	
	public class Mapscene extends SeaSceneBasic
	{
		public var currentSelfPlayer:MyselfElement;
		public var seaMapGrid:SeaMapGridUtil;
		
		public function Mapscene()
		{
			super();
		}
		
		
		public function addSelfPlayer():void
		{
			currentSelfPlayer = new MyselfElement();
			currentSelfPlayer.debugUpdateSpeed(600);
			currentSelfPlayer.uid = "player001";
			currentSelfPlayer.sceneLayerType = DisplaySortableSceneLayer.SCENELAYER_TOP;
			currentSelfPlayer.initialize();
			currentSelfPlayer.showDebugLine(true);
			
//			currentSelfPlayer.display.ad
			this.addSceneEntity(currentSelfPlayer);
		}
			
		/**
		 *每个加入场景中的显示对象都是entity,
		 * 显示对象的尺寸最好设定在dead尺寸的范围内;
		 * 
		 */
		public function addbg():void
		{
			var bgelment:BgElement = new BgElement();
			var point:Point = new Point();
			for (var k:int = 0; k < 30; k++) 
			{
				point.y = k*60;
				for (var j:int = 0; j < 45; j++) 
				{
					bgelment = new BgElement();
					
					point.x = j*60;
					bgelment.x = point.x;
					bgelment.y = point.y;
					bgelment.uid = "bgelment"+j+","+k;
					
					bgelment.sceneLayerType = DisplaySortableSceneLayer.SCENELAYER_BOTTOM;
					bgelment.initialize();
//					bgelment.showDebugLine(true);
					this.bgScenenLayer.add(bgelment);
				}
			}
			
		
		}
		
		public function mapEmptyPointClick(clickTargetPoint:Point, checkValidTime:Boolean = true, comFuncShowIcon:Function = null):void
		{
			
			if(currentSelfPlayer)
			{
				var isValidClick:Boolean = true;
				
				
				if(isValidClick)
				{
					currentSelfPlayer.moveToByPoint(clickTargetPoint);
				}
			}
		}
		
		/**
		 * 推入mapscene场景的时候会默认添加镜头跟随对象;
		 * 
		 */
		override protected function onActivedScene():void
		{
			super.onActivedScene();
			
			//			camera.scrollLimitX = -SCENE_BORDER_WIDTH;
			//			camera.scrollLimitY = -SCENE_BORDER_HEIGHT;
			camera.isTweenMoveCamera = true;//!mapSceneInfo.isHomeMapSceneType();
			
			if(true)
			{
				camera.watchTarget(currentSelfPlayer);	
			}
			else
			{
//				camera.watchPoint(600 * 0.5, 2000 * 0.5 - 150);
				camera.watchPoint(mapSceneInfo.mapTotalWidth * 0.5, mapSceneInfo.mapTotalHeight * 0.5 - 150);
			}
			
		}
		
		
		override protected function onInitialize():void
		{
			super.onInitialize();
			
			//the main
			this.addEventListener(MapSceneEvent.SEFL_TARGET_PAUSE_MOVE, function ():void {//stopMoveLeaderAnimation();
			});
			
			seaMapGrid = new SeaMapGridUtil();
		}
		
		override protected function onInitializeScene(sceneDatas:Array):void
		{
			super.onInitializeScene(sceneDatas);
			
			var sceneConfigXMl:XML = mapSceneInfo.sceneConfigXMl;
			var gridShadowListStr:String = mapSceneInfo.sceneConfigXMl.gridShadowList.toString();
			var gridShadowList:Array = gridShadowListStr != null && gridShadowListStr.length > 0 ?
				gridShadowListStr.split("/") : null; 
			
			seaMapGrid.initGrid(mapSceneInfo.mapNumCols, 
			mapSceneInfo.mapNumRows,  
			sceneConfigXMl.gridTypeList.toString(), 
			gridShadowList);
			
			seaMapGrid.setSetEnclosure(mapSceneInfo.sceneConfigXMl.enclosurePos);
			
			
		}
		/**
		 *当mapscene 被清空时执行;
		 * 
		 */		
		override protected function onClearScene():void
		{
			
//			stopMoveLeaderAnimation();
			
			super.onClearScene();
		}
		//IAnimatedObject Interface
		override public function onTick(deltaTime:Number):void
		{
			super.onTick(deltaTime);
			
		}
		
		override public function onFrame(deltaTime:Number):void
		{
			super.onFrame(deltaTime);
		}
	}
}