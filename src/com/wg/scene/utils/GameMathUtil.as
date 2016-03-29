package  com.wg.scene.utils
{
	import flash.geom.Point;

    public final class GameMathUtil
    {
		public static const EMPTY_POINT:Point = new Point();
		public static const SMALLEST_NUMBER:Number = 0.000001;
		public static const DOUBLE_PI:Number = Math.PI * 2;//360
		public static const HALF_PI:Number = Math.PI * 0.5;//90
		public static const QUARTER_PI:Number = HALF_PI * 0.5;//45
		
		private static var _tempPoint0:Point = new Point();
		private static var _tempPoint1:Point = new Point();
		private static var _tempPoint2:Point = new Point();
		
		/**
		 * Calculate the absolute value of a number.
		 * 
		 * @param	Value	Any number.
		 * 
		 * @return	The absolute value of that number.
		 */
		public static function abs(Value:Number):Number
		{
			return (Value>0)?Value:-Value;
		}
		
		/**
		 * Round down to the next whole number. E.g. floor(1.7) == 1, and floor(-2.7) == -2.
		 * 
		 * @param	Value	Any number.
		 * 
		 * @return	The rounded value of that number.
		 */
		public static function floor(Value:Number):Number
		{
			var number:Number = int(Value);
			return (Value>0)?(number):((number!=Value)?(number-1):(number));
		}
		
		/**
		 * Round up to the next whole number.  E.g. ceil(1.3) == 2, and ceil(-2.3) == -3.
		 * 
		 * @param	Value	Any number.
		 * 
		 * @return	The rounded value of that number.
		 */
		public static function ceil(Value:Number):Number
		{
			var number:Number = int(Value);
			return (Value>0)?((number!=Value)?(number+1):(number)):(number);
		}
		
		/**
		 * Round to the closest whole number. E.g. round(1.7) == 2, and round(-2.3) == -2.
		 * 
		 * @param	Value	Any number.
		 * 
		 * @return	The rounded value of that number.
		 */
		public static function round(Value:Number):Number
		{
			var number:Number = int(Value+((Value>0)?0.5:-0.5));
			return (Value>0)?(number):((number!=Value)?(number-1):(number));
//			return Value < 0 ? Value + .5 == (Value | 0) ? Value : Value - .5 : Value + .5;
		}
		
		/**
		 * Figure out which number is smaller.
		 * 
		 * @param	Number1		Any number.
		 * @param	Number2		Any number.
		 * 
		 * @return	The smaller of the two numbers.
		 */
		public static function min(Number1:Number,Number2:Number):Number
		{
			return (Number1 <= Number2)?Number1:Number2;
		}
		
		/**
		 * Figure out which number is larger.
		 * 
		 * @param	Number1		Any number.
		 * @param	Number2		Any number.
		 * 
		 * @return	The larger of the two numbers.
		 */
		public static function max(Number1:Number,Number2:Number):Number
		{
			return (Number1 >= Number2)?Number1:Number2;
		}
		
		/**
		 * Bound a number by a minimum and maximum.
		 * Ensures that this number is no smaller than the minimum,
		 * and no larger than the maximum.
		 * 
		 * @param	Value	Any number.
		 * @param	Min		Any number.
		 * @param	Max		Any number.
		 * 
		 * @return	The bounded value of the number.
		 */
		public static function clamp(value:Number, min:Number, max:Number):Number
		{
//			var lowerBound:Number = (Value<Min)?Min:Value;
//			return (lowerBound>Max)?Max:lowerBound;
			
			return value < min ? min :
				(value > max ? max : value);
		}
		
		public static function lerp(a:Number,b:Number,ratio:Number):Number
		{
			return a + (b - a) * ratio;
		}
		
		public static function isEquivalent(a:Number, b:Number, epsilon:Number = 0.0001):Boolean
		{
			return (a - epsilon < b) && (a + epsilon > b);
		}
		
		public static function distance(x0:Number, y0:Number, x1:Number, y1:Number):Number
		{
			_tempPoint0.x = x0;
			_tempPoint0.y = y0;
			_tempPoint1.x = x1;
			_tempPoint1.y = y1;
			return Point.distance(_tempPoint0, _tempPoint1);
		}
		
		public static function interpolateTwoPoints(p0:Point, p1:Point, f:Number):Point
		{
			_tempPoint0.x = p0.x;
			_tempPoint0.y = p0.y;
			_tempPoint1.x = p1.x;
			_tempPoint1.y = p1.y;
			
			return Point.interpolate(_tempPoint0, _tempPoint1, f);
		}
		
		//计算椭圆上的点
		public static function caculatePointOnEllipse(circleCenterX:Number, circleCenterY:Number, radian:Number, radiusX:Number, radiusY:Number):Point
		{
			var point:Point = new Point();
			point.x = circleCenterX + cos(radian) * radiusX;
			point.y = circleCenterY + sin(radian) * radiusY;
			return point;
		}
		
		//贝塞尔曲线根据经过曲线的点求，真实的控制点
		public static function adjustBezierCurveThroughControllPointToActualControllPoint(startPoint:Point, 
																						  throughControllPoint:Point, endPoint:Point):void
		{
			throughControllPoint.x = throughControllPoint.x * 2 - (startPoint.x + endPoint.x) * 0.5;
			throughControllPoint.y = throughControllPoint.y * 2 - (startPoint.y + endPoint.y) * 0.5
		}
		
		public static function caculateDirectionRadianByTwoPoint2(startX:Number, startY:Number, endX:Number, endY:Number):Number
		{
			return GameMathUtil.adjustRadianBetween0And2PI(Math.atan2(endY - startY, endX - startX));
		}
		
		//按照ActionScript中角度的方向分成portion等份返回index(从0-8) 
//		public static function toSpecialAngleIndexByAngle(radian:Number):int 
//		{
//			radian = adjustRadianBetween0And2PI(radian);
//			var index:uint = uint(radian / HALF_PORTION_ANGLE);
//			if(index == 15 || index == 0) return 0;
//			index = Math.ceil(index / 2);
//			return index;
//		}

		public static const GAME_DIRECT_PORTION:uint = 8;
		public static const PORTION_ANGLE:Number = DOUBLE_PI / GAME_DIRECT_PORTION;
		public static const HALF_PORTION_ANGLE:Number = PORTION_ANGLE * 0.5;
		
		//左边开始0 一共要8方向表现， 实际要16个方向判断. 但是最终返回(0-7)
		public static function radianToSpecialAngleIndex(radian:Number):int
		{
			radian = adjustRadianBetween0And2PI(radian);
			
			var index:int = int(radian / HALF_PORTION_ANGLE);
			
			if(index == (GAME_DIRECT_PORTION * 2 - 1)) index = 0;
			
			index = Math.ceil(index / 2);
			
			return index;
		}
		
		public static function caculateLengthOfPath(path:Array):Number
		{
			var result:Number = 0;
			var pCurrent:Object = null;
			var pLast:Object = null;
			for(var i:uint = 1, n:uint = path ? path.length : 0; i < n; i++)
			{
				pCurrent = path[i];
				pLast = path[i - 1];
				
				result += distance(pCurrent.x, pCurrent.y, pLast.x, pLast.y);
			}
			return result;
		}
		
		public static function converToCurrentAngleIndexToMirrorIndex(angleIndex:int):int
		{
			switch(angleIndex)
			{
				case 0:
					return 8;
					break;
				
				case 2:
					return 6;
					break;

				case 14:
					return 10;
					break;
				
				default:
					return angleIndex;
					break;
			}
		}
		
		public static function getIsFlipOverByAngleIndex(angleIndex:int):Boolean
		{
			return angleIndex < 4 || angleIndex > 12;
		}
		
		//求圆上一点点坐标
		public static function caculatePointOnCircle(circleCenterX:Number, circleCenterY:Number, radian:Number, radius:Number):Point
		{
			var point:Point = new Point();
			point.x = circleCenterX + cos(radian) * radius;
			point.y = circleCenterY + sin(radian) * radius;
			return point;
		}

//		//朝向上-1中间0下面1
//		public static function caculateVerticalDirectionByAngleIndex(angleIndex:int):int
//		{
//			if(angleIndex == 0 || angleIndex == 4) return 0;
//			if(angleIndex == 1 || angleIndex == 2 || angleIndex == 3) return 1;
//			else return -1;
//		}
//		
//		//-1左0中间1右
//		public static function caculateHorizontalDirectionByAngleIndex(angleIndex:int):int
//		{
//			if(angleIndex == 2 || angleIndex == 6) return 0;
//			if(angleIndex == 0 || angleIndex == 1 || angleIndex == 7) return 1;
//			else return -1;
//		}
		
		public static function interpolateRadianBetween0And2PI(startRadian:Number, endRadin:Number, progress:Number):Number
		{
			startRadian = standardizeRadian(startRadian);
			endRadin = standardizeRadian(endRadin);
			
			if(progress < 0) progress = 0;
			else if(progress > 1) progress = 1;

			var daltValue:Number = endRadin - startRadian;
			if(Math.abs(daltValue) > Math.PI)
			{
				if(daltValue > 0)
				{
					endRadin -= GameMathUtil.DOUBLE_PI;
				}
				else
				{
					startRadian -= GameMathUtil.DOUBLE_PI;
				}
				
				return startRadian + (endRadin - startRadian) * progress;
			}
			else
			{
				return startRadian + (endRadin - startRadian) * progress;
			}
		}
		
		//取1/4π的近似值
		public static function interpolateRadianToQuarer(radian:Number):Number
		{
			var reminderNum:Number = radian%GameMathUtil.QUARTER_PI;
			
			if(reminderNum>GameMathUtil.QUARTER_PI*0.5)
			{
				radian = radian - reminderNum + GameMathUtil.QUARTER_PI;
				
				radian = standardizeRadian(radian);
			}
			else
			{
				radian = radian - reminderNum;
			}
			
			return radian
		}
		//弧度转角度
		public static function radianToDegree(radian:Number):Number
		{
			return radian * 180 / Math.PI;
		}
		
		//角度转弧度
		public static function degreeToRadian(degree:Number):Number
		{
			return degree * Math.PI / 180;
		}
		
		public static function standardizeDegree(degree:Number):Number
		{
			degree = degree % 360;
			if(degree < 0)
			{
				degree += 360;
			}
			
			return degree;
		}
		
		public static function standardizeRadian(radian:Number):Number
		{
			radian = radian % DOUBLE_PI;
			if(radian < 0)
			{
				radian += DOUBLE_PI;
			}
			
			return radian;
		}
		
		public static function cos(radian:Number):Number
		{
			return Math.cos(radian);
//			return adjustSmallNumber(Math.cos(radian));
		}
		
		public static function sin(radian:Number):Number
		{
			return Math.sin(radian);
//			return adjustSmallNumber(Math.sin(radian));
		}
		
		public static function adjustSmallNumber(value:Number):Number
		{
			return Math.abs(value) < SMALLEST_NUMBER ? 0 : value;
		}

		public static function adjustRadianBetween0And2PI(radian:Number):Number
		{
			radian %= DOUBLE_PI;
			
			if(radian < 0)
			{
				radian += DOUBLE_PI;
			}
			
			if(DOUBLE_PI - radian < SMALLEST_NUMBER) radian = 0;
			
			return radian;
		}
		
		public static function caculateTargetAxePointInSourceAxePoint(targetAxePointX:Number, targetAxePointY:Number,
																	  	targetAxeXDirectionRadianInSourceAxe:Number,
																		targetAxeOriginPointX:Number, targetAxeOriginPointY:Number,
																		result:Point = null):Point
		{
			result ||= new Point();
			
			var sinValue:Number = GameMathUtil.sin(targetAxeXDirectionRadianInSourceAxe);
			var cosVlaue:Number = GameMathUtil.cos(targetAxeXDirectionRadianInSourceAxe);
			
			result.x = cosVlaue * targetAxePointX - sinValue * targetAxePointY + targetAxeOriginPointX;
			result.y = cosVlaue * targetAxePointY + sinValue * targetAxePointX + targetAxeOriginPointY;
			
			return result;
		}
		
		public static  function colorToRgb(color:uint, results:Array = null):Array
		{
			results ||= [];
			
			results[1] = (color >> 16) & 0xFF;//red
			results[2] = (color >> 8) & 0xFF;//green
			results[3] = color & 0xFF;//blue
			return results;
		}
		
		/** Creates an RGB color, stored in an unsigned integer. Channels are expected
		 *  in the range 0 - 255. */
		public static function rgbToColor(red:int, green:int, blue:int):uint
		{
			return (red << 16) | (green << 8) | blue;
		}
		
		//random
		public static function randomNumberBetween(min:Number, max:Number):Number
		{
			return min + Math.random() * (max - min);
		}
		
		public static function randomFromValues(values:Array):*
		{
			if(values == null || values.length == 0) return null;
			
			var n:uint = values.length;
			var radomIndex:int = int(Math.random() * n);
			return values[radomIndex];
		}
		
		public static function randomIndexByLength(length:uint):int
		{
			if(length == 0) return -1;
			
			return Math.random() * length;
		}

		public static function randomTrueByProbability(probability:Number/*0-1*/):Boolean
		{
			if(probability == 0) return false;
			else if(probability >= 1) return true;
			
			return Math.random() <= probability;
		}
		
		public static function isRectangleOverlap(rect0X:Number, rect0Y:Number, 
															  rect0Width:Number, rect0Height:Number, 
															  rect1X:Number, rect1Y:Number, 
															  rect1Width:Number, rect1Height:Number):Boolean
		{
			if(rect0X + rect0Width < rect1X) return false;
			else if(rect0X > rect1X + rect1Width) return false;
			
			if(rect0Y + rect0Height < rect1Y) return false;
			else if(rect0Y > rect1Y + rect1Height) return false;
			
			return true;
		}
		
		public static function isOverlapCircleAndRectangle(circleCenterX:Number, 
														   circleCenterY:Number, 
														   circleRadius:Number, 
														   rectX:Number, rectY:Number, 
														   rectWidth:Number, rectHeight:Number):Boolean
		{
			if(circleCenterX + circleRadius < rectX) return false;
			else if(circleCenterX - circleRadius  > rectX + rectWidth) return false;
			
			if(circleCenterY + circleRadius < rectY) return false;
			else if(circleCenterY - circleRadius > rectY + rectHeight) return false;
			
			return true;
		}
		
		//key:value;key:name
		public static function decodeSimpleKeyValueStr(str:String, keySplitFlag:String = ":", itemSplitFlag:String = ";"):Object
		{
			var result:Object = {};
			
			var arr:Array = str.split(itemSplitFlag);
			var itemStr:String = null;
			var itemArr:Array = null;
			for(var i:int = 0, n:int = arr ? arr.length : 0; i < n; i++)
			{
				itemStr = arr[i];
				itemArr = itemStr.split(keySplitFlag);
				
				result[itemArr[0]] = itemArr[1];
			}
			
			return result;
		}
		
		//"x-y-z;x-y-z"
		public static function decodeSimpleValuesStr(str:String, keySplitFlag:String = "-", itemSplitFlag:String = ";"):Array
		{
			var results:Array = [];
			
			var arr:Array = str.split(itemSplitFlag);
			var itemStr:String = null;
			var itemArr:Array = null;
			for(var i:int = 0, n:int = arr ? arr.length : 0; i < n; i++)
			{
				itemStr = arr[i];
				itemArr = itemStr.split(keySplitFlag);
				
				results.push(itemArr);
			}
			
			return results;
		}
		
		public static function getFileName(text:String) : String
		{
			if (text.lastIndexOf("/") == text.length -1)
			{
				return getFileName(text.substring(0, text.length-1));
			}
			
			var startAt : int = text.lastIndexOf("/") + 1;
			//if (startAt == -1) startAt = 0;
			var croppedString : String = text.substring(startAt);
			var lastIndex :int = croppedString.indexOf(".");
			if (lastIndex == -1 )
			{
				if (croppedString.indexOf("?") > -1)
				{
					lastIndex = croppedString.indexOf("?") ;
				}
				else
				{
					lastIndex = croppedString.length;
				}
			}
			
			var finalPath : String = croppedString.substring(0, lastIndex);
			return finalPath;
		}
		
		public static function fillZeroWithNumber(numValue:uint, charsCount:int):String
		{
			var numValueStr:String = numValue.toString();
			var numValueStrLen:int = numValueStr.length;
			var fillCharsCount:int = charsCount - numValueStrLen;
			while(fillCharsCount > 0)
			{
				numValueStr = "0" + numValueStr;
				fillCharsCount--;
			}
				
			return numValueStr;
		}
		
		//00:00:00
		public static function formatTime(split:String, timeSec:Number):String
		{
			const ONE_H_SECOND:uint = 60 * 60;
			const ONE_M_SECOND:uint = 60;
			
			var hour:uint = timeSec / ONE_H_SECOND;
			timeSec %= ONE_H_SECOND;
			
			var minute:uint = timeSec / ONE_M_SECOND;
			timeSec %=  ONE_M_SECOND;
			
			var second:uint = timeSec;
			
			return fillZeroWithNumber(hour, 2) + split + fillZeroWithNumber(minute, 2) + split + fillZeroWithNumber(second, 2);
		}
    }
}