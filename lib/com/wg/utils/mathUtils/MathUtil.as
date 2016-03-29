package com.wg.utils.mathUtils
{
	/**
	 * as3数值类型操作工具类集合
	 
	 * version v20121029.0.1  <br/>
	 * date 2012.10.29  <br/>
	 *   <br/>
	 * <br/>
	 * getRandomNum       返回[min, max]之间的一个整型随机数(包含两边)  <br/>
	 * getRandomNumArr    返回[min, max]之间的整型随机数集合(包含两边)  <br/>
	 * getRandomStr       获取随机数， 随机数级别 ($n * 100) ^ 10  <br/>
	 * isEvenNum          是否为偶数  <br/>
	 * isNumber           (整数、小数、正数、负数)  <br/>
	 * numbers.toFixed(2) 取小数点后两位;
	 * between 			     传入一个数字v,返回[min,max] 之间的v,若不在此范围,则返回min 或是 max;
	 * getIntFromString   获取字符串中的所有的数字串; 
	 */
	public class MathUtil
	{
		public function MathUtil()
		{
			
		}
		/**
		 *传入一个数字v,返回[min,max] 之间的v,若不在此范围,则返回min 或是 max;
		 * @param v
		 * @param min
		 * @param max
		 * @return 
		 * 
		 */
		public static function between(v:Number, min:Number = 0, max:Number = 1) : Number
		{
			if(v < min) return min;
			if(v > max) return max;
			return v;
		}
		/**
		 * 返回[min, max]之间的一个整型随机数(包含两边)
		 * @param min 最小值限定
		 * @param max 最大值限定
		 * @return int 返回一个获取的无重复随机数
		 */
		public static function getRandomNum(min:int, max:int):int
		{
			return int(Math.random() * (max - min + 1) + min);
		}
		
		/**
		 * 返回[min, max]之间的整型随机数集合(包含两边)
		 * @param min 最小值限定
		 * @param max 最大值限定
		 * @param no 生成几个不同的数字
		 * @return Array 返回获取的无重复随机数集合对象
		 */
		public static function getRandomNumArr(min:int, max:int, nums:int):Array
		{
			var result:Array = [];
			if(nums > 0)
			{
				if(nums == 1)
				{
					result.push(getRandomNum(min,max));
				}
				else
				{
					var generate:int = getRandomNum(min,max);
					while(true)
					{
						if(result.length == nums)
						{
							break;
						}
						if(result.indexOf(generate) != -1)
						{
							generate = getRandomNum(min,max);
						}
						else
						{
							result.push(generate);
						}
					}
				}
			}
			return result;
		}
		
		/**
		 * 获取随机数， 随机数级别 ($n * 100) ^ 10
		 * @param $n 随机数级别，越高所生成的随机数的长度越大，当然效率越低，一般不大于10
		 * @return (String) 返回生成的随机数结果
		 * */
		public static function getRandomStr($n:int):String
		{
			var s:String = "";
			var i:int = 0;
			while(i < $n)
			{
				s += int(Math.random() * 1000).toString();
				i++;
			}
			return s;
		}
		
		/**
		 * 是否为偶数
		 * @param num 目标数值 
		 * @return Boolean 偶数返回true，奇数返回false
		 * */
		public static function isEvenNum(num:int):Boolean
		{
			if(num % 2 == 0)
			{
				return true;        //偶数
			}
			else
			{
				return false;    //奇数
			}
		}
		
		/**
		 * 判断是否为数值型字符串(整数、小数、正数、负数)
		 * @param str 目标字符串
		 * @return Boolean 是数值型字符串返回true, 否则返回false
		 * */
		public static function isNumber(str:String):Boolean
		{
			if(str == null)
			{
				return false;
			}
			return !isNaN(Number(str));
		}
		
		/**
		 *获取字符串中的所有的数字串; 
		 * @param str 目标字符串
		 * @return 返回所有的字符串集合;
		 * 
		 */
		public static function getIntFromString(str:String):Array
		{
			var arr:Array = str.split(/\D+/);
			
			var index:int = arr.indexOf("");
			while(index!=-1)
			{
				arr.splice(index,1);
				index = arr.indexOf("");
			}
			return arr;
		}
	}
}