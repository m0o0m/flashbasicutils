package  com.wg.scene.utils
{
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.geom.Point;

	public final class BitmapDataUtil
	{
		public static function createNumberBitmapDataFromDigitMC(numberMC:MovieClip, number:int, hasFlag:Boolean = false):BitmapData
		{
			//1-10 0-9
			//11 -> -
			//12 -> +
			var numString:String;
			if(number > 0)
			{
				numString = number.toString();
				if(hasFlag)
				{
					numberMC.gotoAndStop(12);
				}
				else
				{
					numberMC.stop();
				}
			}
			else if(number < 0)
			{
				hasFlag = true;
				numString = number.toString().substr(1)
				numberMC.gotoAndStop(11);
			}
			else
			{
				hasFlag = false;
				numString = "0";
				numberMC.gotoAndStop(1);
			}
			
			var n:int = numString.length;
			
			var itemWidth:Number = numberMC.width;
			var itemHeight:Number = numberMC.height;
			
			var totalWidth:Number = hasFlag ? itemWidth * (n + 1) : itemWidth * n;
			
			var destPoint:Point = new Point();
			
			var numberContentBitmapData:BitmapData = new BitmapData(totalWidth, itemHeight, true, 0);
			
			var numberItemBitmapData:BitmapData = new BitmapData(itemWidth, itemHeight, true, 0);
			
			if(hasFlag)
			{
				numberItemBitmapData.draw(numberMC);
				numberContentBitmapData.copyPixels(numberItemBitmapData, numberItemBitmapData.rect, destPoint);
				
				destPoint.x += itemWidth;
			}
			
			for(var i:int = 0; i < n; i++)
			{
				var charNumber:int = int(numString.charAt(i));
				numberMC.gotoAndStop(charNumber + 1);
				
				numberItemBitmapData.fillRect(numberItemBitmapData.rect, 0x00);
				numberItemBitmapData.draw(numberMC);
				
				numberContentBitmapData.copyPixels(numberItemBitmapData, numberItemBitmapData.rect, destPoint);
				destPoint.x += itemWidth;
			}
			
			return numberContentBitmapData;
		}
	}
}