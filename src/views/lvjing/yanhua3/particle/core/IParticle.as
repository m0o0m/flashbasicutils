package  views.lvjing.yanhua3.particle.core
{
	/**
	 * 粒子类接口
	 *
	 **/
	public interface IParticle
	{
		// Interface methods:
		/**
		 * 移动粒子
		 *
		 **/
		function move():void;
		
		/**
		 * 当前粒子是否已完成使命
		 *
		 **/
		function get finished():Boolean;
	}
}