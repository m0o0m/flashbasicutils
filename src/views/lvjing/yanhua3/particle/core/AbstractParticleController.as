package  views.lvjing.yanhua3.particle.core {
	
	public class AbstractParticleController implements IParticleController{
		
		/**
		 * 时间变量（在控制过程中可能会用得比较多，故先在这里定义一下）
		 *
		 **/
		public var t:int;
		 
		/**
		 * 移动粒子
		 *
		 **/
		public function move():void
		{
			t++;
		}
		
		/**
		 * 是否完成了它的使命
		 *
		 **/
		public function get finished():Boolean
		{
			return false;
		}
		
		public function get particles():Array
		{
			return [];
		}
		
		public function AbstractParticleController() {
			// constructor code
			t = 0;
		}

	}
	
}
