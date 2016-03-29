package com.wg.scene.mapScene
{
	import com.wg.logging.Log;
	import com.wg.scene.basics.BasicAnimatedViewElement;
	
	import flash.geom.Rectangle;
	
	import starling.core.Starling;
	import com.wg.scene.SceneCamera;

	public class SceneBasic extends BasicAnimatedViewElement
	{
		static private var lastActivedScene:SceneBasic;
		
		public var camera:SceneCamera;
		
		protected var mActived:Boolean = false;
		private var mSceneInited:Boolean = false;
		
		/**
		 *保存整个场景的宽,包括未显示的 
		 */
		protected var mSceneScrollWidth:Number = 0;
		/**
		 *保存整个场景的高,包括未显示的 ; 
		 */
		protected var mSceneScrollHeight:Number = 0;
		
		public function SceneBasic()
		{
			super();

			this.watchStageResize = true;
			this.visible = this.registerForUpdates = false;
		}
		
		public function get actived():Boolean { return mActived }; 
		public function get sceneScrollWidth():Number { return mSceneScrollWidth; }
		public function get sceneScrollHeight():Number { return mSceneScrollHeight; }
		
		public final function activeScene():void
		{
			if(!mSceneInited) 
			{
				Log.error("SceneBasic::activeScene SceneInited must befor the active!");
				return;
			}
			
			if(!mActived)
			{
				mActived = true;
				
				onActivedScene();
			}
		}
		
		public final function deactiveScene():void
		{
			if(mActived)
			{
				mActived = false;
				
				onDeActivedScene();
			}
		}
		
		protected function onActivedScene():void
		{
			camera.reset();
			
//			var mStarling:Starling = Starling.current;
//			var viewPort:Rectangle = mStarling.viewPort;
//			viewPort.setTo(0, 0, stage.stageWidth, stage.stageHeight);
//			mStarling.stage.stageWidth = stage.stageWidth;
//			mStarling.stage.stageHeight = stage.stageHeight;
//			mStarling.viewPort = viewPort;
//			camera.setCameraSize(stage.stageWidth, stage.stageHeight);
			camera.cameraStage.setChildIndex(this, 0);
			
			camera.scrollWidth = mSceneScrollWidth;
			camera.scrollHeight = mSceneScrollHeight;
//			camera.fade(0, 1, false);
			camera.cameraStage.visible = this.visible = this.registerForUpdates = true;
			
			//stage size may be changed in last scene.
			requestStageResize();
		}
		
		protected function onDeActivedScene():void
		{
			camera.cameraStage.visible = this.visible = this.registerForUpdates = false;
		}
		
		public final function initializeScene(sceneDatas:Array):void
		{
			if(!mSceneInited)
			{
				onInitializeScene(sceneDatas);
				mSceneInited = true;
				onInitializeSceneComplete();
			}
		}
		
		protected function onInitializeScene(sceneDatas:Array):void
		{
		}
		
		protected function onInitializeSceneComplete():void
		{
		}
		
		public final function clearScene():void
		{
			if(mSceneInited)
			{
				onClearScene();
				mSceneInited = false;
			}
		}
		
		protected function onClearScene():void
		{
			this.visible = this.registerForUpdates = false;
		}
		
		public function destoryScene():void
		{
			clearScene();
		}
		
		override public function onTick(deltaTime:Number):void
		{
			camera.onTick(deltaTime);
		}
		
		override public function onFrame(deltaTime:Number):void
		{
			super.onFrame(deltaTime);
		
			camera.onFrame(deltaTime);
		}
		
		override protected function requestStageResize():void
		{
			if(!mActived) return;
			
			super.requestStageResize();
		}
		
		override protected function onStageResize():void
		{
			if(mActived)
			{
//				camera.setCameraSize(stage.stageWidth, stage.stageHeight);
				//测试用
				/*var mStarling:Starling = Starling.current;
				var viewPort:Rectangle = mStarling.viewPort;
				viewPort.setTo(0, 0, stage.stageWidth, stage.stageHeight);
				mStarling.stage.stageWidth = stage.stageWidth;
				mStarling.stage.stageHeight = stage.stageHeight;
				mStarling.viewPort = viewPort;*/
			}
		}
	}
}