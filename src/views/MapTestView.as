package views
{
	
	import com.asset.xml.XmlToObject;
	import com.wg.logging.Log;
	import com.wg.scene.SceneCamera;
	import com.wg.scene.SceneManager;
	import com.wg.scene.avtars.BasicAvatar;
	import com.wg.scene.elments.SeaMapSceneEntity;
	import com.wg.scene.elments.entity.SceneEntity;
	import com.wg.scene.mapScene.SeaMapSceneLoader;
	import com.wg.scene.mapScene.layers.DisplaySortableSceneLayer;
	import com.wg.schedule.Scheduler;
	import com.wg.utils.xmlUtils.XmlLoader;
	
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.media.Camera;
	import flash.utils.getTimer;
	
	import mymap.elements.BgElement;
	import mymap.scene.Mapscene;
	import mymap.sceneInfo.MapSceneInfo;
	
	import starling.core.Starling;
	import starling.display.Sprite;
	
	public class MapTestView extends ViewBase
	{
		private var _mvcTimer:MvcTimer;
		
		public var firstInitSceneConfig:XML;
		public function MapTestView()
		{
			panelName = "maptest";
			super();
		}
		override protected function render():void
		{
			if(!content)
			{
				var maincls:Class = Config.resourceLoader.getClass(panelName);
				content = new maincls();
				this.addChild(content);
				
				Scheduler.getInstance().init({stage:_stage});
				Config.stage = _stage;
				
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
			//加载101地图;
			var xmlobject:XmlLoader = new XmlLoader("assets/map/town/101/map.xml",function (xml:XML):void
			{
				firstInitSceneConfig = xml;
				mSeaMapSceneLoader = new SeaMapSceneLoader(101);
				mSeaMapSceneLoader.loadStartCallback = null//changedToMapSceneStartHandler;
				mSeaMapSceneLoader.loadProgressCallback = null;//changedToMapSceneProgressHandler;
				mSeaMapSceneLoader.loadCompleteCallback = changedToMapSceneCompleteHandler;
				
				var currentMapId:int = 101;
				var mapSceneInfo:MapSceneInfo = mSeaMapSceneLoader.getMapSceneInfo(currentMapId, new BitmapData(10,10), firstInitSceneConfig);
				readyAndEnterScene(mapSceneInfo);
			});
			
			
		}
		
		private function starlingRootCreatedHandler(event:*):void
		{
			Starling.current.start();
			//			readyAndEnterScene(mapSceneInfo);
			
		}
		
		private var map1:MovieClip;
		private var hasRgistHandler:Boolean;
		private var mapscene:Mapscene;
		private function readyAndEnterScene(mapSceneInfo:MapSceneInfo):void
		{
			//pre init
			//设置镜头
			Config.camera = new SceneCamera(_stage);
			Config.camera.setCameraSize(stage.stageWidth, stage.stageHeight);//camera.setCameraSize(stage.stageWidth, stage.stageHeight);

//			Scheduler.getInstance().addTickedObject(Config.camera);
//			Scheduler.getInstance().addAnimatedObject(Config.camera);
			
			mapscene = new Mapscene();
			mapscene.camera = Config.camera;
			Config.mapscene = mapscene;
/*			mapscene.x = 200;
			mapscene.y = 100;*/
			Config.camera.cameraStage.addChildAt(mapscene,0);
			mapscene.initializeScene([mapSceneInfo]);
			
			mapscene.addSelfPlayer();
			mapscene.addbg();
			//激活此屏幕;
			mapscene.activeScene();
			
			
			Config.sceneManager = new SceneManager();
			
			registSceneListenerHandler();
			
			Scheduler.getInstance().start();
			
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
		private var mSeaMapSceneLoader:SeaMapSceneLoader;
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