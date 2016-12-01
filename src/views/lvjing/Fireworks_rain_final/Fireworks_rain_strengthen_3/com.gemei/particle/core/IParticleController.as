package com.gemei.particle.core {	
	public interface IParticleController extends IParticle{
		// Interface methods:		
		/**
		 * 当前在控制的粒子所组成的数组
		 *
		 **/
		function get particles():Array;
	}	
}
