package com.seaWarScene
{
	public final class ModelStateType
	{
		public static const IDEL:String = "Idel";
		public static const WALK:String = "Walk";
		public static const NORMALATTACK:String = "NormalAttack";
		public static const BEATTACK:String = "BeAttack";
		public static const SKILLATTACK:String = "SkillAttack";
		public static const DIE:String = "Die";
		public static const RELEASE:String = "Release";
		
		public static const VOID:String = "Void";
		
		//模型朝向
		/**
		 * 东方 
		 */		
		public static const ANGLE_EAST:int = 0;
		
		/**
		 * 东南
		 */	
		public static const ANGLE_SOUTHEAST:int = 2;
		
		/**
		 * 南
		 */	
		public static const ANGLE_SOUTH:int = 4;
		
		/**
		 * 西南
		 */
		public static const ANGLE_SOUTWEST:int = 6;
		
		/**
		 * 西
		 */
		public static const ANGLE_WEST:int = 8;
		
		/**
		 * 西北
		 */
		public static const ANGLE_NORTHWEST:int = 10;
		
		/**
		 * 北
		 */
		public static const ANGLE_NORTH:int = 12;
		
		/**
		 * 东北
		 */
		public static const ANGLE_NORTHEAST:int = 14;
		
	}
}