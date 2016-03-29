package com.wg.utils.timeUtils
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	/**
	 * 
	 * @author Administrator
	 * 
	 */
	public class GlobalTimer
	{
		private static var _instance:GlobalTimer;
		private var timer:Timer;
		private var millisecondTimer:Timer;
		private var millisecond:int = 10;
		private var millisecondJishu:int = 0;
		private var millisecondArr:Array = [];
		private var funcArr:Array = [];
		public function GlobalTimer()
		{
			if(!_instance)
			{
				
			}else
			{
				throw new Error("只有一个实例...");
			}
			init();
		}
		
		public static function get instance():GlobalTimer
		{
			if(!_instance)
			{
				_instance = new GlobalTimer();
			}
			return _instance;
		}

		private function init():void
		{
			timer = new Timer(1000);
			timer.addEventListener(TimerEvent.TIMER,onTimer);
			timer.start();//开始之后不停止;
			
			millisecondTimer = new Timer(millisecond);
			millisecondTimer.addEventListener(TimerEvent.TIMER,onmillisecondTimer);
			millisecondTimer.start();//开始之后不停止;
		}
		
		public function onmillisecondTimer(event:TimerEvent):void
		{
			// TODO Auto-generated method stub
			millisecondJishu = millisecondJishu+millisecond;
			for (var i:int = 0; i < millisecondArr.length; i++) 
			{
				if(millisecondJishu%millisecondArr[i][0]==0)
				{
					millisecondArr[i][1]();
				}
			}
		}
		
		protected function onTimer(event:TimerEvent):void
		{
			// TODO Auto-generated method stub
			for (var i:int = 0; i < funcArr.length; i++) 
			{
				funcArr[i]();
			}
		}
		
		/**
		 * 如果没有传入时间,那么每秒执行一次,
		 * @param func
		 * @param sec 单位:毫秒;必须是millisecond毫秒的整倍数;计时器的精确值为millisecond毫秒;
		 * 
		 */
		public function pushFunc(func:Function,sec:int = 0):void
		{
			if(sec)
			{
				millisecondArr.push([sec,func]);
			}else
			{
				funcArr.push(func);
			}
		}
		
		public function delFunc(func:Function):void
		{
			for (var i:int = 0; i < funcArr.length; i++) 
			{
				if(funcArr[i]==func)
				{
					funcArr.splice(i,1);
					break;
				}
			}
			for (var j:int = 0; j < millisecondArr.length; j++) 
			{
				if(millisecondArr[j][1]==func)
				{
					millisecondArr.splice(j,1);
					break;
				}
			}
			
		}
		public function hasFunc(func:Function):Boolean
		{
			for (var i:int = 0; i < funcArr.length; i++) 
			{
				if(funcArr[i]==func)
				{
					return true;
				}
			}
			return false;
		}
		
	}
}