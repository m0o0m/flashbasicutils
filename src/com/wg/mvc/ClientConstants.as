package com.wg.mvc
{
	public class ClientConstants
	{
		//游戏最小尺寸
		public static var STAGE_MIN_WIDTH:int = 500;
		public static var STAGE_MIN_HEIGHT:int = 400;
		//游戏正常尺寸
		public static var STAGE_NORMAL_WIDTH:int = 1000;
		public static var STAGE_NORMAL_HEIGHT:int = 600;
		//游戏最大尺寸
		public static var STAGE_MAX_WIDTH:int =1600 /*1250*/;
		public static var STAGE_MAX_HEIGHT:int =818/* 650*/;
		//游戏当前尺寸 根据窗口大小改变而改变
		public static var SCREEN_WIDTH:int = STAGE_MAX_WIDTH; //舞台宽度  
		public static var SCREEN_HEIGHT:int = STAGE_MAX_HEIGHT;//舞台高度
		public function ClientConstants()
		{
			
		}
	}
}