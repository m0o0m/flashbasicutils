package com.wg.ui.button
{
	import flash.display.MovieClip;
	/**
	 * 
	 * @author Allen
	 * 
	 */	
	public class RichLittleButton extends LittleButton
	{
		private var _picsMc:MovieClip;
		private var _picIndex:uint;
		public function RichLittleButton(con:MovieClip, tit:String,__picsMc:MovieClip)
		{
			super(con, tit);
			_picsMc = __picsMc;
		}

		public function set picIndex(value:uint):void
		{
			_picIndex = value;
		}

		public function set picsMc(value:MovieClip):void
		{
			_picsMc = value;
		}

		override public function init():void
		{
			super.init();
			setPic(int(title));
		}
		
		override public function dispose():void
		{
			content.pic_mc.removeChild(_picsMc);
			super.dispose();
		}
		
		
		private function setPic(param0:int):void
		{
			// TODO Auto Generated method stub
			_picsMc.gotoAndStop(changeMcFrame(_picIndex));
				
			_picsMc.mask = content.mark_mc;
			_picsMc.scaleX = 1.0;
			_picsMc.scaleY = 1.0;
			_picsMc.x = content.mark_mc.x+(content.mark_mc.width-_picsMc.width)/2;
			_picsMc.y = 0-_picsMc.y+(content.mark_mc.height-_picsMc.height)/2;
			
			content.pic_mc.addChild(_picsMc);
		}
		private  function changeMcFrame(num:uint):uint
		{
			return num;
		}
	}
}