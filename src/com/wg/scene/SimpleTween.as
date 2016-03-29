package com.seaWarScene
{
	import com.boyojoy.schedule.IAnimatedObject;

	public class SimpleTween implements IAnimatedObject
	{
		private var _totalTime:Number;
		private var _currentTime:Number;

		public var updateCallback:Function;
		public var completeCallback:Function;
		
		private var _isPlaying:Boolean = false;
		
		public function SimpleTween()
		{
			super();
		}
		
		public function play(duration:Number):void
		{
			_currentTime = 0;
			_totalTime = duration;
			_isPlaying = true;
		}
		
		public function get isPlaying():Boolean
		{
			return _isPlaying;
		}
		
		public function stop():void
		{
			_isPlaying  = false;
			_currentTime = 0;
		}
		
		public function onFrame(deltaTime:Number):void
		{
			if(!_isPlaying) return;
			
			var percent:Number = _currentTime / _totalTime;
			_currentTime += deltaTime;
			
			if(percent >= 1)
			{
				if(updateCallback != null)
				{
					updateCallback(1);
				}
				
				if(completeCallback != null)
				{
					completeCallback();
				}
				_isPlaying = false;
			}
			else
			{
				if(updateCallback != null)
				{
					updateCallback(percent);
				}
			}
		}
	}
}