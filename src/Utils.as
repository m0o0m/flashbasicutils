package
{
	import com.wg.logging.Log;
	import com.wg.logging.Logger;
	import com.wg.utils.arrayUtils.ArrayUtil;
	import com.wg.utils.mathUtils.MathUtil;
	import com.wg.utils.objectUtils.ObjectUtil;
	import com.wg.utils.stringUtils.StringUtil;
	import com.wg.utils.timeUtils.Daojishi;
	import com.wg.utils.timeUtils.Jishiqi;
	import com.wg.utils.timeUtils.TimeUtil;
	import com.wg.utils.timeUtils.TimerManager;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * as3工具类集合
	 * @author xuechong
	 * @version v20121029.0.1
	 * @date 2012.10.29
	 * @
	 * */
	public class Utils extends Sprite
	{
		public function Utils()
		{
			arrayUtilsFunc();    //数组
			//mathUtilsFunc();    //数值型
			timeUtilsFunc();    //时间工具类
			TimerManager    //时间管理器参考范例
			trace(StringUtil.sprintf("%5.2d",Math.floor(1832600 / 3600)));
			trace(StringUtil.sprintf("%x",1234));
			trace(StringUtil.sprintf("%10.15s","sffsfsfdsfsdfsdd"));
			trace(StringUtil.sprintf("%s, %s %#2u, %.2d:%.2d\n","Sunday  ","July","088",4,5));
			trace(StringUtil.sprintf("%-" + 5 + "s%-10s%-8s%-8s%-8s%-8s%-8s", "name", "Calls", "Total%", "NonSub%", "AvgMs", "MinMs", "MaxMs"));
		}
		
		/**
		 * 数组
		 * */
		private function arrayUtilsFunc():void
		{
			var r1:Array = ["a", "b", "c", "d", "c", "a"];
			ArrayUtil.removeValues(r1, "c");
			trace(r1);    //a,b,d,a
			
			var r2:Array = ["a", "b", "c", "d", "c", "a"];
			ArrayUtil.removeValue(r2, "c");
			trace(r2);    //a,b,d,c,a
			
			var r3:Array = ["a", "b", "c", "d", "c", "a"];
			ArrayUtil.removeAllBehindIndex(r3, 2);
			trace(r3);    //a,b,c
			
			var r4:Array = ["ass", "bs", "c", "dss", "c", "asss"];
			ArrayUtil.updateDelArr(r4, "ss", "c");
			trace(r4);    //a,bs,,d,,as
			
			var r5:Array = ["aa", "b", "cc", "c", "cc", "ccc"];
			r5 = ArrayUtil.createUniqueCopy(r5);
			trace(r5);    //aa,b,cc,c,ccc
			
			trace(ArrayUtil.arraysAreEqual(["a", "b", "c"], ["a", "b", "d"]));    //false
			
			var obj:Object = ArrayUtil.getRepeatArr([1, 3, 5, 7, 1, 3, 8, "a", "b", "a", -1, -1]);
			trace(obj.repeat + "   " + obj.noRepeat);    //1,3,a,-1   5,7,8,b
			
			var r6:Array = ["aa", "b", "cc", "c", "cc", "ccc"];
			ArrayUtil.setSize(r6, 4);
			trace(r6);    //aa,b,cc,c
			
			var r7:Array = ArrayUtil.randomGetArr(["a", "b", "c", "a", "b", "c"], 3);
			trace(r7);    //b,a,c
			
			var r8:Array = ArrayUtil.randomSortArr(["a", "b", "c", "a", "b", "c"]);
			trace(r8);    //c,b,c,a,b,a
		}
		
		/**
		 * 数值型
		 * */
		private function mathUtilsFunc():void
		{
			var a:int = MathUtil.getRandomNum(2, 20);
			trace(a);    //12
			
			var b:Array = MathUtil.getRandomNumArr(2, 10, 5);
			trace(b);    //5,6,3,2,9
			
			trace(MathUtil.getRandomStr(3));    //538785499
			
			trace(MathUtil.isEvenNum(6));    //true
			
			trace(MathUtil.isNumber("22"));    //true
		}
		
		/**
		 * 时间工具类
		 * */
		private function timeUtilsFunc():void
		{
			var daojishi:Daojishi = new Daojishi();
			daojishi.timeStart(1, 2, 00, 00, ":");
			//daojishi.addEventListener(hello);
			function hello(event:Event):void
			{
			    //trace(daojishi.result);
			}
			
			//trace(TimeUtil.secondsFormat(3601, "-"));
			
			var jishiqi:Jishiqi = new Jishiqi();
			jishiqi.addEventListener(Jishiqi.RESULT, hello2);
			jishiqi.timeStart(1000);
			function hello2(event:Event):void
			{
			    trace(jishiqi.resultNum);
				jishiqi.timeStop();
			}
		}
		
	}
}