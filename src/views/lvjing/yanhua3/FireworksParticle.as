package views.lvjing.yanhua3  {
	import views.lvjing.yanhua3.particle.core.AbstractParticle;
	
	public class FireworksParticle extends AbstractParticle{

		public function FireworksParticle() {
			// constructor code
			super();
		}
		
		/**
		 * 移动粒子
		 *
		 **/
		override public function move():void
		{
			super.move();
			/*抛物线运动公式计算x和y坐标，水平方向：匀速直线运动，竖直方向：匀加速直线运动*/
			this.x += this.speedX;
			this.y += this.speedY;
			/*每次都要为y方向的速度添加重力加速度*/
			this.speedY += this.accelerationY;				
			//让粒子的旋转角度与速度方向一致，用反三角函数进行计算，不懂的可以重温第二章跟Math类有关的内容
			this.rotation = Math.atan2(this.speedY, this.speedX) / Math.PI * 180;
			//通过改变alpha值实现淡出
			this.alpha -= 0.02;
		}
		
		/**
		 * 是否完成了它的使命
		 *
		 **/
		override public function get finished():Boolean
		{
			//当不透明度已经很接近0的时候
			return this.alpha < 0.01;
		}

	}
	
}
