package views
{
	
	import com.asset.xml.XmlToObject;
	import com.wg.logging.Log;
	import com.wg.scene.SceneCamera;
	import com.wg.scene.SceneManager;
	import com.wg.scene.avtars.BasicAvatar;
	import mymap.elements.BgElement;
	import com.wg.scene.elments.SeaMapSceneEntity;
	import com.wg.scene.elments.entity.SceneEntity;
	import com.wg.scene.mapScene.layers.DisplaySortableSceneLayer;
	import com.wg.schedule.Scheduler;
	
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.media.Camera;
	import flash.utils.getTimer;
	
	import starling.core.Starling;
	import starling.display.Sprite;
	
	import mymap.scene.Mapscene;

	/**
	 *详细的操作效果,可在MaptestView中,查看; 
	 * @author Administrator
	 * 
	 */
	public class SceneTestView extends ViewBase
	{
		private var _mvcTimer:MvcTimer;
		private var map1cls:Class;
		
		public var firstInitSceneConfig:XML;
		public function SceneTestView()
		{
			panelName = "scenetest";
			super();
		}
		override protected function render():void
		{
			if(!content)
			{
				var maincls:Class = Config.resourceLoader.getClass(panelName);
				content = new maincls();
				map1cls = Config.resourceLoader.getClass("map1",panelName);
				this.addChild(content);
				
				Scheduler.getInstance().init({stage:_stage});
				Scheduler.getInstance().start();
				
				/*Starling.handleLostContext = true;
				var mStarling:Starling = new Starling(starling.display.Sprite,_stage);
				Config.starling = mStarling;
				mStarling.addEventListener("rootCreated", starlingRootCreatedHandler);*/
				content.shark_btn.addEventListener(MouseEvent.CLICK,function(e:MouseEvent):void
				{
					Config.camera.shake(0.05, 0.5, SceneCamera.SHAKE_BOTH_AXES, true);
				});
				content.fade_btn.addEventListener(MouseEvent.CLICK,function(e:MouseEvent):void
				{
					Config.camera.fade(0xff0000,1,false,true);
				});
				content.wide_btn.addEventListener(MouseEvent.CLICK,function(e:MouseEvent):void
				{
					Config.camera.wideScreen(300,1,false,true);
					
//					Config.camera.watchPoint(200,100,function(){trace("sdafsdfsdf")});
				});
				
				content.gotoself_btn.addEventListener(MouseEvent.CLICK,function(e:MouseEvent):void
				{
					Config.camera.watchTarget(mapscene.currentSelfPlayer);
				});
				
				content.gotopoint_btn.addEventListener(MouseEvent.CLICK,function(e:MouseEvent):void
				{
					Config.camera.watchPoint(900,500);
				});
			}
			super.render();
			
			readyAndEnterScene();
			
		}
		
		private function starlingRootCreatedHandler(event:*):void
		{
			Starling.current.start();
//			readyAndEnterScene(mapSceneInfo);
			
		}
		
		private var map1:MovieClip;
		private var hasRgistHandler:Boolean;
		private var mapscene:Mapscene;
		private function readyAndEnterScene():void
		{
			//pre init
			/*_mvcTimer = new MvcTimer;
			_mvcTimer.init(this);*/
			//设置镜头
			Config.camera = new SceneCamera(_stage,this);
			Config.camera.setCameraSize(800,400);
			/*content.x = 100;
			content.y = 100;
			Config.camera.cameraStage.addChild(content);
			*/
			Scheduler.getInstance().addTickedObject(Config.camera);
			Scheduler.getInstance().addAnimatedObject(Config.camera);
			
			mapscene = new Mapscene();
			mapscene.camera = Config.camera;
			Config.mapscene = mapscene;
			map1 = new map1cls();
//			mapscene.addChild(map1);
			mapscene.x = 200;
			mapscene.y = 100;
			Config.camera.cameraStage.addChildAt(mapscene,0);
			mapscene.initializeScene([]);
			
			//添加显示对象;
			var tempentity:SeaMapSceneEntity = new SeaMapSceneEntity();
			tempentity.sceneLayerType = DisplaySortableSceneLayer.SCENELAYER_MIDDLE;
			tempentity.uid = "guaiwu001";
			tempentity.initialize();
			tempentity.showDebugLine(true);
			tempentity.setPosition(100,100);
			mapscene.addSceneEntity(tempentity);
			
			
			mapscene.addSelfPlayer();
			mapscene.addbg();
			//激活此屏幕;
			mapscene.activeScene();
			
//			Scheduler.getInstance().addTickedObject(mapscene);
//			Scheduler.getInstance().addAnimatedObject(mapscene);
			
			Config.sceneManager = new SceneManager();
			
			registSceneListenerHandler();
			
			
			//模拟地图加载完毕;
//			changedToMapSceneCompleteHandler();
			
//			testMapscene();
		}
		
		
		public function registSceneListenerHandler():void
		{
			if(!hasRgistHandler)
			{
				hasRgistHandler = true;
				
				
				
				//scene mouse interactive type.
				mapscene.stage.addEventListener(MouseEvent.MOUSE_DOWN, sceneMouseMouseDownHandler);
				mapscene.stage.addEventListener(MouseEvent.MOUSE_UP, sceneMouseUpHandler);
				//				mapscene.stage.addEventListener(Event.MOUSE_LEAVE, sceneMouseLeaveHandler);
				mapscene.stage.addEventListener(Event.ACTIVATE, sceneMouseBackHandler);
				mapscene.stage.addEventListener(Event.DEACTIVATE, sceneMouseLeaveHandler);
			}
		}
		public function cancelSceneListenerHandler():void
		{
			if(hasRgistHandler)
			{
				hasRgistHandler = false;
				
				
				
				//scene mouse interactive type.
				mapscene.stage.removeEventListener(MouseEvent.MOUSE_DOWN, sceneMouseMouseDownHandler);
				mapscene.stage.removeEventListener(MouseEvent.MOUSE_UP, sceneMouseUpHandler);
				//				mapscene.stage.addEventListener(Event.MOUSE_LEAVE, sceneMouseLeaveHandler);
				mapscene.stage.removeEventListener(Event.ACTIVATE, sceneMouseBackHandler);
				mapscene.stage.removeEventListener(Event.DEACTIVATE, sceneMouseLeaveHandler);
			}
		}
		
		private function sceneMouseBackHandler(event:Event):void
		{
			Log.debug("——————舞台得到焦点——————");//触发一次的情况下，本地编译会执行2次，网页上会只会执行1次
			stage.focus = null;
			if(isDeactvie == true)
			{
				//				view.activity.updateMcCD();
				//				view.campFightInfo.updateMcCD();
				isDeactvie = false;
			}
		}
		/**
		 *响应鼠标点击屏幕事件; 
		 * @param event
		 * 
		 */
		private function sceneMouseLeaveHandler(event:Event):void
		{
			Log.debug("——————舞台失去焦点——————");//触发一次的情况下，本地编译会执行2次，网页上会只会执行1次
			isDeactvie = true;
			if(mapscene.visible &&
				mapscene.actived && 
				(mapscene.mouseEnabled && mapscene.mouseChildren))
			{
				mSceneMouseDown = false;
				
//				removeListenSceneMouseMoving();
			}
		}
		
		private var mSceneMouseDown:Boolean = false;
		private var mSceneMouseDownStageX:int = 0;
		private var mSceneMouseDownStageY:int = 0;
		private var mSceneMouseDownCameraFocusX:int = 0;
		private var mSceneMouseDownCameraFocusY:int = 0;
		private var mSceneMouseDownCameraTweenScroll:Boolean = false;
		private var isDeactvie:Boolean;
		private var isOnChangeMap:Boolean;
		private function sceneMouseMouseDownHandler(event:MouseEvent):void
		{
//			stopScreenMove(); 
			
//			t0 = getTimer();
			
			var target:Object = event.target;
			
			
			var camera:SceneCamera = Config.camera;
			
			if(camera.cameraStage.mouseChildren &&
				mapscene.visible &&
				mapscene.actived && 
				(mapscene.mouseEnabled && mapscene.mouseChildren) &&
				(target == mapscene || 
					target is Stage))
			{
				if(!mSceneMouseDown)
				{
					mSceneMouseDown = true;
					
					mSceneMouseDownStageX = event.stageX;
					mSceneMouseDownStageY = event.stageY;
					mSceneMouseDownCameraFocusX = mapscene.camera.focusTargetX
					mSceneMouseDownCameraFocusY = mapscene.camera.focusTargetY;
					
					mSceneMouseDownCameraTweenScroll = mapscene.camera.isTweenMoveCamera;
				/*	mSceneListenMouseMoving = isHomeSceneType;
					if(mSceneListenMouseMoving)
					{
						//						mapscene.camera.isTweenMoveCamera = false;
						mapscene.stage.addEventListener(MouseEvent.MOUSE_MOVE, sceneMouseMouseMoveHandler);
					}*/
				}
			}
		}
		
		private function sceneMouseUpHandler(event:MouseEvent):void
		{
//			removeListenSceneMouseMoving();
			
			var camera:SceneCamera = Config.camera;
			
			if(camera.cameraStage.mouseChildren &&
				mapscene.actived && 
				(mapscene.mouseEnabled && mapscene.mouseChildren))
			{
				if(mSceneMouseDown)
				{
					mSceneMouseDown = false;
					
					//click
					var target:Object = event.target;
					
//					mAutoWayFindding.cancle();
					
					if(target === mapscene || target === mapscene.stage)
					{
						var worldX:Number = mapscene.mouseX + mapscene.camera.scrollX;
						var worldY:Number = mapscene.mouseY + mapscene.camera.scrollY;
						
						mapscene.mapEmptyPointClick(new Point(worldX, worldY));
					}
					else
					{
						if(target is BasicAvatar && BasicAvatar(target).owner)
						{ 
//							stopScreenMove();
							//点击monster响应;
//							mapscene.sceneElementTargetClick(SeaMapSceneEntity(BasicAvatar(target).owner));
						}
					}
				}
			}
		}
		
		
		/**
		 *模拟地图加载完毕 
		 * 
		 */
		private function changedToMapSceneCompleteHandler():void
		{
			//clear the last one scene.
			mapscene.clearScene();
			Config.sceneManager.popupScene();
			
			mapscene.initializeScene([]);
			
//			mapscene.mouseEnabled = mapscene.mouseChildren = !mapSceneInfo.isPataMapSceneType();
			
			//			trace("changedToMapSceneCompleteHandler: ", getTimer() - t);
			
			this.registSceneListenerHandler();
			
			Scheduler.start();
			
			//set camera
			Config.sceneManager.pushScene(mapscene);
			mapscene.notifyInitializeSceneComplete();
			
			isOnChangeMap = false;
		}
		
		
		
		private function testMapscene():void
		{
			// TODO Auto Generated method stub
//			mapscene = new mapscene();
		}
		
		public function frameProcess():void
		{
			trace("frameProcess");
		}
		public function timerProcess():void
		{
			trace("timerProcess");
		}
		
		
		override protected function dispose():void
		{
			cancelSceneListenerHandler();
			Scheduler.getInstance().removeAnimatedObject(Config.camera);
			Scheduler.getInstance().removeAnimatedObject(Config.camera);
			Scheduler.getInstance().stop();
			this.removeChild(content);
			content = null;
			_stage.removeChild(Config.camera.cameraStage);
			Config.camera = null;
		}
		
	}
}