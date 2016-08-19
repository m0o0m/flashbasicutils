package com.wg.mvc 
{
	import flash.utils.getQualifiedClassName;

	public class SuperBase extends Object 
	{
		private var _superSubBaseList:Object;
		private var _frameProcessList:Object;
		private var _timerProcessList:Object;
		private var _nameHash:Object;
		
		public function SuperBase() 
		{
			_superSubBaseList = {};
			_frameProcessList = {};
			_timerProcessList = {};
			_nameHash = {};
		}
		
		public function get sign() : String
		{
			return getQualifiedClassName(this);
		}
		
		public function addToFrameProcessList(handlerName:String, handler:Function) : void
		{
			_frameProcessList[handlerName] = handler;
		}

		public function removeFromFrameProcessList(handlerName:String) : void
		{
			delete _frameProcessList[handlerName];
		}
		
		public function frameProcess() : void
		{
			for (var handlerName:String in _frameProcessList) {
				_frameProcessList[handlerName]();
			}
		}
		
		public function addToTimerProcessList(handlerName:String, handler:Function) : void
		{
			_timerProcessList[handlerName] = handler;
		}

		public function removeFromTimerProcessList(handlerName:String) : void
		{
			delete _timerProcessList[handlerName];
		}
		
		public function timerProcess() : void
		{
			for (var handlerName:String in _timerProcessList) {
				_timerProcessList[handlerName]();
			}
		}
		
		/**
		 *根据 传入的类类型创建并保存这个类实例;
		 * @param typeClass
		 * @param name
		 * @return 
		 * 
		 */
		protected function createObjectBase(typeClass:Class, name:String) : *
		{
			var module:* = _nameHash[name];
			if (module == null) {
				module = name.replace(/^\[class /, "");
				module = module.substring(0, 1).toLowerCase() + module.substring(1);
				_nameHash[name] = module;
			}
			
			if (_superSubBaseList[module] == null) {
				_superSubBaseList[module] = new typeClass;
				(_superSubBaseList[module] as SuperSubBase).__init(this, module);
			}
			return _superSubBaseList[module];
		}
		
		public function destroyObject(module:String) : void
		{
			delete _superSubBaseList[module];
		}
	}
}