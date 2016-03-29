package com.wg.scene.loading
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;

	public class CallLaterLoadItem extends EventDispatcher implements ISceneResourceLoaderItem
	{
		public function CallLaterLoadItem()
		{
			super();
		}
		
		public function load(modelURL:String):void
		{
			var that:IEventDispatcher = this;
			
			//reference the object
			
			//strong reference the cotent for count purpose.
			ShareObjectCacheManager.getInstance().fetchShareObject(modelURL);//noReferenceFetchShareObject(modelURL);
			
			//call later
			//because the Scheduler will stop when battle
			//so temp here stead
			Config.stage.addEventListener(Event.ENTER_FRAME, 
				function():void 
				{
					Config.stage.removeEventListener(Event.ENTER_FRAME, arguments.callee);
					
					//release the content
					ShareObjectCacheManager.getInstance().releaseShareObject(modelURL);
					
					if(that.hasEventListener(Event.COMPLETE))
					{
						that.dispatchEvent(new Event(Event.COMPLETE));
					}
			});
		}
	}
}