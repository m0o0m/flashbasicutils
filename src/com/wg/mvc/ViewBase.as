package com.wg.mvc
{
	import com.wg.logging.Log;
	import com.wg.mvc.ClientConstants;
	import com.wg.mvc.command.interfaces.ICommand;
	import com.wg.mvc.interfaces.views.IView;
	import com.wg.resource.ResourceLoader;
	
	import flash.display.Stage;
	import flash.events.Event;
	
	public class ViewBase extends SuperBase implements IView
	{
		private var _stage:Stage;
		private var _positionList:Object = {};
		private var _eventHandlers:Object = {};
		
		public function ViewBase()
		{
			return;
		}

		public function get stage() : Stage
		{
			return _stage;
		}
		
		
		
		public function init(stage:Stage) : void
		{
			_stage = stage;
			_stage.addEventListener(Event.RESIZE,resetPosition)
		}
		
		public function registerEventHandler(event:String, handler:Function = null) : void
		{
			if (_eventHandlers[event]) {
				var found:Boolean = false;
				for (var i:uint = 0; i < _eventHandlers[event].length; ++i) {
					if (_eventHandlers[event][i] == handler) {
						found = true;
						Log.warn("event[" + event+ "] handler[" + handler + "] already add");
						break;
					}
				}
				if (!found) {
					_eventHandlers[event].push(handler);
				}
			}
			else {
				_eventHandlers[event] = [handler];
			}
		}
		
		public function cancelEventHandler(event:String, handler:Function) : void
		{
			if (_eventHandlers[event]) {
				var found:Boolean = false;
				for (var i:uint = 0; i < _eventHandlers[event].length; ++i) {
					if (_eventHandlers[event][i] == handler) {
						found = true;
						_eventHandlers[event].splice(i, 1);
						break;
					}
				}
				if (!found) {
					Log.warn("event[" + event + "] handler[" + handler + "] not found");
				}
			}
			else {
				Log.warn("event[" + event + "] handler[" + handler + "] not found");
			}			
		}
		
		public function notifyEvent(event:String, data:*=null) : void
		{
			var tempCommand:ICommand = MVCManager.getCommand(event);
			if(!tempCommand)
			{
				Log.warn(event+" 消息不存在或是在Constant中没有配置常量");
				return;
			}
			tempCommand.excute(data);
			
			var handlers:* = _eventHandlers[event];
			if (handlers) {
				(handlers as Array).forEach(function(handler:Function, index:int, array:Array):void {
					if(handler is Function) handler(tempCommand);
				});
			}else
			{
				Log.warn(event+" 消息在view中没有注册");
				return;
			}			
		}
		public function hasEventHandler(event:String):Boolean
		{
			var tempBln:Boolean;
			var handlers:* = _eventHandlers[event];
			if (handlers) {
				tempBln = true;
			}else
			{
				tempBln = false;
				
			}
			return tempBln;
		}
		
		public function cancelCenter(param1:String) : void
		{
			removeFromPositionList(param1);
		}
		

		public function addToPositionList(p_sign:String, p_fun:Function) : void{
			_positionList[p_sign] = p_fun;
		}
		
		public function removeFromPositionList(param1:String) : void
		{
			delete _positionList[param1];
		}

		protected function createObject(className:Class) : Object
		{
			return createObjectBase(className, (className + "").replace(/View\]$/, ""));
		}
		
		protected function resetPosition(event:Event) : void
		{
			ClientConstants.SCREEN_WIDTH =ClientConstants.STAGE_MAX_WIDTH =ClientConstants.STAGE_NORMAL_WIDTH = ClientConstants.STAGE_MIN_WIDTH = stage.stageWidth;
			ClientConstants.SCREEN_HEIGHT =ClientConstants.STAGE_MAX_HEIGHT =ClientConstants.STAGE_NORMAL_HEIGHT = ClientConstants.STAGE_MIN_HEIGHT = stage.stageHeight; 
			
			var w:int = ClientConstants.STAGE_MAX_WIDTH;
			for each(var fun:Function in _positionList){
				fun();
			}
		}
	}
}
