package
{
	
	import com.wg.schedule.IAnimatedObject;
	import com.wg.schedule.Scheduler;
	
	import flash.media.Sound;
	import flash.net.URLRequest;

	public class MvcTimer implements IAnimatedObject
	{
		private var _view:*;

		public function MvcTimer()
		{
		}
		
		public function init(view:*) : void
		{
			_view = view;
			Scheduler.addAnimatedObject(this, Number.MAX_VALUE);
			Scheduler.schedule(1000, null, onSecond);
		}
		
		public function onFrame(deltaTime:Number) : void
		{
			_view.frameProcess(); 
		}
		
		public function onSecond() : void
		{
			Scheduler.schedule(1000, null, onSecond);

			_view.timerProcess();			
		}
	}
}