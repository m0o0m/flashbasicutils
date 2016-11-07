package com.wg.utils.localDataUtils
{
	import flash.net.SharedObject;
	import flash.system.System;

	public class LocalDataUtil
	{
		private static var mySO:SharedObject;
		public function LocalDataUtil()
		{
			
		}
		
		public static function getLocal(name:String):Object{
			mySO = SharedObject.getLocal(name);
			return mySO.data;
		}
		public static function setLocal(name:String,obj:Object):Boolean
		{
			var bln:Boolean = false;
			mySO = SharedObject.getLocal(name);
			if(mySO)
			{
				bln = true;
				for (var a:* in obj) {
					mySO.data[a] = obj[a];
				}
			}
			
			return bln;
		}
		public static function getValueByKey(name:String,key:String):String
		{
			var str:String = "";
			mySO = SharedObject.getLocal(name);
			if(!mySO){
				str = "没有找到本地数据";
			}else{
				for (var a in mySO.data) {
					if(a==key)
					{
						str = mySO.data[a];
						break;
					}
				}
			}
			return str;
		}
		private static function checkSO():void {
			//测试客户端可不可以使用SharedObject，创建一个虚假SharedObject测试
			mySO = SharedObject.getLocal("test");
			if (!mySO.flush(1)) {
				//这里仅仅测试能不能加入1Byte的SharedObject
				//SharedObject不能运行，提示改变设置
				//System.showSettings(1);
			} else {
				//SharedObject可以运行
				trace("Your system allows SharedObjects");
			}
		}
	}
}