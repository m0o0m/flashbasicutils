package views.formula.sanjiao
{
	import flash.display.MovieClip;
	import flash.events.Event;

	public class  SanJiaoUtils
	{
		public function SanJiaoUtils()
		{
		}
		
		
		/**
		 *范例
		 * 根据运动速度,求物体转动角度 
		 * @param _fireworks_mc
		 * 
		 */
		public static function speedRotation(_fireworks_mc:MovieClip):void
		{
			_fireworks_mc.speedX = 3;
			_fireworks_mc.speedY = 3;
			function enterFrameHandler(event:Event):void {
				_fireworks_mc.x += _fireworks_mc.speedX;
				_fireworks_mc.y += _fireworks_mc.speedY;
				_fireworks_mc.rotation = Math.atan2(_fireworks_mc.speedY, _fireworks_mc.speedX) / Math.PI * 180;
			}
		}
	}
	
	
}