package  com.wg.scene.basics
{
	import flash.display.Sprite;
	import flash.events.Event;

	public class BasicViewElement extends Sprite
	{
		private var _isInitilized:Boolean = false;
		
		public function BasicViewElement()
		{
			this.addEventListener(Event.ADDED_TO_STAGE, addToStageHandler);
		}
		
		public final function get initilized():Boolean
		{
			return _isInitilized;
		}
		
		protected function onAddToStage():void
		{
		}
		
		protected function onInitialize():void
		{
		}
		
		protected function onRemoveFromStage():void
		{
		}
		
		//event handler
		private function addToStageHandler(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, addToStageHandler);
			this.addEventListener(Event.REMOVED_FROM_STAGE, removeFromStageHandler);
			
			if(!_isInitilized) 
			{
				_isInitilized = true;
				onInitialize();
			}
			
			onAddToStage();
		}
		
		private function removeFromStageHandler(event:Event):void
		{
			this.removeEventListener(Event.REMOVED_FROM_STAGE, removeFromStageHandler);
			this.addEventListener(Event.ADDED_TO_STAGE, addToStageHandler);
			
			onRemoveFromStage();
		}
	}
}