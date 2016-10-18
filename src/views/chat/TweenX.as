package views.chat
{
	/**
	 * x轴移动 
	 */	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;

	public class TweenX
	{
		private var _complete:Function;
		
		private var _mc:Sprite;
		
		private var _speed:int =30;
		/**
		 * 1向左缩，2向右缩
		 */		
		private var _type:int =0;
		private var _targetX:int;
		public function TweenX(mc:Sprite,targetX:int,speed:int)
		{
			_mc =mc;
			
			_speed =speed;
			
			_targetX = targetX;
			
			if(_targetX<mc.x)
			{
				_type = 1;
			}else if(_targetX>mc.x){
				_type = 2;
			}else{
				_type = 0;
			}
			
			addEvent();
		}
		
		private function addEvent():void
		{
			_mc.addEventListener(Event.ENTER_FRAME,enterFramHandler);
			
		}
		
		private function enterFramHandler(e:Event):void
		{
			if((_mc.x== _targetX)||_type==0)
			{
				removeEvent();
				if(_complete!=null)_complete();
			}
			
			if(_type==1)
			{
				_mc.x -= _speed;
				if(_mc.x<=_targetX) _mc.x=_targetX;
			}else if(_type==2)
			{
				_mc.x += _speed;
				if(_mc.x>=0) _mc.x= _targetX;
			}
		}
		
		private function removeEvent():void
		{
			_mc.removeEventListener(Event.ENTER_FRAME,enterFramHandler);
		}
		
		public function set complete(value:Function):void
		{
			_complete =value;
		}
		
		/**
		 *  
		 * @param mc 移动的MvieClip
		 * @param targetX 目标坐标
		 * @param speed 移动速度
		 * @return 
		 * 
		 */		
		public static function to(mc:Sprite,targetX:int,speed:int=30):TweenX
		{	
			var chatTween:TweenX = new TweenX(mc,targetX,speed);
			return chatTween
		}
	}
}