package  {
	import com.gemei.particle.core.AbstractParticle;
	
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
			//如果已经碰到地面（当前主位图的高度是FWConstants.STAGE_BMP_HEIGHT）
			if(this.y > FWConstants.STAGE_BMP_HEIGHT)
			{
				//不让粒子在地面以下
				this.y = FWConstants.STAGE_BMP_HEIGHT;
				//速度大小在0~0.75倍之间随机，并且方向相反
				this.speedY = - 0.75 * Math.random() * this.speedY;
			}
			//如果已经碰到左侧墙壁（x为0的位置）
			if(this.x < 0)
			{
				//不让粒子出现在左墙壁以左
				this.x = 0;
				//速度方向相反
				this.speedX = - this.speedX * 0.9;
			}
			//如果已经碰到左侧墙壁（x为FWConstants.STAGE_BMP_WIDTH的位置）
			if(this.x > FWConstants.STAGE_BMP_WIDTH)
			{
				//不让粒子出现在左墙壁以左
				this.x = FWConstants.STAGE_BMP_WIDTH;
				//速度方向相反
				this.speedX = - this.speedX * 0.9;
			}
		}
		
		/**
		 * 是否完成了它的使命
		 *
		 **/
		override public function get finished():Boolean
		{
			//当速度很小，并且跟地面很接近的时候
			return (this.speedX * this.speedX + this.speedY * this.speedY < 20) && (Math.abs(this.y - FWConstants.STAGE_BMP_HEIGHT) < 2);
		}

	}
	
}
