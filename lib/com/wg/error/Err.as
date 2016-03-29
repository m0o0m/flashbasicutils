package com.wg.error
{
	import com.wg.logging.Log;
	
	public class Err
	{
		private static var _instance:Err;

		private var _errors:Object = {};

		public static function getInstance() : Err
		{
			if (_instance == null) {
				_instance = new Err;
			}
			return _instance;
		}

		public static function occur(error:*, data:*=null) : void
		{
			getInstance().handleError(error, data);
		}		
		
		public function Err()
		{
			return;
		}
		
		public function init(pairs:Object=null) : void
		{
			for each (var pair:Object in pairs) {
				for each (var error:* in pair['errors']) {
					addHandler(error, pair['handler']);
				}
			}
		}
		
		public function addHandler(error:*, handler:Function) : void
		{
			if (_errors[error]) {
				var found:Boolean = false;
				for (var i:uint = 0; i < _errors[error].length; ++i) {
					if (_errors[error][i] == handler) {
						found = true;
						Log.warn("error[" + error + "] handler[" + handler + "] already add");
						break;
					}
				}
				if (!found) {
					_errors[error].push(handler);
				}
			}
			else {
				_errors[error] = [handler];
			}
		}
		
		public function removeHandler(error:*, handler:Function) : void
		{
			if (_errors[error]) {
				var found:Boolean = false;
				for (var i:uint = 0; i < _errors[error].length; ++i) {
					if (_errors[error][i] == handler) {
						found = true;
						_errors[error].splice(i, 1);
						break;
					}
				}
				if (!found) {
					Log.warn("error[" + error + "] handler[" + handler + "] not found");
				}
			}
			else {
				Log.warn("error[" + error + "] handler[" + handler + "] not found");
			}			
		}
		
		public function handleError(error:*, data:*=null) : void
		{
			var handlers:* = _errors[error];
			if (handlers) {
				(handlers as Array).forEach(function(handler:Function, index:int, array:Array):void {
					handler(error, data);
				});
			}			
		}
	}
}