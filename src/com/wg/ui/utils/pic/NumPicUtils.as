package com.wg.ui.utils.pic
{
	
	import flash.display.MovieClip;

	/**
	 *将数字参数转换为图片mc返回; 
	 * @author Allen
	 * 
	 */
	public class NumPicUtils
	{
		public static var numPicCls:Class;
		public static var NongjialengCaiNumMc:Class;
		public static var Jiangsu3PicCls:Class;
		public static var CarNumMcCls:Class;
		public static var shuxiangObj:Object;
		
		public function NumPicUtils()
		{
			
		}
		
		public static function numToPic(num:String,type:String,parent:MovieClip = null):MovieClip
		{
			var tempMc:MovieClip;
			var tempNum:uint = uint(num);
			switch(type)
			{
				
				case "updown":
					tempMc = new NongjialengCaiNumMc();
					createMc();
					/*
					//所有图片在同一帧,从上到下排列
					tempMc.x = parent.mark_mc.x+(parent.mark_mc.width-tempMc["numTxt"+tempNum].width)/2;
					tempMc.y = 0-tempMc["numTxt"+tempNum].y+(parent.mark_mc.height-tempMc["numTxt"+tempNum].height)/2;*/
					//			_picsMc.y = content.mark_mc.y;
					break;
//				case PanelConfig.XIANGGANGCAI_HAOMA:
				case "xuliezhen":
					tempMc = new numPicCls();
					if(!parent)
					{
						tempMc.txt.text = num;
						tempMc.gotoAndStop(changeMcFrame(tempNum));
						break;
					}
					tempMc.txt.text = num;
					tempMc.gotoAndStop(changeMcFrame(tempNum));
					tempMc.mask = parent.mark_mc;
					tempMc.scaleX = 1.0;
					tempMc.scaleY = 1.0;
					tempMc.x = parent.mark_mc.x+(parent.mark_mc.width-tempMc.width)/2;
					tempMc.y = 0-tempMc.y+(parent.mark_mc.height-tempMc.height)/2;
					break;
			}
			
			function createMc():void
			{
				if(parent) tempMc.mask = parent.mark_mc;
				tempMc.gotoAndStop(num);
			}
			
			return tempMc;
		}
		
		/**
		 * 香港彩 红绿蓝波 
		 * @param num
		 * @return 
		 * 
		 */
		public static function changeMcFrame(num:uint):uint
		{
			
			return 0;
		}
		
		
		/**
		 *1-- maxNum
		 * @param maxNum
		 * 
		 */
		public static function randomNumNoRepeat(nums:uint,maxNum:uint):Array
		{
			var tempArr:Array = new Array();
			var num:int = 0;
			for (var i:int = 0; i < nums; i++) 
			{
				num = Math.ceil(Math.random()*maxNum);
				var num2:uint = checkNum(tempArr,num,maxNum);
				tempArr[i] = num;
			}
			
			
			return tempArr;
		}
		
		public static function checkNum(tempArr:Array,num:uint,maxNum:uint):uint
		{
//			trace("start...",tempArr,num,maxNum);
			var tempnum:uint;
			var mybln:Boolean =tempArr.every(func);
//			trace("mybln",mybln);
			if(!mybln){
//				trace("true");
				var num2:uint = Math.ceil(Math.random()*maxNum);
				tempnum = checkNum(tempArr,num2,maxNum);
			}
			return tempnum;
			
			function func(item :uint, index :int, arr:Array):Boolean
			{
//				trace("item::",item,"num::",num);
				return (item != num) ? true :false;
			}
		}
		
		public static function numToDoubleStr(num:int):String
		{
			var str:String = "";
			if(num<10)
			{
				str = "0"+num.toString();
			}else
			{
				str = num.toString();
			}
			return str;
		}
	}
}