package  com.wg.scene.basics
{
	
	
	import com.wg.schedule.IAnimatedObject;
	import com.wg.schedule.ITickedObject;
	import com.wg.schedule.Scheduler;
	
	import flash.events.Event;

	public class BasicAnimatedViewElement extends BasicViewElement implements IAnimatedObject, ITickedObject
	{
		public var watchStageResize:Boolean = false;
		
		private var mStageSizeDirty:Boolean = false;
		
		private var mRegisterForUpdates:Boolean = true;
		private var mInitialRegisterForUpdates:Boolean = mRegisterForUpdates;
		private var mIsRegisteredForUpdates:Boolean = false;
		
		public function BasicAnimatedViewElement()
		{
			super();
		}
		
		public function set registerForUpdates(value:Boolean):void
		{
			mRegisterForUpdates = value;
			
			if(mRegisterForUpdates && !mIsRegisteredForUpdates)
			{
				// Need to register.
				mIsRegisteredForUpdates = true;
				//Scheduler.addTickedcontent;
				//Scheduler.addAnimatedcontent;
			}
			else if(!mRegisterForUpdates && mIsRegisteredForUpdates)
			{
				// Need to unregister.
				mIsRegisteredForUpdates = false;
				//Scheduler.removeTickedcontent;
				//Scheduler.removeAnimatedcontent;
			}
		}
		
		public function get registerForUpdates():Boolean { return mRegisterForUpdates; }
		
		//IAnimatedObject Interface
		public function onFrame(deltaTime:Number):void 
		{
			if(mStageSizeDirty)
			{
				onStageResize();
				mStageSizeDirty = false;
			}
		}
	
		public function onTick(deltaTime:Number):void
		{
		}
		
		override protected function onAddToStage():void
		{
			mInitialRegisterForUpdates = mRegisterForUpdates;
			registerForUpdates = mRegisterForUpdates;
			
			if(watchStageResize)
			{
				stage.addEventListener(Event.RESIZE, stageResizeHandler, false, 0, true);
			}
		}
		
		override protected function onRemoveFromStage():void
		{
			registerForUpdates = false;
			mRegisterForUpdates = mInitialRegisterForUpdates; 
			
			if(watchStageResize)
			{
				stage.removeEventListener(Event.RESIZE, stageResizeHandler);
			}
		}
		
		private function stageResizeHandler(event:Event):void
		{
			requestStageResize();
		}
		
		protected function requestStageResize():void
		{
			mStageSizeDirty = true;
		}
		
		protected function onStageResize():void
		{
		}
	}
}