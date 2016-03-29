package com.wg.scene.loading
{
	import com.ClientConstants;
	import com.wg.logging.Log;
	
	import flash.events.TimerEvent;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	
	public final class ShareObjectCacheManager
	{
		private static var _instance:ShareObjectCacheManager;
		
		public static function getInstance():ShareObjectCacheManager
		{
			return _instance ||= new ShareObjectCacheManager();
		}

		private var _cachedShareObjects:Dictionary = new Dictionary();
		private var _markedShareObjects:Dictionary = new Dictionary();
		
		private var _timer:Timer;
		
		private var _swipTime:int = ClientConstants.SHARE_OBJECT_CACHE_MANAGER_SWIP_TIME;
		
		public function ShareObjectCacheManager()
		{
			super();
		}
		
		public function get swipTime():int
		{
			return _swipTime
		}
		
		public function set swipTime(value:int):void
		{
			if(value < 0)
			{
				throw new Error("ShareObjectCacheManager::set swipTime value is smaller than 0");
			}
			
			_swipTime = value;
		}
		
		public function run():void
		{
			if(_timer == null)
			{
				_timer = new Timer(swipTime);
			}
			else
			{
				if(_timer.running)
				{
					_timer.reset();
				}

				_timer.delay = swipTime;
			}
			
			if(!_timer.hasEventListener(TimerEvent.TIMER))
			{
				_timer.addEventListener(TimerEvent.TIMER, shareObjectSwipTimerCompleteHandler);
			}

			_timer.start();
		}
		
		public function stop():void
		{
			if(_timer != null)
			{
				_timer.reset();
				
				if(_timer.hasEventListener(TimerEvent.TIMER))
				{
					_timer.removeEventListener(TimerEvent.TIMER, shareObjectSwipTimerCompleteHandler);
				}
			}
		}
		
//		public function reset():void
//		{
//			stop();
//			run();
//		}
		
		public function setSwipTimeDelta(value:int):void
		{
			if(!_timer)
			{
				_timer = new Timer(value);
				_timer.addEventListener(TimerEvent.TIMER, shareObjectSwipTimerCompleteHandler);
			}
			else
			{
				_timer.reset();
				_timer.delay = value;
			}
			
			_timer.start();
		}
		
		private function shareObjectSwipTimerCompleteHandler(event:TimerEvent):void
		{
			swipMarkedSharedObjects();
		}
		
		public function swipMarkedSharedObjects():void
		{
			//			var count:int = 0;
			for each(var shareObjectData:ShareObjectData in _markedShareObjects)
			{
				var key:String = shareObjectData.key;
				
				try
				{
					if(shareObjectData.shareObject && 
						Object(shareObjectData.shareObject).hasOwnProperty("dispose"))
					{
						shareObjectData.shareObject.dispose();
						//						count++;		
						Log.debug("!!!!!!!!!!ShareObjectSwip realease key: " + key);
					}
				}
				catch(error:Error)
				{
				}
				
				delete _markedShareObjects[key];
			}
			
			//			Log.debug("!!!!!!!!!!!!ShareObjectSwip realease count: " + count);
		}
		
		public function registShareObject(key:String, shareObject:*):void
		{
//			trace("registShareObject");
			if(!_markedShareObjects[key] && !_cachedShareObjects[key])
			{
				var shareObjectData:ShareObjectData = new ShareObjectData();
				shareObjectData.key = key;
				shareObjectData.shareObject = shareObject;
				_markedShareObjects[key] = shareObjectData;
			}
		}
		
		public function hasRegistShareObject(key:String):Boolean
		{
			return _markedShareObjects[key] || _cachedShareObjects[key];
		}

		public function fetchShareObject(key:String):*
		{
			var shareObjectData:ShareObjectData = null;
			
			shareObjectData = _markedShareObjects[key] as ShareObjectData;
			if(shareObjectData != null)
			{
				shareObjectData.referenceCount++;
				
				delete _markedShareObjects[key];
				_cachedShareObjects[key] = shareObjectData;
				
//				trace("fetchShareObject", shareObjectData.referenceCount);
				
				return shareObjectData.shareObject;
			}
			
			shareObjectData = _cachedShareObjects[key] as ShareObjectData;
			if(shareObjectData != null)
			{
				shareObjectData.referenceCount++;
				
//				trace("fetchShareObject", shareObjectData.referenceCount);
				return shareObjectData.shareObject;
			}
			
			return null;
		}
		
		public function toString():String
		{
//			return ""
			
			var results:String = "";
			var count:int = 0;
			var shareObjectData:ShareObjectData;
			
			var size:Number = 0;
			var contentSize:Number = 0;
			results += "\n markedShareObjects: \n";
			
			for each(shareObjectData in _markedShareObjects)
			{
				count++;
				
				contentSize = shareObjectData.getContentSize();
				size += contentSize;
				
				results += "key: " + shareObjectData.key + " size: " + int(contentSize * 100 / 1024 / 1024) * 0.01 + "M \n";
			}
			
			results += "count: " + count + " totalSize: " + int(size * 100 / 1024 / 1024) * 0.01 + "M";
			
			//--
			
			count = 0;
			size = 0;
			
			results += "\n ----------------------------------------------------------- \n";
			
			results += "\n cachedShareObjects: \n";
			for each(shareObjectData in _cachedShareObjects)
			{
				count++;
				
				contentSize = shareObjectData.getContentSize();
				size += contentSize;
				
				results += "key: " + shareObjectData.key + " size: " + int(contentSize * 100 / 1024 / 1024) * 0.01 + "M \n";
			}
			
			results += "count: " + count + " totalSize: " + int(size * 100 / 1024 / 1024) * 0.01 + "M";
			
			return results;
		}
		
//		public function noReferenceFetchShareObject(key:String):*
//		{
////			trace("noReferenceFetchShareObject");
//			var shareObjectData:ShareObjectData = null;
//			
//			shareObjectData = _markedShareObjects[key] as ShareObjectData;
//			if(shareObjectData != null)
//			{
//				_cachedShareObjects[key] = shareObjectData;
//				
//				return shareObjectData.shareObject;
//			}
//			
//			shareObjectData = _cachedShareObjects[key] as ShareObjectData;
//			if(shareObjectData != null)
//			{
//				return shareObjectData.shareObject;
//			}
//			
//			return undefined;
//		}
		
		public function releaseShareObject(key:String):void
		{
			var shareObjectData:ShareObjectData = _cachedShareObjects[key] as ShareObjectData;
			if(shareObjectData != null)
			{
				if(shareObjectData.referenceCount > 0)
				{
					shareObjectData.referenceCount--;
				}
				
//				trace("releaseShareObject", shareObjectData.referenceCount);
				
				if(shareObjectData.referenceCount == 0)
				{
					delete _cachedShareObjects[key];
					_markedShareObjects[key] = shareObjectData;
				}
			}
		}
	}
}
import flash.sampler.getSize;

internal final class ShareObjectData
{
	public var key:String;
	public var shareObject:*;
	public var referenceCount:int = 0;
	
	public function getContentSize():Number
	{
		if("getContentSize" in shareObject)
		{
			return shareObject["getContentSize"]();
		}
		else
		{
			return getSize(shareObject);
		}
	}
}